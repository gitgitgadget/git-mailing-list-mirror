From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] Make git-log honor log.merges option
Date: Sun, 22 Mar 2015 16:50:47 -0400
Message-ID: <CAPig+cSOc-V=DG=tq7q8sWjJjMpnx8vNkGk56eFFWCMU-u77Rg@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-2-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZmpg-0003Ge-VR
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 21:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbbCVUus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 16:50:48 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:35535 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbCVUur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 16:50:47 -0400
Received: by yhim52 with SMTP id m52so32087376yhi.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=znnfiQ7leXKdlHytU4RaeRdS/deQu3EVnw46CqXwxSY=;
        b=JtKbqxzUQSPslqkIl8wEMLntl4ojgscssKQ+pLNkA6AXK7Hha/sMDm1nwsv5nF4TIL
         XqhjHjDsQfmCMpVTgmIn5TfNRO7LcuLd3VJmHjxiEsOX94rvSpC2ngQG1C/E1K2D+Xoh
         /snVPbnct2tSGoPOhoPiRCJNPNt+Lq1EDB3xUne84ZA/sDwgam14uRExkyBnMtWkIycy
         8xg2rIeWJ1bbqWyTi5ot/UHd5usWF75sgZyKamYplJHtGCYSXXMntXYhjYdgja0H8bid
         CmX7S8icLcMAYKeZlTzpatQ5CiJnMJBEtOILCcgPQ0yIvqA0cHDhBMAZzZZUfDh1O3QW
         aFxg==
X-Received: by 10.236.105.210 with SMTP id k58mr90829298yhg.52.1427057447156;
 Sun, 22 Mar 2015 13:50:47 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 13:50:47 -0700 (PDT)
In-Reply-To: <1427048921-28677-2-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: HM0EVmLuHIBYlIWZ-QlsXcryUa8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266091>

On Sun, Mar 22, 2015 at 2:28 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> Subject: Make git-log honor log.merges option

Drop capitalization, mention area you're touching, followed by colon,
followed by short summary:

    log: honor log.merges option

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>

As discussed in my review of patch 1/5, since Junio actually wrote
this patch[1], it would be more correct and considerate to attribute
it to him by ensuring that a "From:" header is at the very top of the
commit message before mailing out the patch:

    From: Junio C Hamano <gitster@pobox.com>

(If Junio had also signed-off on his patch, you would also include his
sign-off just above yours. In this case, he didn't sign off[1], so
your sign-off is all that is needed; and Junio will add his own if he
picks up this series.)

[1]: http://article.gmane.org/gmane.comp.version-control.git/265597

> ---
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..c7a7aad 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -36,6 +36,7 @@ static int decoration_given;
>  static int use_mailmap_config;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
> +static const char *log_merges;
>
>  static const char * const builtin_log_usage[] = {
>         N_("git log [<options>] [<revision range>] [[--] <path>...]"),
> @@ -386,6 +387,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
>                         decoration_style = 0; /* maybe warn? */
>                 return 0;
>         }
> +       if (!strcmp(var, "log.merges")) {
> +               return git_config_string(&log_merges, var, value);
> +       }
>         if (!strcmp(var, "log.showroot")) {
>                 default_show_root = git_config_bool(var, value);
>                 return 0;
> @@ -628,6 +632,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>
>         init_revisions(&rev, prefix);
>         rev.always_show_header = 1;
> +       if (log_merges && parse_merges_opt(&rev, log_merges))
> +               die("unknown config value for log.merges: %s", log_merges);
>         memset(&opt, 0, sizeof(opt));
>         opt.def = "HEAD";
>         opt.revarg_opt = REVARG_COMMITTISH;
> --
> 2.3.3.263.g095251d.dirty
