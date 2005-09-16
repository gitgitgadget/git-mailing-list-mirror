From: Linus Torvalds <torvalds@osdl.org>
Subject: Avoid building object ref lists when not needed
Date: Fri, 16 Sep 2005 14:55:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161446100.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGOBL-0005aF-Pm
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 23:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIPVzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 17:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVIPVzl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 17:55:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbVIPVzk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 17:55:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GLtYBo019884
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 14:55:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GLtXG5015416;
	Fri, 16 Sep 2005 14:55:33 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8736>


The object parsing code builds a generic "this object references that 
object" because doing a full connectivity check for fsck requires it.

However, nothing else really needs it, and it's quite expensive for 
git-rev-list that can have tons of objects in flight.

So, exactly like the commit buffer save thing, add a global flag to 
disable it, and use it in git-rev-list.

Before:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	12.28user 0.29system 0:12.57elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+26718minor)pagefaults 0swaps
	59124

After this change:

	[torvalds@g5 linux]$ /usr/bin/time git-rev-list --objects v2.6.12..HEAD | wc -l
	10.33user 0.18system 0:10.54elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+18509minor)pagefaults 0swaps
	59124

and note how the number of pages touched by git-rev-list for this
particular object list has shrunk from 26,718 (104 MB) to 18,509 (72 MB).

Calculating the total object difference between two git revisions is still
clearly the most expensive git operation (both in memory and CPU time),
but it's now less than 40% of what it used to be.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----
diff --git a/object.c b/object.c
--- a/object.c
+++ b/object.c
@@ -9,6 +9,8 @@ struct object **objs;
 int nr_objs;
 static int obj_allocs;
 
+int track_object_refs = 1;
+
 static int find_object(const unsigned char *sha1)
 {
 	int first = 0, last = nr_objs;
@@ -67,9 +69,12 @@ void created_object(const unsigned char 
 
 void add_ref(struct object *refer, struct object *target)
 {
-	struct object_list **pp = &refer->refs;
-	struct object_list *p;
-	
+	struct object_list **pp, *p;
+
+	if (!track_object_refs)
+		return;
+
+	pp = &refer->refs;
 	while ((p = *pp) != NULL) {
 		if (p->item == target)
 			return;
@@ -87,6 +92,8 @@ void mark_reachable(struct object *obj, 
 {
 	struct object_list *p = obj->refs;
 
+	if (!track_object_refs)
+		die("cannot do reachability with object refs turned off");
 	/* If we've been here already, don't bother */
 	if (obj->flags & mask)
 		return;
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -17,6 +17,7 @@ struct object {
 	void *util;
 };
 
+extern int track_object_refs;
 extern int nr_objs;
 extern struct object **objs;
 
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -581,6 +581,7 @@ int main(int argc, char **argv)
 	}
 
 	save_commit_buffer = verbose_header;
+	track_object_refs = 0;
 
 	if (!merge_order) {		
 		sort_by_date(&list);
