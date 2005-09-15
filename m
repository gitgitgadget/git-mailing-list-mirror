From: Linus Torvalds <torvalds@osdl.org>
Subject: Avoid wasting memory in git-rev-list
Date: Thu, 15 Sep 2005 14:43:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151434470.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 15 23:44:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG1Vu-0007c4-MO
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 23:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVIOVnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 17:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbVIOVnX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 17:43:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030468AbVIOVnX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 17:43:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FLhIBo022330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 14:43:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FLhHY7026575;
	Thu, 15 Sep 2005 14:43:17 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8642>


As pointed out on the list, git-rev-list can use a lot of memory.

One low-hanging fruit is to free the commit buffer for commits that we
parse. By default, parse_commit() will save away the buffer, since a lot
of cases do want it, and re-reading it continually would be unnecessary. 
However, in many cases the buffer isn't actually necessary and saving it 
just wastes memory.

We could just free the buffer ourselves, but especially in git-rev-list, 
we actually end up using the helper functions that automatically add 
parent commits to the commit lists, so we don't actually control the 
commit parsing directly. 

Instead, just make this behaviour of "parse_commit()" a global flag.  
Maybe this is a bit tasteless, but it's very simple, and it makes a
noticable difference in memory usage.

Before the change:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list v2.6.12..HEAD > /dev/null
	0.26user 0.02system 0:00.28elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+3714minor)pagefaults 0swaps

after the change:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list v2.6.12..HEAD > /dev/null
	0.26user 0.00system 0:00.27elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+2433minor)pagefaults 0swaps

note how the minor faults have decreased from 3714 pages to 2433 pages. 
That's all due to the fewer anonymous pages allocated to hold the comment 
buffers and their metadata.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Hey, I'm not proud. If somebody wants to do a prettier patch, go wild.

This still doesn't attack the _big_ memory use by

	"git-rev-list --objects"

where we just parse more stuff than we need to, but it's a first step.

diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,8 @@
 #include "commit.h"
 #include "cache.h"
 
+int save_commit_buffer = 1;
+
 struct sort_node
 {
 	/*
@@ -264,7 +266,7 @@ int parse_commit(struct commit *item)
 			     sha1_to_hex(item->object.sha1));
 	}
 	ret = parse_commit_buffer(item, buffer, size);
-	if (!ret) {
+	if (save_commit_buffer && !ret) {
 		item->buffer = buffer;
 		return 0;
 	}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -17,6 +17,7 @@ struct commit {
 	char *buffer;
 };
 
+extern int save_commit_buffer;
 extern const char *commit_type;
 
 struct commit *lookup_commit(const unsigned char *sha1);
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -582,6 +582,8 @@ int main(int argc, char **argv)
 		handle_one_commit(commit, &list);
 	}
 
+	save_commit_buffer = verbose_header;
+
 	if (!merge_order) {		
 		sort_by_date(&list);
 	        if (limited)
