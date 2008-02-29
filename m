From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when not
 running verbosely
Date: Fri, 29 Feb 2008 15:50:03 -0800
Message-ID: <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org>
References: <1204323805-23185-1-git-send-email-mh@glandium.org>
 <alpine.LSU.1.00.0802292334040.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVF0G-0000Bt-9N
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbYB2XuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbYB2XuX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:50:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbYB2XuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:50:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0914A349B;
	Fri, 29 Feb 2008 18:50:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A5A3B3496; Fri, 29 Feb 2008 18:50:11 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802292334040.22527@racer.site> (Johannes
 Schindelin's message of "Fri, 29 Feb 2008 23:34:41 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75593>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 29 Feb 2008, Mike Hommey wrote:
>
>> diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
>> index 149ea85..43b5f15 100755
>> --- a/t/t6024-recursive-merge.sh
>> +++ b/t/t6024-recursive-merge.sh
>> @@ -81,7 +81,7 @@ EOF
>>  
>>  test_expect_success "virtual trees were processed" "git diff expect out"
>>  
>> -git reset --hard
>> +git reset --hard >&3 2>&4
>>  test_expect_success 'refuse to merge binary files' '
>
> Would it not be _much_ more sensible to pull that command _into_ the 
> test_expect_success?

Actually, I think this might be a bit more sensible approach.

-- >8 --
tests: allow optional clean-up phrase to expect_success/failure

When one test modifies the state of the test repository that the later
tests may depend on, you may want to add a clean-up action that is run
regardless of the outcome of the main part of the test.

This can now be specified as the third parameter to test_expect_success
and test_expect_failure functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/README                   |   13 +++++++++++--
 t/t6024-recursive-merge.sh |    5 +++--
 t/test-lib.sh              |   32 ++++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/t/README b/t/README
index 73ed11b..de79c00 100644
--- a/t/README
+++ b/t/README
@@ -146,7 +146,7 @@ Test harness library
 There are a handful helper functions defined in the test harness
 library for your script to use.
 
- - test_expect_success <message> <script>
+ - test_expect_success <message> <script> [<cleanup>]
 
    This takes two strings as parameter, and evaluates the
    <script>.  If it yields success, test is considered
@@ -158,7 +158,12 @@ library for your script to use.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
- - test_expect_failure <message> <script>
+   An optional <cleanup> is executed and can be used to clean-up
+   the state this test modifies (or leaves half-modified when it
+   fails).  The clean-up script is not run if test fails and the
+   test script is run under --immediate mode to help postmortem.
+
+ - test_expect_failure <message> <script> [<cleanup>]
 
    This is NOT the opposite of test_expect_success, but is used
    to mark a test that demonstrates a known breakage.  Unlike
@@ -167,6 +172,10 @@ library for your script to use.
    success and "still broken" on failure.  Failures from these
    tests won't cause -i (immediate) to stop.
 
+   An optional <cleanup> is executed and can be used to clean-up
+   the state this test modifies (or leaves half-modified when it
+   fails).
+
  - test_debug <script>
 
    This takes a single argument, <script>, and evaluates it only
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 149ea85..ae9706f 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -79,9 +79,10 @@ cat > expect << EOF
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
 
-test_expect_success "virtual trees were processed" "git diff expect out"
+test_expect_success "virtual trees were processed" "
+	git diff expect out
+" 'git reset --hard'
 
-git reset --hard
 test_expect_success 'refuse to merge binary files' '
 	printf "\0" > binary-file &&
 	git add binary-file &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 68efda4..0fb2c98 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -220,9 +220,13 @@ test_skip () {
 }
 
 test_expect_failure () {
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 parameters to test-expect-failure"
-	if ! test_skip "$@"
+	case $# in
+	2) ;; # traditional
+	3) ;; # with clean-up
+	*)
+		error "bug in the test script" ;;
+	esac
+	if ! test_skip "$1" "$2"
 	then
 		say >&3 "checking known breakage: $2"
 		test_run_ "$2"
@@ -230,16 +234,24 @@ test_expect_failure () {
 		then
 			test_known_broken_ok_ "$1"
 		else
-		    test_known_broken_failure_ "$1"
+			test_known_broken_failure_ "$1"
+		fi
+		if test -n "$3"
+		then
+			eval >&3 2>&4 "$3"
 		fi
 	fi
 	echo >&3 ""
 }
 
 test_expect_success () {
-	test "$#" = 2 ||
-	error "bug in the test script: not 2 parameters to test-expect-success"
-	if ! test_skip "$@"
+	case $# in
+	2) ;; # traditional
+	3) ;; # with clean-up
+	*)
+		error "bug in the test script" ;;
+	esac
+	if ! test_skip "$1" "$2"
 	then
 		say >&3 "expecting success: $2"
 		test_run_ "$2"
@@ -247,7 +259,11 @@ test_expect_success () {
 		then
 			test_ok_ "$1"
 		else
-			test_failure_ "$@"
+			test_failure_ "$1" "$2"
+		fi
+		if test -n "$3"
+		then
+			eval >&3 2>&4 "$3"
 		fi
 	fi
 	echo >&3 ""
