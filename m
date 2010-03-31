From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] revert: add "--strategy" option to choose merge strategy
Date: Wed, 31 Mar 2010 21:22:08 +0200
Message-ID: <20100331192209.5827.9117.chriscool@tuxfamily.org>
References: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Alexander Gladysh <agladysh@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:46:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx6fi-0003M3-CG
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317Ab0CaWpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:45:41 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53030 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab0CaWpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:45:38 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6FFE881809E;
	Thu,  1 Apr 2010 00:45:27 +0200 (CEST)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3953481808F;
	Thu,  1 Apr 2010 00:45:25 +0200 (CEST)
X-git-sha1: c483e864de2a9b1ffc3e3d1801831e1032223385 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100331192014.5827.90637.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143704>

This patch makes it possible to use a different merge strategy when
cherry-picking. This is usefull mainly for debugging purposes as it
allows to see if some failures are caused by the merge strategy used or
not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8219ee2..bbaa937 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -43,6 +43,7 @@ static const char *commit_name;
 static int allow_rerere_auto;
 
 static const char *me;
+static const char *strategy;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -62,6 +63,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
+		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -483,8 +485,27 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		}
 	}
 
-	do_recursive_merge(base, next, base_label, next_label,
-			   head, &msgbuf, defmsg);
+	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT)
+		do_recursive_merge(base, next, base_label, next_label,
+				   head, &msgbuf, defmsg);
+	else {
+		int res;
+		struct commit_list *common = NULL;
+		struct commit_list *remotes = NULL;
+		write_message(&msgbuf, defmsg);
+		commit_list_insert(base, &common);
+		commit_list_insert(next, &remotes);
+		res = try_merge_command(strategy, common,
+					sha1_to_hex(head), remotes);
+		free_commit_list(common);
+		free_commit_list(remotes);
+		if (res) {
+			fprintf(stderr, "Automatic %s with strategy %s failed.%s\n",
+				me, strategy, help_msg(commit_name));
+			rerere(allow_rerere_auto);
+			exit(1);
+		}
+	}
 
 	/*
 	 *
-- 
1.7.0.3.454.gd9aeb
