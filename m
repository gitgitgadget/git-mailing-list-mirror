From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/11] ref-filter: introduce remote_ref_atom_parser()
Date: Thu, 17 Dec 2015 04:22:09 -0500
Message-ID: <CAPig+cRG_HTWL=VNqOxDnv_M0NbYZSReCHSsGe1CJiFQS8h-XQ@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
	<1450279802-29414-10-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 10:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9UlP-0001AV-6O
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 10:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbbLQJWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 04:22:13 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33421 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbLQJWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 04:22:10 -0500
Received: by mail-vk0-f51.google.com with SMTP id a188so43374645vkc.0
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pPhz6hC7KJ1NoR7pAWr4O2ttqVdvCv7OJjOtadBKfNM=;
        b=svxruwHUMtPHjZ3IzIyybuq61CP6LvYIJD41QemCOTL4GSWLyYpNVOe1CsI3gq9i+T
         V0/wGMACOqsEl4Udn8fDKWCXxJWQpos1Xxn9BQBXssMqc+8JF7o0GflBPyOCt5Rv++/J
         zWy4NsVf6W9jQFjH7qVURzIBcOSCUsJyzfU0jUFCi7XJMY4At8FnrddjpoDiwcTWQzdX
         NRYgoeAXP2F6J2T9LM+PEWZ1U2o/2iZ8nBkY4MqALqEFCREONNuYCOtHv1dC0oBnaSBu
         5beUwCU2O6Y9dnNDnQ3uKS89rEkf0i3KN1czlnl7cvFiHxHceyERkrtU5T61BLBc2TbC
         Tq0w==
X-Received: by 10.31.52.82 with SMTP id b79mr37818887vka.84.1450344129888;
 Thu, 17 Dec 2015 01:22:09 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 17 Dec 2015 01:22:09 -0800 (PST)
In-Reply-To: <1450279802-29414-10-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: EBajQSawyhu70FNiC-KK1wXs5lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282643>

On Wed, Dec 16, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
> and '%(push)' atoms and store information into the 'used_atom'
> structure based on the modifiers used along with the corresponding
> atom.
>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -37,6 +37,8 @@ static struct used_atom {
>         union {
>                 const char *color;
>                 struct align align;
> +               enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }

Nit: I'd have expected to see the normal/plain case first rather than
last (but not itself worth a re-roll).

> +                       remote_ref;
>         } u;
>  } *used_atom;
>  static int used_atom_cnt, need_tagged, need_symref;
> @@ -69,6 +71,25 @@ static void color_atom_parser(struct used_atom *atom)
> +static void remote_ref_atom_parser(struct used_atom *atom)
> +{
> +       const char *buf;
> +
> +       buf = strchr(atom->str, ':');
> +       atom->u.remote_ref = RR_NORMAL;
> +       if (!buf)
> +               return;

This code is not as clear as it could be due to the way the 'buf'
assignment and check for NULL are split apart. It can be made clearer
either by doing this:

    atom->u.remote_ref = RR_NORMAL;
    buf = strchr(...);
    if (!buf)
        return;

or (even better) this:

    buf = strchr(...);
    if (!buf) {
        atom->u.remote_ref = RR_NORMAL;
        return;
    }

> +       buf++;
> +       if (!strcmp(buf, "short"))
> +               atom->u.remote_ref = RR_SHORTEN;
> +       else if (!strcmp(buf, "track"))
> +               atom->u.remote_ref = RR_TRACK;
> +       else if (!strcmp(buf, "trackshort"))
> +               atom->u.remote_ref = RR_TRACKSHORT;
> +       else
> +               die(_("unrecognized format: %%(%s)"), atom->str);
> +}
> +
> @@ -835,6 +856,42 @@ static inline char *copy_advance(char *dst, const char *src)
> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
> +                                   struct branch *branch, const char **s)
> +{
> +       int num_ours, num_theirs;
> +       if (atom->u.remote_ref == RR_SHORTEN)
> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +       else if (atom->u.remote_ref == RR_TRACK) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))
> +                       return;

The RR_TRACKSHORT branch below has a blank line following the
'return', but this branch lacks it, which is inconsistent.

> +               if (!num_ours && !num_theirs)
> +                       *s = "";
> +               else if (!num_ours)
> +                       *s = xstrfmt("[behind %d]", num_theirs);
> +               else if (!num_theirs)
> +                       *s = xstrfmt("[ahead %d]", num_ours);
> +               else
> +                       *s = xstrfmt("[ahead %d, behind %d]",
> +                                    num_ours, num_theirs);
> +       } else if (atom->u.remote_ref == RR_TRACKSHORT) {
> +               if (stat_tracking_info(branch, &num_ours,
> +                                      &num_theirs, NULL))

What happened to the assert(branch) which was in the original code
from which this was derived (below)? Is it no longer needed?

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
> +       } else if (atom->u.remote_ref == RR_NORMAL)
> +               *s = refname;
> +}
> +
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> @@ -889,6 +946,8 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_upstream(branch, NULL);
>                         if (!refname)
>                                 continue;
> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
> +                       continue;
>                 } else if (starts_with(name, "push")) {
>                         const char *branch_name;
>                         if (!skip_prefix(ref->refname, "refs/heads/",
> @@ -899,6 +958,8 @@ static void populate_value(struct ref_array_item *ref)
>                         refname = branch_get_push(branch, NULL);
>                         if (!refname)
>                                 continue;
> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
> +                       continue;
>                 } else if (starts_with(name, "color:")) {
>                         char color[COLOR_MAXLEN] = "";
>
> @@ -944,49 +1005,11 @@ static void populate_value(struct ref_array_item *ref)
>
>                 formatp = strchr(name, ':');
>                 if (formatp) {
> -                       int num_ours, num_theirs;
> -
>                         formatp++;
>                         if (!strcmp(formatp, "short"))
>                                 refname = shorten_unambiguous_ref(refname,
>                                                       warn_ambiguous_refs);
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
> 2.6.4
