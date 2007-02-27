From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Tue, 27 Feb 2007 22:09:06 +0100
Message-ID: <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth> <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9ZX-0003CB-Ka
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXB0VJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbXB0VJR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:09:17 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:45717 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbXB0VJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:09:16 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 07EDA3948;
	Tue, 27 Feb 2007 22:09:14 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id E76ED1F08A; Tue, 27 Feb 2007 22:09:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40806>

On Tue, Feb 27, 2007 at 02:25:57PM +0000, Catalin Marinas wrote:
> On 25/02/07, Yann Dirson <ydirson@altern.org> wrote:
> >This testcase demonstrates a long-standing problem with the handling
> >of conflicts on a rewinding branch, when "stg pull" calls git-pull.
> [...]
> >diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
> [...]
> >+test_expect_failure \
> >+    'Rewind/rewrite upstream commit and pull it from clone, without 
> >--merged' \
> >+    '
> >+    (cd upstream && echo b >> file2 && stg refresh) &&
> >+    (cd clone && stg pull)
> >+    '
> 
> This fails (with git 1.5), as expected, but probably not for the same
> reason. See below.

That would demonstrate the usefulness of a python-based testsuite as I
suggested the other day :)

But I see the test failing with both 1.4.4.4 and 1.5.0.1:

Auto-merged file2
CONFLICT (add/add): Merge conflict in file2
Automatic merge failed; fix conflicts and then commit the result.
stg pull: Failed "git-pull origin"
Traceback (most recent call last):
  File "/export/work/yann/git/stgit/t/../stg", line 43, in ?
    main()
  File "/export/work/yann/git/stgit/stgit/main.py", line 280, in main
    command.func(parser, options, args)
  File "/export/work/yann/git/stgit/stgit/commands/pull.py", line 84, in func
    git.pull(repository)
  File "/export/work/yann/git/stgit/stgit/git.py", line 839, in pull
    raise GitException, 'Failed "%s %s"' % (command, repository)
stgit.git.GitException: Failed "git-pull origin"


> >+test_expect_success \
> >+    'Undo the conflicted pull' \
> >+    '(cd clone && stg push --undo)'
> 
> This actually fails in my tests because the git-pull failed previously
> (and not the patch pushing) and there is no patch on the stack to
> undo.

Right, I was a bit confused.  I first checked whether there was a
"pull --undo" and did not catch correctly the FlagNotFoundException :)


> BTW, push --undo now requires a status --reset beforehand.

Oh, I had not noticed that.  Why so ?  It's not like if "push --undo"
would lose any valuable data...


What strikes me most in this case is the difference in behaviour
between this type of conflict (conflict marked in index, so needs an
operation outside the current scope of stgit to proceed), with a
regular stgit conflict that occurs during a push (index clean,
conflict info not available to tools written for regular GIT).

That reminds me I already wondered why stgit has to deal with conflict
handling itself.  I've not digged much into the GIT merge mechanism,
but I'd think it would be great if we were able to use it.


> I can merge the patch as it is and you can send me another one for this 
> issue.

I have prepared the followin patchlet (you may want to food it into my
previous patch), but I am still a bit unsure what to do - read on.

====================
--- a/t/t2101-pull-policy-pull.sh
+++ b/t/t2101-pull-policy-pull.sh
@@ -47,14 +47,12 @@ test_expect_failure \
     '
 
 test_expect_success \
-    'Undo the conflicted pull' \
-    '(cd clone && stg push --undo)'
+    '"Solve" the conflict (pretend there is none)' \
+    '(cd clone &&
+      git add file2 && EDITOR=cat git commit)'
 
 test_expect_success \
-    'Pull the rewinded commit, with --merged' \
-    '
-    (cd clone && stg pull --merged) &&
-    test `wc -l <clone/file2` = 2
-    '
+    'Push the stack back' \
+    '(cd clone && stg push -a)'
 
 test_done
====================


The testcase now still ends in a bad situation.

What happenned is our "stg pull" could not complete, so we had to
complete it by hand (instead of attempting to abort it, as my initial
testcase wanted to do).  This makes it look like an "unsafe base
change" (since post_rebase was never called to update "orig-base",
after our manual conflict resolution was done), so any subsequent pull
or rebase will require a --force.

I don't like that either.  I'm still quite unsure how the "git-pull"
model of pulling ought to work, that obviously does not help :)
Any idea ?

Best regards,
-- 
Yann.
