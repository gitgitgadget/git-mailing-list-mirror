From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-patch: understand old <his> notation
Date: Sat, 6 May 2006 22:56:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 06 22:56:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcTpf-0007R0-22
	for gcvg-git@gmane.org; Sat, 06 May 2006 22:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWEFU4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 16:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWEFU4j
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 16:56:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7887 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750753AbWEFU4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 16:56:39 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 342951BC1;
	Sat,  6 May 2006 22:56:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 28F2A1BA9;
	Sat,  6 May 2006 22:56:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1769E1BA2;
	Sat,  6 May 2006 22:56:37 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19668>


When calling "git fmt-patch HEAD~5", you now get the same as if you would
have said "git fmt-patch HEAD~5..". This makes it easier for my fingers
which are so used to the old syntax.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I wonder: would it make sense to make add_pending_object() and 
	get_reference() in revision.c non-static?

 builtin-diff.c |    2 +-
 builtin-log.c  |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 636edbf..2087316 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -232,7 +232,7 @@ static int builtin_diff_combined(struct 
 	return 0;
 }
 
-static void add_head(struct rev_info *revs)
+void add_head(struct rev_info *revs)
 {
 	unsigned char sha1[20];
 	struct object *obj;
diff --git a/builtin-log.c b/builtin-log.c
index 0027998..d5bbc1c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -11,6 +11,9 @@ #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
 
+/* this is in builtin-diff.c */
+void add_head(struct rev_info *revs);
+
 static int cmd_log_wc(int argc, const char **argv, char **envp,
 		      struct rev_info *rev)
 {
@@ -185,6 +188,11 @@ int cmd_format_patch(int argc, const cha
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (rev.pending_objects && rev.pending_objects->next == NULL) {
+		rev.pending_objects->item->flags |= UNINTERESTING;
+		add_head(&rev);
+	}
+
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
 
-- 
1.3.1.g9ba6-dirty
