From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Wed, 22 Mar 2006 16:12:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 01:13:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMDRy-00020v-Oj
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 01:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWCWANH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 19:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWCWANG
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 19:13:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964866AbWCWAMt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 19:12:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N0CjDZ019419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 16:12:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N0Cf52002883;
	Wed, 22 Mar 2006 16:12:43 -0800
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17835>



On Wed, 22 Mar 2006, Linus Torvalds wrote:
> 
> Looking at cvsps output (from
> 
> 	cvsps --norc -u -A -v -d --cvsdirect
> 		--root :pserver:anoncvs@sourceware.org:/cvs/src
> 		src > cvsps.out 2> cvsps.err
> 
> it's "PatchSet 104" (well, for me it is, I have a hacked cvsps, so it 
> might not be that for you), which creates the "gdb-4_18-branch", but it 
> appears that cvsps hasn't actually figured out any "Ancestor branch" for 
> that commit.

It _seems_ that the reason for that is that cvsps considers a revision 
number of 1.1.1.1 to have a "dot depth" of 0, for some really strange 
reason (it's a total special case).

And that will currently not compare as a "greater" dot depth than not 
having any revision number at all for the ancestor, so such a revision 
will never be considered an ancestor branch.

This one-liner to cvsps.c seems to make sure we have an ancestor branch 
for that "gdb-4.18-branch" branch, at least according to the cvsps output. 
I'm re-running "git cvsimport" with this cvsps to see if it gets us past 
that one point, but I need to go pick up Patricia from school, so I won't 
have time to actually check the result. If somebody wants to play with 
this, go wild.

(The point of this patch is to make sure that if the head PatchSet doesn't 
have an ancestor, we'll consider _any_ valid ancestor to be better than 
that).

		Linus

---
diff --git a/cvsps.c b/cvsps.c
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
