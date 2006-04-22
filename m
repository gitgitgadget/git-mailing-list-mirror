From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] do not use the no-op "-s" to diff-files.
Date: Sat, 22 Apr 2006 00:49:46 -0700
Message-ID: <7v1wvqnj6t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 22 19:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXMIG-0003s8-EH
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDVRwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWDVRwK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:52:10 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750859AbWDVRwI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 13:52:08 -0400
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M7oG3v016409
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 07:50:31 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422074947.OECB18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 03:49:47 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19041>

The code to use '-s' flag to git-diff-files has been in cg-merge
(and its ancestor) since this commit:

    commit 39c1ae5dfd229fb87c723fcf9737f29a506a31f9
    Author: Petr Baudis <pasky@ucw.cz>
    Date:   Tue Apr 19 02:42:08 2005 +0200

The "-s" flag has been a no-op to git-diff-files (but not for
other diff siblings) for quite some time.  For other diff
siblings, the flag means "do not output anything", and it is
primarily useful to squelch patch/raw from one-tree form of
"diff-tree --pretty".

I am not sure if running diff-files to see if there is any
difference and then running update-index --refresh when it is is
a win -- I suspect you did this out of performance concerns, but
it might be faster to let update-index to figure out if there is
anything that needs to be done.  So the first variant is the
minimum impact (absolutely no semantic changes), the second
variant _might_ be a performance improvement.

-jc

-- >8 --
First variant

diff --git a/cg-merge b/cg-merge
index 004b78a..24fb6ca 100755
--- a/cg-merge
+++ b/cg-merge
@@ -199,7 +199,7 @@ if { [ "$head" = "$base" ] || [ "$head" 
 fi
 
 
-[ "$(git-diff-files -s)" ] && git-update-index --refresh >/dev/null
+[ "$(git-diff-files)" ] && git-update-index --refresh >/dev/null
 
 if [ ! "$squash" ]; then
 	[ -s "$_git/squashing" ] && die "cannot combine squashing and non-squashing merges"

-- >8 --
Second variant

diff --git a/cg-merge b/cg-merge
index 24fb6ca..938d21a 100755
--- a/cg-merge
+++ b/cg-merge
@@ -199,7 +199,7 @@ if { [ "$head" = "$base" ] || [ "$head" 
 fi
 
 
-[ "$(git-diff-files -s)" ] && git-update-index --refresh >/dev/null
+git-update-index --refresh >/dev/null
 
 if [ ! "$squash" ]; then
 	[ -s "$_git/squashing" ] && die "cannot combine squashing and non-squashing merges"
