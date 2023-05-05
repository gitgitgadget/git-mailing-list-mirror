Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCDC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 22:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjEEWTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEWTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 18:19:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DCBEA
        for <git@vger.kernel.org>; Fri,  5 May 2023 15:19:22 -0700 (PDT)
Received: (qmail 4866 invoked by uid 109); 5 May 2023 22:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 22:19:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4728 invoked by uid 111); 5 May 2023 22:19:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 18:19:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 18:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230505221921.GE3321533@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 06:05:45PM -0400, Taylor Blau wrote:

> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline(&buf, out) != EOF) {
> +		struct object_id oid;
> +		struct object *obj;
> +		int type;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}

While adapting this for my "how about this" patch elsewhere in the
thread, I noticed the error handling here is a little funny.

The other side sent us unexpected output, so we stopped parsing. But we
never reap the child process. We just jump to "done", which clears the
memory used by the process struct, but never call finish_command().

I think you want to break out of this loop and run finish_command. But
you have to make sure to fclose(out) first, so that it knows to exit
(otherwise it may fill up the pipe buffer and block waiting for us to
read, creating a deadlock).

And then

So something like:

  while (strbuf_getline(...)) {
	if (some_error) {
		ret = error(...);
		break;
  }

  fclose(out); /* no need for "if (out)" here; it's always open */
  ret |= finish_command(&cmd);

  /* no need to child_process_clear(); already done by finish_command() */
  strbuf_release(&buf);
  return ret;

-Peff
