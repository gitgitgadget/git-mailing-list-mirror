From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH/RFC 1/2] Move "--parent" parsing into generic revision.c
 library code
Date: Thu, 30 Mar 2006 16:52:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Mar 31 02:53:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP7sy-00065Q-Ap
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 02:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWCaAwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 19:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCaAwu
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 19:52:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62399 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751046AbWCaAwt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 19:52:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2V0qkCo004613
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Mar 2006 16:52:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2V0qhsJ001548;
	Thu, 30 Mar 2006 16:52:45 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18212>


Move "--parent" parsing into generic revision.c library code

Not only do we do it in both rev-list.c and git.c, the revision walking
code will soon want to know whether we should rewrite parenthood
information or not.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is the trivial part. The next email will contain the real meat of the 
change, which starts doing path limiting incrementally, and makes doing 
things like

	git log drivers/

on the kernel a hell of a lot more pleasant, because it starts outputting 
the log immediately instead of pausing for about 20 seconds before it has 
parsed all of the history and then outputting it all in one go.

There's a HUGE difference to the "feel" of doing pathname limiting 
git-rev-list options. Not very well tested, but at least this initial 
preparatory patch is "obviously safe".

diff --git a/git.c b/git.c
index 0b40e30..72039c6 100644
--- a/git.c
+++ b/git.c
@@ -283,7 +283,6 @@ static int cmd_log(int argc, const char 
 	char *buf = xmalloc(LOGSIZE);
 	static enum cmit_fmt commit_format = CMIT_FMT_DEFAULT;
 	int abbrev = DEFAULT_ABBREV;
-	int show_parents = 0;
 	const char *commit_prefix = "commit ";
 
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
@@ -294,9 +293,6 @@ static int cmd_log(int argc, const char 
 			if (commit_format == CMIT_FMT_ONELINE)
 				commit_prefix = "";
 		}
-		else if (!strcmp(arg, "--parents")) {
-			show_parents = 1;
-		}
 		else if (!strcmp(arg, "--no-abbrev")) {
 			abbrev = 0;
 		}
@@ -317,7 +313,7 @@ static int cmd_log(int argc, const char 
 	while ((commit = get_revision(&rev)) != NULL) {
 		printf("%s%s", commit_prefix,
 		       sha1_to_hex(commit->object.sha1));
-		if (show_parents) {
+		if (rev.parents) {
 			struct commit_list *parents = commit->parents;
 			while (parents) {
 				struct object *o = &(parents->item->object);
diff --git a/rev-list.c b/rev-list.c
index f3a989c..19a547a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -39,7 +39,6 @@ struct rev_info revs;
 static int bisect_list = 0;
 static int verbose_header = 0;
 static int abbrev = DEFAULT_ABBREV;
-static int show_parents = 0;
 static int show_timestamp = 0;
 static int hdr_termination = 0;
 static const char *commit_prefix = "";
@@ -54,7 +53,7 @@ static void show_commit(struct commit *c
 	if (commit->object.flags & BOUNDARY)
 		putchar('-');
 	fputs(sha1_to_hex(commit->object.sha1), stdout);
-	if (show_parents) {
+	if (revs.parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
 			struct object *o = &(parents->item->object);
@@ -336,10 +335,6 @@ int main(int argc, const char **argv)
 				commit_prefix = "";
 			else
 				commit_prefix = "commit ";
-			continue;
-		}
-		if (!strcmp(arg, "--parents")) {
-			show_parents = 1;
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
diff --git a/revision.c b/revision.c
index abc8745..0330f9f 100644
--- a/revision.c
+++ b/revision.c
@@ -596,6 +596,10 @@ int setup_revisions(int argc, const char
 				revs->limited = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--parents")) {
+				revs->parents = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--dense")) {
 				revs->dense = 1;
 				continue;
diff --git a/revision.h b/revision.h
index 61e6bc9..0caeecf 100644
--- a/revision.h
+++ b/revision.h
@@ -34,7 +34,8 @@ struct rev_info {
 			edge_hint:1,
 			limited:1,
 			unpacked:1,
-			boundary:1;
+			boundary:1,
+			parents:1;
 
 	/* special limits */
 	int max_count;
