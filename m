From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Sat, 1 Apr 2006 16:35:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0604011628500.3684@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> <7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603302225160.27203@g5.osdl.org> <7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 02 02:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPqYp-0003G6-Dh
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 02:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWDBAfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWDBAfN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 19:35:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbWDBAfL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 19:35:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k320Z7EX027204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Apr 2006 16:35:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k320Z66o015663;
	Sat, 1 Apr 2006 16:35:07 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18252>



On Thu, 30 Mar 2006, Junio C Hamano wrote:
> 
> OK, so let's say I agree with you that --unpacked and --since
> are "stop early" rules.  I fully agree with that from usability
> and implementation point of view, but I now wonder if the
> "output filter" in get_revision() and "stop early" in limit_list()
> would do the same thing.

They don't.

What ends up not working very well at all is the combination of 
"--topo-order" and the output filter in get_revision. It will return NULL 
when we see the first commit out of date-order, even if we have other 
commits coming.

So we really should do the "past the date order" thing in get_revision() 
only if we have _not_ done it already in limit_list().

Something like this.

The easiest way to test this is with just

	gitk --since=3.days.ago

on the kernel tree. Without this patch, it tends to be pretty obviously 
broken.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>

		Linus

---
diff --git a/revision.c b/revision.c
index a8a54b6..558ed01 100644
--- a/revision.c
+++ b/revision.c
@@ -783,10 +783,14 @@ struct commit *get_revision(struct rev_i
 
 		/*
 		 * If we haven't done the list limiting, we need to look at
-		 * the parents here
+		 * the parents here. We also need to do the date-based limiting
+		 * that we'd otherwise have done in limit_list().
 		 */
-		if (!revs->limited)
+		if (!revs->limited) {
+			if (revs->max_age != -1 && (commit->date < revs->max_age))
+				continue;
 			add_parents_to_list(revs, commit, &revs->commits);
+		}
 		if (commit->object.flags & SHOWN)
 			continue;
 		if (!(commit->object.flags & BOUNDARY) &&
@@ -794,8 +798,6 @@ struct commit *get_revision(struct rev_i
 			continue;
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
-		if (revs->max_age != -1 && (commit->date < revs->max_age))
-			return NULL;
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
