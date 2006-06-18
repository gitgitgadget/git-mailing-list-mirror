From: Linus Torvalds <torvalds@osdl.org>
Subject: Some more memory leak avoidance
Date: Sat, 17 Jun 2006 18:47:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606171836180.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 18 03:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrmOw-0004IS-IE
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 03:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWFRBsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 21:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFRBsE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 21:48:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbWFRBsC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 21:48:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5I1lwgt002450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Jun 2006 18:47:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5I1lwQA005823;
	Sat, 17 Jun 2006 18:47:58 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22046>


This is really the dregs of my effort to not waste memory in git-rev-list, 
and makes barely one percent of a difference in the memory footprint, but 
hey, it's also a pretty small patch.

It discards the parent lists and the commit buffer after the commit has 
been shown by git-rev-list (and "git log" - which already did the commit 
buffer part), and frees the commit list entry that was used by the 
revision walker.

The big win would be to get rid of the "refs" pointer in the object 
structure (another 5%), because it's only used by fsck. That would require 
some pretty major surgery to fsck, though, so I'm timid and did the less 
interesting but much easier part instead.

This (percentually) makes a bigger difference to "git log" and friends, 
since those are walking _just_ commits, and thus the list entries tend to 
be a bigger percentage of the memory use. But the "list all objects" case 
does improve too.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This one should be independent of the other memory use optimizations.

 builtin-log.c      |    2 ++
 builtin-rev-list.c |    8 ++++++++
 revision.c         |    6 ++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 29a8851..f6da1c3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -40,6 +40,8 @@ static int cmd_log_wc(int argc, const ch
 		log_tree_commit(rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
+		free_commit_list(commit->parents);
+		commit->parents = NULL;
 	}
 	return 0;
 }
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 2b298c4..71353eb 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -89,6 +89,14 @@ static void show_commit(struct commit *c
 		printf("%s%c", pretty_header, hdr_termination);
 	}
 	fflush(stdout);
+	if (commit->parents) {
+		free_commit_list(commit->parents);
+		commit->parents = NULL;
+	}
+	if (commit->buffer) {
+		free(commit->buffer);
+		commit->buffer = NULL;
+	}
 }
 
 static struct object_list **process_blob(struct blob *blob,
diff --git a/revision.c b/revision.c
index f4b8826..475d604 100644
--- a/revision.c
+++ b/revision.c
@@ -944,9 +944,11 @@ struct commit *get_revision(struct rev_i
 	}
 
 	do {
-		struct commit *commit = revs->commits->item;
+		struct commit_list *entry = revs->commits;
+		struct commit *commit = entry->item;
 
-		revs->commits = revs->commits->next;
+		revs->commits = entry->next;
+		free(entry);
 
 		/*
 		 * If we haven't done the list limiting, we need to look at
