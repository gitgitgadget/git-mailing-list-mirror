From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9301-fast-export: move unset of config variable into
 its own test function
Date: Fri, 22 Aug 2008 01:23:39 -0700
Message-ID: <7v7ia9bgqc.fsf@gitster.siamese.dyndns.org>
References: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
 <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil> <7vbpzlbgyl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRwx-0005mh-9m
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYHVIXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYHVIXq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:23:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYHVIXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:23:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38CFB67333;
	Fri, 22 Aug 2008 04:23:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4CB5D67332; Fri, 22 Aug 2008 04:23:41 -0400 (EDT)
In-Reply-To: <7vbpzlbgyl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 22 Aug 2008 01:18:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A26CFFBA-7023-11DD-ABF7-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93273>

Junio C Hamano <gitster@pobox.com> writes:

> For this particular case, what we are interested in testing is not that
> "config --unset" exits with 0 status.  We are however interested in making
> sure that i18n.commitencoding is not set when the body of #12 runs.
>
> So I think a more appropriate change would be something like this for this
> particular case.

Having said that, we may want to have an easier way to exclude certain
classes of pieces, and also encourage test writers to group pieces that
are related to these classes together.

For example, this introduces a new environment you can set,
GIT_SKIP_TEST_CLASS, which is a space separated list of classes of
features that you would want to exclude from the test.
test_expect_success/failure can now take an optional "class token" as the
first parameter (they traditionally took only two parameters, but with
class token, they take three).

This example defines I18N class, and lets you exclude the one you were
manually excluding with "GIT_SKIP_TESTS=t9301.4"


 t/t9301-fast-export.sh |    2 +-
 t/test-lib.sh          |   50 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git i/t/t9301-fast-export.sh w/t/t9301-fast-export.sh
index 2ce2aff..361e8dc 100755
--- i/t/t9301-fast-export.sh
+++ w/t/t9301-fast-export.sh
@@ -63,7 +63,7 @@ test_expect_success 'fast-export master~2..master' '
 
 '
 
-test_expect_success 'iso-8859-1' '
+test_expect_success I18N 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO-8859-1 &&
 	# use author and committer name in ISO-8859-1 to match it.
diff --git i/t/test-lib.sh w/t/test-lib.sh
index e2b106c..88d6d50 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -232,22 +232,44 @@ test_run_ () {
 	return 0
 }
 
+# space sparated list of skippable test classes
+GIT_SKIPPABLE_TEST_CLASSES='I18N'
+
 test_skip () {
 	this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
 	this_test="$this_test.$(expr "$test_count" + 1)"
+
 	to_skip=
-	for skp in $GIT_SKIP_TESTS
-	do
-		case "$this_test" in
-		$skp)
+	if test -n "$test_class"
+	then
+		case " $GIT_SKIPPABLE_TEST_CLASSES " in
+		*" $test_class "*) ;; # ok
+		*)
+			say_color error "'$test_class' is not a skippable test class"
+			error "Skippable are $GIT_SKIPPABLE_TEST_CLASSES"
+		esac
+		case " $GIT_SKIP_TEST_CLASS " in
+		*" $test_class "*)
 			to_skip=t
+			test_class="($test_class) "
 		esac
-	done
+	fi
+	if test -z "$to_skip"
+	then
+		for skp in $GIT_SKIP_TESTS
+		do
+			case "$this_test" in
+			$skp)
+				to_skip=t
+				break
+			esac
+		done
+	fi
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
 		test_count=$(expr "$test_count" + 1)
-		say_color skip "skip $test_count: $1"
+		say_color skip "skip $test_count: $test_class$1"
 		: true
 		;;
 	*)
@@ -257,6 +279,10 @@ test_skip () {
 }
 
 test_expect_failure () {
+	case $# in
+	2)	test_class= ;;
+	3)	test_class=$1; shift ;;
+	esac
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-failure"
 	if ! test_skip "$@"
@@ -274,6 +300,10 @@ test_expect_failure () {
 }
 
 test_expect_success () {
+	case $# in
+	2)	test_class= ;;
+	3)	test_class=$1; shift ;;
+	esac
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-success"
 	if ! test_skip "$@"
@@ -291,6 +321,10 @@ test_expect_success () {
 }
 
 test_expect_code () {
+	case $# in
+	3)	test_class= ;;
+	4)	test_class=$1; shift ;;
+	esac
 	test "$#" = 3 ||
 	error "bug in the test script: not 3 parameters to test-expect-code"
 	if ! test_skip "$@"
@@ -316,6 +350,10 @@ test_expect_code () {
 # Usage: test_external description command arguments...
 # Example: test_external 'Perl API' perl ../path/to/test.pl
 test_external () {
+	case $# in
+	3)	test_class= ;;
+	4)	test_class=$1; shift ;;
+	esac
 	test "$#" -eq 3 ||
 	error >&5 "bug in the test script: not 3 parameters to test_external"
 	descr="$1"
