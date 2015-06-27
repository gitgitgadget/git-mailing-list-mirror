From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 06:43:04 +0700
Message-ID: <CACsJy8DFrNMGBTL2xpQ6aG6huNhL-ipofPySL8_P+-EQtZyAMw@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 01:45:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8zn7-0006XS-BZ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 01:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbbF0Xnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 19:43:35 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37663 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbF0Xne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 19:43:34 -0400
Received: by igblr2 with SMTP id lr2so33676722igb.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 16:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vahJZimwqvjd9KqPaNEEIzRqnrJVLmWt/zoppi+gVhA=;
        b=GFJgJj2C64g34rcRUFBKFPxb33uM5CXS6ABUo/08wDYnQ2r5TuyzH4Su91rF9MvQzI
         QErFoZP16c0ETB7BJQ9vtT/zi8h8zuVVxYOVFKm4ZkAuc9sMp+Ac3Myomxs0OYx7Axgk
         MbsQJsZU4b0zTP07MdBrhXXbdHv0MBAarBct6/RwRqPiotqt2AUYO+2ixWg/0QBJpx0S
         XWVZ9dUNEVe8q3GTtaDSMTM8Bzgd/Wo9rw60/soSERirqNpyfW8AmK8OEm58trjV9lsN
         0VaFvej/jmk8Gt/PftOmG17Ky2rIHARqCNal131VYKO4lKfUk91zGUB4ftytKCdmhHnl
         0wdA==
X-Received: by 10.42.93.17 with SMTP id v17mr10719062icm.42.1435448613641;
 Sat, 27 Jun 2015 16:43:33 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sat, 27 Jun 2015 16:43:04 -0700 (PDT)
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272864>

On Thu, Jun 25, 2015 at 6:43 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support for %(refname:lalignX) where X is a number.
> This will print a shortened refname aligned to the left
> followed by spaces for a total length of X characters.
> If X is less than the shortened refname size, the entire
> shortened refname is printed.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 00d06bf..299b048 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -695,7 +695,22 @@ static void populate_value(struct ref_array_item *ref)
>                         int num_ours, num_theirs;
>
>                         formatp++;
> -                       if (!strcmp(formatp, "short"))
> +                       if (starts_with(formatp, "lalign")) {
> +                               const char *valp;
> +                               int val;
> +
> +                               skip_prefix(formatp, "lalign", &valp);
> +                               val = atoi(valp);
> +                               refname = shorten_unambiguous_ref(refname,
> +                                                                 warn_ambiguous_refs);
> +                               if (val > strlen(refname)) {
> +                                       struct strbuf buf = STRBUF_INIT;
> +                                       strbuf_addstr(&buf, refname);
> +                                       strbuf_addchars(&buf, ' ', val - strlen(refname));

We don't forbid non-ascii characters in refname so you probably want
to use utf8_width() here instead of strlen()

> +                                       free((char *)refname);
> +                                       refname = strbuf_detach(&buf, NULL);
> +                               }
> +                       } else if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);
>                         else if (!strcmp(formatp, "track") &&
> --
> 2.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
