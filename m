From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Split sample update hook into post-receive hook
Date: Wed, 7 Mar 2007 23:16:18 -0500
Message-ID: <20070308041618.GA29744@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 05:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPA3I-0001sj-Vf
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 05:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbXCHEQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbXCHEQY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 23:16:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35847 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXCHEQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 23:16:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPA2y-0001vB-Gn; Wed, 07 Mar 2007 23:16:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E20A820FBAE; Wed,  7 Mar 2007 23:16:18 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41712>

Now that receive-pack supports the new post-receive hook, which
was specifically designed for sending out email notifications,
we should break the default update hook into two parts: one that
rejects non-annotated tags (the update hook) and one that sends
notifications (the post-receive hook).

Future modifications to the default post-receive hook may include
bundling notifications about multiple branches into one email, but
I'm not going to do it as I don't personally use these hooks.  ;-)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Sorry about the mess here.  This is with -M -C, and yet we still
 get a huge diff on hooks--update due to the large number of lines
 removed from an existing file.  I think the diff would have been
 smaller if hooks--update was just considered to be new.  ;-)

 This is a crude hack to make the default hooks be split the way
 receive-pack now supports (and suggests).  Like I said above, I
 don't personally use these, so I'd really appreciate review from
 those who do.

 templates/{hooks--update => hooks--post-receive} |   49 ++---
 templates/hooks--update                          |  226 +---------------------
 2 files changed, 26 insertions(+), 249 deletions(-)
 copy templates/{hooks--update => hooks--post-receive} (90%)

diff --git a/templates/hooks--update b/templates/hooks--post-receive
similarity index 90%
copy from templates/hooks--update
copy to templates/hooks--post-receive
index 5b82b68..cface25 100644
--- a/templates/hooks--update
+++ b/templates/hooks--post-receive
@@ -1,10 +1,12 @@
 #!/bin/sh
 #
-# An example hook script to mail out commit update information.
-# It can also blocks tags that aren't annotated.
-# Called by git-receive-pack with arguments: refname sha1-old sha1-new
+# An example hook script to mail out commit update information
+# after a push has been successfully received into this repository.
+# Called by git-receive-pack with arguments:
+#    (refname sha1-old sha1-new)+
 #
-# To enable this hook, make this file executable by "chmod +x update".
+# To enable this hook, make this file executable by
+# "chmod +x post-receive".
 #
 # Config
 # ------
@@ -16,9 +18,6 @@
 #   This is the list that all pushes of annotated tags will go to.  Leave it
 #   blank to just use the mailinglist field.  The announce emails list the
 #   short log summary of the changes since the last annotated tag
-# hooks.allowunannotated
-#   This boolean sets whether unannotated tags will be allowed into the
-#   repository.  By default they won't be.
 #
 # Notes
 # -----
@@ -32,10 +31,10 @@ LOGBEGIN="- Log ----------------------------------------------------------------
 LOGEND="-----------------------------------------------------------------------"
 DATEFORMAT="%F %R %z"
 
-# --- Command line
-refname="$1"
-oldrev="$2"
-newrev="$3"
+# --- Config
+projectdesc=$(cat $GIT_DIR/description)
+recipients=$(git-repo-config hooks.mailinglist)
+announcerecipients=$(git-repo-config hooks.announcelist)
 
 # --- Safety check
 if [ -z "$GIT_DIR" ]; then
@@ -45,17 +44,18 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
+while [ $# -gt 0 ]; do
+
+# --- Command line
+refname="$1"; shift
+oldrev="$1" ; shift
+newrev="$1" ; shift
+
 if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 	echo "Usage: $0 <ref> <oldrev> <newrev>" >&2
 	exit 1
 fi
 
-# --- Config
-projectdesc=$(cat $GIT_DIR/description)
-recipients=$(git-repo-config hooks.mailinglist)
-announcerecipients=$(git-repo-config hooks.announcelist)
-allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
-
 # --- Check types
 newrev_type=$(git-cat-file -t $newrev)
 
@@ -64,11 +64,6 @@ case "$refname","$newrev_type" in
 		# un-annotated tag
 		refname_type="tag"
 		short_refname=${refname##refs/tags/}
-		if [ "$allowunannotated" != "true" ]; then
-			echo "*** The un-annotated tag, $short_refname is not allowed in this repository" >&2
-			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
-			exit 1
-		fi
 		;;
 	refs/tags/*,tag)
 		# annotated tag
@@ -90,12 +85,12 @@ case "$refname","$newrev_type" in
 		short_refname=${refname##refs/remotes/}
 		# Should this even be allowed?
 		echo "*** Push-update of tracking branch, $refname.  No email generated." >&2
-		exit 0
+		continue
 		;;
 	*)
 		# Anything else (is there anything else?)
 		echo "*** Update hook: unknown type of update, \"$newrev_type\", to ref $refname" >&2
-		exit 1
+		continue
 		;;
 esac
 
@@ -103,9 +98,9 @@ esac
 if [ -z "$recipients" ]; then
 	# If the email isn't sent, then at least give the user some idea of what command
 	# would generate the email at a later date
-	echo "*** No recipients found - no email will be sent, but the push will continue" >&2
+	echo "*** No recipients found - no email was be sent." >&2
 	echo "*** for $0 $1 $2 $3" >&2
-	exit 0
+	continue
 fi
 
 # --- Email parameters
@@ -282,4 +277,4 @@ EOF
 ) | /usr/sbin/sendmail -t
 
 # --- Finished
-exit 0
+done
diff --git a/templates/hooks--update b/templates/hooks--update
index 5b82b68..cf883b2 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -1,36 +1,15 @@
 #!/bin/sh
 #
-# An example hook script to mail out commit update information.
-# It can also blocks tags that aren't annotated.
+# An example hook script to blocks tags that aren't annotated.
 # Called by git-receive-pack with arguments: refname sha1-old sha1-new
 #
 # To enable this hook, make this file executable by "chmod +x update".
 #
 # Config
 # ------
-# hooks.mailinglist
-#   This is the list that all pushes will go to; leave it blank to not send
-#   emails frequently.  The log email will list every log entry in full between
-#   the old ref value and the new ref value.
-# hooks.announcelist
-#   This is the list that all pushes of annotated tags will go to.  Leave it
-#   blank to just use the mailinglist field.  The announce emails list the
-#   short log summary of the changes since the last annotated tag
 # hooks.allowunannotated
 #   This boolean sets whether unannotated tags will be allowed into the
 #   repository.  By default they won't be.
-#
-# Notes
-# -----
-# All emails have their subjects prefixed with "[SCM]" to aid filtering.
-# All emails include the headers "X-Git-Refname", "X-Git-Oldrev",
-# "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and info.
-
-# --- Constants
-EMAILPREFIX="[SCM] "
-LOGBEGIN="- Log -----------------------------------------------------------------"
-LOGEND="-----------------------------------------------------------------------"
-DATEFORMAT="%F %R %z"
 
 # --- Command line
 refname="$1"
@@ -51,9 +30,6 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 fi
 
 # --- Config
-projectdesc=$(cat $GIT_DIR/description)
-recipients=$(git-repo-config hooks.mailinglist)
-announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # --- Check types
@@ -62,34 +38,25 @@ newrev_type=$(git-cat-file -t $newrev)
 case "$refname","$newrev_type" in
 	refs/tags/*,commit)
 		# un-annotated tag
-		refname_type="tag"
 		short_refname=${refname##refs/tags/}
 		if [ "$allowunannotated" != "true" ]; then
 			echo "*** The un-annotated tag, $short_refname is not allowed in this repository" >&2
 			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
 			exit 1
 		fi
+		exit 0
 		;;
 	refs/tags/*,tag)
 		# annotated tag
-		refname_type="annotated tag"
-		short_refname=${refname##refs/tags/}
-		# change recipients
-		if [ -n "$announcerecipients" ]; then
-			recipients="$announcerecipients"
-		fi
+		exit 0
 		;;
 	refs/heads/*,commit)
 		# branch
-		refname_type="branch"
-		short_refname=${refname##refs/heads/}
+		exit 0
 		;;
 	refs/remotes/*,commit)
 		# tracking branch
-		refname_type="tracking branch"
-		short_refname=${refname##refs/remotes/}
 		# Should this even be allowed?
-		echo "*** Push-update of tracking branch, $refname.  No email generated." >&2
 		exit 0
 		;;
 	*)
@@ -98,188 +65,3 @@ case "$refname","$newrev_type" in
 		exit 1
 		;;
 esac
-
-# Check if we've got anyone to send to
-if [ -z "$recipients" ]; then
-	# If the email isn't sent, then at least give the user some idea of what command
-	# would generate the email at a later date
-	echo "*** No recipients found - no email will be sent, but the push will continue" >&2
-	echo "*** for $0 $1 $2 $3" >&2
-	exit 0
-fi
-
-# --- Email parameters
-committer=$(git show --pretty=full -s $newrev | grep "^Commit: " | sed -e "s/^Commit: //")
-describe=$(git describe $newrev 2>/dev/null)
-if [ -z "$describe" ]; then
-	describe=$newrev
-fi
-
-# --- Email (all stdout will be the email)
-(
-# Generate header
-cat <<-EOF
-From: $committer
-To: $recipients
-Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname now at $describe
-X-Git-Refname: $refname
-X-Git-Reftype: $refname_type
-X-Git-Oldrev: $oldrev
-X-Git-Newrev: $newrev
-
-Hello,
-
-This is an automated email from the git hooks/update script, it was
-generated because a ref change was pushed to the repository.
-
-Updating $refname_type, $short_refname,
-EOF
-
-case "$refname_type" in
-	"tracking branch"|branch)
-		if expr "$oldrev" : '0*$' >/dev/null
-		then
-			# If the old reference is "0000..0000" then this is a new branch
-			# and so oldrev is not valid
-			echo "  as a new  $refname_type"
-		    echo "        to  $newrev ($newrev_type)"
-			echo ""
-			echo $LOGBEGIN
-			# This shows all log entries that are not already covered by
-			# another ref - i.e. commits that are now accessible from this
-			# ref that were previously not accessible
-			git log $newrev --not --all
-			echo $LOGEND
-		else
-			# oldrev is valid
-			oldrev_type=$(git-cat-file -t "$oldrev")
-
-			# Now the problem is for cases like this:
-			#   * --- * --- * --- * (oldrev)
-			#          \
-			#           * --- * --- * (newrev)
-			# i.e. there is no guarantee that newrev is a strict subset
-			# of oldrev - (would have required a force, but that's allowed).
-			# So, we can't simply say rev-list $oldrev..$newrev.  Instead
-			# we find the common base of the two revs and list from there
-			baserev=$(git-merge-base $oldrev $newrev)
-
-			# Commit with a parent
-			for rev in $(git-rev-list $newrev --not $baserev --all)
-			do
-				revtype=$(git-cat-file -t "$rev")
-				echo "       via  $rev ($revtype)"
-			done
-			if [ "$baserev" = "$oldrev" ]; then
-				echo "      from  $oldrev ($oldrev_type)"
-			else
-				echo "  based on  $baserev"
-				echo "      from  $oldrev ($oldrev_type)"
-				echo ""
-				echo "This ref update crossed a branch point; i.e. the old rev is not a strict subset"
-				echo "of the new rev.  This occurs, when you --force push a change in a situation"
-				echo "like this:"
-				echo ""
-				echo " * -- * -- B -- O -- O -- O ($oldrev)"
-				echo "            \\"
-				echo "             N -- N -- N ($newrev)"
-				echo ""
-				echo "Therefore, we assume that you've already had alert emails for all of the O"
-				echo "revisions, and now give you all the revisions in the N branch from the common"
-				echo "base, B ($baserev), up to the new revision."
-			fi
-			echo ""
-			echo $LOGBEGIN
-			git log $newrev --not $baserev --all
-			echo $LOGEND
-			echo ""
-			echo "Diffstat:"
-			git-diff-tree --no-color --stat -M -C --find-copies-harder $baserev..$newrev
-		fi
-		;;
-	"annotated tag")
-		# Should we allow changes to annotated tags?
-		if expr "$oldrev" : '0*$' >/dev/null
-		then
-			# If the old reference is "0000..0000" then this is a new atag
-			# and so oldrev is not valid
-			echo "        to  $newrev ($newrev_type)"
-		else
-			echo "        to  $newrev ($newrev_type)"
-			echo "      from  $oldrev"
-		fi
-
-		# If this tag succeeds another, then show which tag it replaces
-		prevtag=$(git describe $newrev^ 2>/dev/null | sed 's/-g.*//')
-		if [ -n "$prevtag" ]; then
-			echo "  replaces  $prevtag"
-		fi
-
-		# Read the tag details
-		eval $(git cat-file tag $newrev | \
-			sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
-		tagged=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$DATEFORMAT")
-
-		echo " tagged by  $tagger"
-		echo "        on  $tagged"
-
-		echo ""
-		echo $LOGBEGIN
-		echo ""
-
-		if [ -n "$prevtag" ]; then
-			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
-		else
-			git rev-list --pretty=short $newrev | git shortlog
-		fi
-
-		echo $LOGEND
-		echo ""
-		;;
-	*)
-		# By default, unannotated tags aren't allowed in; if
-		# they are though, it's debatable whether we would even want an
-		# email to be generated; however, I don't want to add another config
-		# option just for that.
-		#
-		# Unannotated tags are more about marking a point than releasing
-		# a version; therefore we don't do the shortlog summary that we
-		# do for annotated tags above - we simply show that the point has
-		# been marked, and print the log message for the marked point for
-		# reference purposes
-		#
-		# Note this section also catches any other reference type (although
-		# there aren't any) and deals with them in the same way.
-		if expr "$oldrev" : '0*$' >/dev/null
-		then
-			# If the old reference is "0000..0000" then this is a new tag
-			# and so oldrev is not valid
-			echo "  as a new  $refname_type"
-			echo "        to  $newrev ($newrev_type)"
-		else
-			echo "        to  $newrev ($newrev_type)"
-			echo "      from  $oldrev"
-		fi
-		echo ""
-		echo $LOGBEGIN
-		git-show --no-color --root -s $newrev
-		echo $LOGEND
-		echo ""
-		;;
-esac
-
-# Footer
-cat <<-EOF
-
-hooks/update
----
-Git Source Code Management System
-$0 $1 \\
-  $2 \\
-  $3
-EOF
-#) | cat >&2
-) | /usr/sbin/sendmail -t
-
-# --- Finished
-exit 0
-- 
1.5.0.3.927.g2432c
