From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 17:11:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091710560.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com> 
 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org> 
 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com> 
 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org> 
 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com> 
 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org> 
 <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com> 
 <Pine.LNX.4.64.0606091640200.5498@g5.osdl.org>
 <9e4733910606091700s49018cd5p3b66f8ef51b22d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 02:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1For4m-0006Zg-SA
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWFJALi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWFJALi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:11:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932600AbWFJALh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 20:11:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A0BXgt008772
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 17:11:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A0BSMO003459;
	Fri, 9 Jun 2006 17:11:31 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091700s49018cd5p3b66f8ef51b22d2e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21571>



On Fri, 9 Jun 2006, Jon Smirl wrote:
> 
> Are we sure cvsps is ok? It is generating 500MB of warnings when I run it.

Do they go away with these patches?

		Linus
---
commit 3d1ebcef6b4f9f6c9064efd64da4dd30d93c3c96
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 17:20:20 2006 -0800

    Fix branch ancestor calculation
    
    Not having any ancestor at all means that any valid ancestor (even of
    "depth 0") is fine.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/cvsps.c b/cvsps.c
index c22147e..2695a0f 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2599,7 +2599,7 @@ static void determine_branch_ancestor(Pa
 	 * note: rev is the pre-commit revision, not the post-commit
 	 */
 	if (!head_ps->ancestor_branch)
-	    d1 = 0;
+	    d1 = -1;
 	else if (strcmp(ps->branch, rev->branch) == 0)
 	    continue;
 	else if (strcmp(head_ps->ancestor_branch, "HEAD") == 0)

commit 82fcf7e31bbeae3b01a8656549e9b8fd89d598eb
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 11:23:37 2006 -0800

    Improve handling of file collisions in the same patchset
    
    Take the file revision into account.

diff --git a/cvsps.c b/cvsps.c
index 1e64e3c..c22147e 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -2384,8 +2384,31 @@ void patch_set_add_member(PatchSet * ps,
     for (next = ps->members.next; next != &ps->members; next = next->next) 
     {
 	PatchSetMember * m = list_entry(next, PatchSetMember, link);
-	if (m->file == psm->file && ps->collision_link.next == NULL) 
-		list_add(&ps->collision_link, &collisions);
+	if (m->file == psm->file) {
+		int order = compare_rev_strings(psm->post_rev->rev, m->post_rev->rev);
+
+		/*
+		 * Same revision too? Add it to the collision list
+		 * if it isn't already.
+		 */
+		if (!order) {
+			if (ps->collision_link.next == NULL)
+				list_add(&ps->collision_link, &collisions);
+			return;
+		}
+
+		/*
+		 * If this is an older revision than the one we already have
+		 * in this patchset, just ignore it
+		 */
+		if (order < 0)
+			return;
+
+		/*
+		 * This is a newer one, remove the old one
+		 */
+		list_del(&m->link);
+	}
     }
 
     psm->ps = ps;

commit 534120d9a47062eecd7b53fd7ac0b70d97feb4fd
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Mar 22 11:20:59 2006 -0800

    Increase log-length limit to 64kB
    
    Yeah, it should be dynamic. I'm lazy.

diff --git a/cvsps_types.h b/cvsps_types.h
index b41e2a9..dba145d 100644
--- a/cvsps_types.h
+++ b/cvsps_types.h
@@ -8,7 +8,7 @@ #define CVSPS_TYPES_H
 
 #include <time.h>
 
-#define LOG_STR_MAX 32768
+#define LOG_STR_MAX 65536
 #define AUTH_STR_MAX 64
 #define REV_STR_MAX 64
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
