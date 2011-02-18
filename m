From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: cherry-pick does not set ORIG_HEAD
Date: Fri, 18 Feb 2011 17:17:48 -0600
Message-ID: <20110218231748.GA17836@elie>
References: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com>
 <20110218012435.GA16893@elie>
 <4D5EE6BB.9070507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 00:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqZaN-0001QV-La
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 00:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351Ab1BRXR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 18:17:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37478 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab1BRXR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 18:17:56 -0500
Received: by qyk7 with SMTP id 7so521857qyk.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fg8s0lI3LzIORZK1CE+62Uq46teyovLJP/v8CawWEXo=;
        b=omrGu3aeaCibu0elyvOQz9KddUhMmkWQpQlTc5Ibzb79aHup2vScj9a0NLyKidGX/e
         YS7EwP0N9TYH/qTqDGD5WqPl+t8QQLc+FCP/wuwlozVJIh1gX2nSwri/1zyNaq/tIBo7
         zNmZFNpEdKeodwdDm3TJoh5G/I8JZN9hybIL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jCoJLOYlY2NNcOmCk0sxOE0d7FxbL2F/yDwCAAqcs86KixMkRgCRTXaR2Jb1GeMvb6
         QW4h4HZPIcBPN5qaz1ItbGU9Suc0R28tsqgBOfv7gmr84VK9KD1uLIVu9qxbzZm5hL1l
         sceH12oaXTS6tAUS9sF827zarOlDS5GtMUQ1A=
Received: by 10.229.226.8 with SMTP id iu8mr1050662qcb.126.1298071075753;
        Fri, 18 Feb 2011 15:17:55 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id g28sm1889084qck.13.2011.02.18.15.17.53
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 15:17:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5EE6BB.9070507@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167233>

The example that uses "reset --merge" to bail out from a failed
cherry-pick is dangerously wrong.  For example,

	git reset --keep master
	git cherry-pick HEAD@{1};	# conflicts!
	git reset --merge ORIG_HEAD;	# let's try that again
	git cherry-pick --strategy=more-careful HEAD@{1}

would not reset the topic to the pre cherry-pick state (master) but to
whatever branch we were on before then.

The example used ORIG_HEAD by habit from aborting merges.  "git reset
--merge HEAD" is more appropriate here.

Noticed-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Piotr Krukowiecki wrote:

> I took it from Documentation/git-cherry-pick.txt, which seem
> to be wrong:

Good catch.  The manpage I was looking at was stale.

>> "git reset --merge" will remove local changes marked with "git add",
>> under the assumption that they were part of the conflict resolution
>> and thus should be cleared away.
>
> Didn't know that (one probably shouldn't merge with uncommitted/local
> changes anyway). git-reset.txt mentions it, but there's no explicit
> warning.

Care to write a patch?

>> This leaves me afraid of the following scenario:
>>
[...]
>> 	# ... two days later ...
>> 	... hack hack hack ...
>> 	... add add add ...
>> 	git commit;	# fails because of unmerged files
>> 
>> 	# whoops, forgot about that merge.
>> 	# Let's do what it says to do:
>> 	git reset --merge ORIG_HEAD
[...]
> Is it possible to recognize that you have something more than what
> was cause by the merge/cherry-pick?

I suppose it depends what you mean.  I see at least two distinct
problems to solve:

 A. "undo" facility to recover from an ugly cherry-pick

This one is what reset --merge is for.  The idea is that after
spending a little while trying to make something good out of a
mess, you say, "oh, bother, let me get back to where I started".

So in this case it really does make sense to back out any changes
you marked with "git add" after the cherry-pick, since they were
part of the messy resolution process.  If there had been any
changes registered before the cherry-pick, the cherry-pick would
have just failed without making a mess.

A patch in flight makes "git cherry-pick" print advice for this case
when it encounters conflicts (thanks!).

 B. clearing away a forgotten merge from long ago

If you had been doing work without remembering that there was
a merge in progress, the best way to recover is probably a plain
"git reset HEAD -- .".

This is a case people might be looking for advice about when reading
"git status" ("where was I?") output.

Thanks.

 Documentation/git-cherry-pick.txt |    6 +-
 t/t3404-rebase-interactive.sh     |    6 --
 t/t3510-cherry-pick-doc.sh        |  137 +++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                     |    9 +++
 4 files changed, 149 insertions(+), 9 deletions(-)
 create mode 100755 t/t3510-cherry-pick-doc.sh

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 749d68a..abedcb7 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -137,7 +137,7 @@ again, this time exercising more care about matching up context lines.
 ------------
 $ git cherry-pick topic^             <1>
 $ git diff                           <2>
-$ git reset --merge ORIG_HEAD        <3>
+$ git reset --merge HEAD             <3>
 $ git cherry-pick -Xpatience topic^  <4>
 ------------
 <1> apply the change that would be shown by `git show topic^`.
@@ -146,8 +146,8 @@ information about the conflict is written to the index and
 working tree and no new commit results.
 <2> summarize changes to be reconciled
 <3> cancel the cherry-pick.  In other words, return to the
-pre-cherry-pick state, preserving any local modifications you had in
-the working tree.
+pre-cherry-pick state, preserving any local modifications you have
+in the working tree.
 <4> try to apply the change introduced by `topic^` again,
 spending extra time to avoid mistakes based on incorrectly matching
 context lines.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d8147b..88f1192 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -29,12 +29,6 @@ Initial setup:
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
-}
-
 set_fake_editor
 
 # WARNING: Modifications to the initial repository can change the SHA ID used
diff --git a/t/t3510-cherry-pick-doc.sh b/t/t3510-cherry-pick-doc.sh
new file mode 100755
index 0000000..e645caa
--- /dev/null
+++ b/t/t3510-cherry-pick-doc.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='examples from git-cherry-pick(1)
+
+Check that what the manual claims is still true.
+
+  -
+  + seven [next]
+  + six
+  + five [master]
+  + four
+  + three
+  + two (modifies one.t)
+  + one
+  + initial
+'
+. ./test-lib.sh
+
+check_log () {
+	git rev-list "$2" |
+	git diff-tree -r --root --stdin |
+	sed -e "s/$_x40/OBJID/g" >actual.log &&
+	test_cmp "$1" actual.log
+}
+
+test_expect_success setup '
+	GIT_EDITOR=false &&
+	export GIT_EDITOR &&
+
+	test_commit initial &&
+	test_commit one &&
+	test_commit two one.t &&
+	test_commit three &&
+	test_commit four &&
+	test_commit five &&
+	git checkout -b next &&
+	test_commit six &&
+	test_commit seven &&
+	git checkout -b topic initial
+'
+
+test_expect_success 'cherry-pick tip of branch' '
+	cat >expect.log <<-\EOF &&
+	OBJID
+	:000000 100644 OBJID OBJID A	five.t
+	EOF
+	git reset --hard initial &&
+	git cherry-pick master &&
+	check_log expect.log initial..topic
+'
+
+test_expect_success 'cherry-pick to catch up' '
+	cat >expect.log <<-\EOF &&
+	OBJID
+	:000000 100644 OBJID OBJID A	five.t
+	OBJID
+	:000000 100644 OBJID OBJID A	four.t
+	OBJID
+	:000000 100644 OBJID OBJID A	three.t
+	OBJID
+	:100644 100644 OBJID OBJID M	one.t
+	OBJID
+	:000000 100644 OBJID OBJID A	one.t
+	EOF
+	git reset --hard initial &&
+	git cherry-pick ..master &&
+	check_log expect.log initial..topic &&
+
+	git reset --hard initial &&
+	git cherry-pick ^HEAD master &&
+	check_log expect.log initial..topic
+'
+
+test_expect_success 'cherry-pick selected changes' '
+	cat >expect.log <<-\EOF &&
+	OBJID
+	:000000 100644 OBJID OBJID A	three.t
+	OBJID
+	:000000 100644 OBJID OBJID A	one.t
+	EOF
+	git reset --hard initial &&
+	git cherry-pick master~4 master~2 &&
+	check_log expect.log initial..topic
+'
+
+test_expect_success 'cherry-pick --no-commit' '
+	>expect.log &&
+	cat >expect.after-commit <<-\EOF &&
+	OBJID
+	:000000 100644 OBJID OBJID A	four.t
+	:000000 100644 OBJID OBJID A	seven.t
+	EOF
+	git reset --hard initial &&
+	git cherry-pick -n master~1 next &&
+	check_log expect.log initial..topic &&
+	test_must_fail git commit &&
+	git commit -m "squashed patches" &&
+	check_log expect.after-commit initial..topic
+'
+
+test_expect_success 'cherry-pick --ff' '
+	git reset --hard initial &&
+	git cherry-pick --ff ..next &&
+	test_cmp_rev next topic
+'
+
+test_expect_success 'cherry-pick --no-commit --stdin' '
+	git reset --hard initial &&
+	git rev-list --reverse master -- one.t |
+	git cherry-pick -n --stdin &&
+
+	test_cmp_rev initial topic &&
+	git diff-index --cached --exit-code master -- one.t &&
+	git rm -f one.t &&
+	git diff-index --cached --exit-code initial
+'
+
+test_expect_success 'cherry-pick -Xignore-all-space' '
+	git reset --hard one &&
+	test_commit one-with-whitespace one.t "   one   " &&
+
+	test_must_fail git cherry-pick three^ &&
+	git diff >conflict-desc &&
+	grep "[+][+]<<<" conflict-desc &&
+
+	echo modified >initial.t &&
+	git reset --merge HEAD &&
+	test_cmp_rev one-with-whitespace topic &&
+	test_must_fail git diff --exit-code HEAD &&
+	echo initial >initial.t &&
+	git diff --exit-code HEAD &&
+
+	git cherry-pick -Xignore-all-space three^ &&
+	git diff --exit-code two topic
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..0c053b3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -673,6 +673,15 @@ test_line_count () {
 	fi
 }
 
+# test_cmp_rev checks that two revision specifiers refer to the
+# same object.  Uses expect.rev and actual.rev files in the
+# current directory as scratch space.
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
-- 
1.7.4.1
