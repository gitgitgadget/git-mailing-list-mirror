From: Richard Hansen <rhansen@bbn.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 03:56:51 -0400
Message-ID: <5364A143.1060404@bbn.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat May 03 10:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgUoh-00046t-Dq
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 09:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbaECH46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 03:56:58 -0400
Received: from smtp.bbn.com ([128.33.0.80]:58675 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbaECH45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 03:56:57 -0400
Received: from socket.bbn.com ([192.1.120.102]:41360)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WgUoW-0002Eo-QH; Sat, 03 May 2014 03:56:52 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 5B4713FE73
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248025>

On 2014-05-02 14:13, Junio C Hamano wrote:
> Stepping back even further, and thinking what is different between
> these two pulls, we notice that the first one is pulling from the
> place we push back to.

I think the fundamental difference is in the relationship between the
local and the remote branch (which branch derives from the other).
The relationship between the branches determines what the user wants
from 'git pull'.

In my experience 'git pull' is mostly (only?) used for the following
three tasks:

 1. update a local branch to incorporate the latest upstream changes

    In this case, the local branch (master) is a derivative of the
    upstream branch (origin/master).  The user wants all of the
    commits in the remote branch to be in the local branch.  And the
    user would like the local changes, if any, to descend from the tip
    of the remote branch.

    For this case, 'git pull --ff-only' followed by 'git rebase -p'
    works well, as does 'git pull --rebase=preserve' if the user is
    comfortable rebasing without reviewing the incoming commits first.
    A plain 'git pull' or 'git pull --ff' is suboptimal due to the
    awkward backwards-parents merge commit.

 2. update a published feature branch with the latest changes from its
    parent branch

    In this case, the local branch (foo) is a derivative of the
    upstream branch (origin/foo) which is itself a derivative of
    another branch (origin/master).  All commits in origin/master
    should be in origin/foo, and ideally all commits unique to
    origin/foo would descend from the tip of origin/master.

    The relationship between origin/foo and origin/master is similar
    to the relationship between master and origin/master in case #1
    above, but rebase is frowned upon because the feature branch has
    been shared with other developers (and the shared repository might
    reject non-ff updates).

    This case is sort-of like case #1 above (updating) and sort-of
    like case #3 below (integrating).

    For this case, after the local branch foo is updated (case #1
    above), 'git pull --ff origin master' or 'git fetch --all && git
    merge --ff origin/master' work well to update origin/foo.

 3. integrate a more-or-less complete feature/fix back into the line
    of development it forked off of

    In this case the local branch is a primary line of development and
    the remote branch contains the derivative work.  Think Linus
    pulling in contributions.  Different situations will call for
    different ways to handle this case, but most will probably want
    some or all of:

     * rebase the remote commits onto local HEAD
     * merge into local HEAD so that the first parent (if a real merge
       and not a ff) is the previous version of the main line of
       development and the second parent is the derivative work
     * merge --no-ff so that:
        - the merge can serve as a cover letter (who reviewed it,
          which bug reports were fixed, where the changes came from,
          etc.)
        - the commits that compose the new topic are grouped together
        - the first-parent path represents a series of completed tasks

    (I prefer to do all three, although I may skip the rebase if the
    commits came from another public repository so as to not annoy
    users of that downstream repository.)

    For this case, 'git pull --no-ff' is better than 'git pull --ff'
    (for the reasons listed above), but perhaps something more
    elaborate would be ideal (e.g., rebase there onto here, then merge
    --no-ff).

These three usage patterns are at odds; it's hard to change the
default behavior of 'git pull' to favor one usage case without harming
another.  Perhaps this is why there's so much disagreement about what
'git pull' should do.

I see a few ways to improve the situation:

  1. Add one or two new commands to split up how the three cases are
     handled.  For example:

      * Add a new 'git update' command that is friendly for case
        #1.  Update tutorials to recommend 'git update' instead of
        'git pull'.  It would behave like 'git pull --ff-only' by
        default.

        It could behave like 'git pull --rebase[=preserve]' instead,
        but this has a few downsides:
         - It doesn't give the user an opportunity to review the
           incoming commits before rebasing (e.g., to see what sort of
           conflicts to expect).
         - It subjects new users to that scary rebase thing before
           they are prepared to handle it.
         - The branch to be updated must be checked out.  If 'git
           update' used --ff-only, then 'git update --all' could
           fast-forward all local branches to their configured
           upstreams when possible.  (How cool would that be?)

      * Leave 'git pull' and 'git pull $remote [$refspec]' alone --
        the current defaults are acceptable (though maybe not ideal)
        for cases #2 and #3.

     Another example:

      * Add a new 'git integrate' command to handle case #3.  Ideally
        it would be configurable enough to work with various
        workflows.  It would behave like 'git pull --no-ff' by
        default.

      * Change plain 'git pull' to assume case #1 and default to
        --ff-only.  It could default to --rebase[=preserve] instead,
        but that has the same downsides as those listed for 'git
        update' above.

      * Have 'git pull $remote [$refspec]' also default to merge
        --ff-only.  It could assume case #2 and default to --ff, but
        that would cause 'git pull' to have different behaviors
        depending on how it is invoked.  That might be too confusing
        to users.  If 'git pull origin master' errors out due to
        non-ff, it's easy enough for users to manually run 'git merge
        origin/master'.  Alternatively users could use 'git integrate
        origin master', so long as it does not rebase by default.
        Thus, I don't think that defaulting to --ff-only (when the
        remote is specified) would be a huge loss.

  2. Teach 'git pull' to have different defaults depending on how it
     is invoked:

      * If plain 'git pull', assume case #1 above and default to merge
        --ff-only.
      * If 'git pull $configured_remote_name [$refspec]', assume case
        #2 and default to merge --ff.
      * If 'git pull $url [$refspec]', assume case #3 and default to
        merge --no-ff.

     I'm not a fan of this approach -- it seems like it would be a
     huge source of confusion for users.

  3. Add some branch metadata to automatically figure out branch
     relationships, then adjust the default behavior of 'git pull'
     according to that metadata.  This seems like a complicated and
     disruptive change, but it could have other benefits.

Of these options, I prefer adding a new 'git integrate' command and
changing 'git pull' (and 'git pull $remote [$refspec]') to default to
--ff-only.

-Richard
