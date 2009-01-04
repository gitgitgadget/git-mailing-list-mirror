From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] git.c: make autocorrected aliases work
Date: Sun,  4 Jan 2009 18:08:19 +0100
Message-ID: <1231088899-11943-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 18:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJWU8-0001Z3-D3
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 18:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbZADRId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 12:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZADRId
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 12:08:33 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3949
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZADRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 12:08:32 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 4B85B801C025;
	Sun,  4 Jan 2009 18:08:23 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LJWSZ-00037N-1E; Sun, 04 Jan 2009 18:08:19 +0100
X-Mailer: git-send-email 1.6.1.62.g677ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104524>

help_unknown_cmd() is able to autocorrect a command to an alias, and no=
t
only to internal or external commands. However, main() was not passing =
the
autocorrected command through handle_alias(), hence it failed if it was=
 an
alias.

This commit makes the autocorrected command go through handle_alias, on=
ce
handle_internal_command() and execv_dashed_external() have been tried. =
Since
this is done twice in main() now, moved that logic to a new run_argv()
function.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 git.c |   46 +++++++++++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/git.c b/git.c
index e0d9071..f443b4c 100644
--- a/git.c
+++ b/git.c
@@ -416,12 +416,35 @@ static void execv_dashed_external(const char **ar=
gv)
 	strbuf_release(&cmd);
 }
=20
+static int run_argv(int *argcp, const char ***argv)
+{
+	int done_alias =3D 0;
+
+	while (1) {
+		/* See if it's an internal command */
+		handle_internal_command(*argcp, *argv);
+
+		/* .. then try the external ones */
+		execv_dashed_external(*argv);
+
+		/* It could be an alias -- this works around the insanity
+		 * of overriding "git log" with "git show" by having
+		 * alias.log =3D show
+		 */
+		if (done_alias || !handle_alias(argcp, argv))
+			break;
+		done_alias =3D 1;
+	}
+
+	return done_alias;
+}
+
=20
 int main(int argc, const char **argv)
 {
 	const char *cmd =3D argv[0] && *argv[0] ? argv[0] : "git-help";
 	char *slash =3D (char *)cmd + strlen(cmd);
-	int done_alias =3D 0;
+	int was_alias =3D 0;
=20
 	/*
 	 * Take the basename of argv[0] as the command
@@ -478,32 +501,17 @@ int main(int argc, const char **argv)
 	 */
 	setup_path();
=20
-	while (1) {
-		/* See if it's an internal command */
-		handle_internal_command(argc, argv);
-
-		/* .. then try the external ones */
-		execv_dashed_external(argv);
-
-		/* It could be an alias -- this works around the insanity
-		 * of overriding "git log" with "git show" by having
-		 * alias.log =3D show
-		 */
-		if (done_alias || !handle_alias(&argc, &argv))
-			break;
-		done_alias =3D 1;
-	}
+	was_alias =3D run_argv(&argc, &argv);
=20
 	if (errno =3D=3D ENOENT) {
-		if (done_alias) {
+		if (was_alias) {
 			fprintf(stderr, "Expansion of alias '%s' failed; "
 				"'%s' is not a git-command\n",
 				cmd, argv[0]);
 			exit(1);
 		}
 		argv[0] =3D help_unknown_cmd(cmd);
-		handle_internal_command(argc, argv);
-		execv_dashed_external(argv);
+		run_argv(&argc, &argv);
 	}
=20
 	fprintf(stderr, "Failed to run command '%s': %s\n",
--=20
1.6.1.62.g677ca
