From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/10] branch: roll show_detached HEAD into regular ref_list
Date: Mon, 10 Aug 2015 22:41:57 -0400
Message-ID: <CAPig+cRvdpv_NO8jCrWmFfpuQ+mcxaC5P_oHVrU+tQoH9DKnkg@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
	<1438693282-15516-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 04:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOzWH-0008Ht-Bw
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 04:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbbHKCl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 22:41:58 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34661 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbbHKCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 22:41:58 -0400
Received: by ykdt205 with SMTP id t205so75767186ykd.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n8InK+n0XbTGxhsGv53FoqZnToG1pspRuoYCB7wIJ28=;
        b=kxYShe+GErMrSgnakt/D4v/nQDqEvDx9vw1/st6sQmmbe9bpdrl6eSlI1q8OU9QyIm
         MBtAveHTi/iShwu7cJdgCqrvISB/jTnQ9wCs5vetCMTWSwSy3HIl/amn9pY5k9Fc+yG1
         kQrnpICMJR/PjfA7StdQOLL4+NqpbxMYbD59dxg/2jFlYfbUkVqnZim3IidoOby/LC8T
         cysxW1crwUKDS2HR9EpS8sXD8KPYr6qqEH64BtUwYszIh9q8ZzB1ghvn0eKcfvRz9PQR
         IN3SrD/YLbwXR8kNIAMKhfRW9JGi8rgz71Q5YQcPg2hf53IZDdV4bIbBTZhqt0pDA8nO
         P3lw==
X-Received: by 10.13.207.1 with SMTP id r1mr25199444ywd.166.1439260917519;
 Mon, 10 Aug 2015 19:41:57 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 19:41:57 -0700 (PDT)
In-Reply-To: <1438693282-15516-4-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: WKiYqW02LlhJJQeyjtLl8NsPZZs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275669>

On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Remove show_detached() and make detached HEAD to be rolled into
> regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
> supporting the same in append_ref(). This eliminates the need for an
> extra function and helps in easier porting of branch.c to use
> ref-filter APIs.
>
> Before show_detached() used to check if the HEAD branch satisfies the
> '--contains' option, now that is taken care by append_ref().
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 65f6d0d..81815c9 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -535,6 +540,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>         int color;
>         struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
>         const char *prefix = "";
> +       const char *desc = item->name;
>
>         if (item->ignore)
>                 return;
> @@ -547,6 +553,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>                 color = BRANCH_COLOR_REMOTE;
>                 prefix = remote_prefix;
>                 break;
> +       case REF_DETACHED_HEAD:
> +               color = BRANCH_COLOR_CURRENT;
> +               desc = get_head_description();
> +               break;
>         default:
>                 color = BRANCH_COLOR_PLAIN;
>                 break;
> @@ -558,7 +568,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>                 color = BRANCH_COLOR_CURRENT;
>         }
>
> -       strbuf_addf(&name, "%s%s", prefix, item->name);
> +       strbuf_addf(&name, "%s%s", prefix, desc);
>         if (verbose) {
>                 int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
>                 strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
> @@ -581,6 +591,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>         }
>         strbuf_release(&name);
>         strbuf_release(&out);
> +       if (item->kind == REF_DETACHED_HEAD)
> +               free((void *)desc);

This would be cleaner, and more easily extended to other cases if you
used a 'to_free' variable. For instance, something like this:

    const char *desc = item->name;
    char *to_free = NULL;
    ...
    case REF_DETACHED_HEAD:
        ...
        desc = to_free = get_head_description();
        break;
    ...
    strbuf_addf(&name, "%s%s", prefix, desc);
    ...
    free(to_free);

Note that it's safe to free 'to_free' when it's NULL, so you don't
need to protect the free() with that ugly specialized 'if' which
checks for REF_DETACHED_HEAD. You can also do away with the "cast to
non-const" when freeing.

>  }
> @@ -642,7 +638,14 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>         cb.ref_list = &ref_list;
>         cb.pattern = pattern;
>         cb.ret = 0;
> +       /*
> +        * First we obtain all regular branch refs and then if the

s/then//

> +        * HEAD is detached then we insert that ref to the end of the
> +        * ref_fist so that it can be printed first.
> +        */
>         for_each_rawref(append_ref, &cb);
> +       if (detached)
> +               head_ref(append_ref, &cb);
