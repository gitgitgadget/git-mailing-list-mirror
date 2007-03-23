From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Fri, 23 Mar 2007 10:21:59 +0000
Message-ID: <200703231022.00189.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 11:22:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgud-0001aY-1P
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 11:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422772AbXCWKWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 06:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbXCWKWK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 06:22:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:62462 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422772AbXCWKWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 06:22:08 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1530795muf
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 03:22:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=utlIoae/F9Sd3eXXM5J/mVKcBKQFqwaLGRvFSOFXlF+WdRYWUWrGIanFkoAi+59Y+X4iZMRrt6+lOZPeTiduXhhckgdzZg4ZlUyA/5IMDOwuev/W0ghY3Hv+Bqrqrpi8K5AfAtlbdZ+LHm3ByD7MN5aXB58SfgMDOoY0N/Hwzy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=pRUD+0nnyb0ntXGQOIUBxKOEB24tQg07ZXHbAIhn0C++mDHOmISJp6/pQQch0svkYHLVGdwoF3lwEABNlgT8Ic8YlkEd4kEzJp0TX096AmfYfoG/b0cXQvDVF0d1YwqePdKQsEX3WZfY/66CL0idi/krH/aVRCWbDzy9GZpIRVc=
Received: by 10.82.148.7 with SMTP id v7mr6245749bud.1174645325825;
        Fri, 23 Mar 2007 03:22:05 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id i1sm11060965nfe.2007.03.23.03.22.04;
        Fri, 23 Mar 2007 03:22:04 -0700 (PDT)
X-TUID: 40e5a3d387aff6bb
X-UID: 296
X-Length: 10027
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42924>

Now that we have a post-receive hook; the update hook's only job is to
decide is a particular update is allowed or not.

This example hook removes all of the functionality that should now
rightly be done by the post-receive hook.  In particular: the generation
of notification emails.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
Replacement of functionality removed by this patch with a post-receive hook
to follow.

 templates/hooks--update |  225 +----------------------------------------------
 1 files changed, 3 insertions(+), 222 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index 8f6c4fe..638d2d1 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -1,36 +1,16 @@
 #!/bin/sh
 #
-# An example hook script to mail out commit update information.
-# It can also blocks tags that aren't annotated.
+# An example hook script to blocks unannotated tags from entering.
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
 #
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
@@ -51,9 +31,6 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 fi
 
 # --- Config
-projectdesc=$(cat $GIT_DIR/description)
-recipients=$(git-repo-config hooks.mailinglist)
-announcerecipients=$(git-repo-config hooks.announcelist)
 allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
 
 # --- Check types
@@ -62,224 +39,28 @@ newrev_type=$(git-cat-file -t $newrev)
 case "$refname","$newrev_type" in
 	refs/tags/*,commit)
 		# un-annotated tag
-		refname_type="tag"
 		short_refname=${refname##refs/tags/}
 		if [ "$allowunannotated" != "true" ]; then
-			echo "*** The un-annotated tag, $short_refname is not allowed in this repository" >&2
+			echo "*** The un-annotated tag, $short_refname, is not allowed in this repository" >&2
 			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
 			exit 1
 		fi
 		;;
 	refs/tags/*,tag)
 		# annotated tag
-		refname_type="annotated tag"
-		short_refname=${refname##refs/tags/}
-		# change recipients
-		if [ -n "$announcerecipients" ]; then
-			recipients="$announcerecipients"
-		fi
 		;;
 	refs/heads/*,commit)
 		# branch
-		refname_type="branch"
-		short_refname=${refname##refs/heads/}
 		;;
 	refs/remotes/*,commit)
 		# tracking branch
-		refname_type="tracking branch"
-		short_refname=${refname##refs/remotes/}
-		# Should this even be allowed?
-		echo "*** Push-update of tracking branch, $refname.  No email generated." >&2
-		exit 0
 		;;
 	*)
 		# Anything else (is there anything else?)
-		echo "*** Update hook: unknown type of update, \"$newrev_type\", to ref $refname" >&2
+		echo "*** Update hook: unknown type of update to ref $refname of type $newrev_type" >&2
 		exit 1
 		;;
 esac
 
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
-		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
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
 # --- Finished
 exit 0
-- 
1.5.1.rc1.28.gedbf0
