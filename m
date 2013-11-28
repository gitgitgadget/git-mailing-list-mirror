From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 03/10] git_connect: remove artificial limit of a remote command
Date: Thu, 28 Nov 2013 20:48:45 +0100
Message-ID: <201311282048.45739.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7a3-0002OH-Qs
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759402Ab3K1Tsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:48:52 -0500
Received: from mout.web.de ([212.227.15.3]:59753 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759267Ab3K1Tsv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:48:51 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LlF9O-1VB88V3wiE-00b5er for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:48:50 +0100
X-Provags-ID: V03:K0:jfLHKaNA8lvoyjQeDc1/0ABh32NdYkAZsjheAI1GNrnZGO2cXps
 cX57g/00ehthcVVSS5eBYVi2hJ07UfyJ2b6bbCIphpFFuXa+TybK33ZNoPvLi+2Q4OGzfsa
 jZpC/9kYEVnahDepJzd9cNzw7Qs389u6TQkCBjUbLvuzrBeB2CkAX0c+DFdSPu/nKutSiM8
 U5NrfGqmjltAHjQZFeEOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238505>

Since day one, function git_connect() had a limit on the command line o=
f
the command that is invoked to make a connection. 7a33bcbe converted th=
e
code that constructs the command to strbuf. This would have been the
right time to remove the limit, but it did not happen. Remove it now.

git_connect() uses start_command() to invoke the command; consequently,
the limits of the system still apply, but are diagnosed only at execve(=
)
time. But these limits are more lenient than the 1K that git_connect()
imposed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 06e88b0..6cc1f8d 100644
--- a/connect.c
+++ b/connect.c
@@ -527,8 +527,6 @@ static struct child_process *git_proxy_connect(int =
fd[2], char *host)
 	return proxy;
 }
=20
-#define MAX_CMD_LEN 1024
-
 static char *get_port(char *host)
 {
 	char *end;
@@ -570,7 +568,7 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	int free_path =3D 0;
 	char *port =3D NULL;
 	const char **arg;
-	struct strbuf cmd;
+	struct strbuf cmd =3D STRBUF_INIT;
=20
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -676,12 +674,9 @@ struct child_process *git_connect(int fd[2], const=
 char *url_orig,
=20
 	conn =3D xcalloc(1, sizeof(*conn));
=20
-	strbuf_init(&cmd, MAX_CMD_LEN);
 	strbuf_addstr(&cmd, prog);
 	strbuf_addch(&cmd, ' ');
 	sq_quote_buf(&cmd, path);
-	if (cmd.len >=3D MAX_CMD_LEN)
-		die("command line too long");
=20
 	conn->in =3D conn->out =3D -1;
 	conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
--=20
1.8.5.rc0.23.gaa27064
