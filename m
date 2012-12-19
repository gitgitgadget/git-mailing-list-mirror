From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] tests: optionally fail passed todo immediately
Date: Tue, 18 Dec 2012 21:38:20 -0800
Message-ID: <7vzk1abnzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 06:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlCMc-0005Zl-7W
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 06:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab2LSFiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 00:38:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab2LSFiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 00:38:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B83106DF4;
	Wed, 19 Dec 2012 00:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	mmWxLuDr7Oei4knuZIZJtcLvb0=; b=N2u4ipBGZfz9mUC9VhIRBQLuhk3VQg0vs
	tQ0epb91T4M8hmf/yJ8mxFkLHhd8qZmyWBw4ObbqMQf6jQpqLLhxRc5dL7+YBE7F
	ZWZ46mNGPhon8LTrkNYzqcdFM19DnwH+kyBCaFQEuDQVSivx/OEAFQq7ZSvLCkam
	msrZ83zIOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bez
	6uIXSOjpR7jn+Std7DSUHrOf/8WOCjtak3Hxo6q08V5Q/veJqRiVHjzBQXankQxE
	X+Xh6x4UnH5rUvTJKB2zGNpuiieNCvZieLc4l7PgWUMZfHyYW49+zs0WIYWWzDyf
	IzEfp+Z60v505LEtwSMH2nr02Fqo9kJ+VsaQ/dT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A60226DF3;
	Wed, 19 Dec 2012 00:38:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06ADE6DF2; Wed, 19 Dec 2012
 00:38:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D04A92A-499E-11E2-9195-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211804>

Add "--fail-passed-todo" option to stop the test immediately when a
test that is expected to fail succeeds.  After seeing the test stop,
the developer can go to the trash directory and inspect why it failed
to fail as expected.

I usually just insert "exit" after such test with an editor, but
an option like this might be easier to use.  I dunno.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Stopping immediately after a test that is failing (and expected
   to fail) and then going to the trash directory to inspect the
   status of the sandbox are the first two steps I often end up
   doing while fixing a bug.  It may make sense to add an option to
   cause the test to stop at a failure of test_expect_failure, but
   that is a separate topic.

 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..7b7cce6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -176,6 +176,8 @@ do
 		debug=t; shift ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t; shift ;;
+	--fail-passed-todo)
+		fail_passed_todo=t; shift ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
 		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
 	-h|--h|--he|--hel|--help)
@@ -307,6 +309,7 @@ test_failure_ () {
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
 	say_color "" "ok $test_count - $@ # TODO known breakage"
+	test "$fail_passed_todo" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
 
 test_known_broken_failure_ () {
-- 
1.8.1.rc2.196.g90926c8
