Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D992013C
	for <e@80x24.org>; Wed, 15 Feb 2017 01:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdBOBgY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 20:36:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:55560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbdBOBgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 20:36:23 -0500
Received: (qmail 5810 invoked by uid 109); 15 Feb 2017 01:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 01:36:23 +0000
Received: (qmail 10271 invoked by uid 111); 15 Feb 2017 01:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 20:36:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 20:36:20 -0500
Date:   Tue, 14 Feb 2017 20:36:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] clean: use warning_errno() when appropriate
Message-ID: <20170215013620.uec3fbmrcafwas6s@sigill.intra.peff.net>
References: <20170213092702.10462-1-pclouds@gmail.com>
 <20170214095449.15585-1-pclouds@gmail.com>
 <xmqqh93wabev.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BXSAUr2knrkOfO0gXYAwQoJpL2hCXy44Q37H4GE_-yVA@mail.gmail.com>
 <xmqqfujg5jjv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfujg5jjv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 05:28:36PM -0800, Junio C Hamano wrote:

> I care more about looking at errno ONLY after we saw our call to a
> system library function indicated an error, and I wanted to avoid
> doing:
> 
> 	res = dry_run ? 0 : rmdir(path);
>         saved_errno = errno;
> 	if (res) {
> 		... do something else ...
> 		errno = saved_errno;
>                 call_something_that_uses_errno();
> 
> When our call to rmdir() did not fail, or when we didn't even call
> rmdir() at all, what is in errno has nothing to do with what we are
> doing, and making a copy of it makes the code doubly confusing.
> 
> Rather, I'd prefer to see:
> 
> 	res = dry_run ? 0 : rmdir(path);
> 	if (res) {
>                 int saved_errno = errno;
> 		... do something else ...
> 		errno = saved_errno;
>                 call_something_that_uses_errno();
> 
> which makes it clear what is going on when reading the resulting
> code.
> 
> For now, I'll queue a separate SQUASH??? and wait for others to
> comment.

I don't have a strong feeling either way, but I think your second
example there is probably preferable. The reason to save errno is
because of the "something else" that may affect it, and it puts the
saving close to that.

Duy's version above keeps the saved_errno close to the syscall that
caused it, which is nicer for making sure we're saving the right thing,
and didn't get fooled by:

  res = rmdir(path);
  ... some other stuff ...
  if (res) {
          int saved_errno = errno;
	  ... something else ...
	  errno = saved_errno;

That's wrong if "some other stuff" touches errno. But I think
"saved_errno" is not the right pattern there. It is "stuff away the
result _and_ errno for this thing so we can use it later".

IOW, I'd expect it to be more like:

  rmdir_result = rmdir(path);
  rmdir_errno = errno;
  ... some other stuff ...
  if (rmdir_result)
      show_error(rmdir_errno);

And that leads to the "gee, why don't we just encode error values as
negative integers" pattern. Which I agree is nicer, but I'm not sure I
want to get into wrapping every syscall to give it a better interface.

-Peff
