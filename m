Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57421FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 03:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdC2DlK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 23:41:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53398 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdC2DlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 23:41:09 -0400
Received: (qmail 8022 invoked by uid 109); 29 Mar 2017 03:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 03:41:08 +0000
Received: (qmail 19443 invoked by uid 111); 29 Mar 2017 03:41:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 23:41:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 23:41:05 -0400
Date:   Tue, 28 Mar 2017 23:41:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
Message-ID: <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
 <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 03:33:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's a lot of patches, but hopefully they're all pretty straightforward
> > to read.
> 
> Yes, quite a lot of changes.  I didn't see anything questionable in
> there.
> 
> As to the "patch-id" thing, I find the alternate one slightly easier
> to read.  Also, exactly because this is not a performance critical
> codepath, it may be better if patch_id_add_string() filtered out
> whitespaces; that would allow the source to express things in more
> natural way, e.g.
> 
> 		patch_id_addf(&ctx, "new file mode");
> 		patch_id_addf(&ctx, "%06o", p->two->mode);
> 		patch_id_addf(&ctx, "--- /dev/null");
> 		patch_id_addf(&ctx, "+++ b/%.*s", len2, p->two->path);
> 
> Or I may be going overboard by bringing "addf" into the mix X-<.

I think there are two things going on in your example.

One is that obviously patch_id_addf() removes the spaces from the
result. But we could do that now by keeping the big strbuf_addf(), and
then just walking the result and feeding non-spaces.

The second is that your addf means we are back to formatting everything
into a buffer again. And it has to be dynamic to handle the final line
there, because "len2" isn't bounded. At which point we may as well go
back to sticking it all in one big strbuf (your example also breaks it
down line by line, but we could do that with separte strbuf_addf calls,
too).

Or you have to reimplement the printf format-parsing yourself, and write
into the sha1 instead of into the buffers. But that's probably insane.

I think the "no extra buffer with whitespace" combo is more like:

  void patch_id_add_buf(git_SHA1_CTX *ctx, const char *buf, size_t len)
  {
	for (; len > 0; buf++, len--) {
		if (!isspace(*buf))
			git_SHA1_Update(ctx, buf, 1);
	}
  }

  void patch_id_add_str(git_SHA1_CTX *ctx, const char *str)
  {
	patch_id_add_buf(ctx, strlen(str));
  }

  void patch_id_add_mode(git_SHA1_CTX *ctx, unsigned mode)
  {
	char buf[16]; /* big enough... */
	int len = xsnprintf(buf, "%06o", mode);
	patch_id_add_buf(ctx, buf, len);
  }

  patch_id_add_str(&ctx, "new file mode");
  patch_id_add_mode(&ctx, p->two->mode);
  patch_id_add_str(&ctx, "--- /dev/null");
  patch_id_add_str(&ctx, "+++ b/");
  patch_id_add_buf(&ctx, p->two->path, len2);

I dunno. I wondered if feeding single bytes to the sha1 update might
actually be noticeably slower, because I would assume that internally it
generally copies data in larger chunks. I didn't measure it, though.

-Peff
