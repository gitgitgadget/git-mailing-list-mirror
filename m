From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 14:55:37 +0100
Message-ID: <20060207135537.GB9462@diku.dk>
References: <20060131041318.GC30744@diku.dk> <20060207003643.GJ31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 14:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6TK5-0003Y6-6K
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 14:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWBGNzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWBGNzm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 08:55:42 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:1970 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S965085AbWBGNzk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 08:55:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 981F552D52E;
	Tue,  7 Feb 2006 14:55:39 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32210-15; Tue,  7 Feb 2006 14:55:37 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id DF41152D4BD;
	Tue,  7 Feb 2006 14:55:37 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5C50B6DF845; Tue,  7 Feb 2006 14:54:53 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C46D861ACE; Tue,  7 Feb 2006 14:55:37 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060207003643.GJ31278@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15694>

Petr Baudis <pasky@suse.cz> wrote Tue, Feb 07, 2006:
> Dear diary, on Tue, Jan 31, 2006 at 05:13:18AM CET, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> said that...
> > A few Cogito bugs I found yesterday.
> > 
> >  - cg-fetch between local repos fails when the cloned branch URL does
> >    not point to a .git directory and a needed object from the repository
> >    being cloned is packed. git-local-fetch expects a .git directory.
> 
> Can't reproduce and I don't buy it. The very first line of local fetch
> handler is
> 
> 	[ -d "$uri/.git" ] && uri="$uri/.git"

I cannot reproduce it either and my strace file is long gone thanks to
cg-clean. Come to think of it it might have been caused by a pack file
not following the more strict name rules which recently was introduced
in GIT.

> >  - cg-status reports a deleted file both as deleted and as unknown:
> > 
> > 	fonseca@antimatter:~/src/elinks/0.12 > git --version
> > 	git version 1.1.6.g1506
> > 	fonseca@antimatter:~/src/elinks/0.12 > cg --version
> > 	cogito-0.17pre.GIT (d3aa9a2b3375e36c774ea477492db76baa1db03e)
> > 	fonseca@antimatter:~/src/elinks/0.12 > cg rm AUTHORS
> > 	Removing file AUTHORS
> > 	fonseca@antimatter:~/src/elinks/0.12 > cg status | grep AUTHORS
> > 	? AUTHORS
> > 	D AUTHORS
> 
> This is fine, I'd say. The file was not deleted from the tree, either do
> that manually by rm or say cg-rm -f.

Yes, I guess you are right, this is a special case. But I think it needs
to be noted that this is 'normal'. Something like this vague patch
signed-off-by me.

diff --git a/cg-status b/cg-status
index 6abc52f..d38c61f 100755
--- a/cg-status
+++ b/cg-status
@@ -21,12 +21,12 @@
 # D::
 #	'<file>' has been deleted.
 # !::
-#	'<file>' is gone from your working copy but not deleted by cg-rm.
+#	'<file>' is gone from your working copy but not deleted by `cg-rm`.
 # M::
 #	'<file>' has been touched or modified.
 # m::
 #	'<file>' has been touched or modified, but will not be automatically
-#	committed the next time you call cg-commit. This is used during a
+#	committed the next time you call `cg-commit`. This is used during a
 #	merge to mark files which contained local changes before the merge.
 #
 # OPTIONS
@@ -55,6 +55,14 @@
 #	Path to the directory to use as the base for the working tree
 #	file list (instead of the current directory).
 #
+# NOTES
+# -----
+# If a file has been removed with `cg-rm` without using the `-f` option
+# to remove it physically from the tree it will be reported as both being
+# deleted and unknown. The reason for this is that the file is internally
+# marked as deleted and thus also untracked. After next commit it will only
+# be reported as being untracked.
+#
 # FILES
 # -----
 # $GIT_DIR/info/exclude::

-- 
Jonas Fonseca
