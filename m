From: Linus Torvalds <torvalds@osdl.org>
Subject: Make git-rev-list understand --tags/--branches/--remotes
Date: Wed, 17 May 2006 14:44:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171439371.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 23:45:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgTpM-0007UG-SZ
	for gcvg-git@gmane.org; Wed, 17 May 2006 23:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWEQVo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 17:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWEQVo6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 17:44:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbWEQVo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 17:44:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HLiqtH011610
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 14:44:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HLiqgm028573;
	Wed, 17 May 2006 14:44:52 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20245>


We shouldn't add stuff to git-rev-parse without teaching git-rev-list and 
all the other tools to do the same.

In fact, these days there is much less reason for git-rev-parse in the 
first place: it's usually used to verify a particular reference, or to 
just split the different argument types up from each other. Most tools 
don't need or use it any more (eg "gitk" will just pass its arguments 
directly to git-rev-list).

With this, you can now do (for example)

	gitk HEAD --not --tags

to see all the work on all the main branch that hasn't been included in a 
tagged version (replace HEAD with "--branches" to show all branches, of 
course).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/revision.c b/revision.c
index 2294b16..1fc6725 100644
--- a/revision.c
+++ b/revision.c
@@ -470,11 +470,13 @@ static int handle_one_ref(const char *pa
 	return 0;
 }
 
-static void handle_all(struct rev_info *revs, unsigned flags)
+typedef int (*ref_fn_t)(int (*)(const char *, const unsigned char *));
+
+static void handle_ref(ref_fn_t fn, struct rev_info *revs, unsigned flags)
 {
 	all_revs = revs;
 	all_flags = flags;
-	for_each_ref(handle_one_ref);
+	fn(handle_one_ref);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
@@ -614,7 +616,19 @@ int setup_revisions(int argc, const char
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				handle_all(revs, flags);
+				handle_ref(for_each_ref, revs, flags);
+				continue;
+			}
+			if (!strcmp(arg, "--branches")) {
+				handle_ref(for_each_branch_ref, revs, flags);
+				continue;
+			}
+			if (!strcmp(arg, "--tags")) {
+				handle_ref(for_each_tag_ref, revs, flags);
+				continue;
+			}
+			if (!strcmp(arg, "--remotes")) {
+				handle_ref(for_each_remote_ref, revs, flags);
 				continue;
 			}
 			if (!strcmp(arg, "--not")) {
