From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not try installing SVNimport on RPM
Date: Sun, 30 Oct 2005 14:37:12 -0800
Message-ID: <7vll0amy1z.fsf_-_@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7v1x22odka.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 23:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWLnj-0004fV-8m
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 23:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVJ3WhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJ3WhP
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 17:37:15 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57291 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932373AbVJ3WhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 17:37:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030223655.EKWY1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 17:36:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <7v1x22odka.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 30 Oct 2005 14:16:53 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10838>

HPA reports that svnimport uses perl 5.8.4 and the syntax it
uses to require confuses rpmbuild.  So let's try demoting the
problematic script just like we do with send-email.

Somebody should supply tested patches to split the package or
whatever is needed if they want to use these scripts on RPM
based systems.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

     "H. Peter Anvin" <hpa@zytor.com> writes:

    > git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)
    >
    > ... which RPM thinks means that you need a Perl module called v5.8.0 
    > which doesn't, of course, exist.  This is arguably an rpmbuild bug, but 
    > it nevertheless breaks at the moment.
    >
    > I'm afraid I cannot update any of the kernel.org machines to 0.99.9 
    > until these problems have been cleaned up.

    Does this work for you?

 Makefile         |   10 ++++++++--
 debian/changelog |    6 ++++++
 debian/rules     |    3 ++-
 git.sh           |    1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

applies-to: 5d3fb770835ba710480cbaf0c1b076a3a4affc54
e217a63c79ad93b26cb816eede1baf34e27b1e61
diff --git a/Makefile b/Makefile
index 1163dda..c60fb6b 100644
--- a/Makefile
+++ b/Makefile
@@ -52,7 +52,7 @@
 
 # DEFINES += -DUSE_STDEV
 
-GIT_VERSION = 0.99.9.GIT
+GIT_VERSION = 0.99.9a
 
 CFLAGS = -g -O2 -Wall
 ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
-	git-findtags.perl git-svnimport.perl git-mv.perl
+	git-findtags.perl git-mv.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
@@ -142,6 +142,12 @@ else
 	GIT_LIST_TWEAK += -e '/^send-email$$/d'
 endif
 
+ifdef WITH_SVNIMPORT
+	SCRIPT_PERL += git-svnimport.perl
+else
+	GIT_LIST_TWEAK += -e '/^svnimport$$/d'
+endif
+
 LIB_FILE=libgit.a
 
 LIB_H = \
diff --git a/debian/changelog b/debian/changelog
index 5fd31b7..5c5ba55 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+git-core (0.99.9a-0) unstable; urgency=low
+
+  * GIT 0.99.9a
+
+ -- Junio C Hamano <junkio@cox.net>  Sun, 30 Oct 2005 14:30:03 -0800
+
 git-core (0.99.9-0) unstable; urgency=low
 
   * GIT 0.99.9
diff --git a/debian/rules b/debian/rules
index 568d430..e6b6bad 100755
--- a/debian/rules
+++ b/debian/rules
@@ -26,8 +26,9 @@ else
 endif
 
 # We do have the requisite perl modules in the mainline, and
-# have no reason to shy away from this script.
+# have no reason to shy away from these scripts.
 export WITH_SEND_EMAIL=YesPlease
+export WITH_SVNIMPORT=YesPlease
 
 PREFIX := /usr
 MANDIR := /usr/share/man/
diff --git a/git.sh b/git.sh
index 94940ae..cd800bc 100755
--- a/git.sh
+++ b/git.sh
@@ -70,6 +70,7 @@ send-email
 shortlog
 show-branch
 status
+svnimport
 tag
 verify-tag
 whatchanged
---
0.99.9.GIT
