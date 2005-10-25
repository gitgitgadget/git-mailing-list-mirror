From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "gitk" work better with dense revlists
Date: Tue, 25 Oct 2005 13:01:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251253110.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 25 22:05:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUUzt-0003M4-Hu
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVJYUBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 16:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJYUBw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 16:01:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbVJYUBw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 16:01:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PK1iFC016322
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 13:01:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PK1g8l026680;
	Tue, 25 Oct 2005 13:01:43 -0700
To: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10612>


To generate the diff for a commit, gitk used to do

	git-diff-tree -p -C $p $id

(and same thing to generate filenames, except using just "-r" there) which 
does actually generate the diff from the parent to the $id, exactly like 
it meant to do.

However, that really sucks with --dense, where the "parent" information 
has all been rewritten to point to the previous commit. The diff actually 
works exactly right, but now it's the diff of the _whole_ sequence of 
commits all the way to the previous commit that last changed the file(s) 
that we are looking at.

And that's really not what we want 99.9% of the time, even if it may be 
perfectly sensible. Not only will the diff not actually match the commit 
message, but it will usually be _huge_, and all of it will be totally 
uninteresting to us, since we were only interested in a particular set of 
files.

It also doesn't match what we do when we write the patch to a file.

So this makes gitk just show the diff of _that_ commit.

We might even want to have some way to limit the diff to only the 
filenames we're interested in, but it's often nice to see what else 
changed at the same time, so that's secondary.

The merge diff handling is left alone, although I think that should also 
be changed to only look at what that _particular_ merge did, not what it 
did when compared to the faked-out parents.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Hmm?

Also, having now tested the previous "handle root commit in the 
TREECHANGED" logic a bit more, I think it's (a) stable and (b) the right 
thing to do. Sign me off on that one too.

		Linus

diff --git a/gitk b/gitk
index f1ea4e1..a9d37d9 100755
--- a/gitk
+++ b/gitk
@@ -2806,7 +2806,7 @@ proc gettreediffs {ids} {
     set treediff {}
     set id [lindex $ids 0]
     set p [lindex $ids 1]
-    if [catch {set gdtf [open "|git-diff-tree -r $p $id" r]}] return
+    if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
 }
@@ -2842,7 +2842,7 @@ proc getblobdiffs {ids} {
     set id [lindex $ids 0]
     set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree -r -p -C $p $id]
+    set cmd [list | git-diff-tree -r -p -C $id]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return
