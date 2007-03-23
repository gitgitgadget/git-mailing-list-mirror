From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Fri, 23 Mar 2007 10:23:58 +0000
Message-ID: <200703231023.58911.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 11:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUgwN-0002SB-6T
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 11:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbXCWKYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbXCWKYH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 06:24:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43265 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422774AbXCWKYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 06:24:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1926706nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 03:24:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=r+FHzyDHSfBFOzDfJQ9hDvIeGca/NS0Kry9kx/NB8bBYsF4jbIL7ETCYa4fBsLltJqoO23B9k8rr2pj+hkZBOnh0ecbv+FcXDbzjtgYpdsdh5cx9lZlncjuXR+Bi03YMSHDOr7jNCrFaCLEwaxbKkeVRMiiK5K5p7BbCyjaE2m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=bL7usJhwfa+c4a0udfEWeliRInfXwMs+tHZ4vlVd8MqVT6XpDmXIjKmLNrhbj8AfMjH551gw4KmOMuiZLxj4avQnPaMTNh4bVTPC58N6WcmkfSq+QF2pP+m5v1m69gokkvilLpFFMbNfKJH9Nphz4H8nHgkuIxzd8rFb9YY4LXY=
Received: by 10.78.181.13 with SMTP id d13mr1447872huf.1174645441553;
        Fri, 23 Mar 2007 03:24:01 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id n22sm6752350nfc.2007.03.23.03.24.00;
        Fri, 23 Mar 2007 03:24:00 -0700 (PDT)
X-TUID: 71a140cd5924f76e
X-UID: 297
X-Length: 21820
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42925>

The update hook is no longer the correct place to generate emails; there
is now the hooks/post-receive script which is run automatically after a
ref has been updated.

This patch is to make use of that new location, and to address some
faults in the old update hook.

The primary problem in the conversion was that in the update hook, the
ref has not actually been changed, but is about to be.  In the
post-receive hook the ref has already been updated.  That meant that
where we previously had lines like:

 git rev-list --not --all

would now fail because "--all" in the post-receive hook includes the ref
that we are making the email for.  This made it more difficult to show
only the new revisions added by this update.

The solution is not pretty; however it does work and doesn't need any
changes to git-rev-list itself.  It also fixes (more accurately: reduces
the likelihood of) a nasty race when another update occurs while this
script is running.  The solution, in short, looks like this (see the
source code for a longer explanation)

 git rev-parse --not --all | grep -v $(<$refname) |
 git rev-list --pretty --stdin $newrev --not $baserev

This uses git-rev-parse followed by grep to filter out the revision of
the ref in question before it gets to rev-list and inhibits the output
of itself.  By using $(<$refname) rather than $newrev as the filter, it
also takes care of the situation where another update to the same ref
has been made since $refname was $newrev.

The second problem that is addressed is that of tags inhibiting the
correct output of an update email.  Consider this, with somebranch and
sometag pointing at the same revision:

 git push origin somebranch
 git push origin sometag

That would work fine; the push of the branch would generate an email
containing all the new commits introduced by the update, then the push
of the tag would generate the shortlog formatted tag email.  Now
consider:

 git push origin sometag
 git push origin somebranch

When some branch comes to run its "--not --all" line, it will find
sometag, and filter those commits from the email - leaving nothing.
That meant that those commits would not show (in full) on any email.
The fix is to not use "--all", and instead use "--branches" in the
git-rev-parse command.

Other changes
 * Lose the monstrous one-giant-script layout and put things in easy to
   digest functions.  This makes it much easier to find the place you
   need to change if you wanted to customise the output.  I've also
   tried to write more verbose comments for the same reason.  The hook
   script is big, mainly because of all the different cases that it has
   to handle, so being easy to navigate is important.
 * All uses of "git-command" changed to "git command", to cope better
   if a user decided not to install all the hard links to git;
 * Cleaned up some of the English in the email
 * The fact that the receive hook makes the ref available also allows me
   to use Shawn Pearce's fantastic suggestion that an annotated tag can
   be parsed with git-for-each-ref.  This removes the potentially
   non-portable use of "<<<" heredocs and the nasty messing around with
   "date" to convert numbers of seconds UTC to a real date
 * Deletions are now caught and notified (briefly)
 * To help with debugging, I've retained the command line mode from the
   update hook; but made it so that the output is not emailed, it's just
   printed to the screen.  This could then be redirected if the user
   wanted
 * Removed the "Hello" from the beginning of the email - it's just
   noise, and no one seriously has their day made happier by "friendly"
   programs
 * The fact that it doesn't rely on repository state as an indicator any
   more means that it's far more stable in its output; hopefully the
   same arguments will always generate the same email - even if the
   repository changes in the future.  This means you can easily recreate
   an email should you want to.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

I'm sorry this is so big and nasty Junio; but that's mostly because the main
body of it is a cut and paste from the old update hook.

It includes a whole set of little fixes as well as a reorganisation though,
so I don't think the content tracking would have detected it as a rename.

 templates/hooks--post-receive |  554 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 554 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--post-receive

diff --git a/templates/hooks--post-receive b/templates/hooks--post-receive
new file mode 100644
index 0000000..1e988ee
--- /dev/null
+++ b/templates/hooks--post-receive
@@ -0,0 +1,554 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Andy Parkins
+#
+# An example hook script to mail out commit update information.
+#
+# To enable this hook, make this file executable by "chmod +x update".
+#
+# Config
+# ------
+# hooks.mailinglist
+#   This is the list that all pushes will go to; leave it blank to not send
+#   emails for every ref update.
+# hooks.announcelist
+#   This is the list that all pushes of annotated tags will go to.  Leave it
+#   blank to default to the mailinglist field.  The announce emails lists the
+#   short log summary of the changes since the last annotated tag.
+#
+# Notes
+# -----
+# All emails have their subjects prefixed with "[SCM]" to aid filtering.
+# All emails include the headers "X-Git-Refname", "X-Git-Oldrev",
+# "X-Git-Newrev", and "X-Git-Reftype" to enable fine tuned filtering and
+# give information for debugging.
+#
+
+# ---------------------------- Functions
+
+#
+# Top level email generation function.  This decides what type of update
+# this is and calls the appropriate body-generation routine after outputting
+# the common header
+#
+# Note this function doesn't actually generate any email output, that is taken
+# care of by the functions it calls:
+#  - generate_email_header
+#  - generate_create_XXXX_email
+#  - generate_update_XXXX_email
+#  - generate_delete_XXXX_email
+#  - generate_email_footer
+#
+generate_email()
+{
+	# --- Arguments
+	oldrev=$(git rev-parse $1)
+	newrev=$(git rev-parse $2)
+	refname="$3"
+
+	# --- Interpret
+	# 0000->1234 (create)
+	# 1234->2345 (update)
+	# 2345->0000 (delete)
+	if expr "$oldrev" : '0*$' >/dev/null
+	then
+		change_type="create"
+	else
+		if expr "$newrev" : '0*$' >/dev/null
+		then
+			change_type="delete"
+		else
+			change_type="update"
+		fi
+	fi
+
+	# --- Get the revision types
+	newrev_type=$(git cat-file -t $newrev 2> /dev/null)
+	oldrev_type=$(git cat-file -t "$oldrev" 2> /dev/null)
+	case "$change_type" in
+	create|update)
+		rev="$newrev"
+		rev_type="$newrev_type"
+		;;
+	delete)
+		rev="$oldrev"
+		rev_type="$oldrev_type"
+		;;
+	esac
+
+	# The revision type tells us what type the commit is, combined with
+	# the location of the ref we can decide between
+	#  - working branch
+	#  - tracking branch
+	#  - unannoted tag
+	#  - annotated tag
+	case "$refname","$rev_type" in
+		refs/tags/*,commit)
+			# un-annotated tag
+			refname_type="tag"
+			short_refname=${refname##refs/tags/}
+			;;
+		refs/tags/*,tag)
+			# annotated tag
+			refname_type="annotated tag"
+			short_refname=${refname##refs/tags/}
+			# change recipients
+			if [ -n "$announcerecipients" ]; then
+				recipients="$announcerecipients"
+			fi
+			;;
+		refs/heads/*,commit)
+			# branch
+			refname_type="branch"
+			short_refname=${refname##refs/heads/}
+			;;
+		refs/remotes/*,commit)
+			# tracking branch
+			refname_type="tracking branch"
+			short_refname=${refname##refs/remotes/}
+			echo "*** Push-update of tracking branch, $refname"
+			echo "***  - no email generated." >&2
+			exit 0
+			;;
+		*)
+			# Anything else (is there anything else?)
+			echo "*** Unknown type of update to $refname ($rev_type)" >&2
+			echo "***  - no email generated"
+			exit 1
+			;;
+	esac
+
+	# Check if we've got anyone to send to
+	if [ -z "$recipients" ]; then
+		echo "*** hooks.recipients is not set so no email will be sent" >&2
+		echo "*** for $refname update $oldrev->$newrev" >&2
+		exit 0
+	fi
+
+	# Email parameters
+	# The committer will be obtained from the latest existing rev; so
+	# for a deletion it will be the oldrev, for the others, then newrev
+	committer=$(git show --pretty=full -s $rev | grep "^Commit: " | sed -e "s/^Commit: //")
+	# The email subject will contain the best description of the ref
+	# that we can build from the parameters
+	describe=$(git describe $rev 2>/dev/null)
+	if [ -z "$describe" ]; then
+		describe=$rev
+	fi
+
+	generate_email_header
+
+	# Call the correct body generation function - object oriented programming
+	# in a script - overkill perhaps?
+	fn_name=general
+	case "$refname_type" in
+		# --- Branches
+		"tracking branch"|branch)
+			fn_name=branch
+			;;
+		# --- Annotated tags
+		"annotated tag")
+			fn_name=atag
+			;;
+	esac
+	generate_${change_type}_${fn_name}_email
+
+	generate_email_footer
+}
+
+generate_email_header()
+{
+	# --- Email (all stdout will be the email)
+	# Generate header
+	cat <<-EOF
+	From: $committer
+	To: $recipients
+	Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
+	X-Git-Refname: $refname
+	X-Git-Reftype: $refname_type
+	X-Git-Oldrev: $oldrev
+	X-Git-Newrev: $newrev
+
+	This is an automated email from the git hooks/post-receive script. It was
+	generated because a ref change was pushed to the repository containing
+	the project "$projectdesc".
+
+	The $refname_type, $short_refname has been ${change_type}d
+	EOF
+}
+
+generate_email_footer()
+{
+	cat <<-EOF
+
+	hooks/post-receive
+	--
+	Git Source Code Management System
+	EOF
+}
+
+# --------------- Branches
+
+#
+# Called for the creation of a branch
+#
+generate_create_branch_email()
+{
+	# This is a new branch and so oldrev is not valid
+	echo "        at  $newrev ($newrev_type)"
+	echo ""
+
+	echo $LOGBEGIN
+	# This shows all log entries that are not already covered by
+	# another ref - i.e. commits that are now accessible from this
+	# ref that were previously not accessible (see generate_update_branch_email
+	# for the explanation of this command)
+	git rev-parse --not --branches | grep -v $(<${GIT_DIR}/$refname) |
+	git rev-list --pretty --stdin $newrev --not $baserev
+	echo $LOGEND
+}
+
+#
+# Called for the change of a pre-existing branch
+#
+generate_update_branch_email()
+{
+	# Consider this:
+	#   1 --- 2 --- O --- X --- 3 --- 4 --- N
+	#
+	# O is $oldrev for $refname
+	# N is $newrev for $refname
+	# X is a revision pointed to by some other ref, for which we may
+	#   assume that an email has already been generated.
+	# In this case we want to issue an email containing only revisions
+	# 3, 4, and N.  Given (almost) by
+	#
+	#  git-rev-list N ^O --not --all
+	#
+	# The reason for the "almost", is that the "--not --all" will take
+	# precedence over the "N", and effectively will translate to
+	#
+	#  git-rev-list N ^O ^X ^N
+	#
+	# So, we need to build up the list more carefully.  git-rev-parse will
+	# generate a list of revs that may be fed into git-rev-list.  We can get
+	# it to make the "--not --all" part and then filter out the "^N" with:
+	#
+	#  git-rev-parse --not --all | grep -v N
+	#
+	# Then, using the --stdin switch to git-rev-list we have effectively
+	# manufactured
+	#
+	#  git-rev-list N ^O ^X
+	#
+	# This leaves a problem when someone else updates the repository
+	# while this script is running.  Their new value of the ref we're working
+	# on would be included in the "--not --all" output; and as our $newrev
+	# would be an ancestor of that commit, it would exclude all of our
+	# commits.  What we really want is to exclude the current value of
+	# $refname from the --not list, rather than N itself.  So:
+	#
+	#  git-rev-parse --not --all | grep -v $(< $refname)
+	#
+	# Get's us to something pretty safe (apart from the small time between
+	# refname being read, and git-rev-parse running - for that, I give up)
+	#
+	#
+	# Next problem, consider this:
+	#   * --- B --- * --- O ($oldrev)
+	#          \
+	#           * --- X --- * --- N ($newrev)
+	#
+	# That is to say, there is no guarantee that newrev is a strict subset of
+	# oldrev (it would have required a --force, but that's allowed).  So, we
+	# can't simply say rev-list $oldrev..$newrev.  Instead we find the common
+	# base of the two revs and list from there.
+	#
+	# As above, we need to take into account the presence of X; if another
+	# branch is already in the repository and points at some of the revisions
+	# that we are about to output - we don't want them.  The solution is as
+	# before: git-rev-parse output filtered.
+	#
+	# Finally, tags:
+	#   1 --- 2 --- O --- T --- 3 --- 4 --- N
+	#
+	# Tags pushed into the repository generate nice shortlog emails that
+	# summarise the commits between them and the previous tag.  However,
+	# those emails don't include the full commit messages that we output
+	# for a branch update.  Therefore we still want to output revisions
+	# that have been output on a tag email.
+	#
+	# Luckily, git-rev-parse includes just the tool.  Instead of using "--all"
+	# we use "--branches"; this has the added benefit that "remotes/" will
+	# be ignored as well.
+
+	baserev=$(git merge-base $oldrev $newrev)
+
+	# List all the revisions from baserev to newrev in a kind of
+	# "table-of-contents"; note this list can include revisions that have
+	# already had notification emails and is present to show the full detail
+	# of the change from rolling back the old revision to the base revision and
+	# then forward to the new revision
+	for rev in $(git rev-list $newrev --not $baserev)
+	do
+		revtype=$(git cat-file -t "$rev")
+		echo "       via  $rev ($revtype)"
+	done
+
+	# If the baserev is equal to the oldrev, then we know that this was a
+	# fast forward update; otherwise "--force" was used, and we give a more
+	# detailed explanation of what happened.
+	if [ "$baserev" = "$oldrev" ]; then
+		echo "      from  $oldrev ($oldrev_type)"
+	else
+		echo "      from  $baserev"
+		echo "  discards  $oldrev ($oldrev_type) and its branch"
+		echo ""
+		echo "This update added new revisions after undoing old revisions.  That is to"
+		echo "say, the old revision is not a strict subset of the new revision.  This"
+		echo "situation occurs when you --force push a change and generate a"
+		echo "repository containing something like this:"
+		echo ""
+		echo " * -- * -- B -- O -- O -- O ($oldrev)"
+		echo "            \\"
+		echo "             N -- N -- N ($newrev)"
+		echo ""
+		echo "When this happens we assume that you've already had alert emails for all"
+		echo "of the O revisions, and so we here report only the revisions in the N"
+		echo "branch from the common base, B ($baserev),"
+		echo "up to the new branch endpoint."
+	fi
+
+	echo ""
+	echo "Those revisions listed above that are new to this repository have"
+	echo "not appeared on any other notification email; so we list those"
+	echo "revisions in full, below."
+
+	echo ""
+	echo $LOGBEGIN
+	git rev-parse --not --branches | grep -v $(<${GIT_DIR}/$refname) |
+	git rev-list --pretty --stdin $newrev --not $baserev
+
+	# XXX: Need a way of detecting whether git rev-list actually outputted
+	# anything, so that we can issue a "no new revisions added by this
+	# update" message
+
+	echo $LOGEND
+
+	# The diffstat is shown from the old revision to the new revision.  This
+	# is to show the truth of what happened in this change.  There's no point
+	# showing the stat from the base to the new revision because the base
+	# is effectively a random revision at this point - the user will be
+	# interested in what this revision changed - including the undoing of
+	# previous revisions in the case of non-fast forward updates.
+	echo ""
+	echo "Summary of changes:"
+	git diff-tree --no-color --stat -M -C --find-copies-harder $baserev..$newrev
+}
+
+#
+# Called for the deletion of a branch
+#
+generate_delete_branch_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+}
+
+# --------------- Annotated tags
+
+#
+# Called for the creation of an annotated tag
+#
+generate_create_atag_email()
+{
+	echo "        at  $newrev ($newrev_type)"
+
+	generate_atag_email
+}
+
+#
+# Called for the update of an annotated tag (this is probably a rare event
+# and may not even be allowed)
+#
+generate_update_atag_email()
+{
+	echo "        to  $newrev ($newrev_type)"
+	echo "      from  $oldrev (which is now obsolete)"
+
+	generate_atag_email
+}
+
+#
+# Called when an annotated tag is created or changed
+#
+generate_atag_email()
+{
+	# Use git-for-each-ref to pull out the individual fields from the tag
+	eval $(git-for-each-ref --format='
+	tagobject="%(*objectname)"
+	tagtype="%(*objecttype)"
+	tagger="%(taggername)"
+	tagged="%(taggerdate)"' $refname
+	)
+
+	echo "   tagging  $tagobject ($tagtype)"
+	case "$tagtype" in
+	commit)
+		# If the tagged object is a commit, then we assume this is a
+		# release, and so we calculate which tag this tag is replacing
+		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
+
+		if [ -n "$prevtag" ]; then
+			echo "  replaces  $prevtag"
+		fi
+		;;
+	*)
+		echo "    length  $(git cat-file -s $tagobject) bytes"
+		;;
+	esac
+	echo " tagged by  $tagger"
+	echo "        on  $tagged"
+
+	echo ""
+	echo $LOGBEGIN
+
+	# Show the content of the tag message; this might contain a change log
+	# or release notes so is worth displaying.  "tail -n +5" is there to
+	# remove the first 4 lines of the tag object, those details have
+	# already been summarised above
+	git cat-file tag $newrev | tail -q -n +5
+
+	echo ""
+	case "$tagtype" in
+	commit)
+		# Only commit tags make sense to have rev-list operations performed
+		# on them
+		if [ -n "$prevtag" ]; then
+			# Show changes since the previous release
+			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
+		else
+			# No previous tag, show all the changes since time began
+			git rev-list --pretty=short $newrev | git shortlog
+		fi
+		;;
+	*)
+		# XXX: Is there anything useful we can do for non-commit objects?
+		;;
+	esac
+
+	echo $LOGEND
+	echo ""
+}
+
+#
+# Called for the deletion of an annotated tag
+#
+generate_delete_atag_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+}
+
+# --------------- General references
+
+#
+# Called when any other type of reference is created (most likely a
+# non-annotated tag)
+#
+generate_create_general_email()
+{
+	echo "        at  $newrev ($newrev_type)"
+
+	generate_general_email
+}
+
+#
+# Called when any other type of reference is updated (most likely a
+# non-annotated tag)
+#
+generate_update_general_email()
+{
+	echo "        to  $newrev ($newrev_type)"
+	echo "      from  $oldrev"
+
+	generate_general_email
+}
+
+#
+# Called for creation or update of any other type of reference
+#
+generate_general_email()
+{
+	# Unannotated tags are more about marking a point than releasing a version;
+	# therefore we don't do the shortlog summary that we do for annotated tags
+	# above - we simply show that the point has been marked, and print the log
+	# message for the marked point for reference purposes
+	#
+	# Note this section also catches any other reference type (although there
+	# aren't any) and deals with them in the same way.
+
+	echo ""
+	if [ "$newrev_type" = "commit" ]; then
+		echo $LOGBEGIN
+		git show --no-color --root -s $newrev
+		echo $LOGEND
+	else
+		# What can we do here?  The tag marks an object that is not a commit,
+		# so there is no log for us to display.  It's probably not wise to
+		# output git-cat-file as it could be a binary blob.  We'll just say how
+		# big it is
+		echo "$newrev is a $newrev_type, and is $(git cat-file -s $newrev) bytes long."
+	fi
+	echo ""
+}
+
+#
+# Called for the deletion of any other type of reference
+#
+generate_delete_general_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+}
+
+# ---------------------------- main()
+
+# --- Constants
+EMAILPREFIX="[SCM] "
+LOGBEGIN="- Log -----------------------------------------------------------------"
+LOGEND="-----------------------------------------------------------------------"
+
+# --- Config
+# Set GIT_DIR either from the working directory, or from the environment
+# variable.
+GIT_DIR=$(git-rev-parse --git-dir 2>/dev/null)
+if [ -z "$GIT_DIR" ]; then
+	echo "fatal: post-receive: GIT_DIR not set"
+	exit 1
+fi
+
+projectdesc=$(cat $GIT_DIR/description)
+# Check if the description is unchanged from it's default, and shorten it to a
+# more manageable length if it is
+if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
+then
+	projectdesc="UNNAMED PROJECT"
+fi
+
+recipients=$(git repo-config hooks.mailinglist)
+announcerecipients=$(git repo-config hooks.announcelist)
+
+# --- Main loop
+# Allow dual mode: run from the command line just like the update hook, or if
+# no arguments are given then run as a hook script
+if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
+	# Output to the terminal in command line mode - if someone wanted to
+	# resend an email; they could redirect the output to sendmail themselves
+	generate_email $2 $3 $1
+else
+	while read oldrev newrev refname
+	do
+		generate_email $oldrev $newrev $refname | /usr/sbin/sendmail -t
+	done
+fi
-- 
1.5.1.rc1.28.gedbf0
