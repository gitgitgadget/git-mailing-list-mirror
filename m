From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/11] ref-filter: introduce contents_atom_parser()
Date: Thu, 17 Dec 2015 04:39:02 -0500
Message-ID: <CAPig+cRmUe4SRzmiV13XWSYou8M7TuDE3Ko37g8p-q2kEQNU+w@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-11-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 10:39:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9V1o-0002cr-5M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 10:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbLQJjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 04:39:08 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36278 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbLQJjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 04:39:03 -0500
Received: by mail-vk0-f51.google.com with SMTP id f2so4376786vkb.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 01:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BI4zSbPEcsYUYJNGIxy2156yD33L/xhkS86NRmE4UA8=;
        b=AOZbyqKyfPa5NM5UKZXpf7W5n9nogJB5gGM8ChJ+Y2ICj07vycS03F0Nc6ZBGZ5bK3
         Qe/X6WhEt/9KPfPqV5L3LDgRrFW66DUSLXmP6X3PLW4FYOa15wNORbr7lOwriaqfi89C
         tRJ7pTF2Br7MWjbntY0aA+dXXFbC4Wfv1oIbvsxdBsvIhSs+xUomjZlaPzygEr/KixM6
         vg+V+Mj7/Lx+M94SXBGyMpgwfJ7LILl5V8T3sAwkHTfmzD5Ak7LuZSuMoWpo6YEdXcvi
         fZstMqpTiWEWYTKUkYkbI7KnmMM/me1Do4G/vAm4wbjtoDunEXzxtG5xYMhvrtTThoTs
         F7DA==
X-Received: by 10.31.58.142 with SMTP id h136mr37895311vka.115.1450345142266;
 Thu, 17 Dec 2015 01:39:02 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 01:39:02 -0800 (PST)
In-Reply-To: <1450279802-29414-11-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: 6AtFjNjex_ncllkZIs8kPRtQbEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282645>

On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce contents_atom_parser() which will parse the '%(contents)'
> atom and store information into the 'used_atom' structure based on the
> modifiers used along with the atom.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -39,6 +39,10 @@ static struct used_atom {
>                 struct align align;
>                 enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
>                         remote_ref;
> +               struct {
> +                       enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
> +                       unsigned int no_lines;

'no_lines' sounds like "no lines!". How about 'nlines' instead?

> +               } contents;
>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -90,6 +94,36 @@ static void remote_ref_atom_parser(struct used_atom *atom)
> +static void contents_atom_parser(struct used_atom *atom)
> +{
> +       const char * buf;
> +
> +       if (match_atom_name(atom->str, "contents", &buf))
> +               atom->u.contents.option = C_BARE;
> +       else if (match_atom_name(atom->str, "subject", &buf)) {

The original code used strcmp() and matched only "subject", however
the new code will incorrectly match both "subject" and
"subject:whatever". Therefore, you should be using strcmp() here
rather than match_atom_name().

Ditto for "body".

> +               atom->u.contents.option = C_SUB;
> +               return;
> +       } else if (match_atom_name(atom->str, "body", &buf)) {
> +               atom->u.contents.option = C_BODY_DEP;
> +               return;
> +       }
> +       if (!buf)
> +               return;

It's not easy to see that this 'if (!buf)' check relates to the
"contents" check at the very top of the if/else if/ chain since there
are entirely unrelated checks in between. Reorganizing it can improve
clarity:

    if (!strcmp("subject")) {
        ...
        return;
    } else if (!strcmp("body")) {
        ...
        return;
    } else if (!match_atom_name(...,"contents", &buf))
        die("BUG: expected 'contents' or 'contents:'");

    if (!buf) {
        atom->u.contents.option = C_BARE;
        return;
    }

> +       if (!strcmp(buf, "body"))
> +               atom->u.contents.option = C_BODY;
> +       else if (!strcmp(buf, "signature"))
> +               atom->u.contents.option = C_SIG;
> +       else if (!strcmp(buf, "subject"))
> +               atom->u.contents.option = C_SUB;
> +       else if (skip_prefix(buf, "lines=", &buf)) {
> +               atom->u.contents.option = C_LINES;
> +               if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
> +                       die(_("positive value expected contents:lines=%s"), buf);
> +       } else
> +               die(_("unrecognized %%(contents) argument: %s"), buf);
> +}
> @@ -777,28 +801,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>                                     &bodypos, &bodylen, &nonsiglen,
>                                     &sigpos, &siglen);
>
> -               if (!strcmp(name, "subject"))
> +               if (atom->u.contents.option == C_SUB)
>                         v->s = copy_subject(subpos, sublen);
> -               else if (!strcmp(name, "contents:subject"))
> -                       v->s = copy_subject(subpos, sublen);
> -               else if (!strcmp(name, "body"))
> +               else if (atom->u.contents.option == C_BODY_DEP)
>                         v->s = xmemdupz(bodypos, bodylen);
> -               else if (!strcmp(name, "contents:body"))
> +               else if (atom->u.contents.option == C_BODY)
>                         v->s = xmemdupz(bodypos, nonsiglen);
> -               else if (!strcmp(name, "contents:signature"))
> +               else if (atom->u.contents.option == C_SIG)
>                         v->s = xmemdupz(sigpos, siglen);
> -               else if (!strcmp(name, "contents"))
> -                       v->s = xstrdup(subpos);
> -               else if (skip_prefix(name, "contents:lines=", &valp)) {
> +               else if (atom->u.contents.option == C_LINES) {
>                         struct strbuf s = STRBUF_INIT;
>                         const char *contents_end = bodylen + bodypos - siglen;
>
> -                       if (strtoul_ui(valp, 10, &v->u.contents.lines))
> -                               die(_("positive value expected contents:lines=%s"), valp);
>                         /*  Size is the length of the message after removing the signature */
> -                       append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
> +                       append_lines(&s, subpos, contents_end - subpos, atom->u.contents.no_lines);
>                         v->s = strbuf_detach(&s, NULL);
> -               }
> +               } else if (atom->u.contents.option == C_BARE)
> +                       v->s = xstrdup(subpos);
>         }
>  }
>
> --
> 2.6.4
