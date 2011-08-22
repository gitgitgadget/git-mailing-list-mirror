From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [Git 1.7.6.557.gcee4] git stash
Date: Mon, 22 Aug 2011 12:15:29 -0500
Message-ID: <euT1_KmfLWaxwFqOd8u_Zv-flc6Wr9rvg1tf_39P-YMaH8T-tpKl94WG8yCIAmW0AMLjdqnjA3I2uGRQf9YpY513-Io-lue5aNPuVDv8Qp8@cipher.nrlssc.navy.mil>
References: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Caldwell <david@porkrind.org>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 19:16:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvY6s-0002OF-Iy
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab1HVRQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 13:16:20 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:56408 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab1HVRQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 13:16:19 -0400
Received: by mail3.nrlssc.navy.mil id p7MHFWjx031517; Mon, 22 Aug 2011 12:15:32 -0500
In-Reply-To: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com>
X-OriginalArrivalTime: 22 Aug 2011 17:15:30.0153 (UTC) FILETIME=[17E97D90:01CC60EF]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179873>

On 08/22/2011 01:01 AM, Hilco Wijbenga wrote:
> Hi David,
> 
> I noticed your very timely change to git stash in the current master
> branch. I tried it but it doesn't behave as I was expecting/hoping.

It looks like it is actually creating the stash correctly, but it's
just not deleting the ignored directory.

But, there is a small problem with your command sequence...

> hilco@centaur ~/tmp/repo repo$ git --version
> git version 1.7.6.557.gcee4
> hilco@centaur ~/tmp/repo repo$ git init
> Initialized empty Git repository in /home/hilco/tmp/repo/.git/
> hilco@centaur ~/tmp/repo repo (master #)$ cat >>.gitignore <<- EOF
>>         *.ignore
>>         ignore-dir/
>> EOF
> hilco@centaur ~/tmp/repo repo (master #%)$ mkdir src
> hilco@centaur ~/tmp/repo repo (master #%)$ touch file.txt src/code.txt
> hilco@centaur ~/tmp/repo repo (master #%)$ git add -A .
> hilco@centaur ~/tmp/repo repo (master #)$ git commit -m '1'
> [master (root-commit) 0fb4106] 1
>  1 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 .gitignore
>  create mode 100644 file.txt
>  create mode 100644 src/code.txt
> hilco@centaur ~/tmp/repo repo (master)$ touch file-a.ignore src/file-b.ignore
> hilco@centaur ~/tmp/repo repo (master %)$ echo "hello">src/code.txt
> hilco@centaur ~/tmp/repo repo (master *%)$ mkdir ignore-dir
> hilco@centaur ~/tmp/repo repo (master *%)$ touch
> ignore-dir/{file.ignore,file.txt}
> hilco@centaur ~/tmp/repo repo (master *%)$ git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   src/code.txt
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       file-a.ignore
> #       ignore-dir/
> #       src/file-b.ignore
          ^^^^^^^^^^^^^^^^^
Why are these entries here?

> no changes added to commit (use "git add" and/or "git commit -a")

if your .gitignore file looks like this:

   $ cat .gitignore
   *.ignore
   ignore-dir/

then why are those items showing up under "Untracked files:" in the call
to git status above?  /methinks something is wrong with your .gitignore
file.  It doesn't matter in this case, since --all will cause stash to
stash the untracked files regardless of whether they are ignored.

> hilco@centaur ~/tmp/repo repo (master *%)$ git stash --no-keep-index --all
> Saved working directory and index state WIP on master: 0fb4106 1
> HEAD is now at 0fb4106 1
> Not removing ignore-dir/
> hilco@centaur ~/tmp/repo repo (master $%)$ git status
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       ignore-dir/
> nothing added to commit but untracked files present (use "git add" to track)

Also, in the future it would be nicer if you provided your list of
commands separately, at the beginning, linked together with &&.
This makes it easier to copy/paste into my terminal, rather than
having to extract the commands out from within the body.
Like this (slightly simplified):

   git --version &&
   git init &&
   cat <<-\EOF >.gitignore &&
	*.ignore
	ignore-dir/
	EOF
   mkdir src &&
   touch file.txt src/code.txt &&
   git add . &&
   git commit -m 'initial commit' &&
   touch file-a.ignore src/file-b.ignore &&
   echo "hello" >src/code.txt &&
   mkdir ignore-dir &&
   touch ignore-dir/{file.ignore,file.txt} &&
   git status &&
   git stash --all &&
   git status || echo 'FAILURE'

> So it quite explicitly states "Not removing ignore-dir/".

That message is from git-clean, and it is the real problem.

> How do I
> make sure it also stashes the ignore-dir directory?

It actually did stash the ignore-dir, it just didn't remove it from
the working directory at the end.  Try deleting the ignore-dir by
hand and then applying the stash, ignore-dir and its content should
be recreated.

Something like this is probably the appropriate fix:

diff --git a/git-stash.sh b/git-stash.sh
index f4e6f05..a2d4b4d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -240,7 +240,7 @@ save_stash () {
                test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION
                if test -n "$untracked"
                then
-                       git clean --force --quiet $CLEAN_X_OPTION
+                       git clean --force --quiet -d $CLEAN_X_OPTION
                fi
 
                if test "$keep_index" = "t" && test -n $i_tree

Needs tests.

-Brandon
