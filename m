From: Linus Torvalds <torvalds@osdl.org>
Subject: Improve git-rev-list memory usage further
Date: Fri, 16 Sep 2005 14:32:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161423400.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:33:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGNpU-0000Wl-UL
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 23:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVIPVdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIPVdG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 17:33:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751299AbVIPVdF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 17:33:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GLWrBo018427
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 14:32:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GLWmaL014273;
	Fri, 16 Sep 2005 14:32:50 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8734>


This avoids keeping tree entries around, and free's them as it traverses
the list. This avoids building up a huge memory footprint just for these 
small but very common allocations.

Before:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	11.65user 0.38system 0:12.65elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+42934minor)pagefaults 0swaps
	59124

After:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	12.28user 0.29system 0:12.57elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+26718minor)pagefaults 0swaps
	59124

note how the minor fault numbers - which ends up being how many pages we 
needed to map - go down from 42934 (167 MB) to 26718 (104 MB).

That's still a honking big memory footprint, but it's about half of what
it was just a day or two ago (and this is the object list for a pretty big
update - almost 60,000 objects. Smaller updates need less memory).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -147,11 +147,16 @@ static struct object_list **process_tree
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
 	p = add_object(obj, p, name);
-	for (entry = tree->entries ; entry ; entry = entry->next) {
+	entry = tree->entries;
+	tree->entries = NULL;
+	while (entry) {
+		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
 			p = process_tree(entry->item.tree, p, entry->name);
 		else
 			p = process_blob(entry->item.blob, p, entry->name);
+		free(entry);
+		entry = next;
 	}
 	return p;
 }
@@ -218,12 +223,15 @@ static void mark_tree_uninteresting(stru
 	if (parse_tree(tree) < 0)
 		die("bad tree %s", sha1_to_hex(obj->sha1));
 	entry = tree->entries;
+	tree->entries = NULL;
 	while (entry) {
+		struct tree_entry_list *next = entry->next;
 		if (entry->directory)
 			mark_tree_uninteresting(entry->item.tree);
 		else
 			mark_blob_uninteresting(entry->item.blob);
-		entry = entry->next;
+		free(entry);
+		entry = next;
 	}
 }
 
