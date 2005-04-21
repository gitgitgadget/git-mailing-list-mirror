From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Allow "git cancel" to change branches
Date: Thu, 21 Apr 2005 23:31:24 +1000
Message-ID: <E1DObsr-0006Au-MA@server.smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:35:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DObp7-000156-0i
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 15:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVDUNis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDUNis
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 09:38:48 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:5053 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261363AbVDUNii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 09:38:38 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObsr-0006Au-MA
	for git@vger.kernel.org; Thu, 21 Apr 2005 15:38:28 +0200
Received: (nullmailer pid 2404 invoked by uid 501);
	Thu, 21 Apr 2005 13:38:21 -0000
Received: from [150.203.247.5] (helo=linux.smurf.noris.de)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObm3-00060x-Uy
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 15:31:31 +0200
Received: by linux.smurf.noris.de (sSMTP sendmail emulation); Thu, 21 Apr 2005 23:31:24 +1000
To: git@vger.kernel.org
X-Smurf-Spam-Score: -1.0 (-)
X-Smurf-Whitelist: smurf.noris.de
X-Smurf-Spam-Score: -1.9 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"git cancel" may not be named correctly for this job, but it does almost
everything you'd need for switching between one branch and another
within a repository, so...

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

--- f29be8140c5f1175052ec96ad2fa2b2901fd6ba5/git  (mode:100755 sha1:5f23301eb97a0fadd505a6e9cc851e98741a512a)
+++ 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/git  (mode:100755 sha1:557122dfb05580e4af2c55767f3d6f92b9110edd)
@@ -28,7 +28,7 @@
 	add		FILE...
 	addremote	RNAME RSYNC_URL
 	apply				< patch on stdin
-	cancel
+	cancel		[NAME]
 	ci, commit	[FILE]...	< log message on stdin
 	diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
 	export		DESTDIR [TREE_ID]
Index: gitcancel.sh
===================================================================
--- f29be8140c5f1175052ec96ad2fa2b2901fd6ba5/gitcancel.sh  (mode:100755 sha1:a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67)
+++ 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/gitcancel.sh  (mode:100755 sha1:2fc3e522132ef6a5f71352ab67005c93b5efc04f)
@@ -9,6 +9,9 @@
 # Basically, this is the opposite of git commit in some sense.
 #
 # Takes no arguments and the evil changes from the tree.
+# 
+# ... actually, if you do give it an argument, it'll switch the HEAD to
+# that branch -- or create a new one.
 
 [ -s ".git/add-queue" ] && rm $(cat .git/add-queue)
 rm -f .git/add-queue .git/rm-queue
@@ -29,6 +32,11 @@
 	fi
 fi
 
+if [ "$1" ] ; then
+	test -f .git/heads/$1 || cp .git/HEAD .git/heads/$1
+	ln -sf "heads/$1" .git/HEAD
+fi
+
 rm -f .git/blocked .git/merging .git/merging-sym .git/merge-base
 read-tree $(tree-id)
 
