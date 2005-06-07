From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] Add git-help-script
Date: Tue, 7 Jun 2005 10:19:44 -0400
Message-ID: <20050607141944.GA14915@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 07 16:17:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfes6-0006eN-L2
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 16:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVFGOTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVFGOTv
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 10:19:51 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:16008 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261872AbVFGOTp
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 10:19:45 -0400
Received: by timesys.com (Postfix, from userid 623)
	id C3651B2432; Tue,  7 Jun 2005 10:19:44 -0400 (EDT)
To: torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Id: 13d680c11f5403f3b1b48e71416e36770cd0aecf
tree 91e05412806336f2c9d989b8d9a2eccb21281efe
parent e774aa5641ca2267e7aba7338da3f7e355b7fb78
author Jason McMullan <jason.mcmullan@gmail.com> 1118153648 -0400
committer Jason McMullan <jason.mcmullan@gmail.com> 1118153648 -0400

Add: 'git help' aka 'git-help-script', built from Documentation/* information


======== diff against e774aa5641ca2267e7aba7338da3f7e355b7fb78 ========
diff --git a/Documentation/git-help-script.txt b/Documentation/git-help-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-help-script.txt
@@ -0,0 +1,29 @@
+git-help-script(1)
+==================
+v0.1, May 2005
+
+NAME
+----
+git-help-script - Short help of all the git commands and scripts
+
+
+SYNOPSIS
+--------
+'git-help-script' 
+
+DESCRIPTION
+-----------
+Shows a brief summary of all the git-* commands.
+
+Author
+------
+Written by Jason McMullan <jason.mcmullan@timesys.com>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,7 @@ INSTALL=install
 SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
-	git-log-script git-shortlog
+	git-log-script git-shortlog git-help-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
@@ -84,6 +84,26 @@ test-delta: test-delta.c diff-delta.o pa
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 
+git-help-script: Makefile $(patsubst %,Documentation/%.txt,$(SCRIPTS) $(PROG))
+	echo "#!/bin/sh" >git-help-script
+	echo "cat <<EOF" >>git-help-script
+	echo "Commands:" >>git-help-script
+	echo >>git-help-script
+	for cmd in $(sort $(SCRIPTS)) $(sort $(PROG)); do \
+	  doc="Documentation/$$cmd.txt"; \
+	  if [ ! -e "$$doc" ]; then \
+	    echo "MISSING: $$doc" 1>&2; \
+	    rm -f git-help-script; \
+	    exit 1; \
+	  fi; \
+	  desc=`grep "^$$cmd - " $$doc | cut -d' ' -f3-` ; \
+	  desc=`echo "$$desc" | sed -e 's/\(.\{40\}\) /\1\n                        /g'` ; \
+	  cmd=`echo $$cmd | sed -e 's/^git-\(.*\)-script$$/git \1/'`; \
+	  printf "    %-20s%s\n" "$$cmd" "$$desc" >>git-help-script; \
+	done
+	echo "EOF" >>git-help-script
+	echo "exit 1" >>git-help-script
+
 git-update-cache: update-cache.c
 git-diff-files: diff-files.c
 git-init-db: init-db.c
@@ -143,7 +163,7 @@ test: all
 	$(MAKE) -C t/ all
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE) git-help-script
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
diff --git a/git b/git
--- a/git
+++ b/git
@@ -1,4 +1,8 @@
 #!/bin/sh
-cmd="git-$1-script"
+
+cmd="$1"
+
+[ -z "$cmd" -o "$cmd" = "-h" -o "$cmd" = "--help" ] && cmd="help"
+cmd="git-$cmd-script"
 shift
 exec $cmd "$@"
======== end ========

