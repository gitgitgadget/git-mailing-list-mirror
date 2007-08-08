From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 13:27:02 -0700
Message-ID: <7vlkcl3h7t.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	<Pine.LNX.4.64.0708072349400.14781@racer.site>
	<a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
	<20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
	<7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vps1x3ihp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIs7b-000229-6T
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935575AbXHHU1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935694AbXHHU1G
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:27:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40770 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935575AbXHHU1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 16:27:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808202703.WPEM7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 16:27:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYT31X0021kojtg0000000; Wed, 08 Aug 2007 16:27:03 -0400
In-Reply-To: <7vps1x3ihp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Aug 2007 12:59:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55357>

Ok, this is my second try.

 - Incorporated Sven's suggestion to give an example of
   problematic situation on submodule after "git-checkout" at
   the supermodule level;

 - Describe semantic clean-up of specifying GIT_DIR that is
   not strictly needed (because it is situated at the normal
   place relative to the working tree).

---
diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes-1.5.3.txt
index 21bb1fc..bf7a341 100644
--- a/Documentation/RelNotes-1.5.3.txt
+++ b/Documentation/RelNotes-1.5.3.txt
@@ -9,6 +9,40 @@ Updates since v1.5.2
 
 * The submodule support has Porcelain layer.
 
+  Note that the current submodule support is minimal and this is
+  deliberately so.  A design decision we made is that operations
+  at the supermodule level do not recurse into submodules by
+  default.  The expectation is that later we would add a
+  mechanism to tell git which submodules the user is interested
+  in, and this information might be used to determine the
+  recursive behaviour of certain commands (e.g. "git checkout"
+  and "git diff"), but currently we haven't agreed on what that
+  mechanism should look like.  In particular, if you have any
+  submodules checked out, running a "git checkout" at the
+  supermodule level will not update these submodules.  They will
+  therefore appear to be modified (to the state prior to the
+  checkout) to any subsequent git command, until they have been
+  updated explicitly using "git submodule update".
+
+* You can have a work tree not at the parent directory of .git
+  which is the repository.  This is done with GIT_WORK_TREE
+  environment, or --work-tree option.
+
+  This support slightly changes the semantics of having GIT_DIR
+  environment variable.  The rule used to be that when it is
+  given, you are supposed to be at the top level of the working
+  tree.  However, if it names a .git directory at the top of the
+  working tree, you can be in a subdirectory of that directory
+  and git notices you are in the subdirectory.  E.g. in t/
+  subdirectory of git.git project, 
+
+	$ cd t
+	$ GIT_DIR=../.git/ git ls-files -s
+
+  will list the files in t/ (i.e. your current directory).  It
+  used not to notice that you are in a subdirectory and listed
+  the files from the top-level of the working tree.
+
 * There are a handful pack-objects changes to help you cope better
   with repositories with pathologically large blobs in them.
 
