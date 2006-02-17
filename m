From: linux@horizon.com
Subject: [PATCH] git-repack question
Date: 17 Feb 2006 16:38:24 -0500
Message-ID: <20060217213824.5848.qmail@science.horizon.com>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 17 22:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADJD-0003kV-Ew
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWBQVic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWBQVic
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:38:32 -0500
Received: from science.horizon.com ([192.35.100.1]:47657 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751437AbWBQVib
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 16:38:31 -0500
Received: (qmail 5849 invoked by uid 1000); 17 Feb 2006 16:38:24 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16371>

I'm trying to imagine when you'd want to run git-repack without the -d
option, or without running git-prune-packed afterwards.
(Isn't the idea behind packs to save space?)

I'll leave changing the default to wiser heads, but this trivial patch
will at least allow the normal operations to be performed with one
command.

Oh, and is the failure to support getopt-style concatenated
single-letter options (git-repack -dp) a deliberate design feature
of git, or just laziness?

(Legalese: Patch placed in the public domain; copyright abandoned.)


diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 9060fe8..1b1f50d 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -47,6 +47,10 @@ OPTIONS
         Do not update the server information with
         `git update-server-info`.
 
+-p::
+	After packing, run gitlink:git-prune-packed[1] to delete
+	redundant unpacked objects.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/git-repack.sh b/git-repack.sh
index 1fafb6e..361c7e9 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-l] [-n]'
+USAGE='[-a] [-d] [-l] [-n] [-p]'
 . git-sh-setup
 	
-no_update_info= all_into_one= remove_redundant= local=
+no_update_info= all_into_one= remove_redundant= local= prune=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -14,6 +14,7 @@ do
 	-a)	all_into_one=t ;;
 	-d)	remove_redundant=t ;;
 	-l)	local=t ;;
+	-p)	prune=t ;;
 	*)	usage ;;
 	esac
 	shift
@@ -76,6 +77,10 @@ then
 	fi
 fi
 
+case "$prune" in
+t) git-prune-packed ;;
+esac
+
 case "$no_update_info" in
 t) : ;;
 *) git-update-server-info ;;
