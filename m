From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 07/11] dir: add new_untracked_cache()
Date: Wed, 23 Dec 2015 17:53:49 -0500
Message-ID: <CAPig+cQoho_EAjvS2z5Wa3jV2zd_bMzdZRP5PFyruqB=cXGigw@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
	<1450904639-25592-8-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 23:54:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBsIJ-0007gN-NO
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 23:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbbLWWyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 17:54:01 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36526 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbbLWWxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 17:53:49 -0500
Received: by mail-vk0-f54.google.com with SMTP id f2so101771762vkb.3
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XHKdVLMeCItR5gLWK5bUXE2D6QMl4cch659O5WRgf4Y=;
        b=zaKuJ0I0Ool+aZNK7uxDcb1D2jbcCMBB4HXCTwSlEPTz2NFj7FzWW/jRE8FIGj10aE
         mzsb6iWaok2pLYQ912Tl+Y4fcaDyc23NgXM2eELV9WxGBN1iVKu1SQ4QtZNm+DuZYJDx
         wADU1t2gKqSccbCJVbWbSiYWdYiB6XDuY7P4ZiNaaCIHpq2Xd0N2L6Kf1H0fzbuv6iUL
         zpp+IyBAtZEn66yLjQiqcMnTBjkZDQwpOpIisvGKPtYIva3ZLjJn8eRJR73JINqYT3SA
         I4HGmvLo3Ngh901BrZYTioNMG/5iwGmmYeQBKCJrkNfg5pA3FX6/5IO9qUFWvtUW/6i1
         W2GQ==
X-Received: by 10.31.182.129 with SMTP id g123mr21196041vkf.45.1450911229129;
 Wed, 23 Dec 2015 14:53:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 23 Dec 2015 14:53:49 -0800 (PST)
In-Reply-To: <1450904639-25592-8-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: Wv0u_gLN8dQN8cUtzkYDEmhXC0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282968>

On Wed, Dec 23, 2015 at 4:03 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>     Factor out code into new_untracked_cache(), which will be used
>     multiple times in a later commit.

Odd indentation: s/^\s+//

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/dir.c b/dir.c
> @@ -1938,16 +1938,20 @@ void add_untracked_ident(struct untracked_cache *uc)
>         strbuf_addch(&uc->ident, 0);
>  }
>
> +static void new_untracked_cache(void)
> +{
> +       struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
> +       strbuf_init(&uc->ident, 100);
> +       uc->exclude_per_dir = ".gitignore";
> +       /* should be the same flags used by git-status */
> +       uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +       the_index.untracked = uc;
> +}

This and the previous patch both move the same code around. As a
reviewer, I could easily see the two patches combined, and would not
find the unified patch onerous to review.

>  void add_untracked_cache(void)
>  {
> -       if (!the_index.untracked) {
> -               struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
> -               strbuf_init(&uc->ident, 100);
> -               uc->exclude_per_dir = ".gitignore";
> -               /* should be the same flags used by git-status */
> -               uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> -               the_index.untracked = uc;
> -       }
> +       if (!the_index.untracked)
> +               new_untracked_cache();
>         add_untracked_ident(the_index.untracked);
>         the_index.cache_changed |= UNTRACKED_CHANGED;
>  }
> --
> 2.7.0.rc2.11.g68ccdd4
