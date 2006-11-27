X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] revision traversal: Add --refs=<pattern> option
Date: Mon, 27 Nov 2006 18:09:11 +0300
Message-ID: <11646401513369-git-send-email-vsu@altlinux.ru>
References: <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Mon, 27 Nov 2006 15:09:33 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>, catalin.marinas@gmail.com,
	git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gb0b0
In-Reply-To: <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32416>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goi6j-0001bi-Pf for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758276AbWK0PJR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 10:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758278AbWK0PJR
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:09:17 -0500
Received: from master.altlinux.org ([62.118.250.235]:50450 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S1758277AbWK0PJQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 10:09:16 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id 79ACDE51DF;
 Mon, 27 Nov 2006 18:09:12 +0300 (MSK)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Add the --refs=<pattern> option, which can be used to select a
subset of refs matching the specified glob pattern.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 If --all-branches is too specific for the mentioned use case,
 what about adding a more general glob pattern match?

 Documentation/git-rev-list.txt |    9 +++++++++
 revision.c                     |   21 ++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ec43c0b..d5f99ef 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [ \--remove-empty ]
 	     [ \--not ]
 	     [ \--all ]
+	     [ \--refs=<pattern> ]
 	     [ \--stdin ]
 	     [ \--topo-order ]
 	     [ \--parents ]
@@ -179,6 +180,14 @@ limiting may be applied.
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
+--refs='pattern'::
+
+	Pretend as if all the refs in `$GIT_DIR/refs/` matching the
+	specified glob pattern are listed on the command line as
+	'<commit>'.  The initial `refs/` part is skipped when matching,
+	but the subsequent `heads/`, `tags/` or `remotes/` part is
+	included in the text to match.
+
 --stdin::
 
 	In addition to the '<commit>' listed on the command
diff --git a/revision.c b/revision.c
index 993bb66..240ff59 100644
--- a/revision.c
+++ b/revision.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "revision.h"
 #include <regex.h>
+#include <fnmatch.h>
 #include "grep.h"
 
 static char *path_name(struct name_path *path, const char *name)
@@ -464,18 +465,28 @@ static void limit_list(struct rev_info *
 
 static int all_flags;
 static struct rev_info *all_revs;
+static const char *all_pattern;
 
 static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *object = get_reference(all_revs, path, sha1, all_flags);
+	struct object *object;
+
+	if (all_pattern) {
+		if (strncmp(path, "refs/", 5))
+			return 0;
+		if (fnmatch(all_pattern, path + 5, 0))
+			return 0;
+	}
+	object = get_reference(all_revs, path, sha1, all_flags);
 	add_pending_object(all_revs, object, "");
 	return 0;
 }
 
-static void handle_all(struct rev_info *revs, unsigned flags)
+static void handle_all(struct rev_info *revs, unsigned flags, const char *pattern)
 {
 	all_revs = revs;
 	all_flags = flags;
+	all_pattern = pattern;
 	for_each_ref(handle_one_ref, NULL);
 }
 
@@ -800,7 +811,11 @@ int setup_revisions(int argc, const char
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				handle_all(revs, flags);
+				handle_all(revs, flags, NULL);
+				continue;
+			}
+			if (!strncmp(arg, "--refs=", 7)) {
+				handle_all(revs, flags, arg + 7);
 				continue;
 			}
 			if (!strcmp(arg, "--not")) {
-- 
1.4.4.1.gb0b0
