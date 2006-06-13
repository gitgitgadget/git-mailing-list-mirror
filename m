From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 6/8] Make git-update-ref a builtin
Date: Tue, 13 Jun 2006 22:22:00 +0200
Organization: Chalmers
Message-ID: <448F1E68.5090504@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOt-0006Y1-CU
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFMUWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWFMUWF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:22:05 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932219AbWFMUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:22:04 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E7268; Tue, 13 Jun 2006 22:22:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21810>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                             |    7 ++++---
 update-ref.c =3D> builtin-update-ref.c |    5 ++++-
 builtin.h                            |    1 +
 git.c                                |    3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 906fc0f..4b30ca0 100644
--- a/Makefile
+++ b/Makefile
@@ -159,11 +159,11 @@ PROGRAMS =3D \
 	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X \
-	git-update-ref$X git-symbolic-ref$X \
+	git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
=20
-BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
+BUILT_INS =3D git-log$X git-whatchanged$X git-show$X git-update-ref$X =
\
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X git-stripspace$X \
 	git-check-ref-format$X git-rev-parse$X git-mailinfo$X \
@@ -226,7 +226,8 @@ BUILTIN_OBJS =3D \
 	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
-	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o
+	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o \
+	builtin-update-ref.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/update-ref.c b/builtin-update-ref.c
similarity index 89%
rename from update-ref.c
rename to builtin-update-ref.c
index a1e6bb9..00333c7 100644
--- a/update-ref.c
+++ b/builtin-update-ref.c
@@ -1,10 +1,11 @@
 #include "cache.h"
 #include "refs.h"
+#include "builtin.h"
=20
 static const char git_update_ref_usage[] =3D
 "git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
=20
-int main(int argc, char **argv)
+int cmd_update_ref(int argc, const char **argv, char **envp)
 {
 	const char *refname=3DNULL, *value=3DNULL, *oldval=3DNULL, *msg=3DNUL=
L;
 	struct ref_lock *lock;
@@ -52,5 +53,7 @@ int main(int argc, char **argv)
 		return 1;
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		return 1;
+
+	/* write_ref_sha1 always unlocks the ref, no need to do it explicitly=
 */
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 9ee5ea6..c1f3395 100644
--- a/builtin.h
+++ b/builtin.h
@@ -48,6 +48,7 @@ extern int cmd_diff_tree(int argc, const
 extern int cmd_cat_file(int argc, const char **argv, char **envp);
 extern int cmd_rev_parse(int argc, const char **argv, char **envp);
 extern int cmd_update_index(int argc, const char **argv, char **envp);
+extern int cmd_update_ref(int argc, const char **argv, char **envp);
=20
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
diff --git a/git.c b/git.c
index 4a931fb..652e3c4 100644
--- a/git.c
+++ b/git.c
@@ -183,7 +183,8 @@ static void handle_internal_command(int=20
 		{ "mailsplit", cmd_mailsplit },
 		{ "mailinfo", cmd_mailinfo },
 		{ "stripspace", cmd_stripspace },
-		{ "update-index", cmd_update_index }
+		{ "update-index", cmd_update_index },
+		{ "update-ref", cmd_update_ref }
 	};
 	int i;
=20
--=20
1.4.0
