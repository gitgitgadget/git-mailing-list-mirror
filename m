From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/11] ref-filter: introduce struct used_atom
Date: Wed, 16 Dec 2015 15:57:51 -0500
Message-ID: <CAPig+cR5=8urU+Vq_doC53+T4WCmEWJdKXyMEsbL3gWxsNpmxg@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:57:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9J93-0007ed-8T
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965604AbbLPU5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:57:52 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33382 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216AbbLPU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:57:52 -0500
Received: by mail-vk0-f47.google.com with SMTP id a188so34713895vkc.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 12:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kCFlhxIQ2T4YOCkxLSqNGafORYkICpMENFZrbCe14XU=;
        b=dNFagjVBX2+ucsTwL73ftfyg1ZqUQbM6wFKrrOIGhC+1Q6WJgpkfeUBfRsHZktFpzY
         g+H0IRyw7fXnPG78ZLri9CgwVNVf5cCM0pOjLjf5qXd44ETiRnWRsqUBlq0KPJW1LPO5
         pDL3QAlUPXs1imIdT5u/cdJScEzM0bajx7cCT4K6hE2ZNmta8Y5orUvOjcoCV2QBTvY6
         KZWItEl/sUcmuik8oqCPi7IQRRHStJY58Ap1qzCpGvGy6wJOeY1hNfwimM+ksT8cdSWS
         iWlVOFB7v3Timyw6KuDMj7i4F1SrnXf3pqRr+41V8ZyXs42Gzx+qurYDJ7E4UUPA5kKy
         hP6A==
X-Received: by 10.31.52.82 with SMTP id b79mr36120750vka.84.1450299471195;
 Wed, 16 Dec 2015 12:57:51 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 12:57:51 -0800 (PST)
In-Reply-To: <1450279802-29414-4-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: nzwUeJRV1pS1DTAQs81WVH3MWBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282589>

On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce the 'used_array' structure which would replace the existing
> implementation of 'used_array' (which a list of atoms). This helps us
> parse atom's before hand and store required details into the
> 'used_array' for future usage.

All my v1 review comments[1] about the commit message still apply to
this version.

[1]: http://article.gmane.org/gmane.comp.version-control.git/281860

> Also introduce a parsing function for each atom in valid_atom. Using
> this we can define special parsing functions for each of the atoms.

This is a conceptually distinct change which probably deserves its own
patch. In particular, the new patch would add this field to
valid_atom[] *and* add the code which invokes the custom parser. (That
code is currently commingled with introduction of the color parser in
patch 6/11.)

More below...

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -16,9 +16,27 @@
> +/*
> + * An atom is a valid field atom listed below, possibly prefixed with
> + * a "*" to denote deref_tag().
> + *
> + * We parse given format string and sort specifiers, and make a list
> + * of properties that we need to extract out of objects.  ref_array_item
> + * structure will hold an array of values extracted that can be
> + * indexed with the "atom number", which is an index into this
> + * array.
> + */
> +static struct used_atom {
> +       const char *str;
> +       cmp_type type;
> +} *used_atom;
> +static int used_atom_cnt, need_tagged, need_symref;
> +static int need_color_reset_at_eol;
> +
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> +       void (*parser)(struct used_atom *atom);
>  } valid_atom[] = {
>         { "refname" },
>         { "objecttype" },
> @@ -786,7 +788,8 @@ static void populate_value(struct ref_array_item *ref)
>
>         /* Fill in specials first */
>         for (i = 0; i < used_atom_cnt; i++) {
> -               const char *name = used_atom[i];
> +               struct used_atom *atom = &used_atom[i];
> +               const char *name = atom->str;

Same question as my previous review[1]: Why not just:

    const char *name = used_atom[i].str;

?

>                 struct atom_value *v = &ref->value[i];
>                 int deref = 0;
>                 const char *refname;
