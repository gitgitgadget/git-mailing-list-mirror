Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2311F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 04:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbcITE2g (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 00:28:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:45411 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbcITE2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 00:28:36 -0400
Received: (qmail 24572 invoked by uid 109); 20 Sep 2016 04:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 04:28:35 +0000
Received: (qmail 16937 invoked by uid 111); 20 Sep 2016 04:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 00:28:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 21:28:33 -0700
Date:   Mon, 19 Sep 2016 21:28:33 -0700
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160920042832.7xzazxsfiug3llyl@sigill.intra.peff.net>
References: <20160916210204.31282-1-me@ikke.info>
 <20160919185440.18234-3-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160919185440.18234-3-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 08:54:40PM +0200, Kevin Daudt wrote:

> diff --git a/t/t5100/comment.expect b/t/t5100/comment.expect
> new file mode 100644
> index 0000000..1197e76
> --- /dev/null
> +++ b/t/t5100/comment.expect
> @@ -0,0 +1,5 @@
> +Author: A U Thor (this is a comment (really))

Hmm. I don't see any recursion in your parsing, so after the first ")"
our escape_context would be 0 again, right? So a more tricky test is:

  Author: A U Thor (this is a comment (really) with \(quoted\) pairs)

We are still inside "ctext" when we hit those quoted pairs, and they
should be unquoted, but your code would not do so (unless we go the
route of simply unquoting pairs everywhere).

I think your parser would have to follow the BNF more closely with a
recursive descent parser, like:

  const char *parse_comment(const char *in, struct strbuf *out)
  {
        size_t orig_out = out->len;

        if ((in = parse_char('(', in, out))) &&
            (in = parse_ccontent(in, out)) &&
            (in = parse_char(')', in, out))))
                return in;

        strbuf_setlen(out, orig_out);
        return NULL;
  }

  const char *parse_ccontent(const char *in, struct strbuf *out)
  {
        while (*in && *in != ')') {
                const char *next;

                if ((next = parse_quoted_pair(in, out)) ||
                    (next = parse_comment(in, out)) ||
                    (next = parse_ctext(in, out))) {
                        in = next;
                        continue;
                }
        }

	/*
	 * if "in" is NUL here we have an unclosed comment; but we'll
	 * just silently ignore and accept it
	 */
	return in;
  }

  const char *parse_char(char c, const char *in, struct strbuf *out)
  {
        if (*in != c)
                return NULL;
        strbuf_addch(out, c);
        return in + 1;
  }

You can probably guess at the implementation of parse_quoted_pair(),
parse_ctext(), etc (and naturally, the above is completely untested and
probably has some bugs in it).

In a former life (back when it was still rfc822!) I remember
implementing a similar parser, which I think was in turn based on the
cclient code in pine. It's not _too_ hard to get it all right based on
the BNF in the RFC, but as you can see it's a bit tedious. And I'm not
convinced we actually need it to be completely right for our purposes.
We really are looking for a single address, with the email in "<>" and
the name as everything before that, but de-quoted.

-Peff
