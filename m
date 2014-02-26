From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/25] checkout: support checking out into a new
 working directory
Date: Wed, 26 Feb 2014 15:06:49 -0500
Message-ID: <CAPig+cSDT72MHFdwnZHBwEUiJQiQAkc-nv0vK166O8EuXVtgbw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkkp-0007CA-4t
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbaBZUGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 15:06:51 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:40143 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaBZUGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 15:06:50 -0500
Received: by mail-yh0-f45.google.com with SMTP id i57so1597853yha.32
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FYHhSmsDlMzhrtEgZIE0xz1FFafchfxE7hhDomXqRlg=;
        b=leh422DWJtvNCT7aguSWtfl0AeYzJy16th4fOEPjDsV5AMjJqDUWDQoOZgqAmsODXe
         XNUfGBRTLjlM8ChmnBsHfoPll45KyDAOKZZK7O+ycXkUt17Huc4JegfC68P1hBu48dZl
         0sljgLmah/rcOJWJo7RN67HyBeYD5n9EPEE5ccTgfuvXvDnNgMpbyxjPMClvnD7wXEod
         hv3VfrHpJgRpqjq6t4Jx4/+h1o8zSahHOjlB8PgRxx/jTUb69X83MphSBih/MlssgUGl
         VvjePWhNnNdfhYhPEJ/DgdUGl2h99XrLloY+I20VYLHJyTghqKITCTImYnPV1vb5hC0T
         zChw==
X-Received: by 10.236.122.99 with SMTP id s63mr10108501yhh.19.1393445209602;
 Wed, 26 Feb 2014 12:06:49 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 26 Feb 2014 12:06:49 -0800 (PST)
In-Reply-To: <1392730814-19656-22-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 9jI0OGlZOjLPbHxOchVV9Na0xDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242754>

On Tue, Feb 18, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> "git checkout --to" sets up a new working directory with a .git file
> pointing to $GIT_DIR/repos/<id>. It then executes "git checkout" agai=
n
> on the new worktree with the same arguments except "--to" is taken
> out. The second checkout execution, which is not contaminated with an=
y
> info from the current repository, will actually check out and
> everything that normal "git checkout" does.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 0570e41..2b856a6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -806,6 +814,74 @@ static int switch_branches(const struct checkout=
_opts *opts,
>         return ret || writeout_error;
>  }
>
> +static int prepare_linked_checkout(const struct checkout_opts *opts,
> +                                  struct branch_info *new)
> +{
> +       struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT=
;
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char *path =3D opts->new_worktree;
> +       struct stat st;
> +       const char *name;
> +       struct child_process cp;
> +       int counter =3D 0, len;
> +
> +       if (!new->commit)
> +               die(_("no branch specified"));
> +
> +       len =3D strlen(path);
> +       if (!len || is_dir_sep(path[len - 1]))
> +               die(_("'--to' argument '%s' cannot end with a slash")=
, path);

What is the purpose of this restriction?

> +       for (name =3D path + len - 1; name > path; name--)
> +               if (is_dir_sep(*name)) {
> +                       name++;
> +                       break;
> +               }
> +       strbuf_addstr(&sb_repo, git_path("repos/%s", name));
> +       len =3D sb_repo.len;
> +       if (safe_create_leading_directories_const(sb_repo.buf))
> +               die_errno(_("could not create leading directories of =
'%s'"),
> +                         sb_repo.buf);
> +       while (!stat(sb_repo.buf, &st)) {
> +               counter++;
> +               strbuf_setlen(&sb_repo, len);
> +               strbuf_addf(&sb_repo, "%d", counter);
> +       }
> +       name =3D sb_repo.buf + len - strlen(name);
> +       if (mkdir(sb_repo.buf, 0777))
> +               die_errno(_("could not create directory of '%s'"), sb=
_repo.buf);
> +
> +       strbuf_addf(&sb_git, "%s/.git", path);
> +       if (safe_create_leading_directories_const(sb_git.buf))
> +               die_errno(_("could not create leading directories of =
'%s'"),
> +                         sb_git.buf);
> +
> +       write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
> +                  real_path(get_git_dir()), name);
> +       /*
> +        * This is to keep resolve_ref() happy. We need a valid HEAD
> +        * or is_git_directory() will reject the directory. Any valid
> +        * value would do because this value will be ignored and
> +        * replaced at the next (real) checkout.
> +        */
> +       strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> +       write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object=
=2Esha1));
> +       strbuf_reset(&sb);
> +       strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
> +       write_file(sb.buf, 1, "../..\n");
> +
> +       if (!opts->quiet)
> +               fprintf_ln(stderr, _("Enter %s (identifier %s)"), pat=
h, name);
> +
> +       setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
> +       setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
> +       setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
> +       memset(&cp, 0, sizeof(cp));
> +       cp.git_cmd =3D 1;
> +       cp.argv =3D opts->saved_argv;
> +       return run_command(&cp);
> +}
> +
