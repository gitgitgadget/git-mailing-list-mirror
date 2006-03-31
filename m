From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Fri, 31 Mar 2006 11:39:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603311135290.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> <Pine.LNX.4.64.0603302153350.27203@g5.osdl.org>
 <7v3bgzxgbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 21:39:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPPT5-00039j-MD
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 21:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWCaTjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 14:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWCaTjd
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 14:39:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932078AbWCaTjc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 14:39:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2VJdSEX015239
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 31 Mar 2006 11:39:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2VJdRlm000901;
	Fri, 31 Mar 2006 11:39:27 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bgzxgbg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18229>



On Thu, 30 Mar 2006, Junio C Hamano wrote:
> 
> There already was a report that --boundary stuff is not quite
> right, so what you are seeing might be that the new code exposes
> its original breakage even more.  I haven't looked into the
> breakage of the original version yet either, so I cannot really
> say how your change breaks it.

[ Awake and thinking about this again ]

No, I think the new breakage was just because I was being a stupid ass.

When I converted get_revision() to do the parent parsing up at the top 
instead of at the bottom, I just didn't think correctly about your new 
BOUNDARY code, and my conversion for that was just wrong. Part of the "do 
the parents early" code was also removing the current commit early, so 
suddenly your BOUNDARY case for doing that thing was just removing some 
other random commit instead, which was obviously wrong.

The fix is trivial - with the new get_revision() organization, the 
BOUNDARY case special-case actually goes away entirely, and this trivial 
patch (on top of my 2/2 patch) should just fix it.

At least it passes my tests again now, and looking at the code everything 
seems sane.

		Linus
---
diff --git a/revision.c b/revision.c
index 0e3f074..753633e 100644
--- a/revision.c
+++ b/revision.c
@@ -796,18 +796,6 @@ struct commit *get_revision(struct rev_i
 			if (revs->parents)
 				rewrite_parents(commit);
 		}
-		/* More to go? */
-		if (revs->max_count) {
-			if (commit->object.flags & BOUNDARY) {
-				/* this is already uninteresting,
-				 * so there is no point popping its
-				 * parents into the list.
-				 */
-				struct commit_list *it = revs->commits;
-				revs->commits = it->next;
-				free(it);
-			}
-		}
 		commit->object.flags |= SHOWN;
 		return commit;
 	} while (revs->commits);
