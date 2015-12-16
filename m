From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/11] ref-filter: introduce color_atom_parser()
Date: Wed, 16 Dec 2015 16:21:00 -0500
Message-ID: <CAPig+cTNEXA75Gh_jXrdhLOJpXYgyZ97TJCPHXz4DodOcjWheA@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9JVX-0000Yn-4j
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966906AbbLPVVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:21:04 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34940 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966873AbbLPVVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:21:01 -0500
Received: by mail-vk0-f42.google.com with SMTP id a189so34689049vkh.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 13:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=C2FZwdHXXSRiyYnnaMDzQpUrU8Kmqq8zFa2nBUWcTII=;
        b=Hh/6xG6h2s6sayPW4ItfDPoxW+6aGn5Pe8o7wdGcSOpZX7/gpT8Ee2p6B5yRgoLZAD
         UOqP4xOsq3YK1FZAHxIid+Kxg43L4mhgkoIqbJpwUkGH71wllszmOPyzwHZaKai5v8L9
         nQGPMfd9QMtRHG3fGU1+uEbTcKsuVwjJq/OznZBs/w5dpseUNzMUnLO42P52juiHg/AK
         C2wH6zAveFOT0M1ILYwXjNt73QjsfXr6tkFoR8aey6jPyEnzUErvmtj3PXZNUi2NxuT8
         7y4saV3D4lScoYDiHDiHB0G5KFP+q9dqOFQfMbKxmsOAHe0bDqj07fYzynEuERcwofTi
         gBDg==
X-Received: by 10.31.56.18 with SMTP id f18mr31988728vka.19.1450300860623;
 Wed, 16 Dec 2015 13:21:00 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 13:21:00 -0800 (PST)
In-Reply-To: <1450279802-29414-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: REkp-ovwKJaksI__s_st0HqiK5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282591>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce color_atom_parser() which will parse a "color" atom and
> store its color in the "use_atom" structure for further usage in

Same comment as last time: s/use_atom/used_atom/

> 'populate_value()'.

s/'//g

More below...

> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -29,6 +29,9 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  static struct used_atom {
>         const char *str;
>         cmp_type type;
> +       union {
> +               const char *color;
> +       } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
>  static int need_color_reset_at_eol;
> @@ -53,6 +56,13 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
> +static void color_atom_parser(struct used_atom *atom)
> +{
> +       match_atom_name(atom->str, "color", &atom->u.color);
> +       if (!atom->u.color)
> +               die(_("expected format: %%(color:<color>)"));
> +}
> +
> @@ -833,12 +846,10 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_push(branch, NULL);
>                         if (!refname)
>                                 continue;
> -               } else if (match_atom_name(name, "color", &valp)) {
> +               } else if (starts_with(name, "color:")) {
>                         char color[COLOR_MAXLEN] = "";
>
> -                       if (!valp)
> -                               die(_("expected format: %%(color:<color>)"));
> -                       if (color_parse(valp, color) < 0)
> +                       if (color_parse(atom->u.color, color) < 0)

It would make a lot more sense to invoke color_parse() with the
unchanging argument to "color:" just once in color_atom_parser()
rather than doing it here repeatedly. (Also, you'd drop 'const' from
used_atom.u.color declaration.)

>                                 die(_("unable to parse format"));
>                         v->s = xstrdup(color);

Does v->s get freed each time through the loop? If not, then, assuming
you parse the color just once in color_atom_parser(), then you could
just assign the parsed color directly to v->s rather than duplicating
it.

>                         continue;
> --
> 2.6.4
