From: Bill Lear <rael@zopyra.com>
Subject: Suggestions for improvements to post-receive hook
Date: Wed, 10 Oct 2007 09:32:14 -0500
Message-ID: <18188.57966.215393.192741@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 16:33:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfccF-0006sd-O8
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbXJJOcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXJJOcj
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:32:39 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61361 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbXJJOci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 10:32:38 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l9AEWau18294;
	Wed, 10 Oct 2007 08:32:36 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60502>

We have made a few changes to the post-receive hook for operation in
our company.  I wanted to pass them on in case they are suitable for
more general use.  Below I mix description of the change, a
justification of the change, along with a snippet of code and/or code
comments illustrating the change.  I'm sure there are more
sophisticated ways to do what we've done, but it seems to work for us.

1. Support per-branch mailing lists.  This allows me to collaborate
   with several different people on different mini-projects from the
   same "hub" repository without each of them getting mail they don't
   care about.

   Code:

# hooks.{branch}mailinglist
#   This is the list that all pushes to a given branch will go to;
#   leave it blank to not send emails for every ref update to this branch.
[...]
        if [ -z "$recipients" ]; then
                # Essentially an associative array,
                # hooks.${short_refname}mailinglist: allows a separate mailing
                # list for each branch/tag thingie.
                recipients=$(git-repo-config hooks.${short_refname}mailinglist)
        fi

        # One last try ...
        if [ -z "$recipients" ]; then
                recipients=$(git repo-config hooks.mailinglist)
        fi

        # Check if we've got anyone to send to
        if [ -z "$recipients" ]; then
                echo >&2 "*** hooks.recipients is not set so no email will be sent"
                echo >&2 "*** for $refname update $oldrev->$newrev"
                exit 0
        fi


2. Allow specification of a prefix for the subject line.  This allows
   us to better filter our email --- we use a mailing list for some
   projects and the mailing list prefixes the subject with its own
   string, for example.

   Code:

# hooks.prefix
#   Set the email subject prefix to "[$hooks.prefix]".  Defaults to empty string.
[...]
# Notes
# -----
# All emails have their subjects prefixed with "[$hooks.prefix]"
# to aid filtering, if hooks.prefix is set.  If it is not set, no
# prefix is used.
[...]
prefix=$(git-repo-config hooks.prefix)

if [ -n "$prefix" ]; then
        EMAILPREFIX="[${prefix}] "
else
        EMAILPREFIX=""
fi
[... elsewhere in the code]
generate_email_header()
{
        # --- Email (all stdout will be the email)
        # Generate header
        cat <<-EOF
        From: $committer
        To: $recipients
        Subject: ${EMAILPREFIX}$projectdesc $refname_type "$short_refname" ${change_type}d. $describe
        X-Git-Refname: $refname
        X-Git-Reftype: $refname_type
[...]

3.  Provide change content in email.  The current hook does not produce
    enough information for us --- we like to see the content of the change
    so we can code-review on-the-fly.  I hacked the code, in my ignorance,
    to use git-whatchanged, as it seemed to provide what we wanted.  I
    am not currently controlling this behavior with a config flag, though
    presumably it could be, easily.

    Code (simple diff):
408,411c399,400
<       echo "Diffstat:"
<       git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$oldrev
<       echo ""
<       git-whatchanged --no-color -p --find-copies-harder $oldrev..$newrev
---
>       echo "Summary of changes:"
>       git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev

4 and 5.

    4: Log the content of the emails, if desired, to a log file.
    Our email archiving system here is between lame and nonexistent,
    so we like to be able to look back at the logs if a problem should
    occur.

    5: Allow sending only a certain number of lines maximum to email
    recipients.  Some diffs are huge, so we don't want to overwhelm
    recipients' inboxes.

    Note: currently, specifying the maximum number of email lines
    only works when you specify logging, though this is not necessary.
    Also: this might only be useful if you have a flag that controls
    the use of git-whatchanged (or whatever) to produce a fuller diff
    set in the email.

    Code:

# hooks.maxemaillines
#   Clip the email sent out to this number of lines.  If unset,
#   defaults to 500 lines.
[...]
# hooks.logfile
#   If set then the entire email content sent will be logged to this file.
#   If unset, no logging is done.
[...]
maxemaillines=$(git-repo-config --int hooks.maxemaillines)
logfile=$(git-repo-config hooks.logfile)
[...]
        # If a log file was specified, tee to the logfile, head, and then
        # sendmail, else just send the mail directly.
        if [ -n "$logfile" ]; then
                while read oldrev newrev refname
                do
                        generate_email $oldrev $newrev $refname |
                            /usr/bin/tee -a ${logfile} 2>/dev/null |
                            /usr/bin/head -${maxemaillines} |
                            /usr/sbin/sendmail -t $envelopesender
                done
        else
                while read oldrev newrev refname
                do
                        generate_email $oldrev $newrev $refname |
                            /usr/sbin/sendmail -t $envelopesender
                done
        fi

6.  Support an author filter.  I don't have this running currently,
    but I believe this feature was in the update script.  Basically
    (and here follows most likely confusion on my part) it allows you
    to filter your changes out of a change set so that when you
    push a change set that includes your changes to a hub, it only
    sends them once (here, I'm most certainly not expressing this
    correctly).

    Anyway, someone on the list suggested this, and it was in
    the update hook, like this:

authorfilter=$(git-repo-config hooks.authorfilter)
case "$refname_type" in
        "tracking branch"|branch)
                if expr "$oldrev" : '0*$' >/dev/null
                then
                        # If the old reference is "0000..0000" then this is a new branch
                        # and so oldrev is not valid
                        echo "  as a new  $refname_type"
                        echo "        to  $newrev ($newrev_type)"
                        echo ""
                        # This shows all log entries that are not already covered by
                        # another ref - i.e. commits that are now accessible from this
                        # ref that were previously not accessible
                        git-whatchanged -p ${authorfilter:+--author="$authorfilter"} --pretty $newref $(git-rev-parse --not --all)
                else
                        # oldrev is valid
                        oldrev_type=$(git-cat-file -t "$oldrev")

                        # Now the problem is for cases like this:
                        #   * --- * --- * --- * (oldrev)
                        #          \
                        #           * --- * --- * (newrev)
                        # i.e. there is no guarantee that newrev is a strict subset
                        # of oldrev - (would have required a force, but that's allowed).
                        # So, we can't simply say rev-list $oldrev..$newrev.  Instead
                        # we find the common base of the two revs and list from there
                        baserev=$(git-merge-base $oldrev $newrev)

                        # Commit with a parent
                        for rev in $(git-rev-list ${authorfilter:+--author="$authorfilter"} $newrev ^$baserev)
                        do
                                revtype=$(git-cat-file -t "$rev")
                                echo "       via  $rev ($revtype)"
                        done
                        if [ "$baserev" = "$oldrev" ]; then
                                echo "      from  $oldrev ($oldrev_type)"
                        else
                                echo "  based on  $baserev"
                                echo "      from  $oldrev ($oldrev_type)"
                                echo ""
                                echo "This ref update crossed a branch point; i.e. the old rev is not a strict subset"
                                echo "of the new rev.  This occurs, when you --force push a change in a situation"
                                echo "like this:"
                                echo ""
                                echo " * -- * -- B -- O -- O -- O ($oldrev)"
                                echo "            \\"
                                echo "             N -- N -- N ($newrev)"
                                echo ""
                                echo "Therefore, we assume that you've already had alert emails for all of the O"
                                echo "revisions, and now give you all the revisions in the N branch from the common"
                                echo "base, B ($baserev), up to the new revision."
                        fi
                        echo ""
                        echo "Diffstat:"
                        git-diff-tree --no-color --stat -M -C --find-copies-harder $newrev ^$baserev
                        echo ""
                        git-whatchanged -p ${authorfilter:+--author="$authorfilter"} --pretty $newrev ^$baserev
                fi
                ;;
        "annotated tag")

Ok, I think that's about it.  Andy, let me know if I can help
clarify anything.


Bill
