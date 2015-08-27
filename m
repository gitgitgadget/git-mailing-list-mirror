From: John Szakmeister <john@szakmeister.net>
Subject: Bug with worktrees...
Date: Thu, 27 Aug 2015 15:03:57 -0400
Message-ID: <CAEBDL5UQSvS=t1dUKYqK6R=xHU6RU3bS72w-i02ey-Y_VB9KMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 21:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV2T3-0004Rl-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 21:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbbH0TD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 15:03:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36069 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbH0TD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 15:03:58 -0400
Received: by iodv127 with SMTP id v127so68367949iod.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=jXuWax3hW4vRY/Iz2CNcbEMTxmdwvOlGetdxkBq1R+k=;
        b=GeToKuwlQG0QKBc3RrEXVQLkQ6Wdis3MIMOA+eS2bjtVqoJVGjjDlnRgcynHfIJYBv
         AVPriiHbvTflWjSvezwbnnHWZXHx1rgYwaZn8jm0ofxRwIYSd3uiVcj7heftWDpWOpG3
         8K8qKiyWx6WluM7uLyhPjr86adjg1enMdUiduzloVCPkHy649IUGOIRPLT87IoWRuUzD
         6gdttrC2r8/zaima+jljZdEQFFQ8eqzT+01Hne4HZYg7Nram59KSVh6VJJioHjPJvI4d
         bWvtKBlUxXeueck6yf6IOPvQ98Qo8qmM5rDmLhH1uCJl+PomQhG87pWY6f29iBLtqYjP
         jYIg==
X-Received: by 10.107.133.137 with SMTP id p9mr10880352ioi.146.1440702237771;
 Thu, 27 Aug 2015 12:03:57 -0700 (PDT)
Received: by 10.107.187.2 with HTTP; Thu, 27 Aug 2015 12:03:57 -0700 (PDT)
X-Google-Sender-Auth: _t9JzojhqiMTPA8wqYMor2DziuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276686>

My apologies if this has already been reported, but I ran into an
interesting bug with worktrees.  In particular, I have an alias 'st'
that maps to 'status -sb'.  When running this under a subdirectory of
a worktree created with 'git worktree add', it fails complaining that
the work tree has already been set.

Here's a script to reproduce the problem:
    git init test-repo
    cd test-repo
    git config --local alias.st 'status -sb'
    mkdir subdir
    echo file > subdir/file.txt
    git add subdir/file.txt
    git commit -m 'add file'
    git branch foo
    git worktree add ../new-worktree foo
    cd ../new-worktree/subdir
    echo "new line" >> file.txt
    echo "this will work"
    git status -sb
    echo "this fails"
    git st

When I run it, I see this:

Initialized empty Git repository in
/home/jszakmeister/tmp/test-case/test-repo/.git/
[master (root-commit) 1ec5360] add file
 1 file changed, 1 insertion(+)
 create mode 100644 subdir/file.txt
Enter ../new-worktree (identifier new-worktree)
Switched to branch 'foo'
this will work
## foo
this fails
fatal: internal error: work tree has already been set
Current worktree: /home/jszakmeister/tmp/test-case/new-worktree
New worktree: /home/jszakmeister/tmp/test-case/new-worktree/subdir

Hope this helps!

-John
