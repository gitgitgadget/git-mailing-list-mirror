From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 11:58:36 -0600
Message-ID: <20101111175836.GD16972@burratino>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
 <201011111649.oABGnjca019731@no.baka.org>
 <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbQY-0006Mo-1X
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0KKR7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 12:59:01 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38678 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0KKR7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 12:59:00 -0500
Received: by vws13 with SMTP id 13so461329vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hPDqn0S/pNsV5K1F5RSfd065nC01ayVPAxyq1E+6ImA=;
        b=s1YwBKDCaB1ZenWBzsol5iPOiuWmvx3LTkkNgG+qHm4CAaqNL5eEEadiMkVDvIoVRg
         oVrFKFtVYsWfwurT2WznU5ybHOn/rY9Vx4Bq3Xam5ZjFvm3Bb5HifutULtMOiAfzBA38
         2NvPOTQe7PH+wZdyEtv4zALwI2UvLC1d1NJt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Zq5iCwERoXoaRyDxlFr6e08tYy+6WBGP5Dsyg7JtVXtWyL9hI5Pohu2631r3Z7v618
         3XXq8pwoVqd1theoqcw9Gsu7XMyvpu3WYyKfmCOP63Z1f3uyQK6lDKKChoX10yHW5PR/
         HLqakz9relPgbwHrvPUleDftlCli5PSIYXJ4w=
Received: by 10.220.181.1 with SMTP id bw1mr263581vcb.38.1289498339511;
        Thu, 11 Nov 2010 09:58:59 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y14sm647806vch.28.2010.11.11.09.58.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 09:58:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikqBXjAf44O0QERH39rK+7nNA8uD2CwtPKJTTyV@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161280>

Patrick Doyle wrote:

> Thank you for your reply and cogent explanation.  Yes, in fact, I did
> do a "git reset HEAD^".  Somewhere along the way, I decided that was a
> way to make my working copy look like it did prior to a commit.
> 
> I thought that git reset only affected HEAD.  I didn't realize that it
> also affected the branch pointer.

Right.  In general, git operations that update HEAD also tend to take
the current branch along with them.  So:

	# update the current branch to include a new commit
	git commit

	# update the current branch to include a change from another branch
	git cherry-pick --ff $rev

	# update the current branch to incorporate the history of another branch
	git merge $rev

	# reset the current branch head to match _that_ commit
	git reset --keep $rev

	# only reset the current branch head; index and worktree will be untouched
	git reset --soft $rev

If you want to use such an operation without updating a certain
branch, then switch to a different branch.

	# switch branches: we are following 'topic' now
	git checkout topic

	# detach from all branches: we are building unanchored history now
	git checkout HEAD^0

See the section DETACHED HEAD from the "git checkout" manual for details.

> Your "great power, great responsibility" comment will make me treat
> "git reset" with a lot more fear and respect.

Once you're used to it, it is not so scary.  If you pass paths to
"git reset", it will not change HEAD; instead, it changes the content
registered in the index:

	git reset some-crazy-old-commit -- foo.c bar.c baz.c
	git diff --cached

If you do not pass paths, it will update HEAD to point to the specified
commit.

	# the last commit was bad; discard it
	git reset --keep HEAD^

	# I'm totally lost.  Let's just start over, based on the version
	# that worked from yesterday.
	git reset --hard @{yesterday}

	# specialized operation: the tracked content of all files should
	# be used as a single commit on top of some other revision
	git reset --soft $new_parent
	git commit

	# less strange way to do about the same thing
	git reset $new_parent
	git diff;	# looks good?
	git add -u
	git commit

If you do not pass paths and do not pass a revision arg, this means
you wanted to update HEAD to point to the commit it is already at.
In other words, with --soft or --keep this is basically a noop, with
--hard it discards any changes in working-tree files you haven't
committed, with no operation mode arg it makes the index match the
HEAD commit.

> $ git merge --no-commit
> $ git reset
> 
> Why is that "git reset" benign, when the "git reset HEAD^" wasn't benign before?

There should be a revision argument after "git merge --no-commit".

This "git reset" is equivalent to "git reset HEAD": it resets the
index to match the current commit, so the changes applied by the
merge appear as local changes.

Regards,
Jonathan
