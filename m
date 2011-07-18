From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v3 18/23] transport-helper: change import semantics
Date: Mon, 18 Jul 2011 17:13:44 +0600
Message-ID: <CA+gfSn_Cxkmrz6k0ScZ+fTNZvzU7oA9Li5G1VBFtkohzYOFm7w@mail.gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
	<1310821424-4750-19-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 13:13:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qillo-0005TT-Iy
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 13:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab1GRLNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 07:13:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46537 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab1GRLNp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 07:13:45 -0400
Received: by qwk3 with SMTP id 3so1426368qwk.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Lch+bwuGAcuVih/5+k349nHrOSnJGv+G9vYK+lUOPiQ=;
        b=O5+BvgphriWLrB31TH9VPgnoZbqP7NJOfMkJ/xo7fjLh09wst1sd5XilRyce8wtiHq
         cTqdNKzNHxbmHEpiMtnnlSsa97aUHSX22vO4+9FZXWZ6YZwoiEErX/gHs1AEhSq/cxqd
         G3+ZHGL7Wf4Lga7VqrXri6Tm0/TknOqr5O/44=
Received: by 10.229.185.211 with SMTP id cp19mr4616403qcb.102.1310987624778;
 Mon, 18 Jul 2011 04:13:44 -0700 (PDT)
Received: by 10.229.63.232 with HTTP; Mon, 18 Jul 2011 04:13:44 -0700 (PDT)
In-Reply-To: <1310821424-4750-19-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177367>

Hi,

I'll comment on "[PATCH v3 16/23] transport-helper: use the new done
feature where possible" (
http://thread.gmane.org/gmane.comp.version-control.git/177255/focus=3D1=
77274)
first. There is a hunk for transport-helper.c
@@ -417,11 +418,8 @@ static int fetch_with_import(struct transport *tra=
nsport,
 		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
-	if (disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-
 	free(fastimport.argv);
 	fastimport.argv =3D NULL;

This is related to the done feature but a helper can use the done
feature without this hunk.
And it does change the import semantics, so I'd suggest moving the
hunk here, to
"[PATCH v3 18/23] transport-helper: change import semantics".

On Sat, Jul 16, 2011 at 7:03 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Currently the helper must somehow guess how many import statements to
> read before it starts outputting its fast-export stream. This is
> because the remote helper infrastructure runs fast-import only once,
> so the helper is forced to output one stream for all import commands
> it will receive. The only reason this worked in the past was because
> only one ref was imported at a time.
>
> Change the semantics of the import statement such that it matches
> that of the push statement. That is, the import statement is followed
> by a series of import statements that are terminated by a '\n'.

I'll add more comments to the "import" job termination.

Before these two patches:
The helper input was closed which caused it to exit just after writing
the import stream.
(first, helper can terminate on eof; second it can terminate on '\n'
just before eof; third, it may know that the import always was the
last command and terminate before reading '\n').
The transport-helper.o didn't held a copy of helper's stdout, so once
the helper exits this end of import-stream pipe becomes closed.
And then the importer saw EOF on stdin and could terminate normally.

After these patches:
transport-helper waits for importer to terminate, so the helper must ei=
ther
a) crash or exit during or just after the import and reading no more
than '\n' (blocking read beyond this character may hang us up)
or
b) use the 'done' feature to make importer terminate normally

So the old helper won't hang us up if it terminates (or at least
closes stdout) on just after the import or if it can read '\n' (but
not blocking read further) and terminate.
But if it just ignores empty lines and waits for new commands or eof
as an exit indicator, it all hangs.

Sadly, old documentation didn't mention many of these quirks, but on
the other hand the old semantic is a bit broken and not documented so
it's all ok.

We should definitely add a new description for import command to
Documentation/git-remote-helpers.txt
Something roughly like this addition:

A batch sequence of one or more import commands is terminated
with a blank line. Single fast-import stream should be produced for
the whole batch.
If the helper is able to proceed with more commands after the import
(in earlier versions import used to be the last command for a helper)
it must use the "done" feature to indicate the end of this batch's
import stream for the importer, otherwise the importer will wait foreve=
r
and the caller will wait for the importer to finish.

Aside from documenting and squashing I think this patch is the best
way to proceed with improving the import command.

>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
> =A0As Jonathan suggested we now follow push' example, rather than
> =A0'list'. It makes the remote-testgit code a bit longer, but it mean=
s
> =A0less changes to remote-helper.c.
>
> =A0git-remote-testgit.py =A0 =A0 | =A0 16 +++++++++++++++-
> =A0t/t5800-remote-helpers.sh | =A0 =A02 +-
> =A0transport-helper.c =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A03 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 0b5928d..1ed7a56 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -120,8 +120,22 @@ def do_import(repo, args):
> =A0 =A0 if not repo.gitdir:
> =A0 =A0 =A0 =A0 die("Need gitdir to import")
>
> + =A0 =A0ref =3D args[0]
> + =A0 =A0refs =3D [ref]
> +
> + =A0 =A0while True:
> + =A0 =A0 =A0 =A0line =3D sys.stdin.readline()
> + =A0 =A0 =A0 =A0if line =3D=3D '\n':
> + =A0 =A0 =A0 =A0 =A0 =A0break
> + =A0 =A0 =A0 =A0if not line.startswith('import '):
> + =A0 =A0 =A0 =A0 =A0 =A0die("Expected import line.")
> +
> + =A0 =A0 =A0 =A0# strip of leading 'import '
> + =A0 =A0 =A0 =A0ref =3D line[7:].strip()
> + =A0 =A0 =A0 =A0refs.append(ref)
> +
> =A0 =A0 repo =3D update_local_repo(repo)
> - =A0 =A0repo.exporter.export_repo(repo.gitdir, args)
> + =A0 =A0repo.exporter.export_repo(repo.gitdir, refs)
>
> =A0 =A0 print "done"
>
> diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
> index 12f471c..1c62001 100755
> --- a/t/t5800-remote-helpers.sh
> +++ b/t/t5800-remote-helpers.sh
> @@ -98,7 +98,7 @@ test_expect_success 'fetch new branch' '
> =A0 =A0 =A0 =A0compare_refs public HEAD localclone FETCH_HEAD
> =A0'
>
> -test_expect_failure 'fetch multiple branches' '
> +test_expect_success 'fetch multiple branches' '
> =A0 =A0 =A0 =A0(cd localclone &&
> =A0 =A0 =A0 =A0 git fetch
> =A0 =A0 =A0 =A0) &&
> diff --git a/transport-helper.c b/transport-helper.c
> index a8f69b0..0c00be9 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -418,6 +418,9 @@ static int fetch_with_import(struct transport *tr=
ansport,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sendline(data, &buf);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_reset(&buf);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 write_constant(data->helper->in, "\n");
> +
> =A0 =A0 =A0 =A0if (finish_command(&fastimport))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Error while running fast-import")=
;
> =A0 =A0 =A0 =A0free(fastimport.argv);
> --
> 1.7.5.1.292.g728120
>
>
