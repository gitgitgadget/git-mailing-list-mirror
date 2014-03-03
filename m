From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/27] Convert git_snpath() to strbuf_git_path()
Date: Sun, 2 Mar 2014 19:02:16 -0500
Message-ID: <CAPig+cTjqrveuOS+3+bonwJa_Kjg=STJU1JJ2Kj7Gs5U9eEB9Q@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:02:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKGKy-0001oE-0J
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 01:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbaCCACV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 19:02:21 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:54745 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaCCACR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 19:02:17 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so8733671ykr.9
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=tGXlEbFAtbdPLSgalsBYhB2Wmm9noZKvND7oWgI4poY=;
        b=BHxfOArarH9GEbk+wr27YHZ+9Igi+8RjDb6lVwOJagBuarzTmGp9LpK7+hI3fyWxxB
         iSqpg3pTW17zqrymxigkTywBMSPxNW0xuxf0It9cu33fU2nzCpJONFST9tHp3k15MM0I
         9whIIl7Uqr34bYzGrGSPsvrHUOevdl+tQsmCXZbq/RkIOTU4etu0ouMyK/qU0AkpL0/7
         8YUuLllnY6g0DvMhb9+C4lsmeBtzQTGHG6Lkftf3/n0kex9mRu5Ume4W3lszeJrwEsau
         ahmLnVwQm83ZccejKUukyORAoDAj34E0UbJMGSSP6+NIaUr5P9D1MnfIol47GNlSBBe9
         xKxg==
X-Received: by 10.236.122.99 with SMTP id s63mr18715837yhh.19.1393804936981;
 Sun, 02 Mar 2014 16:02:16 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 16:02:16 -0800 (PST)
In-Reply-To: <1393675983-3232-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 65HdBQ6KB4Gv41CSq5zwxvvxo2s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243166>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> In the previous patch, git_snpath() is modified to allocate a new
> strbuf buffer because vsnpath() needs that. But that makes it awkward
> because git_snpath() receives a pre-allocated buffer from outside and
> has to copy data back. Rename it to strbuf_git_path() and make it
> receive strbuf directly.
>
> The conversion from git_snpath() to git_path() in
> update_refs_for_switch() is safe because that function does not keep
> any pointer to the round-robin buffer pool allocated by
> get_pathname().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/refs.c b/refs.c
> index 89228e2..434bd5e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2717,17 +2729,19 @@ static int copy_msg(char *buf, const char *ms=
g)
>         return cp - buf;
>  }
>
> -int log_ref_setup(const char *refname, char *logfile, int bufsize)
> +int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
>  {
>         int logfd, oflags =3D O_APPEND | O_WRONLY;
> +       const char *logfile;
>
> -       git_snpath(logfile, bufsize, "logs/%s", refname);
> +       strbuf_git_path(sb_logfile, "logs/%s", refname);
> +       logfile =3D sb_logfile->buf;
>         if (log_all_ref_updates &&
>             (starts_with(refname, "refs/heads/") ||
>              starts_with(refname, "refs/remotes/") ||
>              starts_with(refname, "refs/notes/") ||
>              !strcmp(refname, "HEAD"))) {
> -               if (safe_create_leading_directories(logfile) < 0)
> +               if (safe_create_leading_directories(sb_logfile->buf) =
< 0)

At this point, 'logfile' is still 'sb_logfile->buf', so do you really
need this change?

>                         return error("unable to create directory for =
%s",
>                                      logfile);
>                 oflags |=3D O_CREAT;
> @@ -2762,20 +2776,22 @@ static int log_ref_write(const char *refname,=
 const unsigned char *old_sha1,
>         int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
>         unsigned maxlen, len;
>         int msglen;
> -       char log_file[PATH_MAX];
> +       struct strbuf sb_log_file =3D STRBUF_INIT;
> +       const char *log_file;
>         char *logrec;
>         const char *committer;
>
>         if (log_all_ref_updates < 0)
>                 log_all_ref_updates =3D !is_bare_repository();
>
> -       result =3D log_ref_setup(refname, log_file, sizeof(log_file))=
;
> +       result =3D log_ref_setup(refname, &sb_log_file);
>         if (result)
> -               return result;
> +               goto done;
> +       log_file =3D sb_log_file.buf;
>
>         logfd =3D open(log_file, oflags);
>         if (logfd < 0)
> -               return 0;
> +               goto done;
>         msglen =3D msg ? strlen(msg) : 0;
>         committer =3D git_committer_info(0);
>         maxlen =3D strlen(committer) + msglen + 100;
> --
> 1.9.0.40.gaa8c3ea
