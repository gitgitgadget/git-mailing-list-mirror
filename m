Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BCB1F97F
	for <e@80x24.org>; Sat, 13 Oct 2018 02:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeJMKOH (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 06:14:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:39568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726097AbeJMKOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 06:14:07 -0400
Received: (qmail 20139 invoked by uid 109); 13 Oct 2018 02:38:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Oct 2018 02:38:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16699 invoked by uid 111); 13 Oct 2018 02:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Oct 2018 22:37:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Oct 2018 22:38:45 -0400
Date:   Fri, 12 Oct 2018 22:38:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] zlib.c: use size_t for size
Message-ID: <20181013023845.GA15595@sigill.intra.peff.net>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 04:07:25PM +0900, Junio C Hamano wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e6316d294d..b9ca04eb8a 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -266,15 +266,15 @@ static void copy_pack_data(struct hashfile *f,
>  		struct packed_git *p,
>  		struct pack_window **w_curs,
>  		off_t offset,
> -		off_t len)
> +		size_t len)
>  {
>  	unsigned char *in;
> -	unsigned long avail;
> +	size_t avail;

I know there were a lot of comments about "maybe this off_t switch is
not good". Let me say something a bit stronger: I think this part of the
change is strictly worse.

copy_pack_data() looks like this right now:

  static void copy_pack_data(struct hashfile *f,
                  struct packed_git *p,
                  struct pack_window **w_curs,
                  off_t offset,
                  off_t len)
  {
          unsigned char *in;
          unsigned long avail;
  
          while (len) {
                  in = use_pack(p, w_curs, offset, &avail);
                  if (avail > len)
                          avail = (unsigned long)len;
                  hashwrite(f, in, avail);
                  offset += avail;
                  len -= avail;
          }
  }

So right now let's imagine that off_t is 64-bit, and "unsigned long" is
32-bit (e.g., 32-bit system, or an IL32P64 model like Windows). We'll
repeatedly ask use_pack() for a window, and it will tell us how many
bytes we have in "avail". So even as a 32-bit value, that just means
we'll process chunks smaller than 4GB, and this is correct (or at least
this part of it -- hold on). But we can still process the whole "len"
given by the off_t eventually.

But by switching away from off_t in the function interface, we risk
truncation before we even enter the loop. Because of the switch to
size_t, it actually works on an IL32P64 system (because size_t is big
there), but it has introduced a bug on a true 32-bit system. If your
off_t really is 64-bit (and it generally is because we #define
_FILE_OFFSET_BITS), the function will truncate modulo 2^32.

And nor will most compilers warn without -Wconversion. You can try it
with this on Linux:

  #define _FILE_OFFSET_BITS 64
  #include <unistd.h>
  
  void foo(size_t x);
  void bar(off_t x);
  
  void bar(off_t x)
  {
  
  	foo(x);
  }

That compiles fine with "gcc -c -m32 -Wall -Werror -Wextra" for me.
Adding "-Wconversion" catches it, but our code base is not close to
compiling with that warning enabled.

So I don't think this hunk is actually fixing any problems, and is
actually introducing one.

I do in general support moving to size_t over "unsigned long". Switching
avail to size_t makes sense here. It's just the off_t part that is
funny.

-Peff
