From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Make builtin-commit.c export GIT_INDEX_FILE for
	launch_editor as well.
Date: Mon, 26 Nov 2007 10:27:30 -0500
Message-ID: <1196090850.2875.13.camel@hinata.boston.redhat.com>
References: <20071125211831.GA21121@artemis.corp>
	 <20071126002519.GA11133@efreet.light.src>
	 <20071126084731.GB23373@artemis.corp> <20071126085927.GC23373@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 16:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwfxs-0006S5-CI
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 16:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXKZPdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbXKZPdV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 10:33:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbXKZPdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 10:33:20 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAQFRaQE015055;
	Mon, 26 Nov 2007 10:27:36 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAQFRahr008043;
	Mon, 26 Nov 2007 10:27:36 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAQFRZcS005672;
	Mon, 26 Nov 2007 10:27:35 -0500
In-Reply-To: <20071126085927.GC23373@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66078>

On Mon, 2007-11-26 at 09:59 +0100, Pierre Habouzit wrote:
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>=20
>   And here's the fix for this tiny problem =E2=80=A6

That looks good to me.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>

>=20
>=20
>  builtin-commit.c |    9 ++++++---
>  builtin-tag.c    |    6 +++---
>  strbuf.h         |    2 +-
>  3 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 5d27102..6e6b9f2 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -748,9 +748,12 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
> =20
>  	/* Get the commit message and validate it */
>  	header_len =3D sb.len;
> -	if (!no_edit)
> -		launch_editor(git_path(commit_editmsg), &sb);
> -	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
> +	if (!no_edit) {
> +		char index[PATH_MAX];
> +		const char *env[2] =3D { index, NULL };
> +		snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
> +		launch_editor(git_path(commit_editmsg), &sb, env);
> +	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) =
{
>  		rollback_index_files();
>  		die("could not read commit message\n");
>  	}
> diff --git a/builtin-tag.c b/builtin-tag.c
> index e89b201..8cc7f9c 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -23,7 +23,7 @@ static const char * const git_tag_usage[] =3D {
> =20
>  static char signingkey[1000];
> =20
> -void launch_editor(const char *path, struct strbuf *buffer)
> +void launch_editor(const char *path, struct strbuf *buffer, const ch=
ar *const *env)
>  {
>  	const char *editor, *terminal;
> =20
> @@ -49,7 +49,7 @@ void launch_editor(const char *path, struct strbuf =
*buffer)
>  	if (strcmp(editor, ":")) {
>  		const char *args[] =3D { editor, path, NULL };
> =20
> -		if (run_command_v_opt(args, 0))
> +		if (run_command_v_opt_cd_env(args, 0, NULL, env))
>  			die("There was a problem with the editor %s.", editor);
>  	}
> =20
> @@ -318,7 +318,7 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
>  			write_or_die(fd, tag_template, strlen(tag_template));
>  		close(fd);
> =20
> -		launch_editor(path, buf);
> +		launch_editor(path, buf, NULL);
> =20
>  		unlink(path);
>  		free(path);
> diff --git a/strbuf.h b/strbuf.h
> index 8334a9b..36d61db 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -117,6 +117,6 @@ extern int strbuf_read_file(struct strbuf *sb, co=
nst char *path, size_t hint);
>  extern int strbuf_getline(struct strbuf *, FILE *, int);
> =20
>  extern void stripspace(struct strbuf *buf, int skip_comments);
> -extern void launch_editor(const char *path, struct strbuf *buffer);
> +extern void launch_editor(const char *path, struct strbuf *buffer, c=
onst char *const *env);
> =20
>  #endif /* STRBUF_H */
