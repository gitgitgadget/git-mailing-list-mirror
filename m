From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 2/2] test: allow prerequisite to be evaluated lazily
Date: Thu, 26 Jul 2012 16:11:00 -0700
Message-ID: <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 01:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuXD4-0004xG-20
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 01:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab2GZXLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 19:11:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab2GZXLC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 19:11:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56A288A85;
	Thu, 26 Jul 2012 19:11:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TRWPyTRoC4uzy8z2tTlRyZNVLiQ=; b=AY5DM3
	thnnsiE1iJvv1YAQlKyIJt05ZwuZ/7+Rl+AkTygFemztMTDxTFVe+X0rv/OndSW0
	zYgRd6PyaAraQypjDPWR+k6xvD66tQDzKV+aZbAP6wkWi7kydmUG4gT2q/BEi499
	TtpLOFhZeknwv0oWsJKpn8NVRg64enIQmIk7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsHPHXmyOv+NnsJfLqFfrWEqrf80Wzod
	3wTzXi5MBucdvu8Ryhs5nk91qUOthbo3/o6SZ1T4EOD5W+zC07UyypPmWFgzLPBR
	TvpCsawoUgVnDUhNaK1V8xrQyTiVHaFYcv//tPSXKbFAzOduGWZqFRGPS+NkQdy+
	20oEZIi12xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435628A84;
	Thu, 26 Jul 2012 19:11:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F18F8A83; Thu, 26 Jul 2012
 19:11:01 -0400 (EDT)
In-Reply-To: <7vboj25dk7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jul 2012 16:04:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AA90162-D777-11E1-8565-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202314>

The test prerequisite mechanism is a useful way to allow some tests
in a test script to be skipped in environments that do not offer
certain features (e.g. checking how symbolic links are handled on
filesystems that do not support them).  It is OK for commonly used
prerequisites to be always tested during start-up of test script by
having a codeblock that tests a feature and calls test_set_prereq,
but for an uncommon feature, forcing 90% of scripts to pay the same
probing overhead for prerequisite they do not care about is wasteful.

Introduce a mechanism to probe the prerequiste lazily.  Changes are:

 - test_lazy_prereq () function, which takes the name of the
   prerequisite it probes and the script to probe for it, is
   added.  This only registers the name of the prerequiste that can
   be lazily probed and the script to eval (without running).

 - test_have_prereq() function (which is used by test_expect_success
   and also can be called directly by test scripts) learns to look
   at the list of prerequisites that can be lazily probed, and the
   prerequisites that have already been probed that way.

Update the codeblock to probe and set SYMLINKS prerequisite using
the new mechanism as an example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I thought about various error conditions but didn't come up with
   a solid conclusion.  For example, what should happen when the
   prober directory cannot be created, or removed?  Perhaps aborting
   the whole thing may be a safe and better option.

   Also, I am not distinguishing a syntax error in the script and
   "the prerequisite is not satisfied" signal (they would both be a
   false in the "if ()" part). I do not think we care too much, but
   others may have better ideas.

 t/test-lib-functions.sh | 28 ++++++++++++++++++++++++++++
 t/test-lib.sh           |  7 ++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4dc027d..2214388 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -224,6 +224,13 @@ test_set_prereq () {
 	satisfied_prereq="$satisfied_prereq$1 "
 }
 satisfied_prereq=" "
+lazy_testable_prereq= lazy_tested_prereq=
+
+# Usage: test_lazy_prereq PREREQ 'script'
+test_lazy_prereq () {
+	lazy_testable_prereq="$lazy_testable_prereq$1 "
+	eval test_prereq_lazily_$1=\$2
+}
 
 test_have_prereq () {
 	# prerequisites can be concatenated with ','
@@ -238,6 +245,27 @@ test_have_prereq () {
 
 	for prerequisite
 	do
+		case " $lazy_tested_prereq " in
+		*" $prerequisite "*)
+			;;
+		*)
+			case " $lazy_testable_prereq " in
+			*" $prerequisite "*)
+				mkdir -p "$TRASH_DIRECTORY/prereq-test-dir"
+				if (
+					eval "script=\$test_prereq_lazily_$prerequisite" &&
+					cd "$TRASH_DIRECTORY/prereq-test-dir" &&
+					eval "$script"
+				)
+				then
+					test_set_prereq $prerequisite
+				fi
+				rm -fr "$TRASH_DIRECTORY/prereq-test-dir"
+				lazy_tested_prereq="$lazy_tested_prereq$prerequisite "
+			esac
+			;;
+		esac
+
 		total_prereq=$(($total_prereq + 1))
 		case "$satisfied_prereq" in
 		*" $prerequisite "*)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb4f886..878d000 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -659,9 +659,10 @@ test_i18ngrep () {
 	fi
 }
 
-# test whether the filesystem supports symbolic links
-ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
-rm -f y
+test_lazy_prereq SYMLINKS '
+	# test whether the filesystem supports symbolic links
+	ln -s x y 2>/dev/null && test -h y 2>/dev/null
+'
 
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
-- 
1.7.12.rc0.44.gc69a8ad
