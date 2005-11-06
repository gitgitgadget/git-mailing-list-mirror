From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sat, 05 Nov 2005 23:25:49 -0800
Message-ID: <7vfyqa44qq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
	<Pine.LNX.4.64.0511051535220.3316@g5.osdl.org>
	<Pine.LNX.4.64.0511051625110.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 08:26:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYeur-0004Lq-AX
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 08:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVKFHZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 02:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVKFHZw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 02:25:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46761 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751321AbVKFHZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 02:25:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106072531.LREN16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 02:25:31 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511051625110.3316@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 5 Nov 2005 16:27:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11194>

Linus Torvalds <torvalds@osdl.org> writes:

> This fixes the gitk thing, by installing it (along with git) in the 
> regular $prefix/bin directory (ie default /usr/bin for the RPM).

The other half of the fix needed to gitk is to teach it to use
/usr/lib/git-@@VERSION@@ to locate git-rev-list and friends.

I really hate to do this, but here is an attempt on top of your
patch, which:

 - makes gitk also use the @@GITDIR@@ to find git commands;

 - makes git and gitk honor $GIT_LIBEXEC environment, to let you
   override the hardcoded @@GITDIR@@;

 - makes "make clean" to clean generated file git again.

I am not sure how to handle gitk part, but the best approach
would be to sell this change (including the rename) back to
Paulus the upstream.

---
diff --git a/Makefile b/Makefile
index 2e78089..1948aa1 100644
--- a/Makefile
+++ b/Makefile
@@ -327,6 +327,15 @@ git: git.sh Makefile
 	chmod +x $@+
 	mv $@+ $@
 
+gitk: gitk.tcl Makefile
+	rm -f $@+ $@
+	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
+	    -e 's:@@GITDIR@@:$(gitdir):g' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    <$@.tcl >$@+
+	chmod +x $@+
+	mv $@+ $@
+
 $(filter-out git,$(patsubst %.sh,%,$(SCRIPT_SH))) : % : %.sh
 	rm -f $@
 	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
@@ -450,7 +459,7 @@ deb: dist
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o compat/*.o $(PROGRAMS) $(LIB_FILE)
-	rm -f $(SCRIPTS)
+	rm -f $(SCRIPTS) git gitk
 	rm -f git-core.spec *.pyc *.pyo
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
diff --git a/git.sh b/git.sh
index 9ba1608..f39b373 100755
--- a/git.sh
+++ b/git.sh
@@ -1,7 +1,13 @@
 #!/bin/sh
 
 cmd=
-path="@@GITDIR@@"
+case "$GIT_LIBEXEC" in
+'')
+	GIT_LIBEXEC='@@GITDIR@@'
+	export GIT_LIBEXEC
+	;;
+esac
+path="$GIT_LIBEXEC"
 export PATH="$path:$PATH"
 case "$#" in
 0)	;;
diff --git a/gitk b/gitk.tcl
similarity index 100%
rename from gitk
rename to gitk.tcl
index a9d37d9..be9a79e 100755
--- a/gitk
+++ b/gitk.tcl
@@ -7,6 +7,11 @@ exec wish "$0" -- "$@"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+if {![info exists env(GIT_LIBEXEC)]} {
+    set env(GIT_LIBEXEC) "@@GITDIR@@"
+}
+set env(PATH) "$env(GIT_LIBEXEC):$env(PATH)"
+
 proc gitdir {} {
     global env
     if {[info exists env(GIT_DIR)]} {
