From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 05/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Sat, 29 Aug 2015 23:30:02 -0400
Message-ID: <CAPig+cRHc29TL=sHv3dkEewVQzPo0m8O4d1VL+dWA6PC5pHowA@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 05:30:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVtJp-00072B-QM
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 05:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbbH3DaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 23:30:04 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36624 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbbH3DaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 23:30:03 -0400
Received: by ykey204 with SMTP id y204so18210352yke.3
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JQ6D8TQUXvzKhXMi286yF+KAUl1Xt7Q9XVLtGsSKp6E=;
        b=d70r7JtdP9jnvoPdI5cyxGZU4wt/PL7HAlGvsBzQ3k+yCpAzLfbjI+832ZRx9pG68q
         OvZdV0NLtnUmclg/0C46xdCpWZhfQEt0UJZ+NF5NgUhBgDQV7+6CNPb1InNGVxrIAmMc
         jMwwt0c3j6lceydEUjJUzyqteu8yXoKPvZBlEc0dm9a27Q/31Ot5pgNJ59XhGj3JwPht
         Z/PSo7kz92PaA7xDYznXsAJT5ubv0hVxtvo0HNDZjCQfoOgIB5UdmMpOrTglzxLYAm2N
         gHIE5HGmo96PQ6NR4ueZ7KOsjhzTfdwrlprPuKpiFwD4y5Vl9zo8HKJl0OQHdhDTXoU1
         Z3IQ==
X-Received: by 10.13.201.130 with SMTP id l124mr15655919ywd.39.1440905402374;
 Sat, 29 Aug 2015 20:30:02 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sat, 29 Aug 2015 20:30:02 -0700 (PDT)
In-Reply-To: <1440857537-13968-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 0766llxmVxFwGnL4gKITXghN1mc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276799>

On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a function called 'for_each_fullref_in()' to refs.{c,h} which
> iterates through each ref for the given path without trimming the path
> and also accounting for broken refs, if mentioned.
>
> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
> handled and return the kind to 'ref_filter_handler()', where we
> discard refs which we do not need and assign the kind to needed refs.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/refs.c b/refs.c
> index 4e15f60..a9469c2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2108,6 +2108,15 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
>         return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
>  }
>
> +int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)

Booleans such as 'broken' are typically declared 'int' in this
codebase, rather than 'unsigned int'.

> +{
> +       unsigned int flag = 0;
> +
> +       if (broken)
> +               flag = DO_FOR_EACH_INCLUDE_BROKEN;
> +       return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
> +}
> +
>  int for_each_ref_in_submodule(const char *submodule, const char *prefix,
>                 each_ref_fn fn, void *cb_data)
>  {
> diff --git a/refs.h b/refs.h
> index e9a5f32..6d30c98 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -173,6 +173,7 @@ typedef int each_ref_fn(const char *refname,
>  extern int head_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
> +extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
>  extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
