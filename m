From: Christopher Yee Mon <christopher.yeemon@gmail.com>
Subject: 3 way merge during git p4 rebase is attempting to reapply past commits
Date: Tue, 7 May 2013 19:12:30 -0400
Message-ID: <CAG4Fb8f8vxbqwnCn1B9EfZu3sM-3-wQ2dqcR+BezPaf_XEy5Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, simon@lst.de
X-From: git-owner@vger.kernel.org Wed May 08 01:13:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZr47-0007Oc-TB
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 01:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3EGXMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 19:12:53 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:39411 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab3EGXMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 19:12:52 -0400
Received: by mail-we0-f170.google.com with SMTP id u54so1135437wes.15
        for <git@vger.kernel.org>; Tue, 07 May 2013 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=/yU/uWZjK3WV/16v33rzMca/tvCWJ/h3ESeI4Y8OWQ8=;
        b=OOEsml3Z5HM8howdQ33SclwLJNI9R76RepHwcpHOr9VV7EbBUnroW0IJpHDLDqpwBm
         n0MO0KWK4gJ53JjHzY5y4k7l+vnYvi+H583VyvbmGm9bjkJuWtJ55vUJpM72F5Wk6NdS
         631RRqmW6xdLQW82vnPDI3oi0MTVX1PyyubyeNXIUJea0uWIvO+FF879LOnDnldWAUfu
         OKfo3ExU9QuEZwqvYbJkE/VjZtgNQL0lbLWZ9Nh/MgB452mSgaU0d9A3UQ1Tq4NYq1/o
         WF38hw3kVQYnHMlIhRq0PPdUV6/onFSvkY3qKMdsCO5x6Q6McLvSaoh2q9pLxre+q980
         c+3w==
X-Received: by 10.180.36.165 with SMTP id r5mr17774984wij.18.1367968370933;
 Tue, 07 May 2013 16:12:50 -0700 (PDT)
Received: by 10.217.55.136 with HTTP; Tue, 7 May 2013 16:12:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223627>

Hello,

I have a setup where I have a remote non-bare repo cloned from a
perforce workspace. It is used as a remote repo that people clone into
their own user repos, make commits to, then push back into the remote
repo. Then I periodically run the following commands in a script to
push those changes back to perforce.

git checkout -f
git clean -f
git p4 rebase --import-labels
git p4 submit -M --export-labels
git checkout -f
git clean -f

Sometimes, always after commits from one user's machine specifically,
I get the following error below when pushing back to perforce at the
remote repo. It seems to happen randomly, or at least intermittently,
since I often can't discern any major error during git committing to
the remote repo that precipitates this error. It does happen pretty
reliably when I get a file conflict that I resolve and fix during
committing though.

Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //depot/sub/folder/
No changes to import!
Rebasing the current branch onto remotes/p4/master
First, rewinding head to replay your work on top of it...
Applying: A commit that has already been made previously
Applying: A second commit that has already been made in a previous commit
Using index info to reconstruct a base tree...
<stdin>:15: space before tab in indent.
                            a line of text
<stdin>:24: space before tab in indent.
                another line of text
<stdin>:25: space before tab in indent.
                a third line of text
<stdin>:33: trailing whitespace.
        a forth line of text
<stdin>:71: trailing whitespace.

warning: squelched 1 whitespace error
warning: 6 lines add whitespace errors.
Falling back to patching base and 3-way merge...
Auto-merging file from second
CONFLICT (content): Merge conflict in
a/file/in/the/second/pre-existing/commit/file.php
Auto-merging a/file/in/the/second/pre-existing/commit/file.php
Failed to merge in the changes.
Patch failed at 0002 A second commit that has already been made in a
previous commit

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To check out the original branch and stop rebasing run "git rebase --abort".

Traceback (most recent call last):
  File "/usr/lib/git-core/git-p4", line 3373, in <module>
    main()
  File "/usr/lib/git-core/git-p4", line 3367, in main
    if not cmd.run(args):
  File "/usr/lib/git-core/git-p4", line 3150, in run
    return self.rebase()
  File "/usr/lib/git-core/git-p4", line 3167, in rebase
    system("git rebase %s" % upstream)
  File "/usr/lib/git-core/git-p4", line 183, in system
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command 'git rebase remotes/p4/master'
returned non-zero exit status 1

The patch is usually one that is already in the remote git repo and in
perforce. At that point I have to run git rebase --skip, to skip the
patch, then rerun the commands in the script again. Sometimes it's
multiple patches that cause this problem and I have to run git rebase
--skip repeatedly. When I check the working copy of the remote repo, I
don't see any changes, no conflict markers, just the file.

The real problem happens when I run git rebase --continue. Usually I
end up with repeated submits in perforce when I do that, which is
obviously a corruption of data.

It sounds a lot like this error, except I don't know how git p4 is
branching, so I don't know how to diagnose it.

http://stackoverflow.com/questions/4033009/git-rebase-conflicts-keep-blocking-progress

I also asked stack overflow and someone there said it's probably the
perforce user being different from the git user info, so I had all the
git users switch to having the same info as the perforce user info and
that did NOT solve the problem.

http://stackoverflow.com/questions/16106900/git-p4-rebase-attempts-to-reapply-past-commits

I'm not sure what could possibly be causing this or how to fix it.
Does anyone have any ideas?

Thanks
Christopher Yee Mon
