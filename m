From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git clean -X skips a directory containing only ignored
 files
Date: Tue, 31 Jan 2012 15:47:29 +0100
Message-ID: <4F27FF01.6040706@elegosoft.com>
References: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Paul Berry <stereotype441@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 15:48:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsF0t-0004nI-1L
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 15:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab2AaOsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 09:48:43 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:43875 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280Ab2AaOsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 09:48:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1993CDE849;
	Tue, 31 Jan 2012 15:48:42 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lXLrlRZ0AfGN; Tue, 31 Jan 2012 15:48:42 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id C6393DE847;
	Tue, 31 Jan 2012 15:48:41 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111224 Thunderbird/9.0.1
In-Reply-To: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189456>

On 01/31/2012 12:36 AM, Paul Berry wrote:
> I am trying to use "git clean -X" to remove object files (which
> are gitignored) from my source tree, but it appears to miss
> object files that are in a subdirectory without any git-tracked
> files:
> 
> $ git init test
> Initialized empty Git repository in /home/pberry/tmp/test/.git/
> $ cd test
> $ mkdir foo
> $ touch foo/bar.o
> $ echo '*.o' > .gitignore
> $ git add .gitignore
> $ git commit -mgitignore
> [master (root-commit) 6b5ffcb] gitignore
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 .gitignore
> $ git status
> # On branch master
> nothing to commit (working directory clean)
> $ git clean -d -X -f
> $ ls foo
> bar.o
> 
> It seems to me that bar.o should have been removed, because
> according to the git-clean docs, -X means "Remove only files
> ignored by git", and bar.o is definitely being ignored by git.
> 
> 
> It looks like a very similar bug was reported back in 2010, but
> not fixed:
> http://git.661346.n2.nabble.com/BUG-git-clean-X-behaviour-when-gitignore-has-sub-directory-entries-td5575307.html.
> I've confirmed that the workaround mentioned by Jonathan Nieder
> in that thread fixes my problem too (removing "dir.flags |=
> DIR_SHOW_OTHER_DIRECTORIES;" from builtin/clean.c).  However I'm
> guessing from Jonathan's comments that it would be better to fix
> this bug elsewhere (somewhere in dir.c perhaps).

Removing DIR_SHOW_OTHER_DIRECTORIES just happens to not trigger
this particular "bug" but breaks pretty much everything else.

As a workaround, you could explicitly add the directory to your
gitignore file.

Here's a test:

-- >8 --

Subject: [PATCH] t7300-clean: show known breakage with "git clean -d -X"

"git clean -d -X" fails for directories containing only untracked files.
Example:

	$ ls -R .
	.:
	foo
	./foo:
	bar.o
	$ cat .gitignore
	*.o
	$ git clean -d -X -f
	$ ! test -d foo || echo fail

Reported-by: Paul Berry <stereotype441@gmail.com>
Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 t/t7300-clean.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 800b536..0b6d545 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -332,6 +332,13 @@ test_expect_success 'git clean -d -X' '
 
 '
 
+test_expect_failure 'git clean -d -X' '
+  mkdir -p a/b &&
+  touch a/b/c.o &&
+  git clean -d -X &&
+  ! test -d a
+'
+
 test_expect_success 'clean.requireForce defaults to true' '
 
 	git config --unset clean.requireForce &&
-- 
1.7.9.174.g356eff6
