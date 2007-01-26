From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/2] Heavily expanded update hook to send more useful emails than the old hook
Date: Fri, 26 Jan 2007 09:01:04 +0000
Message-ID: <200701260901.04813.andyparkins@gmail.com>
References: <29b04c45a795406bd9b278eb44321fe572dc8adf.1169801884.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 10:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMxQ-0004y6-II
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030837AbXAZJBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030838AbXAZJBJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:01:09 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:18920 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030837AbXAZJBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:01:07 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 26 Jan 2007 09:04:05 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HAMxG-00011Y-00
	for <git@vger.kernel.org>; Fri, 26 Jan 2007 09:01:06 +0000
In-Reply-To: <29b04c45a795406bd9b278eb44321fe572dc8adf.1169801884.git.andyparkins@gmail.com>
X-TUID: 825f5e5a2a61026f
X-UID: 209
X-Length: 13700
Content-Disposition: inline
X-OriginalArrivalTime: 26 Jan 2007 09:04:05.0640 (UTC) FILETIME=[EE551880:01C74128]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37817>

I know it's only an example, but having this might save someone else the
trouble of writing an enhanced version for themselves.

It basically does the same job as the old update hook, but with these
differences:
 * The recipients list is read from the repository config file from
   hooks.mailinglist
 * Updating unannotated tags can be allowed by setting
   hooks.allowunannotated
 * Announcement emails (via annotated tag creation) can be sent to a
   different mailing list by setting hooks.announcelist
 * Output email is more verbose and generates specific content depending
   on whether the ref is a tag, an annotated tag, a branch, or a
   tracking branch
 * The email is easier to filter; the subject line is prefixed with
   [SCM] and a project description pulled from the "description" file
 * It catches (and displays differently) branch updates that are
   performed with a --force

Obviously, it's nothing that clever - it's the update hook I use on my
repositories but I've tried to keep it general, and tried to make the
output always relevant to the type of update.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I've sent this as a 2/2 patch after the first one; it's not really true that
they're a pair - but this one includes the same fix.  Further, it's less
likely that this one will be accepted as there is no pressing need for it. :-)

 templates/hooks--update |  340 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 268 insertions(+), 72 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 81f706f..4bd9d96 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -1,89 +1,285 @@
 #!/bin/sh
 #
 # An example hook script to mail out commit update information.
-# It also blocks tags that aren't annotated.
+# It can also blocks tags that aren't annotated.
 # Called by git-receive-pack with arguments: refname sha1-old sha1-new
 #
-# To enable this hook:
-# (1) change the recipient e-mail address
-# (2) make this file executable by "chmod +x update".
+# To enable this hook, make this file executable by "chmod +x update".
 #
+# Config
+# ------
+# hooks.mailinglist
+#   This is the list that all pushes will go to; leave it blank to not send
+#   emails frequently.  The log email will list every log entry in full between
+#   the old ref value and the new ref value.
+# hooks.announcelist
+#   This is the list that all pushes of annotated tags will go to.  Leave it
+#   blank to just use the mailinglist field.  The announce emails list the
+#   short log summary of the changes since the last annotated tag
+# hooks.allowunannotated
+#   This boolean sets whether unannotated tags will be allowed into the
+#   repository.  By default they won't be.
+#
+# Notes
+# -----
+# All emails have their subjects prefixed with "[SCM]" to aid filtering.
+# All emails include the headers "X-Git-Refname", "X-Git-Oldrev",
+# "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and info.
 
-project=$(cat $GIT_DIR/description)
-recipients="commit-list@somewhere.com commit-list@somewhereelse.com"
-
-ref_type=$(git cat-file -t "$3")
-
-# Only allow annotated tags in a shared repo
-# Remove this code to treat dumb tags the same as everything else
-case "$1","$ref_type" in
-refs/tags/*,commit)
-	echo "*** Un-annotated tags are not allowed in this repo" >&2
-	echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
-	exit 1;;
-refs/tags/*,tag)
-	echo "### Pushing version '${1##refs/tags/}' to the masses" >&2
-	# recipients="release-announce@somwehere.com announce@somewhereelse.com"
-	;;
-esac
+# --- Constants
+EMAILPREFIX="[SCM] "
+LOGBEGIN="- Log -----------------------------------------------------------------"
+LOGEND="-----------------------------------------------------------------------"
+DATEFORMAT="%F %R %z"
+
+# --- Command line
+refname="$1"
+oldrev="$2"
+newrev="$3"
+
+# --- Safety check
+if [ -z "$GIT_DIR" ]; then
+	echo "Don't run this script from the command line." >&2
+	echo " (if you want, you could supply GIT_DIR then run" >&2
+	echo "  $0 <ref> <oldrev> <newrev>)" >&2
+	exit 1
+fi
+
+if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
+	echo "Usage: $0 <ref> <oldrev> <newrev>" >&2
+	exit 1
+fi
+
+# --- Config
+projectdesc=$(cat $GIT_DIR/description)
+recipients=$(git-repo-config hooks.mailinglist)
+announcerecipients=$(git-repo-config hooks.announcelist)
+allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
-# set this  to 'cat' to get a very detailed listing.
-# short only kicks in when an annotated tag is added
-short='git shortlog'
-
-# see 'date --help' for info on how to write this
-# The default is a human-readable iso8601-like format with minute
-# precision ('2006-01-25 15:58 +0100' for example)
-date_format="%F %R %z"
-
-(if expr "$2" : '0*$' >/dev/null
-then
-	# new ref
-	case "$1" in
-	refs/tags/*)
-		# a pushed and annotated tag (usually) means a new version
-		tag="${1##refs/tags/}"
-		if [ "$ref_type" = tag ]; then
-			eval $(git cat-file tag $3 | \
-				sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
-			date=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$date_format")
-			echo "Tag '$tag' created by $tagger at $date"
-			git cat-file tag $3 | sed -n '5,$p'
-			echo
+# --- Check types
+newrev_type=$(git-cat-file -t "$newrev")
+
+case "$refname","$newrev_type" in
+	refs/tags/*,commit)
+		# un-annoted tag
+		refname_type="tag"
+		short_refname=${refname##refs/tags/}
+		if [ $allowunannotated != "true" ]; then
+			echo "*** The un-annotated tag, $short_refname is not allowed in this repository" >&2
+			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
+			exit 1
 		fi
-		prev=$(git describe "$3^" | sed 's/-g.*//')
-		# the first tag in a repo will yield no $prev
-		if [ -z "$prev" ]; then
-			echo "Changes since the dawn of time:"
-			git rev-list --pretty $3 | $short
-		else
-			echo "Changes since $prev:"
-			git rev-list --pretty $prev..$3 | $short
-			echo ---
-			git diff --stat $prev..$3
-			echo ---
+		;;
+	refs/tags/*,tag)
+		# annotated tag
+		refname_type="annotated tag"
+		short_refname=${refname##refs/tags/}
+		# change recipients
+		if [ -n "$announcerecipients" ]; then
+			recipients="$announcerecipients"
 		fi
 		;;
+	refs/heads/*,commit)
+		# branch
+		refname_type="branch"
+		short_refname=${refname##refs/heads/}
+		;;
+	refs/remotes/*,commit)
+		# tracking branch
+		refname_type="tracking branch"
+		short_refname=${refname##refs/remotes/}
+		# Should this even be allowed?
+		echo "*** Push-update of tracking branch, $refname.  No email generated." >&2
+		exit 0
+		;;
+	*)
+		# Anything else (is there anything else?)
+		echo "*** Update hook: unknown type of update, \"$newrev_type\", to ref $refname" >&2
+		exit 1
+		;;
+esac
+
+# Check if we've got anyone to send to
+if [ -z "$recipients" ]; then
+	# If the email isn't sent, then at least give the user some idea of what command
+	# would generate the email at a later date
+	echo "*** No recipients found - no email will be sent, but the push will continue" >&2
+	echo "*** for $0 $1 $2 $3" >&2
+	exit 0
+fi
+
+# --- Email parameters
+committer=$(git show --pretty=full -s $newrev | grep "^Commit: " | sed -e "s/^Commit: //")
+describe=$(git describe $newrev 2>/dev/null)
+if [ -z "$describe" ]; then
+	describe=$newrev
+fi
 
-	refs/heads/*)
-		branch="${1##refs/heads/}"
-		echo "New branch '$branch' available with the following commits:"
-		git-rev-list --pretty "$3" $(git-rev-parse --not --all)
+# --- Email (all stdout will be the email)
+(
+# Generate header
+cat <<-EOF
+From: $committer
+To: $recipients
+Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname now at $describe
+X-Git-Refname: $refname
+X-Git-Reftype: $refname_type
+X-Git-Oldrev: $oldrev
+X-Git-Newrev: $newrev
+
+Hello,
+
+This is an automated email from the git hooks/update script, it was
+generated because a ref change was pushed to the repository.
+
+Updating $refname_type, $short_refname,
+EOF
+
+case "$refname_type" in
+	"tracking branch"|branch)
+		if expr "$oldrev" : '0*$' >/dev/null
+		then
+			# If the old reference is "0000..0000" then this is a new branch
+			# and so oldrev is not valid
+			echo "  as a new  $refname_type"
+		    echo "        to  $newrev ($newrev_type)"
+			echo ""
+			echo $LOGBEGIN
+			# This shows all log entries that are not already covered by
+			# another ref - i.e. commits that are now accessible from this
+			# ref that were previously not accessible
+			git-rev-list --pretty $newref $(git-rev-parse --not --all)
+			echo $LOGEND
+		else
+			# oldrev is valid
+			oldrev_type=$(git-cat-file -t "$oldrev")
+
+			# Now the problem is for cases like this:
+			#   * --- * --- * --- * (oldrev)
+			#          \
+			#           * --- * --- * (newrev)
+			# i.e. there is no guarantee that newrev is a strict subset
+			# of oldrev - (would have required a force, but that's allowed).
+			# So, we can't simply say rev-list $oldrev..$newrev.  Instead
+			# we find the common base of the two revs and list from there
+			baserev=$(git-merge-base $oldrev $newrev)
+
+			# Commit with a parent
+			for rev in $(git-rev-list $newrev ^$baserev)
+			do
+				revtype=$(git-cat-file -t "$rev")
+				echo "       via  $rev ($revtype)"
+			done
+			if [ "$baserev" = "$oldrev" ]; then
+				echo "      from  $oldrev ($oldrev_type)"
+			else
+				echo "  based on  $baserev"
+				echo "      from  $oldrev ($oldrev_type)"
+				echo ""
+				echo "This ref update crossed a branch point; i.e. the old rev is not a strict subset"
+				echo "of the new rev.  This occurs, when you --force push a change in a situation"
+				echo "like this:"
+				echo ""
+				echo " * -- * -- B -- O -- O -- O ($oldrev)"
+				echo "            \\"
+				echo "             N -- N -- N ($newrev)"
+				echo ""
+				echo "Therefore, we assume that you've already had alert emails for all of the O"
+				echo "revisions, and now give you all the revisions in the N branch from the common"
+				echo "base, B ($baserev), up to the new revision."
+			fi
+			echo ""
+			echo $LOGBEGIN
+			git-rev-list --pretty $newrev ^$baserev
+			echo $LOGEND
+			echo ""
+			echo "Diffstat:"
+			git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$baserev
+		fi
 		;;
-	esac
-else
-	base=$(git-merge-base "$2" "$3")
-	case "$base" in
-	"$2")
-		git diff --stat "$3" "^$base"
-		echo
-		echo "New commits:"
+	"annotated tag")
+		# Should we allow changes to annotated tags?
+		if expr "$oldrev" : '0*$' >/dev/null
+		then
+			# If the old reference is "0000..0000" then this is a new atag
+			# and so oldrev is not valid
+			echo "        to  $newrev ($newrev_type)"
+		else
+			echo "        to  $newrev ($newrev_type)"
+			echo "      from  $oldrev"
+		fi
+
+		# If this tag succeeds another, then show which tag it replaces
+		prevtag=$(git describe $newrev^ 2>/dev/null | sed 's/-g.*//')
+		if [ -n "$prevtag" ]; then
+			echo "  replaces  $prevtag"
+		fi
+
+		# Read the tag details
+		eval $(git cat-file tag $newrev | \
+			sed -n '4s/tagger \([^>]*>\)[^0-9]*\([0-9]*\).*/tagger="\1" ts="\2"/p')
+		tagged=$(date --date="1970-01-01 00:00:00 +0000 $ts seconds" +"$DATEFORMAT")
+
+		echo " tagged by  $tagger"
+		echo "        on  $tagged"
+
+		echo ""
+		echo $LOGBEGIN
+		echo ""
+
+		if [ -n "$prevtag" ]; then
+			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
+		else
+			git rev-list --pretty=short $newrev | git shortlog
+		fi
+
+		echo $LOGEND
+		echo ""
 		;;
 	*)
-		echo "Rebased ref, commits from common ancestor:"
+		# By default, unannotated tags aren't allowed in; if
+		# they are though, it's debatable whether we would even want an
+		# email to be generated; however, I don't want to add another config
+		# option just for that.
+		#
+		# Unannotated tags are more about marking a point than releasing
+		# a version; therefore we don't do the shortlog summary that we
+		# do for annotated tags above - we simply show that the point has
+		# been marked, and print the log message for the marked point for
+		# reference purposes
+		#
+		# Note this section also catches any other reference type (although
+		# there aren't any) and deals with them in the same way.
+		if expr "$oldrev" : '0*$' >/dev/null
+		then
+			# If the old reference is "0000..0000" then this is a new tag
+			# and so oldrev is not valid
+			echo "  as a new  $refname_type"
+			echo "        to  $newrev ($newrev_type)"
+		else
+			echo "        to  $newrev ($newrev_type)"
+			echo "      from  $oldrev"
+		fi
+		echo ""
+		echo $LOGBEGIN
+		git-show --no-color --root -s $newrev
+		echo $LOGEND
+		echo ""
 		;;
-	esac
-	git-rev-list --pretty "$3" "^$base"
-fi) |
-mail -s "$project: Changes to '${1##refs/heads/}'" $recipients
+esac
+
+# Footer
+cat <<-EOF
+
+hooks/update
+---
+Git Source Code Management System
+$0 $1 \\
+  $2 \\
+  $3
+EOF
+#) | cat >&2
+) | /usr/sbin/sendmail -t
+
+# --- Finished
 exit 0
-- 
1.5.0.rc2.g017f3
