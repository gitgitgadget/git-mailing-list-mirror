From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 05/27] Make git_path() aware of file relocation in $GIT_DIR
Date: Sun, 2 Mar 2014 20:34:49 -0500
Message-ID: <CAPig+cTU8-sBsbHpJXHxW2RuXdArWnamTXWvkw9d0WnYpYJtig@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 02:34:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKHmQ-0000OQ-W8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 02:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaCCBev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 20:34:51 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:57562 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaCCBeu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 20:34:50 -0500
Received: by mail-yk0-f171.google.com with SMTP id q9so8930956ykb.2
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 17:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=/KiOD59UddGQieuHttpq6T77YAxMB0KU0VpGEnGYX5U=;
        b=FhIZd77B45kkfgeujtch0MUQhKOuXVo+6j4sSsNg8T6Q0akWoH0zTCud5W+aQPdZzO
         U67Yt09bkNxgWsRKS4fA7g3gkCE0m88rY7WMSrRSX5bAl9PiZep7vnroixcYGWNyMysg
         FZf3A/gXc+pMqCa0L7sHNjo4epZA3VvwxF9oxEeKM0SLgzRa1KPcU8kX0jdeWzwHS6oU
         a2yMaOFQMNouRpIHHAd7yQPsnIGDleisbJPgyyylRW7SiGuuqGQ05jDEgdDSdu7vMSFn
         1kTo0da8DF2IoYzatJfVtCX5tRIoZW78c9qhVwQuE+Ffo1zMZ0Inszv3iLW1PBWh+ERH
         OCwA==
X-Received: by 10.236.152.233 with SMTP id d69mr18918288yhk.11.1393810489582;
 Sun, 02 Mar 2014 17:34:49 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 17:34:49 -0800 (PST)
In-Reply-To: <1393675983-3232-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 6bCbcYJQK6a54HR4gD_MRos3kIA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243171>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> We allow the user to relocate certain paths out of $GIT_DIR via
> environment variables, e.g. GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE and
> GIT_GRAFT_FILE. All callers are not supposed to use git_path() or

"All callers are not" is unusually difficult to understand. Changing
it to "Callers are not" simplifies.

> git_pathdup() to get those paths. Instead they must use
> get_object_directory(), get_index_file() and get_graft_file()
> respectively. This is inconvenient and could be missed in review
> (there's git_path("objects/info/alternates") somewhere in

"(for example, there's..." reads a bit better.

> sha1_file.c).
>
> This patch makes git_path() and git_pathdup() understand those
> environment variables. So if you set GIT_OBJECT_DIRECTORY to /foo/bar=
,
> git_path("objects/abc") should return /tmp/bar/abc. The same is done

I guess you mean it should return /foo/bar/abc.

> for the two remaining env variables.
>
> "git rev-parse --git-path" is the wrapper for script use.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-rev-parse.txt |  5 +++++
>  builtin/rev-parse.c             |  7 +++++++
>  cache.h                         |  1 +
>  environment.c                   |  9 ++++++--
>  path.c                          | 46 +++++++++++++++++++++++++++++++=
++++++++++
>  t/t0060-path-utils.sh           | 19 +++++++++++++++++
>  6 files changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index 0d2cdcd..33e4e90 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -232,6 +232,11 @@ print a message to stderr and exit with nonzero =
status.
>         repository.  If <path> is a gitfile then the resolved path
>         to the real repository is printed.
>
> +--git-path <path>::
> +       Resolve "$GIT_DIR/<path>" and takes other path relocation
> +       variables such as $GIT_OBJECT_DIRECTORY,
> +       $GIT_INDEX_FILE... into account.

Would it help to add a quick illustration here?

    For example, if GIT_OBJECT_DIRECTORY is /foo/bar,
    then "git rev-parse --git-path objects/abc" returns /foo/bar/abc.

>  --show-cdup::
>         When the command is invoked from a subdirectory, show the
>         path of the top-level directory relative to the current
> diff --git a/path.c b/path.c
> index ccd7228..e020530 100644
> --- a/path.c
> +++ b/path.c
> @@ -60,13 +60,59 @@ char *mksnpath(char *buf, size_t n, const char *f=
mt, ...)
>         return cleanup_path(buf);
>  }
>
>  static void do_git_path(struct strbuf *buf, const char *fmt, va_list=
 args)
>  {
>         const char *git_dir =3D get_git_dir();
> +       int gitdir_len;
>         strbuf_addstr(buf, git_dir);

Maybe simplify by dropping git_dir and invoking strbuf_addstr(buf,
get_git_dir())?

>         if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
>                 strbuf_addch(buf, '/');
> +       gitdir_len =3D buf->len;
>         strbuf_vaddf(buf, fmt, args);
> +       adjust_git_path(buf, gitdir_len);
>         strbuf_cleanup_path(buf);
>  }
>
