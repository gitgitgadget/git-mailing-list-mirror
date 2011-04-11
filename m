From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: Converting merge to rebase in the presence of conflicts
Date: Mon, 11 Apr 2011 16:13:53 +0200
Message-ID: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 16:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9HsN-0005eV-Ch
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 16:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab1DKONy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 10:13:54 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58620 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1DKONy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 10:13:54 -0400
Received: by yxs7 with SMTP id 7so2160540yxs.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=iFbX7oab8RW7F2ROv1DgIXVuwmnnQjpf7bGyOYlqngM=;
        b=ALvu5omEw9Asc9DFKYzM/mXhePDZmioT8dN92I8IJNOQJ2IXqV16kIbN8Zqdn3YX6D
         vqnmmZUDXP0kXZKXGvM9nr9lnleW+NlbKqFM9Bhmoemo81A0Hzr4HD7I2YUszoy88XcB
         YCYcbl/EhrHc7kMJKnaPZ+K9iX2+f5jgB4mMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aCpJFjYe1Sut8Krv3lITClVOIo4Dt8NZk0KdJLpUzKW22wCaYWOr767oJj6F70Blot
         yWz/U87bMQGCmGJdA4pqB+Gie+N9OxX4WJcrk+k2A5mcBW4xv8kD1ratV2I/+m9/BhQd
         4hFe5Mu6UF6nWp2UqhmXIgPDOT6LMvnM2S3/M=
Received: by 10.91.69.37 with SMTP id w37mr4711791agk.196.1302531233478; Mon,
 11 Apr 2011 07:13:53 -0700 (PDT)
Received: by 10.90.63.17 with HTTP; Mon, 11 Apr 2011 07:13:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171329>

Is it possible to convert a merge with (resolved) conflicts into a rebase?

I find it useful to always pull commits with "git pull" because it is
less intrusive on my local commits (if any) than "git pull --rebase",
and it provides a nicer change summary. Also, conflict resolution
seems more intuitive when merging than when rebasing. And If I decide
later to rebase after all, I can simply issue "git rebase origin/bla".
As long as there are no conflicts.

If the merge resolves conflicts, the subsequent rebase is unaware of
that, and the conflicts must be resolved once more. Here is an example
in a single repository that just uses 'merge' to show the scenario:

# create a common file with two lines and branch off
printf 'foo\nbar\n' > a
git add a && git commit -m '' a
git add a && git commit -m 'Added.' a
git branch somebranch

# now work on the file in both branches
echo baz >> a
git commit -m changed a
git checkout somebranch
echo qux >> a
git commit -m changed2 a

# we're on somebranch and decide to merge our changes with master:
git merge master
vi a           # resolve conflicts
git add a
git commit     # commit the merge

At this point say the developer on somebranch changes his mind and
wants to rebase after all. The result is, again, a conflict:

# try to change merge to rebase
git rebase master
[... long output on conflicts ...]

First, rewinding head to replay your work on top of it...
Applying: changed2
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging a
CONFLICT (content): Merge conflict in a
Failed to merge in the changes.
Patch failed at 0001 changed2

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".


Is there a way to rebase the branch without redoing conflict
resolution? Some option to rebase, or a trick with rebase -i? The
conflict resolution must obviously go into some commit, it would be
nice to be able to choose whether to amend an existing commit with the
additional changes or to add a new commit.

Hrvoje
