From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/3] Fix commit-msg hook to allow editing
Date: Sun, 9 Dec 2007 13:22:32 +0100
Message-ID: <5B3413C6-48E3-44CD-9577-622C9A93230A@wincent.com>
References: <1197113889-16243-1-git-send-email-win@wincent.com> <1197113889-16243-2-git-send-email-win@wincent.com> <1197113889-16243-3-git-send-email-win@wincent.com> <1197113889-16243-4-git-send-email-win@wincent.com> <7vtzmss58h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 13:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1LBr-0004bG-Co
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 13:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbXLIMXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 07:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbXLIMXB
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 07:23:01 -0500
Received: from wincent.com ([72.3.236.74]:36438 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXLIMXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2007 07:23:00 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB9CMXfB029895;
	Sun, 9 Dec 2007 06:22:34 -0600
In-Reply-To: <7vtzmss58h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67620>

El 9/12/2007, a las 8:21, Junio C Hamano escribi=F3:

> IOW, how about something like this?
>
> ---
>
> builtin-commit.c |    9 +++++----
> builtin-tag.c    |    2 ++
> 2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 2032ca3..30a9deb 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -787,16 +787,17 @@ int cmd_commit(int argc, const char **argv, =20
> const char *prefix)
> 		char index[PATH_MAX];
> 		const char *env[2] =3D { index, NULL };
> 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
> -		launch_editor(git_path(commit_editmsg), &sb, env);
> -	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) =
{
> -		rollback_index_files();
> -		die("could not read commit message");
> +		launch_editor(git_path(commit_editmsg), NULL, env);
> 	}
> 	if (!no_verify &&
> 	    run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
> 		rollback_index_files();
> 		exit(1);
> 	}
> +	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
> +		rollback_index_files();
> +		die("could not read commit message");
> +	}
>
> 	/* Truncate the message just before the diff, if any. */
> 	p =3D strstr(sb.buf, "\ndiff --git a/");
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 729389b..9f966fc 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -53,6 +53,8 @@ void launch_editor(const char *path, struct strbuf =
=20
> *buffer, const char *const *e
> 			die("There was a problem with the editor %s.", editor);
> 	}
>
> +	if (!buffer)
> +		return;
> 	if (strbuf_read_file(buffer, path, 0) < 0)
> 		die("could not read message file '%s': %s",
> 		    path, strerror(errno));

Excellent. Reads much better. I hadn't considered changing the strbuf =20
API, but looking at the callers of launch_editor this is a safe =20
change. Ack.

Cheers,
Wincent
