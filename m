From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 10:51:49 -0600
Message-ID: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 16 18:53:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg2mg-0007WM-Cw
	for gcvg-git@gmane.org; Tue, 16 May 2006 18:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWEPQwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWEPQwa
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 12:52:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35204 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751873AbWEPQw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 12:52:29 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4GGpp49010088;
	Tue, 16 May 2006 10:51:51 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4GGpolq010087;
	Tue, 16 May 2006 10:51:50 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20126>


Importing a quilt patch series into git is not very difficult
but parsing the patch descriptions and all of the other
minutia take a bit of effort to get right, so this automates it.

Since git and quilt complement each other it makes sense
to make it easy to go back and forth between the two.

---

Eric

 Documentation/git-quiltimport.txt |   50 +++++++++++++++++++++
 Makefile                          |    2 -
 git-quiltimport.sh                |   88 +++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-quiltimport.txt
 create mode 100644 git-quiltimport.sh

2256c7e9b3913732a5c3a2e54cdea20fc951b76d
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
new file mode 100644
index 0000000..8ea20eb
--- /dev/null
+++ b/Documentation/git-quiltimport.txt
@@ -0,0 +1,50 @@
+git-quiltimport(1)
+================
+
+NAME
+----
+git-quiltimport - Applies a quilt patchset onto the current branch
+
+
+SYNOPSIS
+--------
+[verse]
+'git-quiltimport' [--author <author>] [--patches <dir>]
+
+
+DESCRIPTION
+-----------
+Applies a quilt patchset onto the current git branch, preserving
+the patch boundaries, patch order, and patch descriptions present
+in the quilt patchset.
+
+For each patch the code attempts to extract the author from the 
+patch description.  If that fails it falls back to the author
+specified with --author.  If the --author flag was not given
+the the author is recorded as unknown.
+
+The patch name is preserved as the 1 line subject in the git
+description.
+
+OPTIONS
+-------
+--author Author Name <Author Email>::
+	The author name and email address to use when no author
+	information can be found in the patch description.
+
+--patches <dir>::
+	The directory to find the quilt patches and the
+	quilt series file.
+
+Author
+------
+Written by Eric Biederman <ebiederm@lnxi.com>
+
+Documentation
+--------------
+Documentation by Eric Biederman <ebiederm@lnxi.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 37fbe78..1f4abe6 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
-	git-lost-found.sh
+	git-lost-found.sh git-quiltimport.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
new file mode 100644
index 0000000..534be82
--- /dev/null
+++ b/git-quiltimport.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+USAGE='--author <author> --patches </path/to/quilt/patch/directory>'
+SUBDIRECTORY_ON=Yes
+. git-sh-setup
+
+quilt_author="Unknown <unknown>"
+while case "$#" in 0) break;; esac
+do
+	case "$1" in
+	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
+		quilt_author=$(expr "$1" : '-[^=]*\(.*\)')
+		shift
+		;;
+	
+	--au|--aut|--auth|--autho|--author)
+		case "$#" in 1) usage ;; esac
+		shift
+		quilt_author="$1"
+		shift
+		;;
+
+	--pa=*|--pat=*|--patc=*|--patch=*|--patche=*|--patches=*)
+		QUILT_PATCHES=$(expr "$1" : '-[^=]*\(.*\)')
+		shift
+		;;
+	
+	--pa|--pat|--patc|--patch|--patche|--patches)
+		case "$#" in 1) usage ;; esac
+		shift
+		QUILT_PATCHES="$1"
+		shift
+		;;
+	
+	*)
+		break
+		;;
+	esac
+done
+
+# Quilt Author
+quilt_author_name=$(expr "z$quilt_author" : 'z\(.*[^ ]\) *<.*') &&
+quilt_author_email=$(expr "z$quilt_author" : '.*\(<.*\)') &&
+test '' != "$quilt_author_name" &&
+test '' != "$quilt_author_email" ||
+die "malformatted --author parameter"
+
+# Quilt patch directory
+: ${QUILT_PATCHES:=patches}
+if ! [ -d "$QUILT_PATCHES" ] ; then
+	echo "The \"$QUILT_PATCHES\" directory does not exist."
+	exit 1
+fi
+
+# Temporay directories
+tmp_dir=.dotest
+tmp_msg="$tmp_dir/msg"
+tmp_patch="$tmp_dir/patch"
+tmp_info="$tmp_dir/info"
+
+
+# Find the intial commit
+commit=$(git-rev-parse HEAD)
+
+mkdir $tmp_dir || exit 2
+cat "$QUILT_PATCHES/series" | grep -v '^#' | 
+while read line ; do 
+	echo $line
+	(cat $QUILT_PATCHES/$line | git-mailinfo "$tmp_msg" "$tmp_patch" > "$tmp_info") || exit 3
+	
+	# Parse the author information
+	export GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
+	export GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
+	if [ -z "$GIT_AUTHOR_EMAIL" ] ; then
+		GIT_AUTHOR_NAME=$quilt_author_name
+		GIT_AUTHOR_EMAIL=$quilt_author_email
+	fi
+	export GIT_AUTHOR_DATE=$(sed -ne 's/Date: //p' "$tmp_info")
+	export SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
+	if [ -z "$SUBJECT" ] ; then
+		SUBJECT=$(echo $line | sed -e 's/.patch$//')
+	fi
+
+	git-apply --index -C1 "$tmp_patch" &&
+	tree=$(git-write-tree) &&
+	commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
+	git-update-ref HEAD $commit || exit 4
+done
+rm -rf $tmp_dir || exit 5
-- 
1.3.2.g2256
