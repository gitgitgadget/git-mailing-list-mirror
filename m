Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081381F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbeGJSpx (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:45:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732237AbeGJSpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:45:52 -0400
Received: (qmail 30491 invoked by uid 109); 10 Jul 2018 18:45:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 18:45:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29679 invoked by uid 111); 10 Jul 2018 18:45:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 14:45:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 14:45:34 -0400
Date:   Tue, 10 Jul 2018 14:45:34 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v1] convert log_ref_write_fd() to use strbuf
Message-ID: <20180710184534.GA27535@sigill.intra.peff.net>
References: <20180710182000.21404-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710182000.21404-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 06:20:22PM +0000, Ben Peart wrote:

> log_ref_write_fd() was written long before strbuf was fleshed out. Remove
> the old manual buffer management code and replace it with strbuf(). Also
> update copy_reflog_msg() which is called only by log_ref_write_fd() to use
> strbuf as it keeps things consistent.

Yay! In all of my buffer size auditing over the years, I've repeatedly
come across this "+ 100" but it never quite made the cut for fixing,
since it wasn't (yet) actually broken. Thanks for tackling it.

> -int copy_reflog_msg(char *buf, const char *msg)
> +void copy_reflog_msg(struct strbuf *sb, const char *msg)

Glad to see this "int" go; it should have been size_t anyway.

>  {
> -	char *cp = buf;
>  	char c;
>  	int wasspace = 1;
>  
> -	*cp++ = '\t';
> +	strbuf_addch(sb, '\t');
>  	while ((c = *msg++)) {
>  		if (wasspace && isspace(c))
>  			continue;
>  		wasspace = isspace(c);
>  		if (wasspace)
>  			c = ' ';
> -		*cp++ = c;
> +		strbuf_addch(sb, c);
>  	}

This is all fairly straight-forward.

> -	while (buf < cp && isspace(cp[-1]))
> -		cp--;
> -	*cp++ = '\n';
> -	return cp - buf;
> +	strbuf_rtrim(sb);

Using rtrim is a nice reduction in complexity. A pure translation would
include a final strbuf_addch(sb, '\n'). It looks like you moved that to
the caller. There's only one, so that's OK now, but it may affect topics
in flight (and I do in fact have an old topic that calls it).

But I think it's OK, as the change in function signature means that any
callers will need updated anyway. So there's little risk of a silent
mis-merge.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a9a066dcfb..c0e892d0c8 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1582,22 +1582,15 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
>  			    const struct object_id *new_oid,
>  			    const char *committer, const char *msg)
>  {
> -	int msglen, written;
> -	unsigned maxlen, len;
> -	char *logrec;
> -
> -	msglen = msg ? strlen(msg) : 0;
> -	maxlen = strlen(committer) + msglen + 100;
> -	logrec = xmalloc(maxlen);
> -	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> -			oid_to_hex(old_oid),
> -			oid_to_hex(new_oid),
> -			committer);
> -	if (msglen)
> -		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
> -
> -	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
> -	free(logrec);
> +	int written;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
> +	if (msg && *msg)
> +		copy_reflog_msg(&sb, msg);
> +	strbuf_addch(&sb, '\n');
> +	written = write_in_full(fd, sb.buf, sb.len);
> +	strbuf_release(&sb);
>  	if (written < 0)
>  		return -1;

This looks like another straight-forward translation.

While we're here, is it worth turning "written" into an ssize_t, which
is the correct return from write_in_full()? Alternatively, I wonder if
the logic would be simpler to follow with:

  int ret;

  ...strbuf bits...

  if (write_in_full(fd, sb.buf, sb.len) < 0)
	ret = -1;
  else
	ret = 0;

  strbuf_release(&sb);
  return ret;

We don't actually care about the number of bytes at all.

That's minor, though. With or without such a change, I'd be happy to see
it applied.

-Peff
