From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] ref-filter: introduce objectname_atom_parser()
Date: Fri, 18 Dec 2015 01:24:50 -0500
Message-ID: <CAPig+cSFG86U=+onvJ1aaosmX3k+fzD-431q-hFTnWHpg=pZVw@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 07:24:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9oTH-0006h4-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 07:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbLRGYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 01:24:51 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36699 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbbLRGYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 01:24:51 -0500
Received: by mail-vk0-f53.google.com with SMTP id f2so21346636vkb.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 22:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XDuw8OLH4bWzlmGcfmT/Ws6ioEoUqnQEb4bDITlx2wA=;
        b=aiwMGMeskTYTg3YC7rIbQ4IVN3oI8Jo0sHXC9pYTsGcI9Vw4ob2Bi4R6yNrX9Pcch+
         qGKARpwCqqcdH0Bnw5O6750z9haZ6iVJCD+jWvAgaVJ7rgMZmbhpryV48FswSqKzxn0K
         bvfc2MiB1VmrWbavxpo6uJQeqWROvTvmYbUPFIrKK38N8gYr8QXntQ7pj17XNuyqVXi6
         xWajRcs8r8CaYAnZQ4iwQwVKZCBpda+DqOb3DpiMybpagWPNZwcKB+kD6vl6MOCn/14Z
         9jLb/PALRzLedjN6JKjHy082GEwlkEETYFDsMyoFCCuKNUlMQpyot/bBJJeJzdTrz/1C
         JtpQ==
X-Received: by 10.31.182.129 with SMTP id g123mr1136982vkf.45.1450419890365;
 Thu, 17 Dec 2015 22:24:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 22:24:50 -0800 (PST)
In-Reply-To: <1450279802-29414-12-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: vH01qg9Yw2tenSbtVkCz6a_ZZ6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282701>

On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce objectname_atom_parser() which will parse the
> '%(objectname)' atom and store information into the 'used_atom'
> structure based on the modifiers used along with the atom.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -43,6 +43,7 @@ static struct used_atom {
>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>                         unsigned int no_lines;
>                 } contents;
> +               enum { O_FULL, O_SHORT } objectname;
>         } u;
>  } *used_atom;
> @@ -124,6 +125,21 @@ static void contents_atom_parser(struct used_atom *atom)
> +static void objectname_atom_parser(struct used_atom *atom)
> +{
> +       const char * buf;
> +
> +       if (match_atom_name(atom->str, "objectname", &buf))
> +               atom->u.objectname = O_FULL;
> +       if (!buf)
> +               return;

Let me make sure that I understand this correctly.

make_atom_name("objectname") will return true only for "objectname" or
"objectname:", and will return false for anything else, such as
"objectnamely" or "schmorf". Furthermore, the only way
objectname_atom_parser() can be called is when %(objectname) or
%(objectname:...) is seen, thus match_atom_name() *must* return true
here, which means the above conditional is misleading, suggesting that
it could somehow return false.

And, if match_atom_name() did return false here, then that indicates a
programming error: objectname_atom_parser() somehow got called for
something other than %(objectname) or %(objectname:...). This implies
that the code should instead be structured like this:

    if (!match_atom_name(..., "objectname", &buf)
        die("BUG: parsing non-'objectname'")
    if (!buf)
        atom->u.objectname = O_FULL;
    else if (!strcmp(buf, "short"))
        atom->u.objectname = O_SHORT;
    else
        die(_("unrecognized %%(objectname) argument: %s"), buf);

However, this can be simplified further by recognizing that, following
this patch series, match_atom_name() is *only* called by these new
parse functions[1], which means that, as a convenience,
match_atom_name() itself could become a void rather than boolean
function and die() if the expected atom name is not found. Thus, the
code would become:

    match_atom_name(...);
    if (!buf)
        ...
    else if (!strcmp(...))
        ...
    ...

By the way, the above commentary isn't specific to this patch and
%(objectname), but is in fact also relevant for all of the preceding
patches which introduce parse functions calling match_atom_name().

More below...

[1]: ...assuming you replace the unnecessary match_atom_name() in
populate_value() with starts_with() as suggested in my patch 7/11
review addendum[2].

[2]: http://article.gmane.org/gmane.comp.version-control.git/282700

> +
> +       if (!strcmp(buf, "short"))
> +               atom->u.objectname = O_SHORT;
> +       else
> +               die(_("unrecognized %%(objectname) argument: %s"), buf);
> +}
> +
> @@ -461,15 +477,16 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
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
> +               if (atom->u.objectname == O_SHORT) {
> +                       v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +                       return 1;
> +               } else if (atom->u.objectname == O_FULL) {
> +                       v->s = xstrdup(sha1_to_hex(sha1));
> +                       return 1;
> +               }

Since 'objectname' can only ever be O_SHORT or O_FULL wouldn't it be a
programming error if it ever falls through to this point after the
closing brace? Perhaps a die("BUG:...") would be appropriate?

>         }
>         return 0;
>  }
> @@ -493,7 +510,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>                         v->s = xstrfmt("%lu", sz);
>                 }
>                 else if (deref)
> -                       grab_objectname(name, obj->sha1, v);
> +                       grab_objectname(name, obj->sha1, v, &used_atom[i]);

This patch hunk is somehow corrupt and doesn't apply. Was there some
hand-editing involved, or were some earlier patches regenerated after
this patch was made or something?

>         }
>  }
>
> @@ -999,7 +1016,7 @@ static void populate_value(struct ref_array_item *ref)
>                                 v->s = xstrdup(buf + 1);
>                         }
>                         continue;
> -               } else if (!deref && grab_objectname(name, ref->objectname, v)) {
> +               } else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
>                         continue;
>                 } else if (!strcmp(name, "HEAD")) {
>                         const char *head;
> --
> 2.6.4
