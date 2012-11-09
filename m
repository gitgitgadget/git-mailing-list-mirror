From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 4/4] Add tests for git-status --sequencer
Date: Fri,  9 Nov 2012 13:56:25 -0500
Message-ID: <1352487385-5929-5-git-send-email-hordp@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 19:57:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtlO-0001tk-9j
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2KIS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:56:55 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:12733 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KIS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3084; q=dns/txt; s=iport;
  t=1352487411; x=1353697011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+UJeqVfxiADVOsHxem+2o6HIRzdB5srrW6GaTnKAHkY=;
  b=ZK2ZTIXhLQr4hgdxYHlm8uhOBXkel7p2rE+Jj+oqoavkNZlPLTkQhftb
   l8KjQZ3P+I4iRNfX/xSiiT+J/YfUsyWTFwVQhwZcVQizhzKE/sJPY+LsI
   UusCG65FSVbQAIogLQjBKpeqhq272uR6Hr+lCzKdXjSIQyuZsGudXf+UG
   w=;
X-IronPort-AV: E=McAfee;i="5400,1158,6891"; a="140702897"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-3.cisco.com with ESMTP; 09 Nov 2012 18:56:50 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id qA9IudCG020062;
	Fri, 9 Nov 2012 18:56:50 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <1352487385-5929-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209241>

Add t7061-status-sequence.sh with tests for the various
'git status --sequence' states.

I did not include tests for these states because I am not
sure how to induce these conditions organically yet:

   conflicted am status
   empty am status
   rebase-interactive editing status
   rebase-interactive splitting status

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7061-status-sequence.sh | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100755 t/t7061-status-sequence.sh

diff --git a/t/t7061-status-sequence.sh b/t/t7061-status-sequence.sh
new file mode 100755
index 0000000..db99822
--- /dev/null
+++ b/t/t7061-status-sequence.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='sequencer state tokens'
+
+. ./test-lib.sh
+
+expect_tokens() {
+	for TOKEN in "$@" ; do
+		echo "## $TOKEN"
+	done | sort
+}
+
+status_has_only() {
+	expect_tokens "$@" >expect &&
+	git status -S | sort >actual &&
+	test_cmp expect actual
+}
+	
+test_expect_success setup '
+	test_commit A &&
+	test_commit B oneside added &&
+	git checkout A^0 &&
+	test_commit C oneside created
+'
+
+test_expect_success 'status -S reports conflicted merge' '
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	status_has_only commit-pending conflicted merge
+'
+
+test_expect_success 'git reset --hard cleans up merge status' '
+	git reset --hard HEAD &&
+	status_has_only
+'
+
+test_expect_success 'status -S reports conflicted rebase' '
+	git reset --hard HEAD &&
+	git checkout B^0 &&
+	test_must_fail git rebase C &&
+	status_has_only conflicted rebase
+'
+
+test_expect_success 'git rebase --abort cleans up rebase status' '
+	git rebase --abort &&
+	status_has_only
+'
+
+test_expect_success 'status -S reports incomplete cherry-pick' '
+	git reset --hard HEAD &&
+	git checkout A &&
+	git cherry-pick --no-commit C &&
+	status_has_only commit-pending
+'
+
+test_expect_success 'completing commit cleans up pending commit status' '
+	git commit -mcompleted &&
+	status_has_only
+'
+
+test_expect_success 'status -S reports failed cherry-pick' '
+	git reset --hard HEAD &&
+	git checkout B &&
+	test_must_fail git cherry-pick C &&
+	status_has_only cherry-pick commit-pending conflicted
+'
+
+test_expect_success 'resolved conflicts clear conflicted status' '
+	git add oneside &&
+	status_has_only cherry-pick commit-pending
+'
+
+test_expect_success 'aborted cherry-pick clears cherry-pick status' '
+	git cherry-pick --abort &&
+	status_has_only
+'
+
+test_expect_success 'conflicted rebase-interactive status' '
+	git reset --hard HEAD &&
+	git checkout B &&
+	test_must_fail git rebase -i C &&
+	status_has_only rebase-interactive conflicted commit-pending
+'
+
+test_expect_success 'bisect status' '
+	git reset --hard HEAD &&
+	git bisect start &&
+	status_has_only bisect
+'
+
+test_expect_success 'bisect-reset clears bisect status' '
+	git bisect reset &&
+	status_has_only
+'
+
+test_done
-- 
1.8.0.3.gde9c7d5.dirty
