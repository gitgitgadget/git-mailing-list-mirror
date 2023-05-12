Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB75C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 04:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjELE64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjELE6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 00:58:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD1171E
        for <git@vger.kernel.org>; Thu, 11 May 2023 21:58:54 -0700 (PDT)
Received: (qmail 2997 invoked by uid 109); 12 May 2023 04:58:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 May 2023 04:58:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18352 invoked by uid 111); 12 May 2023 04:58:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 May 2023 00:58:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 May 2023 00:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <20230512045853.GA2479240@coredump.intra.peff.net>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 07:20:37PM -0400, Taylor Blau wrote:

> +static int run_one_pack_recent_objects_hook(struct oidset *set,
> +					    const char *args)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *out;
> +	int ret = 0;
> +
> +	cmd.use_shell = 1;
> +	cmd.out = -1;
> +
> +	strvec_push(&cmd.args, args);
> +
> +	if (start_command(&cmd))
> +		return -1;
> +
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline(&buf, out) != EOF) {
> +		struct object_id oid;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}
> +
> +		oidset_insert(set, &oid);
> +	}
> +
> +	ret = finish_command(&cmd);
> +
> +done:

I haven't looked closely at this whole patch yet (and I especially want
to look at the new tests since this approach covers more cases), but I
did notice that this version of the function still has the "we don't
reap the child on parse failure" problem I described in:

  https://lore.kernel.org/git/20230505221921.GE3321533@coredump.intra.peff.net/

I'll try to give the whole patch a more thorough review tomorrow.

-Peff
