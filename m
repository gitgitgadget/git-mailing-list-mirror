From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] ref-filter: allow porcelain to translate messages in
 the output
Date: Mon, 12 Oct 2015 00:55:16 +0530
Message-ID: <CAOLa=ZTdXLWqf675M-7mcAQsPvLRN5r9E6yxa-wkwVNKWe5y8Q@mail.gmail.com>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr> <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
 <1444580188-18773-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 21:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlMFm-0000eo-GF
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 21:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbJKTZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 15:25:49 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34861 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbJKTZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 15:25:47 -0400
Received: by vkha6 with SMTP id a6so19510602vkh.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LBfhPw6jRdSG2pW31ImIr5PnqDrx24Fg13GwKj3wOzA=;
        b=VUkK9rvX+5ZrHCuoKfdRhVDeE3KEhN3kqJbzmz3DxGfWV1gcCv+jUorH0n9dhLjXkR
         +OMip1Ix/8dUQzuZUCn8ihv4Iy9g4O7/fkSQ9bHFhP/N0ddtNcboLxj3d8y8zuEDGuEU
         CNqY58k1E1tp8/8ZAGuWd2B1Z0tHrMiYNKzPjBURyeA/qeI1amyBbcrbNBFfeYd/ABVf
         dwyNsjMtOdif6FeW59T8oh0fgS8AavP43KND+R7fUri464BKQMlL23RgxRR7RUTSIVuC
         cgpMiG0tmP5AR2pMsgDkDhhIPKDNjrQB/rMxCaVBlCB1yMVYk82Copvt1yJ1uDvb6RE+
         mKlQ==
X-Received: by 10.31.15.69 with SMTP id 66mr16203313vkp.142.1444591545789;
 Sun, 11 Oct 2015 12:25:45 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 11 Oct 2015 12:25:16 -0700 (PDT)
In-Reply-To: <1444580188-18773-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279354>

On Sun, Oct 11, 2015 at 9:46 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> This patch shows the way, but is obviously incomplete as it works only
> for "nobracket" version. Actually, I think the code should first build
> the unbracketed output string and then do something like
>
> if (!nobracket) {
>         const char *to_free = v->s;
>         v->s = xstrfmt("[%s]", v->s);
>         free(to_free);
> }
>

Makes sense.

> so we don't have to worry about brackets anywhere else in the code.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  ref-filter.c | 28 ++++++++++++++++++++++++----
>  ref-filter.h |  3 +++
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 7932c21..c2ee8c9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -15,6 +15,26 @@
>  #include "version.h"
>  #include "wt-status.h"
>
> +static struct ref_msg {
> +       const char *gone;
> +       const char *ahead;
> +       const char *behind;
> +       const char *ahead_behind;
> +} msgs = {
> +       "gone",
> +       "ahead %d",
> +       "behind %d",
> +       "ahead %d, behind %d"
> +};
> +
> +void setup_ref_filter_porcelain_msg(void)
> +{
> +       msgs.gone = _("gone");
> +       msgs.ahead = _("ahead %d");
> +       msgs.behind = _("behind %d");
> +       msgs.ahead_behind = _("ahead %d, behind %d");
> +}
> +
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
>  static struct {
> @@ -1124,7 +1144,7 @@ static void populate_value(struct ref_array_item *ref)
>                                 if (stat_tracking_info(branch, &num_ours,
>                                                        &num_theirs, NULL)) {
>                                         if (nobracket)
> -                                               v->s = "gone";
> +                                               v->s = msgs.gone;
>                                         else
>                                                 v->s = "[gone]";
>                                         continue;
> @@ -1134,17 +1154,17 @@ static void populate_value(struct ref_array_item *ref)
>                                         v->s = "";
>                                 else if (!num_ours) {
>                                         if (nobracket)
> -                                               v->s = xstrfmt("behind %d", num_theirs);
> +                                               v->s = xstrfmt(msgs.behind, num_theirs);
>                                         else
>                                                 v->s = xstrfmt("[behind %d]", num_theirs);
>                                 } else if (!num_theirs) {
>                                         if (nobracket)
> -                                               v->s = xstrfmt("ahead %d", num_ours);
> +                                               v->s = xstrfmt(msgs.ahead, num_ours);
>                                         else
>                                                 v->s = xstrfmt("[ahead %d]", num_ours);
>                                 } else {
>                                         if (nobracket)
> -                                               v->s = xstrfmt("ahead %d, behind %d",
> +                                               v->s = xstrfmt(msgs.ahead_behind,
>                                                                num_ours, num_theirs);
>                                         else
>                                                 v->s = xstrfmt("[ahead %d, behind %d]",
> diff --git a/ref-filter.h b/ref-filter.h
> index 0014b92..2cce02c 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -112,4 +112,7 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
>  /*  Get the current HEAD's description */
>  char *get_head_description(void);
>
> +/*  Set up translated strings in the output. */
> +void setup_ref_filter_porcelain_msg(void);
> +
>  #endif /*  REF_FILTER_H  */
> --
> 2.6.0.rc2.24.gb06d8e9.dirty
>

I'm squashing this and the other two patches into my series. Thanks :)

-- 
Regards,
Karthik Nayak
