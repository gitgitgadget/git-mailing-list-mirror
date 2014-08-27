From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] log-tree: use FLEX_ARRAY in name_decoration
Date: Tue, 26 Aug 2014 20:30:08 -0400
Message-ID: <CAPig+cTHLOAe+mHr9jiR-k-3yrXfrAEjUSrHG=92kRSEGyto8Q@mail.gmail.com>
References: <20140826102051.GA4885@peff.net>
	<20140826102420.GC25687@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMR7w-0005TL-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbaH0AaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:30:09 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:36234 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbaH0AaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:30:08 -0400
Received: by mail-yh0-f47.google.com with SMTP id f10so12732383yha.20
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pnzkh2y85Az2qX5+aTATB1aHLOUO5qliE6iYjZ3S0R8=;
        b=lcEM1VpkdR3xKxahtuTAyhpQbGHllJ0pxYXdmYpJd6400LlhR8MHHImMIGxa3LmTtd
         gjBYNM2tgF7P54JdolwjR7PcfsLVjqwIq9xydl66I9I2et3+UvViNe1CCntsF5Uo4ilN
         dq3oMYFbcq5VPwdUsCnbBcvqbYCfVN+r3osKdOxJbPdWCQgSA5HkKmPjESuX7oi4vvc+
         n4Gr/Q7htPKqBItMizJ/tW/bXiGRnBQbLGiOhrb46mSlbbVCA2Ri2j/m0iqC/eI156d3
         Egvm3gTXUxohGK/lnr8jN5U4UY432iGPvEkC74IFYgi0bYO9v9qariaezxS2qk2H6wRq
         fbIg==
X-Received: by 10.236.157.134 with SMTP id o6mr5245396yhk.92.1409099408299;
 Tue, 26 Aug 2014 17:30:08 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Tue, 26 Aug 2014 17:30:08 -0700 (PDT)
In-Reply-To: <20140826102420.GC25687@peff.net>
X-Google-Sender-Auth: WFpBM0ymWsmn_pTnhBtsduaKBZ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255958>

On Tue, Aug 26, 2014 at 6:24 AM, Jeff King <peff@peff.net> wrote:
> We are already using the flex-array technique; let's
> annotate it with our usual FLEX_ARRAY macro. Besides being
> more readable, this is slightly more efficient on compilers
> that understand flex-arrays.
>
> Note that we need to bump the allocation in add_name_decoration,
> which did not explicitly add one byte for the NUL terminator
> of the string we putting into the flex-array (it did not

s/we/we are/

> need to before, because the struct itself was over-allocated
> by one byte).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This could come first in the series, but doing it last means we only
> have to update one spot. :)
>
>  commit.h   | 2 +-
>  log-tree.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index 263b49e..1516fc9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -29,7 +29,7 @@ extern const char *commit_type;
>  struct name_decoration {
>         struct name_decoration *next;
>         int type;
> -       char name[1];
> +       char name[FLEX_ARRAY];
>  };
>
>  enum decoration_type {
> diff --git a/log-tree.c b/log-tree.c
> index 7cbc4ee..fb60018 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -77,7 +77,7 @@ int parse_decorate_color_config(const char *var, const int ofs, const char *valu
>  void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
>  {
>         int nlen = strlen(name);
> -       struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
> +       struct name_decoration *res = xmalloc(sizeof(*res) + nlen + 1);
>         memcpy(res->name, name, nlen + 1);
>         res->type = type;
>         res->next = add_decoration(&name_decoration, obj, res);
> --
> 2.1.0.346.ga0367b9
