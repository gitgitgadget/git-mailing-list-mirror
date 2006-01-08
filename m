From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] format-patch: Use --mbox by default.
Date: Sun, 8 Jan 2006 14:01:25 +0000 (UTC)
Message-ID: <20060108140109.909925BE8D@nox.op5.se>
X-From: git-owner@vger.kernel.org Sun Jan 08 15:01:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evb6o-0004mb-Sf
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 15:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWAHOBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 09:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWAHOBL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 09:01:11 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:388 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1161061AbWAHOBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 09:01:11 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BDD8A6BCBE
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 15:01:09 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 909925BE8D; Sun,  8 Jan 2006 15:01:09 +0100 (CET)
Date: 1136727310 +0100
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14318>

This patch enables a slightly modified and more correct --mbox
output by default. The --date, --author and --mbox options
are obsoleted and removed.

Previously, author-info and date was by default only printed if the
commit was made by someone else, irrespective of the obsoleted options.
Since it does no harm having ones own info there too it shouldn't really
matter much, and should lessen the confusion regarding how to use
git-format-patch with git-am.

The patches generated also had bad mail headers for sendmail (of
postfix 2.2.2 at least) to use directly (From: line must be on top,
Subject: last of header), which isn't really an issue but annoying
just the same. I haven't actually tried this new format, but at least
'file' now recognize it as "news or mail text", rather than "ASCII
English text".

Note that this reverts commit aa66c7ec77d474b737da607d6cb2d07f56628def,
"format-patch/commit: Quote single quote in the author name properly"
which is no longer needed since the whosepatchScript now prints
the headers directly rather than passing them to eval.

These changes allow us to remove two conditional statements
and the invokation of a sub-shell in the process_one function,
so it should be a bit faster too.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-format-patch.txt |   18 ++-----------
 git-format-patch.sh                |   49 +++++++-----------------------------
 2 files changed, 12 insertions(+), 55 deletions(-)

b38d1ffeb27ba32de849f33a9c416fda4cd8eecb
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 47705de..73e1358 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c] [--mbox]
+'git-format-patch' [-n | -k] [-o <dir> | --stdout] [-s] [-c]
 		 [--diff-options] <his> [<mine>]
 
 DESCRIPTION
@@ -27,9 +27,8 @@ When -n is specified, instead of "[PATCH
 line is formatted as "[PATCH N/M] Subject", unless you have only
 one patch.
 
-When --mbox is specified, the output is formatted to resemble
-UNIX mailbox format, and can be concatenated together for
-processing with applymbox.
+The output is formatted to resemble UNIX mailbox format, and can
+be concatenated together for processing with gitlink::git-am[1].
 
 
 OPTIONS
@@ -45,11 +44,6 @@ OPTIONS
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
--a|--author, -d|--date::
-	Output From: and Date: headers for commits made by
-	yourself as well.  Usually these are output only for
-	commits made by people other than yourself.
-
 -s|--signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
@@ -61,12 +55,6 @@ OPTIONS
         has a SP character immediately followed by a TAB
         character.
 
--m|--mbox::
-	Format the output files for closer to mbox format by
-	adding a phony Unix "From " line, so they can be
-	concatenated together and fed to `git-applymbox`.
-	Implies --author and --date.
-
 --stdout::
 	This flag generates the mbox formatted output to the
 	standard output, instead of saving them into a file per
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 818059f..047246e 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--mbox] [--diff-options] <upstream> [<our-head>]'
+USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--diff-options] <upstream> [<our-head>]'
 LONG_USAGE='Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
 numbered sequentially from 1, and uses the first line of the commit
@@ -15,9 +15,8 @@ the current working directory.
 When -n is specified, instead of "[PATCH] Subject", the first line is formatted
 as "[PATCH N/M] Subject", unless you have only one patch.
 
-When --mbox is specified, the output is formatted to resemble
-UNIX mailbox format, and can be concatenated together for processing
-with applymbox.'
+The output is formatted to resemble UNIX mailbox format, and can be
+concatenated together for processing with "git am".'
 . git-sh-setup
 
 # Force diff to run in C locale.
@@ -32,14 +31,8 @@ outdir=./
 while case "$#" in 0) break;; esac
 do
     case "$1" in
-    -a|--a|--au|--aut|--auth|--autho|--author)
-    author=t ;;
     -c|--c|--ch|--che|--chec|--check)
     check=t ;;
-    -d|--d|--da|--dat|--date)
-    date=t ;;
-    -m|--m|--mb|--mbo|--mbox)
-    date=t author=t mbox=t ;;
     -k|--k|--ke|--kee|--keep|--keep-|--keep-s|--keep-su|--keep-sub|\
     --keep-subj|--keep-subje|--keep-subjec|--keep-subject)
     keep_subject=t ;;
@@ -48,7 +41,7 @@ do
     -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
     signoff=t ;;
     --st|--std|--stdo|--stdou|--stdout)
-    stdout=t mbox=t date=t author=t ;;
+    stdout=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
     --output-d=*|--output-di=*|--output-dir=*|--output-dire=*|\
     --output-direc=*|--output-direct=*|--output-directo=*|\
@@ -173,12 +166,12 @@ titleScript='
 
 whosepatchScript='
 /^author /{
-	s/'\''/'\''\\'\'\''/g
-	s/author \(.*>\) \(.*\)$/au='\''\1'\'' ad='\''\2'\''/p
+	s/^author \([^>]*>\)[\t ]*\(.*\)$/From: \1\nDate: \2/p
 	q
 }'
 
 process_one () {
+	sed -ne "$whosepatchScript" $commsg
 	mailScript='
 	/./d
 	/^$/n'
@@ -191,26 +184,7 @@ process_one () {
 	    ;;
 	esac
 	mailScript="$mailScript"'
-	s|^|Subject: |'
-	case "$mbox" in
-	t)
-	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
-	    ;;
-	esac
-
-	eval "$(sed -ne "$whosepatchScript" $commsg)"
-	test "$author,$au" = ",$me" || {
-		mailScript="$mailScript"'
-	a\
-From: '"$au"
-	}
-	test "$date,$au" = ",$me" || {
-		mailScript="$mailScript"'
-	a\
-Date: '"$ad"
-	}
-
-	mailScript="$mailScript"'
+	s|^|Subject: |
 	a\
 
 	: body
@@ -218,7 +192,7 @@ Date: '"$ad"
 	n
 	b body'
 
-	(cat $commsg ; echo; echo) |
+	(cat $commsg; echo; echo) |
 	sed -ne "$mailScript" |
 	git-stripspace
 
@@ -239,12 +213,7 @@ Date: '"$ad"
 	git-diff-tree -p $diff_opts "$commit"
 	echo "-- "
 	echo "@@GIT_VERSION@@"
-
-	case "$mbox" in
-	t)
-		echo
-		;;
-	esac
+	echo
 }
 
 total=`wc -l <$series | tr -dc "[0-9]"`
-- 
1.0.7-gb38d1
