From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [FYI PATCH v2] Added a git search and replace command
Date: Wed, 23 Jul 2008 21:55:20 +0200
Message-ID: <1216842920-25600-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 21:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkRl-0004IT-NY
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYGWTz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWTz0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:55:26 -0400
Received: from cas-mta4-fe.casema.nl ([83.80.1.32]:49115 "EHLO
	mta-fe.casema.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbYGWTzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:55:25 -0400
Received: from localhost (cas-filter1.mgmt.casema.nl [10.42.32.68])
	by mta-fe.casema.nl (Postfix) with ESMTP id B59113E21;
	Wed, 23 Jul 2008 21:55:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at casema.nl
Received: from mta-fe.casema.nl ([10.42.32.32])
	by localhost (cas-filter1.mgmt.casema.nl [10.42.32.211]) (amavisd-new, port 20024)
	with ESMTP id CKAoR7Gg-CkP; Wed, 23 Jul 2008 21:55:23 +0200 (CEST)
Received: from localhost.localdomain (535728D8.cable.casema.nl [83.87.40.216])
	by mta-fe.casema.nl (Postfix) with ESMTP id 65D8B3E12;
	Wed, 23 Jul 2008 21:55:23 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.15.gc85d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89761>

A simple script that uses 'git ls-files' and a bash for
loop to search and replace (using sed) all the specified
files. There is a config option for the pathspec. This
allows the user to set 'sar.pathspec' and then specify only
the sed on the commandline.
---

  Not meant for inclusion, just a simple script I wrote up
  when I wanted to change a function name in my repository
  but didn't want to figure out which magic argument to
  find does what I want. Another advantage of using git
  ls-files is that it will prevent that any unrevertable
  changes will be made (since the script checks if the tree
  is dirty or not). I'm sure there's plenty of room for
  improvement here, it's probably not portable at all
  either, so comments are welcome :).
  
  Changes since v2, the use of xargs was taken out and
  replaced by a bash for loop. Also I added a config value
  because I'm too lazy to type the pathspec each time.
  
  Interdiff below:
  
  diff --git a/git-sar.sh b/git-sar.sh
  index db6317b..e64b9bd 100755
  --- a/git-sar.sh
  +++ b/git-sar.sh
  @@ -1,24 +1,26 @@
   #!/bin/bash
   
  -do_sed () {
  -  sed "$2" $3 > $3.replaced
  -  mv $3.replaced $3
  -}
  -
   do_git_find() {
     # Sanity check
     if is_dirty_tree
     then
       echo "Refusing to work on a dirty tree"
  +    exit 1
     fi
   
     files=`git ls-files "$1"`
  +
  +  # See if there were any matching files
     if test -z "$files"
     then
       echo "Your pathspec did not match any files."
       exit 1
     fi
  -  echo "$files" | xargs -n 1 git-sar --replace $2
  +
  +  # Change them in-place
  +  for file in $files; do
  +    sed -i "$2" "$file";
  +  done
   }
   
   is_dirty_tree () {
  @@ -33,27 +35,28 @@ do_show_usage() {
   
   do_main() {
     # Verify argument size
  -  if test "$#" -le 1 -o "$#" -ge 4
  +  if test "$#" -ge 3
     then
       do_show_usage
     fi
   
  -  # Two argument form
  -  if test "$#" -eq 2
  +  if test "$#" -eq 1
     then
  -    do_git_find "$@"
  -  fi
  +    glob=`git config --get sar.pathspec`
   
  -  # Three argument form, we're calling ourselves through sed
  -  if test "$#" -eq 3
  -  then
  -    # Double check if the user typoed or if we are indeed meta-calling
  -    if test "$1" != "--replace"
  +    if test -z "$glob"
       then
  +      echo "No sar.pathspec set"
         do_show_usage
       fi
   
  -    do_sed "$@"
  +    do_git_find "$glob" "$1"
  +  fi
  +
  +  # Two argument form
  +  if test "$#" -eq 2
  +  then
  +    do_git_find "$@"
     fi
   }

 .gitignore |    1 +
 Makefile   |    1 +
 git-sar.sh |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100755 git-sar.sh

diff --git a/.gitignore b/.gitignore
index a213e8e..451cb93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -108,6 +108,7 @@ git-rev-list
 git-rev-parse
 git-revert
 git-rm
+git-sar
 git-send-email
 git-send-pack
 git-sh-setup
diff --git a/Makefile b/Makefile
index b01cf1c..979e9ea 100644
--- a/Makefile
+++ b/Makefile
@@ -252,6 +252,7 @@ SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-sar.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
diff --git a/git-sar.sh b/git-sar.sh
new file mode 100755
index 0000000..e64b9bd
--- /dev/null
+++ b/git-sar.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+
+do_git_find() {
+  # Sanity check
+  if is_dirty_tree
+  then
+    echo "Refusing to work on a dirty tree"
+    exit 1
+  fi
+
+  files=`git ls-files "$1"`
+
+  # See if there were any matching files
+  if test -z "$files"
+  then
+    echo "Your pathspec did not match any files."
+    exit 1
+  fi
+
+  # Change them in-place
+  for file in $files; do
+    sed -i "$2" "$file";
+  done
+}
+
+is_dirty_tree () {
+  `git diff --quiet`
+  test $? -ne 0
+}
+
+do_show_usage() {
+  echo "usage: git-sar pathspec sed"
+  exit 128
+}
+
+do_main() {
+  # Verify argument size
+  if test "$#" -ge 3
+  then
+    do_show_usage
+  fi
+
+  if test "$#" -eq 1
+  then
+    glob=`git config --get sar.pathspec`
+
+    if test -z "$glob"
+    then
+      echo "No sar.pathspec set"
+      do_show_usage
+    fi
+
+    do_git_find "$glob" "$1"
+  fi
+
+  # Two argument form
+  if test "$#" -eq 2
+  then
+    do_git_find "$@"
+  fi
+}
+
+do_main "$@"
+
-- 
1.6.0.rc0.15.gc85d5
