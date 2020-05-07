Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDB1C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC45208DB
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgEGUDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:03:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:40848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbgEGUDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:03:07 -0400
Received: (qmail 2225 invoked by uid 109); 7 May 2020 20:03:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:03:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21589 invoked by uid 111); 7 May 2020 20:03:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:03:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:03:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 4/8] builtin/commit-graph.c: extract 'read_one_commit()'
Message-ID: <20200507200305.GB29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <9ae8745dc090de37af0475ab12b79d541a52713d.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ae8745dc090de37af0475ab12b79d541a52713d.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:13:46PM -0600, Taylor Blau wrote:

> In the case of '--stdin-commits', feed each line to a new
> 'read_one_commit' helper, which (for now) will merely call
> 'parse_oid_hex'.

Makes sense.

> +static int read_one_commit(struct oidset *commits, char *hash)

This could be "const char *hash", couldn't it?

> +	struct object_id oid;
> +	const char *end;
> +
> +	if (parse_oid_hex(hash, &oid, &end)) {
> +		error(_("unexpected non-hex object ID: %s"), hash);
> +		return 1;
> +	}

Returning "-1" for error is more idiomatic in our code base (though I
know some of the commit-graph code doesn't follow that, I think we
should slowly try to move it back in the other direction.

> +		while (strbuf_getline(&buf, stdin) != EOF) {
> +			char *line = strbuf_detach(&buf, NULL);
> +			if (opts.stdin_commits) {
> +				int result = read_one_commit(&commits, line);
> +				if (result)
> +					return result;
> +			} else
> +				string_list_append(&pack_indexes, line);
> +		}

This leaks "line" for each commit in stdin_commits mode (it used to get
added to a string list). I think you want:

  while (strbuf_getline(&buf, stdin) != EOF) {
        if (opts.stdin_commits) {
	        if (read_one_commit(&commits, buf.buf)) {
			strbuf_release(&buf);
			return 1;
		}
	} else {
	        string_list_append(&pack_indexes, strbuf_detach(&buf));
	}
  }

Though I think it might be easier to follow if each mode simply has its
own while loop.

> +
>  		UNLEAK(buf);

Not new in your patch, but this UNLEAK() has always bugged me. ;) Why
not just strbuf_release() it?

-Peff
