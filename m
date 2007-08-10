From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] Optimize the common cases of git-read-tree
Date: Fri, 10 Aug 2007 12:21:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708101216000.30176@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.or
 g>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJa3b-0006ot-Q3
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 21:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbXHJTV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757600AbXHJTV4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 15:21:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59310 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756324AbXHJTVz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 15:21:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJLPjR002220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 12:21:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AJLKmI004375;
	Fri, 10 Aug 2007 12:21:20 -0700
In-Reply-To: <alpine.LFD.0.999.0708101213560.30176@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.924 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_43,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.23__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55565>


This optimizes bind_merge() and oneway_merge() to not unnecessarily
remove and re-add the old index entries when they can just get replaced
by updated ones.

This makes these operations much faster for large trees (where "large"
is in the 50,000+ file range), because we don't unnecessarily move index
entries around in the index array all the time.

Using the "bummer" tree (a test-tree with 100,000 files) we get:

Before:
	[torvalds@woody bummer]$ time git commit -m"Change one file" 50/500
	real    0m9.470s
	user    0m8.729s
	sys     0m0.476s

After:
	[torvalds@woody bummer]$ time git commit -m"Change one file" 50/500
	real    0m1.173s
	user    0m0.720s
	sys     0m0.452s

so for large trees this is easily very noticeable indeed.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Btw, these patches are based on top of my "speedup" branch, which includes 
the previous changes (including the change to use "struct tree_desc" in 
unpacking). However, apart from some context lines, they really should 
work fine on top of current master too, so if you don't want to take the 
"struct tree_desc" one, these patches should work fine even without it.

Also: this same "don't remove unnecessarily" case could (and should) be 
done for the two-way and three-way cases too, and it should be trivial to 
do. However, I didn't bother, since it wasn't the particular timings I was 
worried about. 

But doing that should help branch switching a lot, so I may send a "patch 
3/2" soon.

 unpack-trees.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7fed5d2..b4e2618 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -887,7 +887,6 @@ int bind_merge(struct cache_entry **src,
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	remove_entry(remove);
 	if (o->merge_size != 1)
 		return error("Cannot do a bind merge of %d trees\n",
 			     o->merge_size);
@@ -912,13 +911,14 @@ int oneway_merge(struct cache_entry **src,
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	remove_entry(remove);
 	if (o->merge_size != 1)
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
 
-	if (!a)
+	if (!a) {
+		remove_entry(remove);
 		return deleted_entry(old, old, o);
+	}
 	if (old && same(old, a)) {
 		if (o->reset) {
 			struct stat st;
