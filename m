From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] receive-pack: make it a builtin
Date: Tue,  9 Sep 2008 01:27:08 -0700
Message-ID: <1220948830-3275-3-git-send-email-gitster@pobox.com>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
 <1220948830-3275-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 10:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyaW-0005P5-IK
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbYIII1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbYIII1X
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:27:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbYIII1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:27:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 751337A7C5
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B84DA7A7C4 for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:19
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
In-Reply-To: <1220948830-3275-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1EC1ACCC-7E49-11DD-8878-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95352>

It is a good thing to do in general, but more importantly, transport
routines can only be used by built-ins, which is what I'll be adding next.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                                 |    2 +-
 receive-pack.c => builtin-receive-pack.c |    6 +++---
 builtin.h                                |    1 +
 git.c                                    |    1 +
 4 files changed, 6 insertions(+), 4 deletions(-)
 rename receive-pack.c => builtin-receive-pack.c (99%)

diff --git a/Makefile b/Makefile
index f4c31c8..f9c54ff 100644
--- a/Makefile
+++ b/Makefile
@@ -294,7 +294,6 @@ PROGRAMS += git-mktag$X
 PROGRAMS += git-mktree$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
-PROGRAMS += git-receive-pack$X
 PROGRAMS += git-send-pack$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
@@ -546,6 +545,7 @@ BUILTIN_OBJS += builtin-prune-packed.o
 BUILTIN_OBJS += builtin-prune.o
 BUILTIN_OBJS += builtin-push.o
 BUILTIN_OBJS += builtin-read-tree.o
+BUILTIN_OBJS += builtin-receive-pack.o
 BUILTIN_OBJS += builtin-reflog.o
 BUILTIN_OBJS += builtin-remote.o
 BUILTIN_OBJS += builtin-rerere.o
diff --git a/receive-pack.c b/builtin-receive-pack.c
similarity index 99%
rename from receive-pack.c
rename to builtin-receive-pack.c
index b81678a..6d6027e 100644
--- a/receive-pack.c
+++ b/builtin-receive-pack.c
@@ -462,14 +462,14 @@ static int delete_only(struct command *cmd)
 	return 1;
 }
 
-int main(int argc, char **argv)
+int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	char *dir = NULL;
 
 	argv++;
 	for (i = 1; i < argc; i++) {
-		char *arg = *argv++;
+		const char *arg = *argv++;
 
 		if (*arg == '-') {
 			/* Do flag handling here */
@@ -477,7 +477,7 @@ int main(int argc, char **argv)
 		}
 		if (dir)
 			usage(receive_pack_usage);
-		dir = arg;
+		dir = xstrdup(arg);
 	}
 	if (!dir)
 		usage(receive_pack_usage);
diff --git a/builtin.h b/builtin.h
index e67cb20..5d7cdca 100644
--- a/builtin.h
+++ b/builtin.h
@@ -78,6 +78,7 @@ extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index adf7352..2f5b4d7 100644
--- a/git.c
+++ b/git.c
@@ -328,6 +328,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
-- 
1.6.0.1.415.g7bb82
