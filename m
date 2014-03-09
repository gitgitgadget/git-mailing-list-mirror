From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 06/28] Make git_path() aware of file relocation in $GIT_DIR
Date: Sun, 9 Mar 2014 04:19:27 -0400
Message-ID: <CAPig+cTZb5diOEGNKJVpmQaAGZS9+3wWvS_MxGTQEeLLkhsRjg@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:19:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYxK-0000eC-Pm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 09:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbaCIITa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 04:19:30 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:48576 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaCIIT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 04:19:28 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so15830190ykt.4
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SS1bdeFFO9xJEbIHf30Oj06aYabLXZuV8Mr920htm8s=;
        b=xCbMH0msNTuRvp4ZICF+lUzm7jKwwAnWs8lu1Ct6k0yPNrnP1dl2YQhD3yL9ds2gP2
         18mIclGf4R496u/+4tt+M9UWTBogprI1rk4+UmHm9twJjLBNIUJLOXQdW8mkVEtGkF3K
         0uw8OsMxFJoCTLvaBQxHNIVTQk861S1S6Nk06WbgRj8blZz25nZHxHPZ1oUcxF0E0O2c
         5tFU7sjA6LJrsNuh1IejILAUyEPCJsir7i9hefbBZzU3ls/lu8+nGj9/KZY26lXURnLP
         OzQewvWRbllW4pBGYat15tOBxRqWeCOtTS9GPNgmE6o4Y/c7e5iPUDgIKk14/V4zB+UA
         ca8w==
X-Received: by 10.236.128.170 with SMTP id f30mr6607211yhi.89.1394353167991;
 Sun, 09 Mar 2014 00:19:27 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Sun, 9 Mar 2014 00:19:27 -0800 (PST)
In-Reply-To: <1394246900-31535-7-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: e0iJJVwlf5sTEqVqGPO7v-Y5F0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243692>

On Fri, Mar 7, 2014 at 9:47 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> We allow the user to relocate certain paths out of $GIT_DIR via
> environment variables, e.g. GIT_OBJECT_DIRECTORY, GIT_INDEX_FILE and
> GIT_GRAFT_FILE. Callers are not supposed to use git_path() or
> git_pathdup() to get those paths. Instead they must use
> get_object_directory(), get_index_file() and get_graft_file()
> respectively. This is inconvenient and could be missed in review (for
> example, there's git_path("objects/info/alternates") somewhere in
> sha1_file.c).
>
> This patch makes git_path() and git_pathdup() understand those
> environment variables. So if you set GIT_OBJECT_DIRECTORY to /foo/bar=
,
> git_path("objects/abc") should return /foo/bar/abc. The same is done
> for the two remaining env variables.
>
> "git rev-parse --git-path" is the wrapper for script use.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-rev-parse.txt |  7 ++++++
>  builtin/rev-parse.c             |  7 ++++++
>  cache.h                         |  1 +
>  environment.c                   |  9 ++++++--
>  path.c                          | 49 +++++++++++++++++++++++++++++++=
++++++++--
>  t/t0060-path-utils.sh           | 19 ++++++++++++++++
>  6 files changed, 88 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index 0d2cdcd..46020d9 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -232,6 +232,13 @@ print a message to stderr and exit with nonzero =
status.
>         repository.  If <path> is a gitfile then the resolved path
>         to the real repository is printed.
>
> +--git-path <path>::
> +       Resolve "$GIT_DIR/<path>" and takes other path relocation
> +       variables such as $GIT_OBJECT_DIRECTORY,
> +       $GIT_INDEX_FILE... into account. For example, if
> +       $GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
> +       --git-path objects/abc" returns /tmp/bar/abc.

s/tmp/foo/

> +
>  --show-cdup::
>         When the command is invoked from a subdirectory, show the
>         path of the top-level directory relative to the current
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index aaeb611..e50bc65 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -518,6 +518,13 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>         for (i =3D 1; i < argc; i++) {
>                 const char *arg =3D argv[i];
>
> +               if (!strcmp(arg, "--git-path")) {
> +                       if (!argv[i + 1])
> +                               die("--git-path requires an argument"=
);
> +                       puts(git_path("%s", argv[i + 1]));
> +                       i++;
> +                       continue;
> +               }
>                 if (as_is) {
>                         if (show_file(arg, output_prefix) && as_is < =
2)
>                                 verify_filename(prefix, arg, 0);
