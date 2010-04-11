From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH jl/maint-submodule-gitfile-awareness] Windows: start_command:
 Support non-NULL dir in struct child_process
Date: Sun, 11 Apr 2010 22:40:12 +0200
Message-ID: <4BC233AC.3090603@kdbg.org>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org> <loom.20100411T174751-103@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Wm9sdMOhbkbDvHplc2k=?= <zfuzesi@eaglet.hu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:40:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O13x7-0005L2-TX
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab0DKUkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 16:40:15 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:40639 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752717Ab0DKUkO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 16:40:14 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 92B4CCDF84;
	Sun, 11 Apr 2010 22:40:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <loom.20100411T174751-103@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144682>

A caller of start_command can set the member 'dir' to a directory to
request that the child process starts with that directory as CWD. The f=
irst
user of this feature was added recently in eee49b6 (Teach diff --submod=
ule
and status to handle .git files in submodules).

On Windows, we have been lazy and had not implemented support for this
feature, yet. This fixes the shortcoming.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11.04.2010 17:57, schrieb Zolt=C3=A1nF=C3=BCzesi:
> Junio C Hamano<gitster<at>  pobox.com>  writes:
>> Jens Lehmann (2):
>>        Let check_preimage() use memset() to initialize "struct check=
out"
>>        Teach diff --submodule and status to handle .git files in sub=
modules
>=20
> This breaks git-status on Windows, if repository has submodule(s).
> "fatal: chdir in start_command() not implemented"

This fixes it. Hope this gets through without whitespace damage.

-- Hannes

 compat/mingw.c |   10 ++++++----
 compat/mingw.h |    1 +
 run-command.c  |    4 +---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ab65f77..754b534 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -618,6 +618,7 @@ static int env_compare(const void *a, const void *b=
)
 }
=20
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char=
 **env,
+			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
 	STARTUPINFO si;
@@ -697,7 +698,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, cons=
t char **argv, char **env,
=20
 	memset(&pi, 0, sizeof(pi));
 	ret =3D CreateProcess(cmd, args.buf, NULL, NULL, TRUE, flags,
-		env ? envblk.buf : NULL, NULL, &si, &pi);
+		env ? envblk.buf : NULL, dir, &si, &pi);
=20
 	if (env)
 		strbuf_release(&envblk);
@@ -714,10 +715,11 @@ static pid_t mingw_spawnve_fd(const char *cmd, co=
nst char **argv, char **env,
 static pid_t mingw_spawnve(const char *cmd, const char **argv, char **=
env,
 			   int prepend_cmd)
 {
-	return mingw_spawnve_fd(cmd, argv, env, prepend_cmd, 0, 1, 2);
+	return mingw_spawnve_fd(cmd, argv, env, NULL, prepend_cmd, 0, 1, 2);
 }
=20
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     const char *dir,
 		     int fhin, int fhout, int fherr)
 {
 	pid_t pid;
@@ -740,14 +742,14 @@ pid_t mingw_spawnvpe(const char *cmd, const char =
**argv, char **env,
 				pid =3D -1;
 			}
 			else {
-				pid =3D mingw_spawnve_fd(iprog, argv, env, 1,
+				pid =3D mingw_spawnve_fd(iprog, argv, env, dir, 1,
 						       fhin, fhout, fherr);
 				free(iprog);
 			}
 			argv[0] =3D argv0;
 		}
 		else
-			pid =3D mingw_spawnve_fd(prog, argv, env, 0,
+			pid =3D mingw_spawnve_fd(prog, argv, env, dir, 0,
 					       fhin, fhout, fherr);
 		free(prog);
 	}
diff --git a/compat/mingw.h b/compat/mingw.h
index e254fb4..e0a6aba 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -223,6 +223,7 @@ int mingw_utime(const char *file_name, const struct=
 utimbuf *times);
 #define utime mingw_utime
=20
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
+		     const char *dir,
 		     int fhin, int fhout, int fherr);
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
diff --git a/run-command.c b/run-command.c
index 2feb493..db30cd5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -335,8 +335,6 @@ fail_pipe:
 	else if (cmd->out > 1)
 		fhout =3D dup(cmd->out);
=20
-	if (cmd->dir)
-		die("chdir in start_command() not implemented");
 	if (cmd->env)
 		env =3D make_augmented_environ(cmd->env);
=20
@@ -346,7 +344,7 @@ fail_pipe:
 		cmd->argv =3D prepare_shell_cmd(cmd->argv);
 	}
=20
-	cmd->pid =3D mingw_spawnvpe(cmd->argv[0], cmd->argv, env,
+	cmd->pid =3D mingw_spawnvpe(cmd->argv[0], cmd->argv, env, cmd->dir,
 				  fhin, fhout, fherr);
 	failed_errno =3D errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D ENOENT))
--=20
1.7.0.12.ga3b9
