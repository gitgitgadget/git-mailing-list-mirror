From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/11] ref-filter: introduce align_atom_parser()
Date: Wed, 16 Dec 2015 16:54:41 -0500
Message-ID: <CAPig+cR=dYnMfaHUYcq_kz8M+C1nCxOX=SN=_6+ep1aWvVCUow@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:54:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9K22-00023s-No
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966625AbbLPVyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:54:43 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33617 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbLPVym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:54:42 -0500
Received: by mail-vk0-f51.google.com with SMTP id a188so35602086vkc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SW2Yo6iUakHlpkZLz0MHgkwPAnTbgOEoO8IV4f/8eks=;
        b=m/iLQCRd3/IUYwe7PySTvuAP1xcQAc1hbshI4X7b9HCsSGOUq3Bngagmf5aLsrncw3
         i906Oqi4WDeJ2huvMoT+piGq9RIEbmumfjsG+23ov3kccdtNnIDi0fYzetxVwEAnKxZa
         GNvD00heDl6HqjTLopJKfLQ8IoSMw6fG/dxbgm7SLkC9IMjWZfuIx9taSh9F5TrjMdmd
         G+BBmDVKHtKlZlazxDDp+ddgw9RIG+4XxTPiHPNgQ8OlT7ZVq7ibG/AzAdU838T6kfeG
         HMc21/gYbKJb5VA9ACnRYda2oje0dBjfKPEVDO/B35thXnfDirKxiUs8U9c7BygD6FyE
         CZFQ==
X-Received: by 10.31.52.82 with SMTP id b79mr36294723vka.84.1450302881500;
 Wed, 16 Dec 2015 13:54:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 13:54:41 -0800 (PST)
In-Reply-To: <1450279802-29414-8-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: tTCF1mZz1y2kPhNBtnlJpwo6MgY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282596>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce align_atom_parser() which will parse an "align" atom and
> store the required alignment position and width in the "use_atom"
> structure for further usage in 'populate_value()'.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -63,6 +69,49 @@ static void color_atom_parser(struct used_atom *atom)
> +static align_type parse_align_position(const char *s)
> +{
> +       if (!strcmp(s, "right"))
> +               return ALIGN_RIGHT;
> +       else if (!strcmp(s, "middle"))
> +               return ALIGN_MIDDLE;
> +       else if (!strcmp(s, "left"))
> +               return ALIGN_LEFT;
> +       return -1;
> +}
> +
> +static void align_atom_parser(struct used_atom *atom)
> +{
> +       struct align *align = &atom->u.align;
> +       const char *buf = NULL;
> +       struct strbuf **s, **to_free;
> +       int width = -1;
> +
> +       match_atom_name(atom->str, "align", &buf);
> +       if (!buf)
> +               die(_("expected format: %%(align:<width>,<position>)"));
> +       s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
> +
> +       align->position = ALIGN_LEFT;
> +
> +       while (*s) {
> +               int position;
> +
> +               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))

This casting is pretty ugly. It probably would be cleaner to declare
'width' as 'unsigned int' and initialize it with ~0U than to do this
ugly and potentially dangerous casting. Likewise, below where you
check 'width < 0', you'd check instead for ~0U. However, such a change
should not be part of the current patch, but rather as a separate
preparatory patch.

> +                       ;
> +               else if ((position = parse_align_position(s[0]->buf)) > 0)

Shouldn't this be '>=' rather than '>'?

This likely would have been easier to spot if parse_align_position()
had been factored out in its own patch, as suggested by my v1
review[1], since the caller would have been trivially inspectable
rather than having to keep track of both code movement and changes.

[1]: http://article.gmane.org/gmane.comp.version-control.git/281916

> +                       align->position = position;
> +               else
> +                       die(_("unrecognized %%(align) argument: %s"), s[0]->buf);
> +               s++;
> +       }
> +
> +       if (width < 0)
> +               die(_("positive width expected with the %%(align) atom"));
> +       align->width = width;
> +       strbuf_list_free(to_free);
> +}
> +
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> @@ -880,35 +924,7 @@ static void populate_value(struct ref_array_item *ref)
>                                 v->s = " ";
>                         continue;
>                 } else if (match_atom_name(name, "align", &valp)) {
> -                       struct align *align = &v->u.align;
> -                       struct strbuf **s, **to_free;
> -                       int width = -1;
> -
> -                       if (!valp)
> -                               die(_("expected format: %%(align:<width>,<position>)"));
> -
> -                       s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
> -
> -                       align->position = ALIGN_LEFT;
> -
> -                       while (*s) {
> -                               if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
> -                                       ;
> -                               else if (!strcmp(s[0]->buf, "left"))
> -                                       align->position = ALIGN_LEFT;
> -                               else if (!strcmp(s[0]->buf, "right"))
> -                                       align->position = ALIGN_RIGHT;
> -                               else if (!strcmp(s[0]->buf, "middle"))
> -                                       align->position = ALIGN_MIDDLE;
> -                               else
> -                                       die(_("improper format entered align:%s"), s[0]->buf);
> -                               s++;
> -                       }
> -
> -                       if (width < 0)
> -                               die(_("positive width expected with the %%(align) atom"));
> -                       align->width = width;
> -                       strbuf_list_free(to_free);
> +                       v->u.align = atom->u.align;
>                         v->handler = align_atom_handler;
>                         continue;
>                 } else if (!strcmp(name, "end")) {
> --
> 2.6.4
