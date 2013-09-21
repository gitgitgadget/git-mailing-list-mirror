From: Keshav Kini <keshav.kini@gmail.com>
Subject: [BUG?] inconsistent `git reflog show` output, possibly `git fsck` output
Date: Sat, 21 Sep 2013 17:16:01 -0500
Message-ID: <871u4hzusr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 22 00:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNVTO-0004Rk-9w
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 00:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab3IUWQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 18:16:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:52978 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab3IUWQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 18:16:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VNVTH-0004Px-W9
	for git@vger.kernel.org; Sun, 22 Sep 2013 00:16:11 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 00:16:11 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 00:16:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:ypb1CaNn4CF2S8PYL+2lTpR0tac=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235149>

Hello,

When trying out Roberto Tyley's BFG Repo-Cleaner program [1], I managed
to put a git repository in the following state:

    [2] fs@erdos /tmp/bfg-test-repo $ cat .git/logs/HEAD
    0000000000000000000000000000000000000000 00afb9f9a0c87dba4a203413358984e9f4fa5ffb Keshav Kini <keshav.kini@gmail.com> 1379746570 -0500	clone: from /home/fs/work/x86
    [2] fs@erdos /tmp/bfg-test-repo $ git rev-parse HEAD
    a29caa4646698bcf2273cc60d3d612593b4ced8f
    [2] fs@erdos /tmp/bfg-test-repo $ git reflog | cat
    a29caa4 (HEAD, refs/remotes/origin/HEAD, refs/remotes/origin/32-bit-accesses, refs/heads/32-bit-accesses) HEAD@{0}: clone: from /home/fs/work/x86
    [2] fs@erdos /tmp/bfg-test-repo $ git fsck
    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (6635/6635), done.
    [2] fs@erdos /tmp/bfg-test-repo $ echo $?
    0

This situation came about because the BFG Repo-Cleaner doesn't write new
reflog entries after creating its new objects and moving refs around.
But that aside, I think how git handles the situation might be a bug.

As you can see, HEAD is currently at a29caa46, but the reflog's data
file .git/logs/HEAD doesn't describe how it came to be at a29caa46. The
single reflog entry describes how the HEAD pointer was initialized to
00afb9f9 when I cloned the repository from /home/fs/work/x86 .

By the wording of the `git reflog` man page, I would assume that the
lines displayed by `git reflog show HEAD` would correspond to a chain of
reflog entries, where the short commit ID at the beginning of each line
would represent the second field of the reflog entry in question, and
the first field of the reflog entry would correspond to the short commit
ID at the beginning of the line directly below. For example, if `git
reflog show HEAD` displayed this:

    0123456 [stuff] foo
    789abcd [stuff] bar
    ef01234 [stuff] baz

Then I would expect the reflog data file for HEAD to look something like
this, where '.' represents an unknown hex digit:

    789abcd................................. 0123456................................. [stuff]
    ef01234................................. 789abcd................................. [stuff]
    ........................................ ef01234................................. [stuff]

However, in this example, the short commit ID shown in `git reflog show`
doesn't even appear in the reflog data file!

It seems to me that one of two things should be the case. Either 1) it
should be considered impossible to have a reflog for a ref X which
doesn't contain a chain of commits leading up to the current location of
X; or 2) if reflogs are allowed not to form an unbroken chain of commits
leading to X, then `git reflog show` should at least make sure to
actually display a commit ID corresponding to the second field of each
reflog entry it reads, and not some other commit ID.

In the first case, the bug is that `git fsck` doesn't catch the
supposedly impossible situation that exists in the repository I've
described in this email. In the second case, the bug is that `git reflog
show` has bad output.

I'm reporting this because I was having difficulty figuring out why `git
gc` was not collecting the commit 00afb9f. The reason turned out to be
that it was mentioned in a reflog and thus not getting pruned, which
would have been much easier to discover had the output of `git reflog
show` mentioned 00afb9f at all.

Please let me know what you think.

Thanks,
    Keshav


[1] http://rtyley.github.io/bfg-repo-cleaner/
