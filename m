From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Sat, 12 Apr 2014 19:45:12 -0700
Message-ID: <32c0335e91b9658a9cca007f6851280@74d39fa044aa309eaea14b9f57fe79c>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <vpqsipkmeum.fsf@anie.imag.fr> <D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com> <vpq4n1zg4f9.fsf@anie.imag.fr> <D3916156-0F84-4DD2-833F-64DF675325D3@gmail.com> <vpq38hi8oj3.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Apr 13 04:46:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZAQj-0003CF-Mh
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 04:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbaDMCpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 22:45:24 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:32909 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbaDMCpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 22:45:22 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so6838485pbb.8
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T6/XpXw9bGs1mToSxdunMimJ7zIpJgtiqsBDAJznR6E=;
        b=L/YxS0kQdF0FUCppAaKtVNYY4/6SrFSv9XPqx9xAM7ghD26H+XnzzGxI8eUEarcchX
         H5+nv+CsN7VJjhMe519HkfxlDVwXVxKELjHGdy9IlufbV235tLjtT9a+QULn/9MbO8kM
         WkvDgJaWIRSXpZeBBcUpPLCxpbhD/H/jwBRCP40o0FXVYzW0YNWYX2PvTPXrflklBmK8
         ie6Z/hamErROL4V3CzW05P0jhUL1+znKM5Bez9uvg/3Ys7RoAsx4H0dzzfOFoYiJ7tCO
         5VewapniGTWWmHSrGY3yhpF1o62JzS/W+uxvdSmLHwFqJO6a7buhPFRIMZt+NVpaY07G
         L2MQ==
X-Received: by 10.68.204.162 with SMTP id kz2mr36511811pbc.13.1397357122218;
        Sat, 12 Apr 2014 19:45:22 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vf7sm24943860pbc.5.2014.04.12.19.45.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 19:45:21 -0700 (PDT)
In-Reply-To: <vpq38hi8oj3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246205>

On Apr 12, 2014, at 10:07, Matthieu Moy wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> On Apr 11, 2014, at 10:30, Matthieu Moy wrote:
>>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>>
>>>> There are already nested functions with file inclusion between both
>>>> levels of nesting in git-rebase--interactive.sh and git-rebase--
>>>> merge.sh now, so it's not introducing anything new.
>>>
>>> OK, so it's less serious than I thought. But still, we're
>>> introducing a
>>> function with 3 levels of nesting, split accross files, in an area
>>> where
>>> we know that at least one shell is buggy ...
>>
>> Currently in maint:
>>
>> The current code in maint does this:
>>
>> git-rebase.sh: top-level
>>  git-rebase.sh: run_specific_rebase()
>>    git-rebase.sh: run_specific_rebase_internal() -- contains "dot"
>>      git-rebase--interactive.sh: top-level (using --continue or --
>> skip)
>>        git-rebase--interactive.sh: do_rest
>>          git-rebase--interactive.sh: do_next
>
> You're confusing function calls and function nesting. do_rest calls
> do_next, but the definition of do_next is not nested within do_rest.
>
> When I talk about nested function, I mean
>
> f() {
> 	g() {
> 		...
> 	}
> }
>
> Obviously, having functions call each other is not an issue. That's  
> what
> functions are meant to be.
>
> Now, having run_specific_rebase_internal include a file which defines
> functions which contain nested functions _is_ something I find  
> weird. It
> both stresses the shell in a buggy area and makes the code harder to
> understand.

I meant: "nested functions" = "nested function calls"
You meant: "nested functions" = "nested function definitions"

Okay.  But nested function definitions is not something new to the
rebase code.

>> The problem with these changes, particularly the git-rebase--
>> interactive.sh one is that a bunch of code is still run when the file
>> is "dot" included.
>
> Function definitions, and variables assignments. Is it so much of an
> issue?
>
> What's the difference between a function definition or variable
> assignment within git-rebase--*.sh and within git-rebase.sh?

As I said, this is the issue:

On Apr 11, 2014, at 16:08, Kyle J. McKay wrote:

> The problem with these changes, particularly the git-rebase-- 
> interactive.sh one is that a bunch of code is still run when the  
> file is "dot" included.  With the changes to git-rebase.sh, that  
> code will now run regardless of the action and it will run before it  
> would have now.  So if any of the variables it sets affect the  
> functions like read_basic_state or finish_rebase (they don't  
> currently appear to), then there's a potential for new bugs.  That  
> initial code would not previously have run in the --abort case at all.

Let me rephrase.

Patch 1/3 does not change the order in which individual statements are  
executed in the rebase code.  Nor does it change the logic.  It simply  
introduces one additional function callstack level, but the same  
individual statements are executed in the same order for all control  
flows.  No additional statements other than the introduced callstack  
level.  Nothing's executed in a different order.  No control paths  
execute additional statements they did not before.

The changes you propose introduce exactly the same additional function  
callstack level.  Then they proceed to alter the order in which  
statements are executed.  Statements that did not execute in some  
control paths before are now executed in those control paths.  Other  
statements are moved around to execute earlier/later than they did  
before.

My point is not that this is wrong.  It's nice, really, to move the  
"dot" include to the top level.  The point is that's not necessary to  
fix the problem and moving statements around and adding statements to  
some control paths increases the risk of introducing an uncaught bug  
when it's not necessary to fix the problem.

I would like to get a fix in so that rebase works out-of-the-box when  
Git version 1.8.4 or later is built on FreeBSD.

So I'm not going to belabor the point anymore.

There's a follow-up patch 4/3 attached to the end of this message that  
makes the changes you have proposed in your earlier email on top of  
patches 1/3 and 2/3.  The log message and all changes are taken from  
your emails and so this patch is assigned to you and has a
'Needs-Signed-off-by:' line.

On Apr 11, 2014, at 10:30, Matthieu Moy wrote:
> The real patch is a bit more tricky though, because we need to run the
> ". git-rebase--$type" after computing type properly. A patch passing  
> the
> tests but requiring cleanup is given below.

Unfortunately, after applying the below patch, some of the rebase  
tests (3403, 3407, 3418, 3420, 3421) start failing for me on systems  
where they did not fail previously.  Even though some of the previously  
failing tests on FreeBSD now pass with the patch, 3421 now fails on  
FreeBSD where it did not before.

Here's a test summary of the t34xx*.sh tests:

NOTE: at the time of these tests, maint and v1.9.2 were at the same  
commit.

______________SYSTEM____t34xx*.sh_results________________

maint         FreeBSD   FAIL: 3403,3404,3407,3409,3410,3412,3418,3419,3420
maint         Darwin    PASS
maint         Linux     PASS

maint+1-3/3   FreeBSD   PASS
maint+1-3/3   Darwin    PASS
maint+1-3/3   Linux     PASS

maint+1-4/3   FreeBSD   FAIL[*]: 3403,3407,3418,3420,3421
maint+1-4/3   Darwin    FAIL[*]: 3403,3407,3418,3420,3421
maint+1-4/3   Linux     FAIL[*]: 3403,3407,3418,3420,3421

[*]: The failing test reports for all three systems are identical for  
the "maint+1-4/3" run (except for the wallclock secs part):

Test Summary Report
-------------------
t3403-rebase-skip.sh                   (Wstat: 256 Tests: 10 Failed: 3)
   Failed tests:  8-10
   Non-zero exit status: 1
t3407-rebase-abort.sh                  (Wstat: 256 Tests: 11 Failed: 3)
   Failed tests:  7-9
   Non-zero exit status: 1
t3418-rebase-continue.sh               (Wstat: 256 Tests: 6 Failed: 2)
   Failed tests:  5-6
   Non-zero exit status: 1
t3420-rebase-autostash.sh              (Wstat: 256 Tests: 24 Failed: 11)
   Failed tests:  14-24
   Non-zero exit status: 1
t3421-rebase-topology-linear.sh        (Wstat: 256 Tests: 76 Failed: 16)
   Failed tests:  51-53, 55, 57, 59-63, 65, 67, 73-76
   Non-zero exit status: 1
Files=22, Tests=374, 354 wallclock secs ( 0.31 usr  0.13 sys + 79.57 cusr 233.99 csys = 314.00 CPU)
Result: FAIL
make: *** [prove] Error 1


So I suggest that in the interest of fixing rebase on FreeBSD in an  
expeditious fashion, patches 1/3 and 2/3 get picked up (see note  
below) now and that the follow-on patch below, after being enhanced to  
pass all tests, be submitted separately at some future point.

--Kyle

P.S.  Note to JCH: the below patch requires the previous 1/3 and 2/3  
be applied first.  As per SubmittingPatches for bug fixes those are  
based on maint.  Because of the whitespace change 1/3 introduces it  
does not apply cleanly to master, next or pu.  :(  Please let me know  
if you would like me to resend the initial series (1 & 2 -- 3 has  
already been picked up) based on a different branch instead of maint.

---- 8< ----
From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [PATCH 4/3] rebase: stop using . within function

Move the whole run_specific_rebase_internal function to
git-rebase--$type.

The .-ed script defines the complete function, and then the
function is used from the toplevel script.

The goal is to avoid using tricky features that may trigger
bugs on some shells.

The result is simpler, just using the basic pattern:

    1. use '. file' to import a set of functions
    2. then use these functions

Needs-Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 git-rebase--am.sh          |  3 +--
 git-rebase--interactive.sh |  3 +--
 git-rebase--merge.sh       |  3 +--
 git-rebase.sh              | 40 +++++++++++++++++++++-------------------
 4 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 2d3f6d55..b48b3e90 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,7 +4,7 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-git_rebase__am() {
+run_specific_rebase_infile() {
 	case "$action" in
 	continue)
 		git am --resolved --resolvemsg="$resolvemsg" &&
@@ -75,4 +75,3 @@ git_rebase__am() {
 
 	move_to_original_branch
 }
-git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 42164f11..a7670eb0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -810,7 +810,7 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
-git_rebase__interactive() {
+run_specific_rebase_infile() {
 	case "$action" in
 	continue)
 		# do we have anything to commit?
@@ -1044,4 +1044,3 @@ EOF
 	git update-ref ORIG_HEAD $orig_head
 	do_rest
 }
-git_rebase__interactive
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index b5f05bf5..9550e656 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -101,7 +101,7 @@ finish_rb_merge () {
 	say All done.
 }
 
-git_rebase__merge() {
+run_specific_rebase_infile() {
 	case "$action" in
 	continue)
 		read_state
@@ -153,4 +153,3 @@ git_rebase__merge() {
 
 	finish_rb_merge
 }
-git_rebase__merge
diff --git a/git-rebase.sh b/git-rebase.sh
index 07e2bd48..9e105626 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -175,7 +175,7 @@ run_specific_rebase () {
 		export GIT_EDITOR
 		autosquash=
 	fi
-	. git-rebase--$type
+	run_specific_rebase_infile
 	ret=$?
 	if test $ret -eq 0
 	then
@@ -353,6 +353,26 @@ then
 	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
 fi
 
+if test -n "$rebase_root" && test -z "$onto"
+then
+	test -z "$interactive_rebase" && interactive_rebase=implied
+fi
+
+if test -n "$interactive_rebase"
+then
+	type=interactive
+	state_dir="$merge_dir"
+elif test -n "$do_merge"
+then
+	type=merge
+	state_dir="$merge_dir"
+else
+	type=am
+	state_dir="$apply_dir"
+fi
+
+. git-rebase--$type
+
 case "$action" in
 continue)
 	# Sanity check
@@ -407,24 +427,6 @@ and run me again.  I am stopping in case you still have something
 valuable there.')"
 fi
 
-if test -n "$rebase_root" && test -z "$onto"
-then
-	test -z "$interactive_rebase" && interactive_rebase=implied
-fi
-
-if test -n "$interactive_rebase"
-then
-	type=interactive
-	state_dir="$merge_dir"
-elif test -n "$do_merge"
-then
-	type=merge
-	state_dir="$merge_dir"
-else
-	type=am
-	state_dir="$apply_dir"
-fi
-
 if test -z "$rebase_root"
 then
 	case "$#" in
-- 
1.8.5
