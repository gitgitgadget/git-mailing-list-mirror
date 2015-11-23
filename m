From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for
 each atom in valid_atom
Date: Mon, 23 Nov 2015 18:44:35 -0500
Message-ID: <CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 00:44:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a10ml-0008Ug-93
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 00:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbbKWXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 18:44:36 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34791 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbKWXof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 18:44:35 -0500
Received: by vkbs1 with SMTP id s1so338015vkb.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kNFQciK+0rcIdQka0SlpAMbEUhluAmUwiX8xYCnsU60=;
        b=ElqXOZckTwYRAkOM6mykcVWHL/3YSgos5GQG56AtFbUPhjZE2dQb6ReRK7gvi4yjIY
         dL+iNO7gJwbBovBvUqzNthgHlzhdZ4Du+ljFAL+qMeG2g/HiDJKUBtOoLzZqUFe+X0A5
         Wkg6o6xYsmHaKEol94Ve40pr7g0irtQbrnmMzxMsaw/0XSfP4rAs0nEhYXy4JRW1U7Bn
         4he2Srbbe3i47ki3gQxUm94zKhLKBUY3JBYlBBTs02+7/OZj6MPRjXsV0HAu9jv970B3
         nrvOxId+NZYZC6+wYGrYPoGTeN4fWxoCA9nWswfcanJC581u8Fktxk0VjVtNgVrkqFFX
         pb9Q==
X-Received: by 10.31.58.74 with SMTP id h71mr22750551vka.151.1448322275141;
 Mon, 23 Nov 2015 15:44:35 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 23 Nov 2015 15:44:35 -0800 (PST)
In-Reply-To: <1447271075-15364-2-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: PCWzZygnMZqReJEyQNXa6aR1c3s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281602>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce a parsing function for each atom in valid_atom. Using this
> we can define special parsing functions for each of the atoms. Since
> we have a third field in valid_atom structure, we now fill out missing
> cmp_type values.

I don't get it. Why do you need to "fill out missing cmp_type values"
considering that you're never assigning the third field in this patch?
Are you planning on filling in the third field in a future patch?

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -19,42 +19,43 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> +       void (*parser)(struct used_atom *atom);

Compiler diagnostic:

    warning: declaration of 'struct used_atom' will not be
        visible outside of this function [-Wvisibility]

Indeed, it seems rather odd to introduce the new field in this patch
but never actually do anything with it. It's difficult to understand
the intention.

>  } valid_atom[] = {
> -       { "refname" },
> -       { "objecttype" },
> +       { "refname", FIELD_STR },
> +       { "objecttype", FIELD_STR },
>         { "objectsize", FIELD_ULONG },
> -       { "objectname" },
> -       { "tree" },
> -       { "parent" },
> +       { "objectname", FIELD_STR },
> +       { "tree", FIELD_STR },
> +       { "parent", FIELD_STR },
>         { "numparent", FIELD_ULONG },
> -       { "object" },
> -       { "type" },
> -       { "tag" },
> -       { "author" },
> -       { "authorname" },
> -       { "authoremail" },
> +       { "object", FIELD_STR },
> +       { "type", FIELD_STR },
> +       { "tag", FIELD_STR },
> +       { "author", FIELD_STR },
> +       { "authorname", FIELD_STR },
> +       { "authoremail", FIELD_STR },
>         { "authordate", FIELD_TIME },
> -       { "committer" },
> -       { "committername" },
> -       { "committeremail" },
> +       { "committer", FIELD_STR },
> +       { "committername", FIELD_STR },
> +       { "committeremail", FIELD_STR },
>         { "committerdate", FIELD_TIME },
> -       { "tagger" },
> -       { "taggername" },
> -       { "taggeremail" },
> +       { "tagger", FIELD_STR },
> +       { "taggername", FIELD_STR },
> +       { "taggeremail", FIELD_STR },
>         { "taggerdate", FIELD_TIME },
> -       { "creator" },
> +       { "creator", FIELD_STR },
>         { "creatordate", FIELD_TIME },
> -       { "subject" },
> -       { "body" },
> -       { "contents" },
> -       { "upstream" },
> -       { "push" },
> -       { "symref" },
> -       { "flag" },
> -       { "HEAD" },
> -       { "color" },
> -       { "align" },
> -       { "end" },
> +       { "subject", FIELD_STR },
> +       { "body", FIELD_STR },
> +       { "contents", FIELD_STR },
> +       { "upstream", FIELD_STR },
> +       { "push", FIELD_STR },
> +       { "symref", FIELD_STR },
> +       { "flag", FIELD_STR },
> +       { "HEAD", FIELD_STR },
> +       { "color", FIELD_STR },
> +       { "align", FIELD_STR },
> +       { "end", FIELD_STR },
>  };
>
>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
> --
> 2.6.2
