From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Improve robustness of putty detection
Date: Sun, 26 Apr 2015 15:04:56 -0700
Message-ID: <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
	<1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Apr 27 00:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmUfn-0002SV-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 00:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbbDZWFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 18:05:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751214AbbDZWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 18:04:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBDF34C10E;
	Sun, 26 Apr 2015 18:04:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rYeZ3sx9kjt8qAysdHRvWtl47I4=; b=vtqrdD
	erCTmbsCuclvzqnuPfNpc2vn91a/cVW5M1zVMiHllyaeNVoDmRPM6716lbS94rRS
	1ixqNMJhBLDEt2UW4XVCzmZPhz1R6D++Yo3vRX6SboGEHlE9pwXZXpj2nKOkTEhf
	9wkmPN710bAzJ4/lSnWN4ur0c6IXZDiadYUb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LvIq+VabFkj6iF4fRptsfVJMwW8un6Ps
	wxkZFC1n/OLFv7bLPZEFjcctY++HQaMDxw3KSACTy5TFQG6nCOnFwhPiHs5JCib7
	rtrcxe4IrNm4zljiEHBad40qp7Bt5oWcqJXlmoMscW++DWHNxUp/dxC/OJp68LNP
	Wfmk+NbaaPY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C49244C10B;
	Sun, 26 Apr 2015 18:04:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49C054C10A;
	Sun, 26 Apr 2015 18:04:57 -0400 (EDT)
In-Reply-To: <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 26 Apr 2015 20:30:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46964532-EC60-11E4-8652-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267841>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> While I was adding tests, I noticed that we had a broken test due to the
> use of single quotes within a test, which resulted in the test always
> being skipped.

Good eyes.  While fixing the test is necessary, we should also be
able to improve the test framework to prevent such mistakes at the
same time.

ok 38 # skip
        git clone "[myhost:123]:src" ssh-bracket-clone &&
        expect_ssh myhost -p (missing bracketed hostnames are still
        ssh)

The test scripts are expected to take either 3 or 4 parameters, and
the extra parameter when it takes 4 is the comma separated list of
prerequisites.  "bracketed hostnames are still ssh" does not look
like prerequisites at all to us humans, and the framework should
also be able to notice that and barf, I would think.

Perhaps something like this?

 t/test-lib-functions.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0698ce7..0e4f2a6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -348,11 +348,18 @@ test_declared_prereq () {
 	return 1
 }
 
+test_verify_prereq () {
+	test -z "$test_prereq" ||
+	expr >/dev/null "$test_prereq" : '^[A-Z0-9_,!]*$' ||
+	error "bug in the test script: '$test_prereq' does not look like a prereq"
+}
+
 test_expect_failure () {
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
+	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
 	then
@@ -372,6 +379,7 @@ test_expect_success () {
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$@"
 	then
@@ -400,6 +408,7 @@ test_external () {
 	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
 	descr="$1"
 	shift
+	test_verify_prereq
 	export test_prereq
 	if ! test_skip "$descr" "$@"
 	then
