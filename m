From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 10/10] ref-filter: introduce objectname_atom_parser()
Date: Sat, 12 Dec 2015 23:49:33 -0500
Message-ID: <CAPig+cTduYxSWh5ghmv3vM04saAqrn9TUpBZ0J=TuDOgr05itQ@mail.gmail.com>
References: <20151124214842.GA4848@sigill.intra.peff.net>
	<1448459082-24492-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 05:50:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7ybu-0007Fw-M2
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 05:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbbLMEtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 23:49:35 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36534 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbLMEte (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 23:49:34 -0500
Received: by vkay187 with SMTP id y187so137144670vka.3
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 20:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Y7disfLUgouf7CtRhUTbtwILebnto/5rMw9QD6+rqhI=;
        b=p3UPKBMXmdK3c4QFyNW0v1HQUWK5mABvGZczpVPw4z8du6CVbynAnrlnXioDpMb5q4
         syh4a+4Coz7CNZ2XOiFBzQH696YsRoQEmnuqoqxkrW3iFctMjtjSNY4HKGiVY5jF7Mco
         orC1Cb6+sV/vTmP/A5BYHjdl769lh018YqqY1ayrcqaTV2VuuMZYedtp9gK2hs5CA5Ak
         ZOBQUlpRCQG9y75FqV69EBwCiNCnfcTlkPgfcNOGYMraNuM4HFsHlS80p9GlUm4twYGi
         obylYCVA11sNGDQ0eMLIXgAMbOmsH1huyirPNbU51VKHTKiCPwZv6J5wiuAGjnTgmBLM
         8jig==
X-Received: by 10.31.182.129 with SMTP id g123mr20208083vkf.45.1449982173245;
 Sat, 12 Dec 2015 20:49:33 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 20:49:33 -0800 (PST)
In-Reply-To: <1448459082-24492-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: pAXwHF2CkMWXmlrNRhpqjR0pkb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282319>

On Wed, Nov 25, 2015 at 8:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce objectname_atom_parser() which will parse the
> '%(objectname)' atom and store information into the 'used_atom'
> structure based on the modifiers used along with the atom.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -50,6 +50,10 @@ static struct used_atom {
>                                 lines : 1,
>                                 no_lines;
>                 } contents;
> +               struct {
> +                       unsigned int shorten : 1,
> +                               full : 1;
> +               } objectname;

Same comment as in my patch 8 and 9 reviews: If 'shorten' and 'full'
are mutually exclusive, then an enum would be clearer. In fact, if
there are only these two states (full and short), then this could be a
simple boolean named 'shorten'.

>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -123,6 +127,21 @@ void contents_atom_parser(struct used_atom *atom)
> +void objectname_atom_parser(struct used_atom *atom)
> +{
> +       const char * buf;
> +
> +       if (match_atom_name(atom->str, "objectname", &buf))
> +               atom->u.objectname.full = 1;

Same comment about bogus logic as in patch 9 review: u.objectname.full
and u.objectname.shorten are both set to 1 for %(objectname:short).

> +
> +       if (!buf)
> +               return;

Same comment about misplaced blank line: Put the blank line after the
conditional rather than before or drop it altogether.

> +       if (!strcmp(buf, "short"))
> +               atom->u.objectname.shorten = 1;
> +       else
> +               die(_("improper format entered objectname:%s"), buf);

Maybe just "unrecognized objectname:%s" or something?

> +}
> +
> @@ -463,15 +482,16 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>  }
>
>  static int grab_objectname(const char *name, const unsigned char *sha1,
> -                           struct atom_value *v)
> +                          struct atom_value *v, struct used_atom *atom)
>  {
> -       if (!strcmp(name, "objectname")) {
> -               v->s = xstrdup(sha1_to_hex(sha1));
> -               return 1;
> -       }
> -       if (!strcmp(name, "objectname:short")) {
> -               v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> -               return 1;
> +       if (starts_with(name, "objectname")) {
> +               if (atom->u.objectname.shorten) {
> +                       v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +                       return 1;
> +               } else if (atom->u.objectname.full) {
> +                       v->s = xstrdup(sha1_to_hex(sha1));
> +                       return 1;
> +               }
>         }
>         return 0;
>  }
> @@ -495,7 +515,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>                         v->s = xstrfmt("%lu", sz);
>                 }
>                 else if (deref)
> -                       grab_objectname(name, obj->sha1, v);
> +                       grab_objectname(name, obj->sha1, v, &used_atom[i]);
>         }
>  }
>
> @@ -1004,7 +1024,7 @@ static void populate_value(struct ref_array_item *ref)
>                                 v->s = xstrdup(buf + 1);
>                         }
>                         continue;
> -               } else if (!deref && grab_objectname(name, ref->objectname, v)) {
> +               } else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
>                         continue;
>                 } else if (!strcmp(name, "HEAD")) {
>                         const char *head;
> --
> 2.6.2
