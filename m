From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward when
	cherry-picking
Date: Mon, 01 Feb 2010 08:55:40 +0100
Message-ID: <20100201075542.3929.35967.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr6A-0005ho-5d
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0BAHxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:53:05 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49899 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753Ab0BAHxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:53:02 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 56C2D818124;
	Mon,  1 Feb 2010 08:52:54 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 50B45818127;
	Mon,  1 Feb 2010 08:52:52 +0100 (CET)
X-git-sha1: bcb65c89eae24032d8c08de820c881e9919011c5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138587>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-revert.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 3cbeab7..3f92515 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "pick.h"
+#include "reset.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -31,7 +32,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_commit, mainline, signoff;
+static int edit, no_commit, mainline, signoff, ff_ok;
 static int flags;
 static struct commit *commit;
 static int allow_rerere_auto;
@@ -51,6 +52,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BIT('x', NULL, &flags, "append commit name when cherry-picking", PICK_ADD_NOTE),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+		OPT_BOOLEAN(0, "ff", &ff_ok, "allow fast forward"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
@@ -71,6 +73,8 @@ static void parse_args(int argc, const char **argv)
 	}
 	if (commit->object.type != OBJ_COMMIT)
 		die ("'%s' does not point to a commit", arg);
+	if (ff_ok && no_commit)
+		die ("options --ff and --no-commit are incompatible");
 }
 
 static char *get_encoding(const char *message)
@@ -191,7 +195,7 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	const char *me;
 	struct strbuf msgbuf;
@@ -209,6 +213,19 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (!no_commit && index_differs_from("HEAD", 0))
 		die_dirty_index(me);
 
+	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
+		unsigned char head_sha1[20];
+		if (get_sha1("HEAD", head_sha1))
+			die("You do not have a valid HEAD.");
+		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
+			char *hex = sha1_to_hex(commit->object.sha1);
+			int res = reset(hex, prefix, HARD, 0, 0, 0, NULL);
+			if (!res)
+				fprintf(stderr, "Fast-forward to %s\n", hex);
+			return res;
+		}
+	}
+
 	if (!commit->buffer)
 		return error("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
@@ -270,11 +287,11 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		edit = 1;
 	flags = PICK_REVERSE | PICK_ADD_NOTE;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	flags = 0;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
-- 
1.6.6.1.557.g77031
