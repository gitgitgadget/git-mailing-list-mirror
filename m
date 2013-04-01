From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t6200: use test_config/test_unconfig
Date: Mon,  1 Apr 2013 12:57:18 -0700
Message-ID: <1364846239-8802-3-git-send-email-gitster@pobox.com>
References: <7v7gl3jmx0.fsf_-_@alter.siamese.dyndns.org>
 <1364846239-8802-1-git-send-email-gitster@pobox.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 21:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMkrb-0000PA-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 21:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759465Ab3DAT51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 15:57:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759518Ab3DAT5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 15:57:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9F511061;
	Mon,  1 Apr 2013 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yudt
	A5tCxE8NVRoWUs5EdoRhxRY=; b=iY+726pv0liGAGVUVdcDzLpuSufGAH70HhnI
	XlU4QvizlXwF1ueqHCG9q+fyZbVXYOw//f2gLdB7EGGJlLyEqRqT87Bz9Z/1i0fp
	24FxxgmNp4NmYMyuSFQPPlh3z9uVkDWyeUefP+UQa5c1Y7rT33sDzWiCDbS+pn9X
	L2BGEzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	E8JC293c80LPuRbtS/pjOUWCSckyUJYRmbPd3O/nOZx6wyQ2pNVfe7eSQD6O31uY
	SLrP7i9GC18LTzBpSyz6xwOQ1AmONC9nRk1nb7EIF644J+jZLviWI27bgLMl2ng2
	SxQ1cn+SC2zE7BH711z4PcKee0Jo1ynWCDmo4xHNRhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F1EB11060;
	Mon,  1 Apr 2013 19:57:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 953921105F; Mon,  1 Apr
 2013 19:57:24 +0000 (UTC)
X-Mailer: git-send-email 1.8.2-480-g064f421
In-Reply-To: <1364846239-8802-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5F571D7E-9B06-11E2-9E6E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219703>

The tests were already well protected from previous ones by running
"git config --unset" on variables early they do not want to see, but
it is easier to make sure they start from a clean state by using
more modern test_config/test_unconfig helper functions.

It turns out that the last test depended on the merge.summary
configuration previous one leaves behind.  Set it explicitly in it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6200-fmt-merge-msg.sh | 61 +++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 992c2a0..f84bb0c 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -112,8 +112,8 @@ test_expect_success '[merge] summary/log configuration' '
 	  Common #1
 	EOF
 
-	git config merge.log true &&
-	test_might_fail git config --unset-all merge.summary &&
+	test_config merge.log true &&
+	test_unconfig merge.summary &&
 
 	git checkout master &&
 	test_tick &&
@@ -121,8 +121,8 @@ test_expect_success '[merge] summary/log configuration' '
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary true &&
+	test_unconfig merge.log &&
+	test_config merge.summary true &&
 
 	git checkout master &&
 	test_tick &&
@@ -134,11 +134,6 @@ test_expect_success '[merge] summary/log configuration' '
 	test_cmp expected actual2
 '
 
-test_expect_success 'setup: clear [merge] configuration' '
-	test_might_fail git config --unset-all merge.log &&
-	test_might_fail git config --unset-all merge.summary
-'
-
 test_expect_success 'setup FETCH_HEAD' '
 	git checkout master &&
 	test_tick &&
@@ -248,14 +243,14 @@ test_expect_success 'fmt-merge-msg -m' '
 	  Common #1
 	EOF
 
-	test_might_fail git config --unset merge.log &&
-	test_might_fail git config --unset merge.summary &&
+	test_unconfig merge.log &&
+	test_unconfig merge.summary &&
 	git checkout master &&
 	git fetch "$(pwd)" left &&
 	git fmt-merge-msg -m "Sync with left" <.git/FETCH_HEAD >actual &&
 	git fmt-merge-msg --log -m "Sync with left" \
 					<.git/FETCH_HEAD >actual.log &&
-	git config merge.log true &&
+	test_config merge.log true &&
 	git fmt-merge-msg -m "Sync with left" \
 					<.git/FETCH_HEAD >actual.log-config &&
 	git fmt-merge-msg --no-log -m "Sync with left" \
@@ -290,29 +285,29 @@ test_expect_success 'setup: expected shortlog for two branches' '
 '
 
 test_expect_success 'shortlog for two branches' '
-	git config merge.log true &&
-	test_might_fail git config --unset-all merge.summary &&
+	test_config merge.log true &&
+	test_unconfig merge.summary &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary true &&
+	test_unconfig merge.log &&
+	test_config merge.summary true &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual2 &&
 
-	git config merge.log yes &&
-	test_might_fail git config --unset-all merge.summary &&
+	test_config merge.log yes &&
+	test_unconfig merge.summary &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual3 &&
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
@@ -325,8 +320,8 @@ test_expect_success 'shortlog for two branches' '
 '
 
 test_expect_success 'merge-msg -F' '
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
@@ -335,8 +330,8 @@ test_expect_success 'merge-msg -F' '
 '
 
 test_expect_success 'merge-msg -F in subdirectory' '
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
@@ -350,8 +345,8 @@ test_expect_success 'merge-msg -F in subdirectory' '
 '
 
 test_expect_success 'merge-msg with nothing to merge' '
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 
 	>empty &&
 
@@ -376,8 +371,8 @@ test_expect_success 'merge-msg tag' '
 	  Common #1
 	EOF
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 
 	git checkout master &&
 	test_tick &&
@@ -406,8 +401,8 @@ test_expect_success 'merge-msg two tags' '
 	  Common #1
 	EOF
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 
 	git checkout master &&
 	test_tick &&
@@ -436,8 +431,8 @@ test_expect_success 'merge-msg tag and branch' '
 	  Common #1
 	EOF
 
-	test_might_fail git config --unset-all merge.log &&
-	git config merge.summary yes &&
+	test_unconfig merge.log &&
+	test_config merge.summary yes &&
 
 	git checkout master &&
 	test_tick &&
@@ -464,6 +459,8 @@ test_expect_success 'merge-msg lots of commits' '
 		echo "  ..."
 	} >expected &&
 
+	test_config merge.summary yes &&
+
 	git checkout master &&
 	test_tick &&
 	git fetch . long &&
-- 
1.8.2-480-g064f421
