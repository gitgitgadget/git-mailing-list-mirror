From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix git-fsck-objects SIGSEGV/divide-by-zero
Date: Mon, 4 Sep 2006 08:34:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609040821520.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Sep 04 17:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKGSr-00067C-P2
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 17:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWIDPeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 11:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWIDPeT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 11:34:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751093AbWIDPeS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 11:34:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k84FYDnW031215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Sep 2006 08:34:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k84FYCfB027164;
	Mon, 4 Sep 2006 08:34:13 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.488 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26420>


If you try to fsck a repository that isn't entirely empty, but that has no 
inter-object references (ie all the objects are blobs, and don't refer to 
anything else), git-fsck-objects currently fails.

This probably cannot happen in practice, but can be tested with something 
like

	git init-db
	touch dummy
	git add dummy
	git fsck-objects

where the fsck will die by a divide-by-zero when it tries to look up the 
references from the one object it found (hash_obj() will do a modulus by 
refs_hash_size).

On some other archiectures (ppc, sparc) the divide-by-zero will go 
unnoticed, and we'll instead SIGSEGV when we hit the "refs_hash[j]" 
access.

So move the test that should protect against this from mark_reachable() 
into lookup_object_refs(), which incidentally in the process also fixes 
mark_reachable() itself (it used to not mark the one object that _was_ 
reachable, because it decided that it had no refs too early).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/object-refs.c b/object-refs.c
index b0034e4..98ea100 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -55,9 +55,13 @@ static void add_object_refs(struct objec
 
 struct object_refs *lookup_object_refs(struct object *obj)
 {
-	int j = hash_obj(obj, refs_hash_size);
 	struct object_refs *ref;
+	int j;
 
+	/* nothing to lookup */
+	if (!refs_hash_size)
+		return NULL;
+	j = hash_obj(obj, refs_hash_size);
 	while ((ref = refs_hash[j]) != NULL) {
 		if (ref->base == obj)
 			break;
@@ -125,9 +129,6 @@ void mark_reachable(struct object *obj, 
 
 	if (!track_object_refs)
 		die("cannot do reachability with object refs turned off");
-	/* nothing to lookup */
-	if (!refs_hash_size)
-		return;
 	/* If we've been here already, don't bother */
 	if (obj->flags & mask)
 		return;
