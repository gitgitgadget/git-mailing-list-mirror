From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/11] ref-filter: introduce align_atom_parser()
Date: Fri, 18 Dec 2015 00:50:30 -0500
Message-ID: <CAPig+cTvKL9C0M3NKF395dq6yCP94AL+iDe0EGRaK9xYDZ0YuQ@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 06:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9nw3-0000M1-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 06:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbbLRFuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 00:50:32 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34692 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbLRFub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 00:50:31 -0500
Received: by mail-vk0-f47.google.com with SMTP id j66so59681889vkg.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 21:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wRbsd/NcAc0cBecc9cdnVQ6o+rSwI0MdjhXAiXv8IQk=;
        b=pbxKALwC00N54unszpK5nueQx05OPFnuz6l1MH6Ps+uir4zZA5kCpU1zdGB75aQcfN
         CeBVYujU4xI2ABsCjTY6u0AlGUbDQYbG8NRvSU4MoYw5l1O5pNAlE2eCXRCS3p7272Ns
         yj/s/QduASeDiDRBJAK4FOadqrVsyzyeXAUi8CWjJUEdL+2MsotPldhaQd4sfUexK838
         3NpakkncOZGgJlzz0W1//LeK1jMgm6e8LSGl9jDurTTKlgF9FhGDkZZYKJbfBii7avyY
         ArShuBQ5l5ncIucXn8niqWOPeL1RDk/4syPa1rurJwOW8GAQcE+fn8dGJEQENqfAtSLo
         9fZQ==
X-Received: by 10.31.52.82 with SMTP id b79mr1140259vka.84.1450417830347; Thu,
 17 Dec 2015 21:50:30 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 21:50:30 -0800 (PST)
In-Reply-To: <1450279802-29414-8-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: HJB6RcM48a2GHe3EL10Eb-_g9Jo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282700>

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
> +static void align_atom_parser(struct used_atom *atom)
> +{
> +       [...]
> +       match_atom_name(atom->str, "align", &buf);
> +       if (!buf)
> +               die(_("expected format: %%(align:<width>,<position>)"));
> +       [...]
> +}
> @@ -880,35 +924,7 @@ static void populate_value(struct ref_array_item *ref)
>                                 v->s = " ";
>                         continue;
>                 } else if (match_atom_name(name, "align", &valp)) {

Hmm, align_atom_parser() has already been called before we get here,
right? And it has already invoked match_atom_name() and died if the
argument to "align:" was missing, correct? If so, then this invocation
of match_atom_name() in populate_value() is unnecessary and should be
replaced with a simpler starts_with("align:").

Plus, 'valp' is not used, aside from this unnecessary
match_atom_name(), thus it can be removed as well.

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
