From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] test: skip clean-up when running under --immediate mode
Date: Mon, 27 Jun 2011 11:02:22 -0700
Message-ID: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 20:02:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbG8p-0004X4-DI
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab1F0SC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 14:02:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab1F0SCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1940966AF;
	Mon, 27 Jun 2011 14:04:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	/tf9sGNx/93tnDQBUMxuS2DzTw=; b=iaw5jn1TUjh04PqAEqtMIpYphHxxKre6i
	GVfrwTDH3aJ8cZVGRxBt1UEBTLxT//8qiuz5aNkBMmeVBbEVCU6Fzene72xpDIRf
	soDEno/OgbqQiWON66nhFQ1Pls8SnLXYrGLss6JZzxl+3YeeAc1WU0R6+o0q5UnG
	kJrx73AYOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rPi
	EHKX9O1S/bVMlz6cQFrQx29ypuMgZQo0pPaQdMUvv2u+xYfRVvsnn+XDeubgSVSt
	AFFrWHx+/q/WhPkM6pMp1e7vKr1Mh9sSu1NOhaywHWW2LhpJhcb5Ut2deHMHbFxf
	w/of9KXte+KTpdvDjYGSjRoFWqNvKyIzqoDfwSNI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12A4766AE;
	Mon, 27 Jun 2011 14:04:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5472266AD; Mon, 27 Jun 2011
 14:04:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA843A6E-A0E7-11E0-B75C-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176357>

Some tests try to be too careful about cleaning themselves up and
do

    test_expect_success description '
        set-up some test refs and/or configuration &&
        test_when_finished "revert the above changes" &&
	the real test
    '

Which is nice to make sure that a potential failure would not have
unexpected interaction with the next test. This however interferes when
"the real test" fails and we want to see what is going on, by running the
test with --immediate mode and descending into its trash directory after
the test stops. The precondition to run the real test and cause it to fail
is all gone after the clean-up procedure defined by test_when_finished is
done.

Update test_run_ which is the workhorse of running a test script
called from test_expect_success and test_expect_failure, so that we do not
run clean-up script defined with test_when_finished when a test that is
expected to succeed fails under the --immediate mode.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Likes, dislikes?

 t/test-lib.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8c57a00..e36e67a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -446,9 +446,14 @@ test_debug () {
 
 test_run_ () {
 	test_cleanup=:
+	expecting_failure=$1
 	eval >&3 2>&4 "$1"
 	eval_ret=$?
-	eval >&3 2>&4 "$test_cleanup"
+
+	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
+	then
+		eval >&3 2>&4 "$test_cleanup"
+	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
 		echo ""
 	fi
@@ -497,7 +502,7 @@ test_expect_failure () {
 	if ! test_skip "$@"
 	then
 		say >&3 "checking known breakage: $2"
-		test_run_ "$2"
+		test_run_ "$2" expecting_failure
 		if [ "$?" = 0 -a "$eval_ret" = 0 ]
 		then
 			test_known_broken_ok_ "$1"
@@ -774,6 +779,9 @@ test_cmp() {
 #
 # except that the greeting and config --unset must both succeed for
 # the test to pass.
+#
+# Note that under --immediate mode, no clean-up is done to help diagnose
+# what went wrong.
 
 test_when_finished () {
 	test_cleanup="{ $*
-- 
1.7.6
