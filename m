From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 05/10] ref-filter: introduce color_atom_parser()
Date: Tue, 1 Dec 2015 18:27:28 -0500
Message-ID: <CAPig+cRXgLqmUf1ZK2QnHbHM6-1Ya=iTx6Jq9YdnkO8aOsq+tQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3uKf-0006Pk-S1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbbLAX1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 18:27:33 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35087 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187AbbLAX13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:27:29 -0500
Received: by vkha189 with SMTP id a189so14466223vkh.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rMzszzkE8jjOTXlFxnl/apZQAXjf1E6jroETZrVqhOs=;
        b=kQfJ1X4cadqJzgaDHFaN2yQ+41CZ/VhSx0fdkEURKRzJxkn/lpS3kQL4/p6V2lPOap
         gSRbmwdXpmPgiSgrPXHdxQFVPve2V/QNnJ8KafqeHTvQOcsYmQqK32lP+uJGaAY4bVPs
         l4IQBaDotAjQrvxz+4Z4eVATEEtXfxamq6JJOAWyZL5HlaE9VNSHv+WVP2/fpXfr3Wlh
         GUtOj5ihvc5UflqnFeT+hCPqcXaEkwIzZM8xsQ6SeqG+JpNZ31gZruF8uSlLIfBQpB5I
         5kfJ8DsnCrfeVeVjon9xevjWmWjdVD8jxVcL3B7wvKMnUItkfVX/OeR1dk0RitOFoKhD
         KBCg==
X-Received: by 10.31.58.74 with SMTP id h71mr6863vka.151.1449012448549; Tue,
 01 Dec 2015 15:27:28 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Dec 2015 15:27:28 -0800 (PST)
In-Reply-To: <1447271075-15364-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: IOl6Xs6ehON_CkAaLySD7JipoxI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281864>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce color_atom_parser() which will parse a "color" atom and
> store its color in the "use_atom" structure for further usage in

s/use_atom/used_atom/

> 'populate_value()'.
>
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
> @@ -53,6 +56,13 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
> +void color_atom_parser(struct used_atom *atom)
> +{
> +       match_atom_name(atom->str, "color", &atom->u.color);
> +       if (!atom->u.color)
> +               die(_("expected format: %%(color:<color>)"));
> +}
> +
> @@ -175,6 +185,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>         REALLOC_ARRAY(used_atom, used_atom_cnt);
>         used_atom[at].str = xmemdupz(atom, ep - atom);
>         used_atom[at].type = valid_atom[i].cmp_type;
> +       memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
> +       if (valid_atom[i].parser)
> +               valid_atom[i].parser(&used_atom[at]);
>         if (*atom == '*')
>                 need_tagged = 1;
>         if (!strcmp(used_atom[at].str, "symref"))
> @@ -833,11 +846,10 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_push(branch, NULL);
>                         if (!refname)
>                                 continue;
> -               } else if (match_atom_name(name, "color", &valp)) {
> +               } else if (starts_with(name, "color")) {

Hmm, so this will also match "colorize". Is that desirable?

>                         char color[COLOR_MAXLEN] = "";
> +                       const char *valp = atom->u.color;
>
> -                       if (!valp)
> -                               die(_("expected format: %%(color:<color>)"));
>                         if (color_parse(valp, color) < 0)

Rather than declaring variable 'valp', why not just say:

    if (color_parse(atom->u.color, color) < 0)

?

>                                 die(_("unable to parse format"));
>                         v->s = xstrdup(color);
> --
> 2.6.2
