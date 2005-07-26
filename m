From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Mon, 25 Jul 2005 20:43:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>,
	David Mansfield <cvsps@dm.cobite.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 05:45:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxGNq-0008Kb-OB
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 05:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVGZDpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 23:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGZDpS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 23:45:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVGZDpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 23:45:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6Q3hfjA008117
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Jul 2005 20:43:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6Q3hevm029221;
	Mon, 25 Jul 2005 20:43:41 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Jul 2005, Linus Torvalds wrote:
> 
> And they are in the wrong order, so "cvsimport" ends up committing the 
> last one, which is the _empty_ one.
> 
> Notice? We'll end up committing "COPYING 1.1" (the empty initial create)
> even though we _should_ have committed "COPYING 1.2" (the actual thing
> that BK committed).

David, how about a patch like this to cvsps? My very very limited testing
seems to say that it does the right thing..

It's very simple: if we are adding the same file twice to the same 
PatchSet, we just look at the ordering of the revisions. If the revision 
we're adding is older than the revision we already have, we just drop that 
revision entirely. If it's the same, something is really wrong, and we add 
it to the "collisions" list. And if it's newer, then we remove the old 
revision for that file, and add the new one instead.

As far as I can tell, the old code really was broken, since it would
happen to list different revisions in a random order when you had multiple
changes to the same file in the same patchset. This one always selects the
last one, which would seem to be the sane behaviour.

And this all seem to make "git cvsimport -p --bkcvs" do the right thing. 

		Linus

---
diff --git a/cvsps.c b/cvsps.c
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
