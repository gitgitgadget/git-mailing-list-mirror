From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout and SUBDIRECTORY_OK='Yes'
Date: Thu, 22 Dec 2005 20:58:16 -0800
Message-ID: <7virtge7fb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512222217040.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 05:58:38 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epf0l-0002hV-IS
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 05:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVLWE6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 23:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVLWE6T
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 23:58:19 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27645 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030433AbVLWE6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 23:58:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223045627.UMIX17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 23:56:27 -0500
To: Jon Nelson <jnelson-git@jamponi.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13986>

Jon Nelson <jnelson-git@jamponi.net> writes:

> Is it safe to set SUBDIRECTORY_OK='Yes' in git-checkout.sh?

Personally, I do not like this kind of question. If it were
known to be safe we would have set it so already.

Ah, I must be tired.  Sorry.  Let's try again.

git-checkout does two very different things, and what they
should do when run from subdirectory are probably quite
different.

It does not make any sense to run the one that switches the
current head from anywhere other than the toplevel:

	git-checkout [-f] <branch>
        git-checkout [-b <branch>] <committish>

We could of course chdir to top and do the whole-tree checkout
in git-checkout, but the point is the operation does not make
sense on a partial tree.

The other form is to update the index file and working tree file
selectively:

	git-checkout <treeish> <file>... ;# out of tree to index and file
        git-checkout -- <file>...	 ;# out of index to file

This form _does_ make sense to run from subdirectory; and I
myself often wish we supported this.

Before SUBDIRECTORY_OK was introduced, git-*.sh commands were
carefully inspected and the ones that do not make much sense to
be run in subdirectories were marked with sh-setup.  So if you
do not see SUBDIRECTORY_OK, it is very likely that you need some
real work (like the analysis above to think what should happen
when run from a subdirectory, and actually coding it).

This patch *might* work, or it may not.  Please let us know.


diff --git a/git-checkout.sh b/git-checkout.sh
index 36308d2..1219ea0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 USAGE='[-f] [-b <new_branch>] [<branch>] [<paths>...]'
+SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
 old=$(git-rev-parse HEAD)
@@ -95,6 +96,14 @@ else
 	fi
 fi
 
+# We are switching branches and checking out trees, so
+# we *NEED* to be at the toplevel.
+cdup=$(git-rev-parse --show-cdup)
+if test ! -z "$cdup"
+then
+	cd "$cdup"
+fi
+
 [ -z "$new" ] && new=$old
 
 # If we don't have an old branch that we're switching to,
diff --git a/rev-parse.c b/rev-parse.c
index bb4949a..0c951af 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -216,6 +216,18 @@ int main(int argc, char **argv)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--show-cdup")) {
+				const char *pfx = prefix;
+				while (pfx) {
+					pfx = strchr(pfx, '/');
+					if (pfx) {
+						pfx++;
+						printf("../");
+					}
+				}
+				putchar('\n');
+				continue;
+			}
 			if (!strcmp(arg, "--git-dir")) {
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				static char cwd[PATH_MAX];
