From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Tue, 10 Aug 2010 20:57:09 +0000
Message-ID: <1281473829-2102-1-git-send-email-avarab@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 22:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oivt1-0004HD-Qt
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 22:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab0HJU5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 16:57:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56681 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757718Ab0HJU5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 16:57:17 -0400
Received: by wyb32 with SMTP id 32so1154633wyb.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WIiHpMfp1hPTmu791WQ5eVX1ymMuFFKnrES/zvm/FDc=;
        b=Gzu4Ruw3YHVNJ+Drh2urcVrgl89MKkwgC86cwnZIEMdC/fPg1DiKNrpKsjuT30aN5F
         j180gVB7NgWjuBjmSkZ8eBU5gDANCnynyTeHz8oWdtXSWXh20I3c/6KHqiMEa+FBLMu3
         VmUQXPYbTCwQe4ZJjNy6lPOjU+dAU6cFOBaBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=snkkNBy+6nWhWx/klmg2S+Jx2j0nWigTrmoO8CNizx8EMvIDHw66BB0vqAxmmWZu/9
         LkbyxAeY6G/8U6ft+kz46hiB4dype8eJSMqYFasfhD7J3CYFEUJ9FMTxRug2ij6L5qKn
         tEO9knEFTlRyq9JfRt+5V37XXLf3kaQ6VpVbM=
Received: by 10.216.11.129 with SMTP id 1mr4402352wex.90.1281473835377;
        Tue, 10 Aug 2010 13:57:15 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p42sm3658610weq.36.2010.08.10.13.57.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 13:57:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153157>

It can be a PITA to debug Git's tests. They're a maze of chained &&'s,
and if one bit fails it can be hard to find out what that bit is.

As I mentioned in the comments for the "user friendly alterantives to
-d -f.." series we could do this with TAP subtests:

    $ perl -MTest::More=no_plan -E '
       subtest "A git test" => sub {
           pass("doing test -f file");
           pass("git commit ...");
           pass("test_tick...");
           done_testing();
       } for 1 .. 2
   '
       ok 1 - doing test -f file
       ok 2 - git commit ...
       ok 3 - test_tick...
       1..3
   ok 1 - A git test
       ok 1 - doing test -f file
       ok 2 - git commit ...
       ok 3 - test_tick...
       1..3
   ok 2 - A git test
   1..2

Here's an attempt at that, I've convented test_commit, test_merge and
test_cmp to report intra-test progress. The only problem is that it
doesn't quite work.

It works lik this:

    $ ./t0100-previous.sh  --verbose 2>&1 | ack '(?:^\s*ok|^\s*not ok|\d\.\.\d)'
        ok 1 - test_commit file:<A.t> message:<A> contents<A>
        1..1
    ok 1 - branch -d @{-1}
    ok 2 - branch -d @{-12} when there is not enough switches yet
        ok 3 - test_commit file:<B.t> message:<B> contents<B>
        ok 3 - test_commit file:<C.t> message:<C> contents<C>
        1..2
    ok 3 - merge @{-1}
    ok 4 - merge @{-1} when there is not enough switches yet
    1..4

But the problem is that the subtest code is evaluated in the context of the test itself:

	eval >&3 2>&4 "$1"

So when you run it you'll just get:

    $ ./t0100-previous.sh
        1..1
    ok 1 - branch -d @{-1}
    ok 2 - branch -d @{-12} when there is not enough switches yet
        1..2
    ok 3 - merge @{-1}
    ok 4 - merge @{-1} when there is not enough switches yet
    # passed all 4 test(s)
    1..4

Is there some filedescriptor saving/redirection magic I can do within
the subtest code to print things to the *real* stdout and stderr, not
the new file descriptors Git has aliased stdout/stderr to in the eval?

Another way to to it would be to buffer up the subtest output in a
shell variable and spew it out all at once when the whole test
finishes, but then it would be out of context with the --verbose
output, and it'd be ugly.
---
 t/test-lib.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e73fff..2380cb9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -208,6 +208,11 @@ test_success=0
 
 test_external_has_tap=0
 
+# subtest state
+in_subtest=
+subtest_count=0
+tap_prefix=
+
 die () {
 	code=$?
 	if test -n "$GIT_EXIT_OK"
@@ -290,20 +295,38 @@ test_tick () {
 
 test_commit () {
 	file=${2:-"$1.t"}
-	echo "${3-$1}" > "$file" &&
-	git add "$file" &&
-	test_tick &&
-	git commit -m "$1" &&
-	git tag "$1"
+	subtest_count=$(($subtest_count + 1))
+
+	if echo "${3-$1}" > "$file" &&
+		git add "$file" &&
+		test_tick &&
+		git commit -m "$1" &&
+		git tag "$1"
+	then
+		test_ok_ "test_commit file:<$file> message:<$1> contents<${3-$1}>"
+		true
+	else
+		test_failure_ "test_commit file:<$file> message:<$1> contents<${3-$1}>"
+		true
+	fi
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
 # can be a tag pointing to the commit-to-merge.
 
 test_merge () {
-	test_tick &&
-	git merge -m "$1" "$2" &&
-	git tag "$1"
+
+	subtest_count=$(($subtest_count + 1))
+	if test_tick &&
+		git merge -m "$1" "$2" &&
+		git tag "$1"
+	then
+		test_ok_ "test_merge: file<$2> message<$1> tag:<$1>"
+		true
+	else
+		test_failure_ "test_merge: file<$2> message<$1> tag:<$1>"
+		false
+	fi
 }
 
 # This function helps systems where core.filemode=false is set.
@@ -353,7 +376,7 @@ test_have_prereq () {
 
 test_ok_ () {
 	test_success=$(($test_success + 1))
-	say_color "" "ok $test_count - $@"
+	say_color "" "${tap_prefix}ok $test_count - $@"
 }
 
 test_failure_ () {
@@ -380,9 +403,25 @@ test_debug () {
 
 test_run_ () {
 	test_cleanup=:
+
+	# Run the test in a subtest scope
+	in_subtest=1
+	subtest_count=0
+	tap_prefix='    '
 	eval >&3 2>&4 "$1"
+	in_subtest=
+
 	eval_ret=$?
 	eval >&3 2>&4 "$test_cleanup"
+
+	# Report the subtest plan
+	if test $subtest_count -gt 0
+	then
+		say "${tap_prefix}1..$subtest_count"
+		subtest_count=0
+	fi
+	tap_prefix=
+
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
@@ -602,6 +641,15 @@ test_might_fail () {
 
 test_cmp() {
 	$GIT_TEST_CMP "$@"
+	subtest_count=$(($subtest_count + 1))
+	if test "$?" = 0
+	then
+		test_ok_ "test_cmp '$@'"
+		true
+	else
+		test_failure_ "test_cmp '$@'"
+		false
+	fi
 }
 
 # This function can be used to schedule some commands to be run
-- 
1.7.2.1.295.gd03d
