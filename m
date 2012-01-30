From: Paul Berry <stereotype441@gmail.com>
Subject: [BUG] git clean -X skips a directory containing only ignored files
Date: Mon, 30 Jan 2012 15:36:13 -0800
Message-ID: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 00:36:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs0lo-0004nB-01
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 00:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab2A3XgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 18:36:15 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38890 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab2A3XgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 18:36:14 -0500
Received: by bkcjm19 with SMTP id jm19so15309bkc.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 15:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/fqqN7nnTeNIpbwTGpRSsu3ibS17BUbdLjCJHx2mez4=;
        b=KmoMTyoRnj6ByyGfOFt8KoPxlYHpLCxceGBSxr+Wt4DQoGt5feOl+ruDtV2sU8sPBE
         3iWwOtsP+EfwzpxZVLVXUwxXw4odfHESmPjEdyu5UalXCcYKdwUZBN0yo1fltx32TQkz
         c57LRDDI5p9Mb98djNk8s3V8V0ErnvdD6YT4I=
Received: by 10.205.139.12 with SMTP id iu12mr9385388bkc.2.1327966573250; Mon,
 30 Jan 2012 15:36:13 -0800 (PST)
Received: by 10.205.112.203 with HTTP; Mon, 30 Jan 2012 15:36:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189435>

I am trying to use "git clean -X" to remove object files (which
are gitignored) from my source tree, but it appears to miss
object files that are in a subdirectory without any git-tracked
files:

$ git init test
Initialized empty Git repository in /home/pberry/tmp/test/.git/
$ cd test
$ mkdir foo
$ touch foo/bar.o
$ echo '*.o' > .gitignore
$ git add .gitignore
$ git commit -mgitignore
[master (root-commit) 6b5ffcb] gitignore
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
$ git status
# On branch master
nothing to commit (working directory clean)
$ git clean -d -X -f
$ ls foo
bar.o

It seems to me that bar.o should have been removed, because
according to the git-clean docs, -X means "Remove only files
ignored by git", and bar.o is definitely being ignored by git.


It looks like a very similar bug was reported back in 2010, but
not fixed:
http://git.661346.n2.nabble.com/BUG-git-clean-X-behaviour-when-gitignore-has-sub-directory-entries-td5575307.html.
I've confirmed that the workaround mentioned by Jonathan Nieder
in that thread fixes my problem too (removing "dir.flags |=
DIR_SHOW_OTHER_DIRECTORIES;" from builtin/clean.c).  However I'm
guessing from Jonathan's comments that it would be better to fix
this bug elsewhere (somewhere in dir.c perhaps).

Is anyone interested in following up on this old bug?
Alternatively, if someone could give me some guidance as to the
best way to go about fixing this bug, I would be glad to submit a
patch.

Thanks,

Paul
