From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t5510: harden the way verify-pack is used
Date: Fri,  7 Aug 2009 20:36:32 -0700
Message-ID: <1249702594-7815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 05:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZcjc-0005zY-3g
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 05:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbZHHDgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 23:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbZHHDgf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 23:36:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbZHHDgf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 23:36:35 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBAB2D01
	for <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D9E22D00 for
 <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:35 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.151.g786db
X-Pobox-Relay-ID: AC916270-83CC-11DE-A070-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125240>

The test ignored the exit status from verify pack command, and also relied
on not seeing any delta chain statistics.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5510-fetch.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index bee3424..d13c806 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -9,6 +9,11 @@ test_description='Per branch config variables affects "git fetch".
 
 D=`pwd`
 
+test_bundle_object_count () {
+	git verify-pack -v "$1" >verify.out &&
+	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | wc -l)
+}
+
 test_expect_success setup '
 	echo >file original &&
 	git add file &&
@@ -146,6 +151,7 @@ test_expect_success 'unbundle 1' '
 	test_must_fail git fetch "$D/bundle1" master:master
 '
 
+
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
 	(
@@ -156,8 +162,7 @@ test_expect_success 'bundle 1 has only 3 files ' '
 		cat
 	) <bundle1 >bundle.pack &&
 	git index-pack bundle.pack &&
-	verify=$(git verify-pack -v bundle.pack) &&
-	test 4 = $(echo "$verify" | wc -l)
+	test_bundle_object_count bundle.pack 3
 '
 
 test_expect_success 'unbundle 2' '
@@ -180,7 +185,7 @@ test_expect_success 'bundle does not prerequisite objects' '
 		cat
 	) <bundle3 >bundle.pack &&
 	git index-pack bundle.pack &&
-	test 4 = $(git verify-pack -v bundle.pack | wc -l)
+	test_bundle_object_count bundle.pack 3
 '
 
 test_expect_success 'bundle should be able to create a full history' '
-- 
1.6.4.151.g786db
