From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 09/24] ls-files.c: use index api
Date: Sat, 30 Nov 2013 16:39:52 +0100
Message-ID: <CALWbr2yaD9Z98ysEzVHiQQR_W_zEj7bp0uEgZ3Z=Tp=Yc1NnoQ@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
	<1385553659-9928-10-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 16:40:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmmed-0008PS-TD
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 16:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3K3Pjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 10:39:55 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:58252 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3K3Pjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 10:39:54 -0500
Received: by mail-la0-f48.google.com with SMTP id n7so7304331lam.7
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A34WS+LJm5clXML8Jr0l9oqXjFx1FT+ckeEDygE+qD4=;
        b=iKt4h9nsl9o2gRnujIfwS6Owexeav/b0rxQOMQasVFjG1WPPvqCsz5i0P2qAtlDurs
         2pQdzyl6ITk8GdhIEwrLwTsH80P8AyjsbbZJqVSzGZbHXFV/MG4W85bqYEirlFfDPYPR
         zpJuoifVet/EMOc/HJh9lpO7POwUTOQ1S46ssVtUTbSXUQvnlqBD7EGF4DyxiNfutzjf
         s16fYZDC3Go2bNSHCBA+O3BwkPuHoOYhWQxo4YWaA3ZA11kEJgiV99Pnh85v7Rq8LyIZ
         R41KVYKvnBjsd3kgX+kKYR4gEML4QJutsrzmsscZQCcxscfq/LcyvhsFHNLSr7mJeNDK
         qFgg==
X-Received: by 10.112.205.164 with SMTP id lh4mr37292451lbc.15.1385825992840;
 Sat, 30 Nov 2013 07:39:52 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Sat, 30 Nov 2013 07:39:52 -0800 (PST)
In-Reply-To: <1385553659-9928-10-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238567>

On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -447,6 +463,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>         struct dir_struct dir;
>         struct exclude_list *el;
>         struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +       struct filter_opts *opts = xmalloc(sizeof(*opts));
>         struct option builtin_ls_files_options[] = {
>                 { OPTION_CALLBACK, 'z', NULL, NULL, NULL,
>                         N_("paths are separated with NUL character"),
> @@ -512,9 +529,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>                 prefix_len = strlen(prefix);
>         git_config(git_default_config, NULL);
>
> -       if (read_cache() < 0)
> -               die("index file corrupt");
> -
>         argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
>                         ls_files_usage, 0);
>         el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> @@ -550,6 +564,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>                        prefix, argv);
>
> +       if (!with_tree && !needs_trailing_slash_stripped()) {
> +               memset(opts, 0, sizeof(*opts));
> +               opts->pathspec = &pathspec;
> +               opts->read_staged = 1;
> +               if (show_resolve_undo)
> +                       opts->read_resolve_undo = 1;
> +               if (read_cache_filtered(opts) < 0)
> +                       die("index file corrupt");
> +       } else {
> +               if (read_cache() < 0)
> +                       die("index file corrupt");
> +               parse_pathspec(&pathspec, 0,
> +                              PATHSPEC_PREFER_CWD |
> +                              PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +                              prefix, argv);
> +
> +       }
> +

Would it make sense to move the declaration of "opts" as a non-pointer
to the block where it's used ?
