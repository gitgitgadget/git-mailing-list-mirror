From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 10:58:11 -0700
Message-ID: <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 20:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYSr4-0004sJ-L4
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVERSBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVERSBQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:01:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57305 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262249AbVERR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 13:58:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518175813.PUSZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 13:58:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 18 May 2005 08:41:21 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> However, git-diff-helper doesn't understand these things, and the builtin
LT> diff doesn't do the rename thing. Yet it would be very very useful to do.

It is unclear what you meant by "these things" in "doesn't
understand these things", and what you meant by "it" in "it
would be very very useful to do."  Could you explain?

About the built-in diff not doing the rename , I have a bit
longer term (knowing _my_ timescale I'd imagine you would
understand that is not that long ;-) plan to have -p option for
diff-* family to use the same rename detection logic that I
added to diff-helper in the patch you are commenting on.  It
involves slight change to callers (three diff-* family main
programs) to add a call to tell the diff driver "I've given you
all the diffs, now go look for renames") at the end, and the
rest is changes to what diff.c does internally.

LT> So what I'd suggest is one (or both) of two possibilities:
LT>  - make the internal diff logic also able to do the same rename handling 
LT>    as the external diff-helper. This may or may not be complex, I've not 
LT>    looked at it.

Yes that is part of the plan.  I wanted to do things in these
steps:

  - Put rename detect in helper so screwups there would not
    impact the diff-* family's built-in output, with the initial
    dumb rename detection.

  - Improve rename detection still keeping the logic and
    machinery in diff-helper only.  I expect a heuristics
    similar to the one you posted on the deltification thread
    would work nicely here as well.

  - Straighten out the GIT_EXTERNAL_DIFF interface so that it
    can also express renames (the patch I sent currently punts
    there).  They will get eighth argument (rename destination)
    only when they are being fed a rename patch.
    git-apply-patch-script needs to be adjusted for this change.

  - Change diff-helper not to do the rename detection itself,
    but clean it up so it uses the same diff_addremove(),
    diff_change(), and diff_unmerge() interface the diff-*
    family use.  Change the implementation of these three
    functions so that they do not directly call
    run_external_diff() but pool changes for later matching when
    rename detection is in effect.  Add diff_finished() which
    would flush the rename candidate pools, and call that at the
    end of program from three diff-* family and diff-helper.
    The rename detection logic in diff-helper will be moved to
    this "inspect the pooled rename candidates, match them up
    and flush" part.

The patch I sent is the first step in the above sequence.

LT>  - change diff-helper subtly: instead of printing "cannot parse %s", any
LT>    nonrecognized line would be a "ignore this line, but process all
LT>    pending potential renames".

Once the built-in diff driver is straightened out the way I
outlined above, this change may turn out to be unnecessary, I
need to look at the whatchanged output and think a bit more
about this later today.

