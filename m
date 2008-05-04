From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: Re: git and peer review
Date: Mon, 05 May 2008 08:21:54 +1200
Message-ID: <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 22:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JskyC-0005dX-Mu
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 22:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYEDUhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 16:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYEDUhP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 16:37:15 -0400
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:19746 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355AbYEDUhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 16:37:14 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 May 2008 16:37:14 EDT
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 May 2008 08:21:56 +1200
Received: from nav-akl-pcn-343.mitacad.com.navman.co.nz ([10.112.8.136]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 May 2008 08:21:55 +1200
In-Reply-To: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
	(Ping Yin's message of "Sat, 3 May 2008 09:02:41 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-OriginalArrivalTime: 04 May 2008 20:21:55.0919 (UTC) FILETIME=[7F612DF0:01C8AE24]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15890.000
X-TM-AS-Result: No--16.116000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81198>

On Sat, May 03 2008, Ping Yin wrote:

[...]

> I am in a company environment and i want to enforce a policy that
> every commit must be reviewed before pushed to central repository. I
> think i can use hooks to enforce such kind of policy.

I'm in a similar environment, although it's only me using git (via
git-svn) at the moment.

> One way i want to try is to check in the hook whether every pushed
> commit has a "Reviewed-by " line .  Any suggestion?
>
> And one question, how to add a "Reviewed-by" line automatically?
>
> The reviewers sit near each other, so we do face-to-face peer review
> and don't pass patches by email.
> Say,  i have prepared a patch series,

I'm very interested in good ways of doing this face-to-face review.

At the moment I'm using gitk to step through the patch series along with
the patch to gitk that adds a context-menu entry to lauch an external
diff tool when a side-by-side diff is easier to read.

This is okay, but it's a bit of a pain to make changes while the review
is in progress (git rebase -i, s/pick/edit on the appropriate line, make
changes, git commit --amend, git rebase --continue).  Perhaps stgit or
guilt would help with this.

> Case 1
>     I ask someone to review my patches at my machine. If the review
> passes, i have to add Reviewed-by line to each commit and then merge
> it to the master branch. However, i find no easy way to add
> reviewed-by line. Maybe adding --reviewed-by  option to cherry-pick or
> rebase or merge?
>
> Case 2
>    The reviewer is the maintainer, so i ask him to pull and review. So
> now it is his turn to add review-by line. But still, how?

I do something similar using git filter-branch --msg-filter.  I have a
little shell script call git-add-checked (our convention is to have a
"checked: " line in the commit message):

--8<---------------cut here---------------start------------->8---
#!/bin/sh

usage() {
    cat <<EOF
Usage: git-add-checked <checker> [<filter-branch options>] <rev-list options>
EOF
}

checker="$1"
[ -n "$checker" ] || { usage >&2; exit 2; }
shift

set -x
git filter-branch --msg-filter "sed '\$a\\
\\
checked: $checker'" "$@"
--8<---------------cut here---------------end--------------->8---

Then, after getting my changes reviewed, I just do:

$ git-add-checked joe.bloggs trunk..

This adds a "checked: joe.bloggs" line at the end of the commit message
for all of the commits on the current branch since trunk (which is a
remote branch maintained by git-svn).

Regards,
Toby.
