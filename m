From: Thomas Moulard <thomas.moulard@gmail.com>
Subject: [PATCH] contrib/hooks/post-receive-email: Fix solaris portability issues.
Date: Mon,  8 Jun 2009 16:02:37 +0900
Message-ID: <1244444557-21685-1-git-send-email-thomas.moulard@gmail.com>
Cc: Thomas Moulard <thomas.moulard@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 09:04:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDYtl-0001TK-Vw
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbZFHHDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 03:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbZFHHDw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:03:52 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64001 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZFHHDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:03:52 -0400
Received: by pzk1 with SMTP id 1so2033206pzk.33
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Qwp6rjiXyKCdf1NRghZEFtLM5KAETrJpVjjA6atxxCE=;
        b=VeqpP+iDetARBrWXOs3MV59k+hWmtdE+mm7a29h5RayYGDXA9xTcvPP/IJIdTHqldT
         FRuDUC+MWzT3OXQfUqLy2wvgrq/3a3s21IPrTi+Fw98clrLF1tLYyuM8g/MqaFJCgrql
         vz0HkYpRCxJ1gcZBX3N2Wq6j+zC/qWgxlIqVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ppr9Gal1y/ncmhAs3bAp1LBeU6Lf1Z1H53z61yNn0BHmZ9aBmrcI4HMNUpSBuOXZMJ
         kcs3OwQTuDQNAK7Q7TRulKWSrBLcY7rgKzWhyZ8F2x3KHP8KZkFOUCV9rgxt2jrDMCdQ
         UnimqMIR9MMozczAIedU5Akw5qHCpYk8AOCvA=
Received: by 10.142.218.4 with SMTP id q4mr2088428wfg.76.1244444633623;
        Mon, 08 Jun 2009 00:03:53 -0700 (PDT)
Received: from localhost.localdomain ([150.29.191.67])
        by mx.google.com with ESMTPS id 30sm8279328wfd.1.2009.06.08.00.03.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 00:03:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121041>

This patch solves some issues I had on a Solaris system:
$ showrev -c /bin/sh | grep version
Command version: SunOS 5.10 Generic 121005-03 Oct 2006

1. Replace $(...) by backquotes.
2. Replace shell substitution ${var##word} by echo + sed
3. Replace grep -F by fgrep.

These portability problems are reported in Autoconf documentation:
http://www.gnu.org/software/hello/manual/autoconf/Shell-Substitutions.html#Shell-Substitutions

---
 contrib/hooks/post-receive-email |   60 +++++++++++++++++++-------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 2a66063..3d00475 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -74,8 +74,8 @@
 generate_email()
 {
 	# --- Arguments
-	oldrev=$(git rev-parse $1)
-	newrev=$(git rev-parse $2)
+	oldrev=`git rev-parse $1`
+	newrev=`git rev-parse $2`
 	refname="$3"

 	# --- Interpret
@@ -95,8 +95,8 @@ generate_email()
 	fi

 	# --- Get the revision types
-	newrev_type=$(git cat-file -t $newrev 2> /dev/null)
-	oldrev_type=$(git cat-file -t "$oldrev" 2> /dev/null)
+	newrev_type=`git cat-file -t $newrev 2> /dev/null`
+	oldrev_type=`git cat-file -t "$oldrev" 2> /dev/null`
 	case "$change_type" in
 	create|update)
 		rev="$newrev"
@@ -118,12 +118,12 @@ generate_email()
 		refs/tags/*,commit)
 			# un-annotated tag
 			refname_type="tag"
-			short_refname=${refname##refs/tags/}
+			short_refname=`echo "$refname" | sed 's|refs/tags/||'`
 			;;
 		refs/tags/*,tag)
 			# annotated tag
 			refname_type="annotated tag"
-			short_refname=${refname##refs/tags/}
+			short_refname=`echo "$refname" | sed 's|refs/tags/||'`
 			# change recipients
 			if [ -n "$announcerecipients" ]; then
 				recipients="$announcerecipients"
@@ -132,12 +132,12 @@ generate_email()
 		refs/heads/*,commit)
 			# branch
 			refname_type="branch"
-			short_refname=${refname##refs/heads/}
+			short_refname=`echo "$refname" | sed 's|refs/heads/||'`
 			;;
 		refs/remotes/*,commit)
 			# tracking branch
 			refname_type="tracking branch"
-			short_refname=${refname##refs/remotes/}
+			short_refname=`echo "$refname" | sed 's|refs/remotes/||'`
 			echo >&2 "*** Push-update of tracking branch, $refname"
 			echo >&2 "***  - no email generated."
 			exit 0
@@ -168,7 +168,7 @@ generate_email()
 	# Email parameters
 	# The email subject will contain the best description of the ref
 	# that we can build from the parameters
-	describe=$(git describe $rev 2>/dev/null)
+	describe=`git describe $rev 2>/dev/null`
 	if [ -z "$describe" ]; then
 		describe=$rev
 	fi
@@ -279,7 +279,7 @@ generate_update_branch_email()
 	# all of our commits.  What we really want is to exclude the current
 	# value of $refname from the --not list, rather than N itself.  So:
 	#
-	#  git rev-parse --not --all | grep -v $(git rev-parse $refname)
+	#  git rev-parse --not --all | grep -v `git rev-parse $refname`
 	#
 	# Get's us to something pretty safe (apart from the small time
 	# between refname being read, and git rev-parse running - for that,
@@ -320,9 +320,9 @@ generate_update_branch_email()
 	# revisions
 	fast_forward=""
 	rev=""
-	for rev in $(git rev-list $newrev..$oldrev)
+	for rev in `git rev-list $newrev..$oldrev`
 	do
-		revtype=$(git cat-file -t "$rev")
+		revtype=`git cat-file -t "$rev"`
 		echo "  discards  $rev ($revtype)"
 	done
 	if [ -z "$rev" ]; then
@@ -334,9 +334,9 @@ generate_update_branch_email()
 	# have already had notification emails and is present to show the
 	# full detail of the change from rolling back the old revision to
 	# the base revision and then forward to the new revision
-	for rev in $(git rev-list $oldrev..$newrev)
+	for rev in `git rev-list $oldrev..$newrev`
 	do
-		revtype=$(git cat-file -t "$rev")
+		revtype=`git cat-file -t "$rev"`
 		echo "       via  $rev ($revtype)"
 	done

@@ -357,7 +357,7 @@ generate_update_branch_email()

 		# Find the common ancestor of the old and new revisions and
 		# compare it with newrev
-		baserev=$(git merge-base $oldrev $newrev)
+		baserev=`git merge-base $oldrev $newrev`
 		rewind_only=""
 		if [ "$baserev" = "$newrev" ]; then
 			echo "This update discarded existing revisions and left the branch pointing at"
@@ -460,12 +460,12 @@ generate_atag_email()
 {
 	# Use git for-each-ref to pull out the individual fields from the
 	# tag
-	eval $(git for-each-ref --shell --format='
+	eval `git for-each-ref --shell --format='
 	tagobject=%(*objectname)
 	tagtype=%(*objecttype)
 	tagger=%(taggername)
 	tagged=%(taggerdate)' $refname
-	)
+	`

 	echo "   tagging  $tagobject ($tagtype)"
 	case "$tagtype" in
@@ -474,14 +474,14 @@ generate_atag_email()
 		# If the tagged object is a commit, then we assume this is a
 		# release, and so we calculate which tag this tag is
 		# replacing
-		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
+		prevtag=`git describe --abbrev=0 $newrev^ 2>/dev/null`

 		if [ -n "$prevtag" ]; then
 			echo "  replaces  $prevtag"
 		fi
 		;;
 	*)
-		echo "    length  $(git cat-file -s $tagobject) bytes"
+		echo "    length  `git cat-file -s $tagobject` bytes"
 		;;
 	esac
 	echo " tagged by  $tagger"
@@ -578,7 +578,7 @@ generate_general_email()
 		# a commit, so there is no log for us to display.  It's
 		# probably not wise to output git cat-file as it could be a
 		# binary blob.  We'll just say how big it is
-		echo "$newrev is a $newrev_type, and is $(git cat-file -s $newrev) bytes long."
+		echo "$newrev is a $newrev_type, and is `git cat-file -s $newrev` bytes long."
 	fi
 }

@@ -619,8 +619,8 @@ show_new_revisions()
 		revspec=$oldrev..$newrev
 	fi

-	other_branches=$(git for-each-ref --format='%(refname)' refs/heads/ |
-	    grep -F -v $refname)
+	other_branches=`git for-each-ref --format='%(refname)' refs/heads/ |
+	    fgrep -v $refname`
 	git rev-parse --not $other_branches |
 	if [ -z "$custom_showrev" ]
 	then
@@ -629,7 +629,7 @@ show_new_revisions()
 		git rev-list --stdin $revspec |
 		while read onerev
 		do
-			eval $(printf "$custom_showrev" $onerev)
+			eval `printf "$custom_showrev" $onerev`
 		done
 	fi
 }
@@ -653,13 +653,13 @@ LOGEND="-----------------------------------------------------------------------"
 # --- Config
 # Set GIT_DIR either from the working directory, or from the environment
 # variable.
-GIT_DIR=$(git rev-parse --git-dir 2>/dev/null)
+GIT_DIR=`git rev-parse --git-dir 2>/dev/null`
 if [ -z "$GIT_DIR" ]; then
 	echo >&2 "fatal: post-receive: GIT_DIR not set"
 	exit 1
 fi

-projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+projectdesc=`sed -ne '1p' "$GIT_DIR/description"`
 # Check if the description is unchanged from it's default, and shorten it to
 # a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
@@ -667,11 +667,11 @@ then
 	projectdesc="UNNAMED PROJECT"
 fi

-recipients=$(git config hooks.mailinglist)
-announcerecipients=$(git config hooks.announcelist)
-envelopesender=$(git config hooks.envelopesender)
-emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
-custom_showrev=$(git config hooks.showrev)
+recipients=`git config hooks.mailinglist`
+announcerecipients=`git config hooks.announcelist`
+envelopesender=`git config hooks.envelopesender`
+emailprefix=`git config hooks.emailprefix || echo '[SCM] '`
+custom_showrev=`git config hooks.showrev`

 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
--
1.6.3
