From: David Aguilar <davvid@gmail.com>
Subject: Re: Determining update/merge/current state of a workspace
Date: Sun, 2 Feb 2014 15:04:59 -0800
Message-ID: <20140202230456.GA56790@gmail.com>
References: <85ppn540wi.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:05:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA66N-0007TG-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaBBXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:05:19 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:36525 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaBBXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:05:18 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so6318677pbc.26
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 15:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PPPunaWf8ocSAl6UU5PmGoy225FXNewKYn9AOTdN80A=;
        b=vjWcWnwYefD7HwXK5fdt2BUjdTk1xvafo9fJDtB9k6NLSSUdP0gKIHo3uQSK6DuNJS
         W71bGHR+gz0atYY0kehiXWCCubz104fVGjZrHmlkW7FM9lMp4z+ZYT5CXHBE/jvE8VUb
         oDSHbVfS9a42jMygVe1XqytwViBwNo7qxH2kq2kU/YUx/FUzrmmUGeqYKBdHEx6hcUqD
         MBo+dk1Cn5GIzAGElXZDQ+qFffMai2ml1ezJMKtjSpjC8sTxNve41u+EaefvZg1aWOH1
         Xmi2V6mSxiwyp1hw09WZ5UFH8l6oOwNtAiZbf3E3DByOv12nWWz/Sss3hjeiyiVH+IdA
         B8Vw==
X-Received: by 10.66.248.194 with SMTP id yo2mr28072432pac.51.1391382317944;
        Sun, 02 Feb 2014 15:05:17 -0800 (PST)
Received: from gmail.com ([166.190.243.167])
        by mx.google.com with ESMTPSA id z10sm128843369pas.6.2014.02.02.15.05.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 15:05:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <85ppn540wi.fsf@stephe-leake.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241388>

On Sun, Feb 02, 2014 at 04:15:09PM -0600, Stephen Leake wrote:
> I'm working on the DVC Emacs front-end for git
> (http://www.emacswiki.org/emacs/DistributedVersionControl), adding
> features similar to the ones I added for monotone
> (http://www.monotone.ca). I'm used to monotone and new to git, so this
> may seem like an odd workflow.
> 
> I always do 'fetch' and 'merge' separately, never 'pull'. So after a
> 'fetch', the DVC Emacs front end must determine what needs to happen
> next. I think there are three cases:
> 
> 1) 'fetch' did not retrieve any revisions from remote; the last local
>    commit is the head of the branch.
> 
>     The workspace is up to date (it may need to be comitted).
> 
> 2) 'fetch' retrieved revisions, and there were no local commits since
>    the previous fetch.
> 
>     The last fetch is the head of the branch; if not equal to HEAD, the
>     workspace needs to be updated (via 'merge').
> 
> 3) fetch retrieved revisions, and there were local commits since
>    the previous fetch.
> 
>    There are two heads for the branch (the two described above), they
>    need to be merged, then the workspace updated.
> 
> I'm not sure how 'git fetch' handles case 3); I have not tested that
> case yet.

Fetch updates your cached origin/master ref to match the remote.
Your local master branch and worktree are left as-is.

> The question I have is:
> 
> What git queries can I run to determine which of the three states the
> current workspace is in?
> 
> 'rev-parse HEAD' gives the last workspace commit.
> 
> 'rev-parse refs/remotes/<remote>/<branch>' gives the head of the branch
> in the remote repository as of the most recent fetch.
> 
> But to distinguish among the cases, I need to determine if one of these
> two revs is a child of the other or not. I don't see a git query to
> determine that directly.

I think you're looking for "git merge-base".

If you do `git merge-base HEAD origin/master`
and its result is equal to `git rev-parse HEAD`
then you know that master is an ancestor of origin/master
and can be trivially fast-forwarded to origin/master.

If you get a SHA-1 that is not equal then there are probably[*]
local commits that have happened on master and it should probably
be rebased (or merged).

[*] other possibilities: someone rebased your upstream, etc.


People have differing opinions on how to resolve the diverging
history. Topic branches are the gitty approach.

Another popular approach to resolving the divergence is what
"git pull --rebase" would have done.

(No one really likes what "git pull" would have done by default
 when there are local commits)

To implement the rebase workflow, do "git rebase --autostash origin/master".
after fetching.  That workflow is probably the simplest for
folks who eschew branching or are expats from other vcs.

If you're writing a tool you might want to check whether
the branch has an upstream configured via `git config branch.$name.remote`
and `git config branch.$name.merge` as well.


> I could try parsing a 'log' output; I have not investigated that.
> This is easy in monotone; there is a command 'mtn heads' that gives this
> result directly (it returns either one or two revs), and another command
> 'mtn automate toposort' that orders revs topologically (by parent/child
> relationships).

`git log` can also tell you whether you have commits that they don't..

What does origin/master have that I don't?

	git log HEAD..origin/master

What do I have that origin/master does not?

	git log origin/master..HEAD

The git log output is easily controlled, though for these questions
the mere presence/absense of output tells you what you need to know.

cheers,
-- 
David
