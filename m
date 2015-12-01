From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 02/10] ref-filter: introduce struct used_atom
Date: Tue, 1 Dec 2015 18:00:57 -0500
Message-ID: <CAPig+cRthCCK51XO2mju2VBe6Yvhy_Rp9nVvVUiWd9LuT9BxLQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:01:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3tuw-0007mx-KH
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbbLAXA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 18:00:59 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35563 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbbLAXA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:00:58 -0500
Received: by vkha189 with SMTP id a189so14132476vkh.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 15:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k4gysFkd4A747hUGUNIgLJ9qdLGBPO6pO9ijqPwcqHg=;
        b=dpf+IiTlhe7Wrx6HSu4ZeowTfIt61+j2ILaBE4Uv5NMuWGizBK+U4NR6ZbaCnlSA8o
         GNuaX1dWeUNQNmH6jxEZ9v023P7KZBVp6bowUQSprsgoPwBG0g0pPcuG/lSRvuTvVLCh
         Mz+3nK+qIcXVsR4kAzSK89jSJY3QF7npuzuX3cT+zxUGwFz0cubq72aoLIJY097QIqOP
         q8xIsJmSpbf5ApjEYD2vFCuwy+fo9ksLD7F9jVGyJpqfE4Yy4EpMe9Bfy/dqrOYZBX/s
         1B6u/gW1820qS0k0UdtZuiRS0x3UGymfrZyzAoi0jnymyzKSeJsQx+/gJYqzVK5otkmK
         hQgA==
X-Received: by 10.31.52.82 with SMTP id b79mr60119180vka.84.1449010857216;
 Tue, 01 Dec 2015 15:00:57 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Dec 2015 15:00:57 -0800 (PST)
In-Reply-To: <1447271075-15364-3-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: wG81CFz42AVSwHL1cliF_Vm1IPM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281860>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce the 'used_array' structure which would replace the existing

I guess you meant s/used_array/used_atom/ or something?

Also, s/which would/to/

> implementation of 'used_array' (which a list of atoms). This helps us

s/which a/which is a/

> parse atom's before hand and store required details into the

s/atom's/atoms/
s/before hand/beforehand/

> 'used_array' for future usage.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -16,6 +16,23 @@
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

This is really the atom's name, isn't it? If so, perhaps "name" would
be a better field name.

> +       cmp_type type;
> +} *used_atom;
> +static int used_atom_cnt, need_tagged, need_symref;
> +static int need_color_reset_at_eol;
> +
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> @@ -93,21 +110,6 @@ struct atom_value {
>  };
>
>  /*
> - * An atom is a valid field atom listed above, possibly prefixed with
> - * a "*" to denote deref_tag().
> - *
> - * We parse given format string and sort specifiers, and make a list
> - * of properties that we need to extract out of objects.  ref_array_item
> - * structure will hold an array of values extracted that can be
> - * indexed with the "atom number", which is an index into this
> - * array.
> - */
> -static const char **used_atom;
> -static cmp_type *used_atom_type;
> -static int used_atom_cnt, need_tagged, need_symref;
> -static int need_color_reset_at_eol;

You're moving this block of declarations up above the valid_atom[]
array because the previous patch added a new field named "parser" to
valid_atom[] which references 'struct used_atom' added by this patch
(2). I wonder if this movement should be done as a separate
preparatory patch to make it easier to review since, as it stands, the
reviewer has to read much more carefully to detect changes in the
moved block.

> -/*
>   * Used to parse format string and sort specifiers
>   */
>  int parse_ref_filter_atom(const char *atom, const char *ep)
> @@ -787,7 +788,8 @@ static void populate_value(struct ref_array_item *ref)
>
>         /* Fill in specials first */
>         for (i = 0; i < used_atom_cnt; i++) {
> -               const char *name = used_atom[i];
> +               struct used_atom *atom = &used_atom[i];
> +               const char *name = atom->str;

Why not just:

    const char *name = used_atom[i].str;

?

>                 struct atom_value *v = &ref->value[i];
>                 int deref = 0;
>                 const char *refname;
