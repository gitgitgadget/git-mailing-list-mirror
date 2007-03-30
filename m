From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH v2] Reimplement emailing part of hooks--update in contrib/hooks/post-receive-email
Date: Fri, 30 Mar 2007 19:16:26 +0000
Message-ID: <200703302016.27303.andyparkins@gmail.com>
References: <7v7it54rfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXMdF-00041P-VX
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 21:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbXC3TT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 15:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXC3TT0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 15:19:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:38023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbXC3TTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 15:19:23 -0400
Received: by ug-out-1314.google.com with SMTP id 44so911539uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 12:19:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=nkIlT9dvi9BbY263wmgGGeFyN0Vm2wAfN3ihjm4hj0HIj6jyP4W+9JrqDmgCn5rP8ROGvL8uToKW7AQonGT7Izza9OPyCnpcAE5Bjain/2YhzX9ZRFNeWiwULUZ6OSv5xyhfvl0hC6RVME3Ceec2x+Tz09zHLM55EFDF4TfKKoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=FT3hJjDSlgxBROFcXnoyzHGIhjzrfv/7GHnx80nkBEwpCyOT21NvNwO+TcQaOQc6R4iD+hj3UdhU56A5pL+lsnBUTnnGlqzmCH9MTBcmy2AoeTIYzvIOT/nwfv+8iEeZG3Apo+19z71U4kP+rsUghreYBdOzzhK03gazD3M7jSc=
Received: by 10.66.252.18 with SMTP id z18mr2179384ugh.1175282361874;
        Fri, 30 Mar 2007 12:19:21 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm3547921ugf.2007.03.30.12.19.19;
        Fri, 30 Mar 2007 12:19:20 -0700 (PDT)
In-Reply-To: <7v7it54rfj.fsf@assigned-by-dhcp.cox.net>
X-TUID: e118dcc1a956f3a9
X-UID: 299
X-Length: 24727
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

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

would now give the wrong list because "--all" in the post-receive hook
includes the ref that we are making the email for.  This made it more
difficult to show only the new revisions added by this update.

The solution is not pretty; however it does work and doesn't need any
changes to git-rev-list itself.  It also fixes (more accurately: reduces
the likelihood of) a nasty race when another update occurs while this
script is running.  The solution, in short, looks like this (see the
source code for a longer explanation)

 git rev-parse --not --all | grep -v $(git rev-parse $refname) |
 git rev-list --pretty --stdin $oldrev..$newrev

This uses git-rev-parse followed by grep to filter out the revision of
the ref in question before it gets to rev-list and inhibits the output
of itself.  By using $(git rev-parse $revname) rather than $newrev as the
filter, it also takes care of the situation where another update to the
same ref has been made since $refname was $newrev.

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
 * Included Jim Meyering's envelope sender option for the sendmail call
 * The hook is now so big that it was inappropriate to copy it
   to every repository by keeping it in the templates directory.
   Instead, I've put a comment saying to look in contrib/hooks, and
   given an example of calling the script from that template hook.  The
   advantage of calling the script residing at some fixed location is
   that if a future package of git included a bug fixed version of the
   script, that would be picked up automatically, and the user would not
   have to notice and manually copy the new hook to every repository
   that uses it.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receieve-email |  588 +++++++++++++++++++++++++++++++++++++
 templates/hooks--post-receive     |   17 +
 2 files changed, 605 insertions(+), 0 deletions(-)
 create mode 100644 contrib/hooks/post-receieve-email
 create mode 100644 templates/hooks--post-receive

diff --git a/contrib/hooks/post-receieve-email b/contrib/hooks/post-receieve-email
new file mode 100644
index 0000000..6516015
--- /dev/null
+++ b/contrib/hooks/post-receieve-email
@@ -0,0 +1,588 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Andy Parkins
+#
+# An example hook script to mail out commit update information.  This hook sends emails
+# listing new revisions to the repository introduced by the change being reported.  The
+# rule is that (for branch updates) each commit will appear on one email and one email
+# only.
+#
+# This hook is stored in the contrib/hooks directory.  Your distribution will have put
+# this somewhere standard.  You should make this script executable then link to it in
+# the repository you would like to use it in.  For example, on debian the hook is stored
+# in /usr/share/doc/git-core/contrib/hooks/post-receive-email:
+#
+#  chmod a+x post-receive-email
+#  cd /path/to/your/repository.git
+#  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email hooks/post-receive
+#
+# This hook script assumes it is enabled on the central repository of a project, with
+# all users pushing only to it and not between each other.  It will still work if you
+# don't operate in that style, but it would become possible for the email to be from
+# someone other than the person doing the push.
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
+# hook.envelopesender
+#   If set then the -f option is passed to sendmail to allow the envelope sender
+#   address to be set
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
+			echo >&2 "*** Push-update of tracking branch, $refname"
+			echo >&2 "***  - no email generated."
+			exit 0
+			;;
+		*)
+			# Anything else (is there anything else?)
+			echo >&2 "*** Unknown type of update to $refname ($rev_type)"
+			echo >&2 "***  - no email generated"
+			exit 1
+			;;
+	esac
+
+	# Check if we've got anyone to send to
+	if [ -z "$recipients" ]; then
+		echo >&2 "*** hooks.recipients is not set so no email will be sent"
+		echo >&2 "*** for $refname update $oldrev->$newrev"
+		exit 0
+	fi
+
+	# Email parameters
+	# The committer will be obtained from the latest existing rev; so
+	# for a deletion it will be the oldrev, for the others, then newrev
+	committer=$(git show --pretty=full -s $rev | sed -ne "s/^Commit: //p" |
+		sed -ne 's/\(.*\) </"\1" </p')
+	# The email subject will contain the best description of the ref
+	# that we can build from the parameters
+	describe=$(git describe $rev 2>/dev/null)
+	if [ -z "$describe" ]; then
+		describe=$rev
+	fi
+
+	generate_email_header
+
+	# Call the correct body generation function
+	fn_name=general
+	case "$refname_type" in
+	"tracking branch"|branch)
+		fn_name=branch
+		;;
+	"annotated tag")
+		fn_name=atag
+		;;
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
+
+	hooks/post-receive
+	-- 
+	$projectdesc
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
+	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	git rev-list --pretty --stdin $newrev
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
+	#  git-rev-parse --not --all | grep -v $(git-rev-parse $refname)
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
+	# That is to say, there is no guarantee that oldrev is a strict subset of
+	# newrev (it would have required a --force, but that's allowed).  So, we
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
+	# List all of the revisions that were removed by this update, in a fast forward
+	# update, this list will be empty, because rev-list O ^N is empty.  For a non
+	# fast forward, O ^N is the list of removed revisions
+	fastforward=""
+	rev=""
+	for rev in $(git rev-list $newrev..$oldrev)
+	do
+		revtype=$(git cat-file -t "$rev")
+		echo "  discards  $rev ($revtype)"
+	done
+	if [ -z "$rev" ]; then
+		fast_forward=1
+	fi
+
+	# List all the revisions from baserev to newrev in a kind of
+	# "table-of-contents"; note this list can include revisions that have
+	# already had notification emails and is present to show the full detail
+	# of the change from rolling back the old revision to the base revision and
+	# then forward to the new revision
+	for rev in $(git rev-list $oldrev..$newrev)
+	do
+		revtype=$(git cat-file -t "$rev")
+		echo "       via  $rev ($revtype)"
+	done
+
+	if [ -z "$fastforward" ]; then
+		echo "      from  $oldrev ($oldrev_type)"
+	else
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
+		echo "branch from the common base, B."
+	fi
+
+	echo ""
+	echo "Those revisions listed above that are new to this repository have"
+	echo "not appeared on any other notification email; so we list those"
+	echo "revisions in full, below."
+
+	echo ""
+	echo $LOGBEGIN
+	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
+	git rev-list --pretty --stdin $oldrev..$newrev
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
+	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
+}
+
+#
+# Called for the deletion of a branch
+#
+generate_delete_branch_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+	echo $LOGEND
+	git show -s --pretty=oneline $oldrev
+	echo $LOGEND
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
+	eval $(git for-each-ref --shell --format='
+	tagobject=%(*objectname)
+	tagtype=%(*objecttype)
+	tagger=%(taggername)
+	tagged=%(taggerdate)' $refname
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
+	# or release notes so is worth displaying.
+	git cat-file tag $newrev | sed -e '1,/^$/d'
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
+}
+
+#
+# Called for the deletion of an annotated tag
+#
+generate_delete_atag_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+	echo $LOGEND
+	git show -s --pretty=oneline $oldrev
+	echo $LOGEND
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
+}
+
+#
+# Called for the deletion of any other type of reference
+#
+generate_delete_general_email()
+{
+	echo "       was  $oldrev"
+	echo ""
+	echo $LOGEND
+	git show -s --pretty=oneline $oldrev
+	echo $LOGEND
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
+GIT_DIR=$(git rev-parse --git-dir 2>/dev/null)
+if [ -z "$GIT_DIR" ]; then
+	echo >&2 "fatal: post-receive: GIT_DIR not set"
+	exit 1
+fi
+
+projectdesc=$(sed -e '1p' "$GIT_DIR/description")
+# Check if the description is unchanged from it's default, and shorten it to a
+# more manageable length if it is
+if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
+then
+	projectdesc="UNNAMED PROJECT"
+fi
+
+recipients=$(git repo-config hooks.mailinglist)
+announcerecipients=$(git repo-config hooks.announcelist)
+envelopesender=$(git-repo-config hooks.envelopesender)
+
+# --- Main loop
+# Allow dual mode: run from the command line just like the update hook, or if
+# no arguments are given then run as a hook script
+if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
+	# Output to the terminal in command line mode - if someone wanted to
+	# resend an email; they could redirect the output to sendmail themselves
+	PAGER= generate_email $2 $3 $1
+else
+	if [ -n "$envelopesender" ]; then
+		envelopesender="-f '$envelopesender'"
+	fi
+
+	while read oldrev newrev refname
+	do
+		generate_email $oldrev $newrev $refname |
+		/usr/sbin/sendmail -t $envelopesender
+	done
+fi
diff --git a/templates/hooks--post-receive b/templates/hooks--post-receive
new file mode 100644
index 0000000..190de26
--- /dev/null
+++ b/templates/hooks--post-receive
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# An example hook script for the post-receive event
+#
+# This script is run after receive-pack has accepted a pack and the
+# repository has been updated.  It is passed arguments in through stdin
+# in the form
+#  <oldrev> <newrev> <refname>
+# For example:
+#  aa453216d1b3e49e7f6f98441fa56946ddcd6a20 68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
+#
+# see contrib/hooks/ for an sample, or uncomment the next line (on debian)
+#
+
+
+#. /usr/share/doc/git-core/contrib/hooks/post-receive-email
+
-- 
1.5.1.rc1.27.g1d848
