From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not run git-pack-refs by default for now from git-gc
Date: Tue, 13 Feb 2007 01:48:24 -0800
Message-ID: <7vzm7iz8uv.fsf@assigned-by-dhcp.cox.net>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Feb 13 10:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGuGz-0006lC-KF
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 10:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965485AbXBMJs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 04:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965486AbXBMJs0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 04:48:26 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40048 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965485AbXBMJs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 04:48:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213094825.FKRE21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 04:48:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NxoR1W0051kojtg0000000; Tue, 13 Feb 2007 04:48:25 -0500
In-Reply-To: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 13 Feb 2007 01:27:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39506>

Just to be on the safe side, let's not run pack-refs from git-gc
without an explicit "[gc] packrefs = true" configuration.  This
default should be changed in the future when we can reasonably
assume that everybody runs post v1.5.0-rc0 version of git, at
which time people can still ask it not to run with the same
configuration ("[gc] packrefs = false").

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0129b1f..36b2c4f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -321,6 +321,16 @@ format.headers::
 	Additional email headers to include in a patch to be submitted
 	by mail.  See gitlink:git-format-patch[1].
 
+gc.packrefs::
+	`git gc` does not run `git pack-refs` by default
+	so that older dumb-transport clients can still fetch
+	from the repository.  Setting this to `true` lets `git
+	gc` to run `git pack-refs`.  Enable it only when you
+	know you do not have to support such clients.  The
+	default will change to run `git pack-refs` in some
+	future, and setting this to `false` will continue to
+	prevent `git pack-refs` from being run from `git gc`.
+
 gc.reflogexpire::
 	`git reflog expire` removes reflog entries older than
 	this time; defaults to 90 days.
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index e37758a..ca38c2e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -62,9 +62,14 @@ The optional configuration variable 'gc.rerereunresolved' indicates
 how long records of conflicted merge you have not resolved are
 kept.  This defaults to 15 days.
 
+The optional configuration variable 'gc.packrefs' determines if
+`git gc` runs `git-pack-refs`.  Without the configuration, `git-pack-refs` 
+is not run by default to allow older dumb-transport clients
+fetch from the repository,  but this will change in the future.
 
 See Also
 --------
+gitlink:git-pack-refs[1]
 gitlink:git-prune[1]
 gitlink:git-reflog[1]
 gitlink:git-repack[1]
diff --git a/git-gc.sh b/git-gc.sh
index 3e8c87c..054f338 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -22,7 +22,11 @@ do
 	shift
 done
 
-git-pack-refs --prune &&
+if pack_refs=$(git config --bool --get gc.packrefs) &&
+   test "true" = "$pack_refs"
+then
+	git-pack-refs --prune
+fi &&
 git-reflog expire --all &&
 git-repack -a -d -l &&
 $no_prune git-prune &&
