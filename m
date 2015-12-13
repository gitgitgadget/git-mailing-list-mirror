From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 08/10] ref-filter: introduce remote_ref_atom_parser()
Date: Sat, 12 Dec 2015 19:53:41 -0500
Message-ID: <CAPig+cQrTvDQdCiJGLs8iFj2nS1RvtzbSrDRBpx500JRsAiEtQ@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:53:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7uv4-0008Jk-JW
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbbLMAxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:53:42 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32998 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbLMAxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:53:41 -0500
Received: by vkca188 with SMTP id a188so136737930vkc.0
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jg0k0SvKJ1s00Yguc8y2mbd6KqKwUVQ6JtIX4CXOu+k=;
        b=xjsBG3gBacymSRme38yZTKtnfFckCzipb1O/xZrjvXuTt1Utn/kPlEHB8EU4CFZQbC
         XHdEyCcjfdSlG8UG/+xGtbtmypdV1x9IAiBLy82YrgkwCxmoUwoOB++K7dg8VxyFVVLD
         QfLi0RxIxwLKPO7hzSCV0HC8HlQyQBwLfIh6o4J0R1gMSKNmzRsum9i4kieiCnqwtRt8
         bp1Vz//6Nf8IVthDN7ONbfLP4r7DcK29fMxUChqmBSvPAl/ErlXvPHdzD2co/SbLJvL1
         PNN7xvVshOwC0RsaFSkz/mu9xdoPmYZcs6oJPp+1W2i+x7lC7754Ungx/D3WRb1nCmlK
         a+Ew==
X-Received: by 10.31.182.129 with SMTP id g123mr19721569vkf.45.1449968021216;
 Sat, 12 Dec 2015 16:53:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 16:53:41 -0800 (PST)
In-Reply-To: <1447271075-15364-9-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: DEbPKUU-NQySQifR0y3xO8NZ0fs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282314>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
> and '%(push)' atoms and store information into the 'used_atom'
> structure based on the modifiers used along with the corresponding
> atom.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -37,6 +37,11 @@ static struct used_atom {
>         union {
>                 const char *color;
>                 struct align align;
> +               struct {
> +                       unsigned int shorten : 1,
> +                               track : 1,
> +                               trackshort : 1;
> +               } remote_ref;

Are 'shorten', 'track', and 'trackshort' mutually exclusive? If so, a
simple enum would be clearer than bitfields:

    union {
        const char *color;
        struct align align;
        enum { RR_PLAIN, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
            remote_ref;
    };

Or something.

>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -69,6 +74,24 @@ void color_atom_parser(struct used_atom *atom)
> +void remote_ref_atom_parser(struct used_atom *atom)
> +{
> +       const char *buf;
> +
> +       buf = strchr(atom->str, ':');
> +       if (!buf)
> +               return;
> +       buf++;
> +       if (!strcmp(buf, "short"))
> +               atom->u.remote_ref.shorten = 1;
> +       else if (!strcmp(buf, "track"))
> +               atom->u.remote_ref.track = 1;
> +       else if (!strcmp(buf, "trackshort"))
> +               atom->u.remote_ref.trackshort = 1;
> +       else
> +               die(_("improper format entered align:%s"), buf);

"align:"? Also, how about a more grammatically-friendly error message?

> +}
> +
> @@ -838,6 +861,42 @@ static inline char *copy_advance(char *dst, const char *src)
> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> +                                   struct branch *branch, const char **s)
> +{
> +       int num_ours, num_theirs;
> +       if (atom->u.remote_ref.shorten)
> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +       else if (atom->u.remote_ref.track) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))
> +                       return;
> +               if (!num_ours && !num_theirs)
> +                       *s = "";
> +               else if (!num_ours)
> +                       *s = xstrfmt("[behind %d]", num_theirs);
> +               else if (!num_theirs)
> +                       *s = xstrfmt("[ahead %d]", num_ours);
> +               else
> +                       *s = xstrfmt("[ahead %d, behind %d]",
> +                                    num_ours, num_theirs);

Tangent: These xstrfmt()'d strings are getting leaked, right? Is that
something that we need to worry about (if, for instance, a repository
contains a lot of tracking refs)? Should there be a NEEDSWORK comment
here regarding the issue?

> +       } else if (atom->u.remote_ref.trackshort) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))
> +                       return;
> +
> +               if (!num_ours && !num_theirs)
> +                       *s = "=";
> +               else if (!num_ours)
> +                       *s = "<";
> +               else if (!num_theirs)
> +                       *s = ">";
> +               else
> +                       *s = "<>";
> +       } else
> +               *s = refname;
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -948,49 +1011,11 @@ static void populate_value(struct ref_array_item *ref)
>
>                 formatp = strchr(name, ':');
>                 if (formatp) {
> -                       int num_ours, num_theirs;
> -
>                         formatp++;
>                         if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);

Is this duplicating work already done by fill_remote_ref_details()?

> -                       else if (!strcmp(formatp, "track") &&
> -                                (starts_with(name, "upstream") ||
> -                                 starts_with(name, "push"))) {
> -
> -                               if (stat_tracking_info(branch, &num_ours,
> -                                                      &num_theirs, NULL))
> -                                       continue;
> -
> -                               if (!num_ours && !num_theirs)
> -                                       v->s = "";
> -                               else if (!num_ours)
> -                                       v->s = xstrfmt("[behind %d]", num_theirs);
> -                               else if (!num_theirs)
> -                                       v->s = xstrfmt("[ahead %d]", num_ours);
> -                               else
> -                                       v->s = xstrfmt("[ahead %d, behind %d]",
> -                                                      num_ours, num_theirs);
> -                               continue;
> -                       } else if (!strcmp(formatp, "trackshort") &&
> -                                  (starts_with(name, "upstream") ||
> -                                   starts_with(name, "push"))) {
> -                               assert(branch);
> -
> -                               if (stat_tracking_info(branch, &num_ours,
> -                                                       &num_theirs, NULL))
> -                                       continue;
> -
> -                               if (!num_ours && !num_theirs)
> -                                       v->s = "=";
> -                               else if (!num_ours)
> -                                       v->s = "<";
> -                               else if (!num_theirs)
> -                                       v->s = ">";
> -                               else
> -                                       v->s = "<>";
> -                               continue;
> -                       } else
> +                       else
>                                 die("unknown %.*s format %s",
>                                     (int)(formatp - name), name, formatp);
>                 }
> --
> 2.6.2
