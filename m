From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 09/10] ref-filter: introduce contents_atom_parser()
Date: Sat, 12 Dec 2015 22:10:16 -0500
Message-ID: <CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-10-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 04:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7x3H-0006dj-DU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 04:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbLMDKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 22:10:18 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36434 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbLMDKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 22:10:17 -0500
Received: by vkay187 with SMTP id y187so136638169vka.3
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 19:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FdoX2xaadY+y87cI0xraK3hDLGIvtuByx9EcihMYZpc=;
        b=eGAhzaOKYm+Q1uM5MK7fTFHzgw/D+gsl2jyRfgl+AtcatQ92WWiE/nVP9sA1jK7wbI
         opj7UrXFLTofVeGYwZJDd9fGMKXUqFPa4cOxubTjdfZRGB7NnrUdJ3BYRg4Eahe1BXwN
         jRRnhIlSyYIITRBhx8u8mDHNd432RX02CWsZBW/w3Lz0CL/q1C63cLb4wk4Gj0Et6SUO
         RI9SqxffoT2xA3SN/ThtHh+AE3vxC/E5bfbBDoh+AtymnvSk+stTMd3UWCof5voujVT+
         x+Rm8tpj9HTOAqkHfEPugl551AYMpENO5msZ18BjweWh6+6t8G4/adKKJPlE+0bahcdS
         FbxQ==
X-Received: by 10.31.47.130 with SMTP id v124mr20172059vkv.117.1449976216270;
 Sat, 12 Dec 2015 19:10:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 19:10:16 -0800 (PST)
In-Reply-To: <1447271075-15364-10-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: ciYV8nL9IS5FXbfjqvWWiVt1qtU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282317>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce contents_atom_parser() which will parse the '%(contents)'
> atom and store information into the 'used_atom' structure based on the
> modifiers used along with the atom.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index 802629b..117bbbb 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -42,6 +42,14 @@ static struct used_atom {
>                                 track : 1,
>                                 trackshort : 1;
>                 } remote_ref;
> +               struct {
> +                       unsigned int subject : 1,
> +                               body : 1,
> +                               signature : 1,
> +                               all : 1,
> +                               lines : 1,
> +                               no_lines;
> +               } contents;

Same question as patch 8/10: With the exception of non-bitfield
'no_lines', are these 'contents' flags mutually exclusive? If so, an
enum would be a more natural representation than bitfields.

>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -92,6 +100,29 @@ void remote_ref_atom_parser(struct used_atom *atom)
> +void contents_atom_parser(struct used_atom *atom)
> +{
> +       const char * buf;
> +
> +       if (match_atom_name(atom->str, "contents", &buf))
> +               atom->u.contents.all = 1;
> +
> +       if (!buf)
> +               return;

Hmm, I'd have placed the blank line after the 'if (!buf) return;'
rather than before it.

> +       if (!strcmp(buf, "body"))
> +               atom->u.contents.body = 1;
> +       else if (!strcmp(buf, "signature"))
> +               atom->u.contents.signature = 1;
> +       else if (!strcmp(buf, "subject"))
> +               atom->u.contents.subject = 1;
> +       else if (skip_prefix(buf, "lines=", &buf)) {
> +               atom->u.contents.lines = 1;
> +               if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
> +                       die(_("positive value expected contents:lines=%s"), buf);
> +       } else
> +               die(_("improper format entered contents:%s"), buf);

Perhaps a more grammatically-friendly error message?

> +}
> +
>  static align_type get_align_position(const char *type)
>  {
>         if (!strcmp(type, "right"))
> @@ -761,20 +786,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>         unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
>
>         for (i = 0; i < used_atom_cnt; i++) {
> -               const char *name = used_atom[i].str;
> +               struct used_atom *atom = &used_atom[i];
> +               const char *name = atom->str;
>                 struct atom_value *v = &val[i];
> -               const char *valp = NULL;
>                 if (!!deref != (*name == '*'))
>                         continue;
>                 if (deref)
>                         name++;
>                 if (strcmp(name, "subject") &&
>                     strcmp(name, "body") &&
> -                   strcmp(name, "contents") &&
> -                   strcmp(name, "contents:subject") &&
> -                   strcmp(name, "contents:body") &&
> -                   strcmp(name, "contents:signature") &&
> -                   !starts_with(name, "contents:lines="))
> +                   !atom->u.contents.all)
>                         continue;
>                 if (!subpos)
>                         find_subpos(buf, sz,
> @@ -784,26 +805,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>
>                 if (!strcmp(name, "subject"))
>                         v->s = copy_subject(subpos, sublen);
> -               else if (!strcmp(name, "contents:subject"))
> +               else if (atom->u.contents.subject)
>                         v->s = copy_subject(subpos, sublen);

With the disclaimer that I haven't fully digested the existing logic,
is there a reason that you don't also preprocess bare "subject" as you
preprocess "contents:subject"? Isn't "subject" just historic aliases
for "contents:subject"?

A similar observation may be made about "body" and "contents:body",
although I see they mean slightly different things (for, I suppose,
historical reasons).

>                 else if (!strcmp(name, "body"))
>                         v->s = xmemdupz(bodypos, bodylen);
> -               else if (!strcmp(name, "contents:body"))
> +               else if (atom->u.contents.body)
>                         v->s = xmemdupz(bodypos, nonsiglen);
> -               else if (!strcmp(name, "contents:signature"))
> +               else if (atom->u.contents.signature)
>                         v->s = xmemdupz(sigpos, siglen);
> -               else if (!strcmp(name, "contents"))
> -                       v->s = xstrdup(subpos);
> -               else if (skip_prefix(name, "contents:lines=", &valp)) {
> +               else if (atom->u.contents.lines) {
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
> +               } else /*  For %(contents) without modifiers */

Too many blanks following '/*'; downcase 'for' or drop it altogether:

    /* bare %(contents) */

> +                       v->s = xstrdup(subpos);
>         }
>  }
>
> --
> 2.6.2
