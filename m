From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] t/t5528-push-default: test pushdefault workflows
Date: Sun, 23 Jun 2013 21:33:07 -0700
Message-ID: <1372048388-16742-6-git-send-email-gitster@pobox.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 06:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyTD-0004Eb-5C
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3FXEdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:33:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab3FXEdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:33:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0E9265C5
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=I3pU
	qvo1h8ATNhXY3NTc7q+4P1s=; b=gk9IVda95d9hdnbSOM925DQ5CIeG+0TYvTUR
	bXp0cI+oT4rQvqUQ6aX9l2htfhPgnhOwFNBMA6cBRLbsiuIg+HpeVbGSawhZCTdL
	CHkOvBRXlStS+QBHpgLqf6W7BRyGfVaw/5z08qlNDZZOk/e+uRpU1VwCEyAGxDOY
	ukNEeXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xPDk0w
	ytFjSxC/0G+B70A+vXTyzHYNCXKQCy+5GTsfF55U561UshuDRnv+YxTiIktXj4FG
	bNzcFLWk4UEkiMP3Idtj441JDKqKlY5APGgMWvJAH4PBjqgU5G0qyShkiuQKaNn+
	bsyOyJyRr174L7MpG8cMd5PtlvHiocJMkFDPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01AF5265C4
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64428265C2
	for <git@vger.kernel.org>; Mon, 24 Jun 2013 04:33:19 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-721-g0a353d3
In-Reply-To: <1372048388-16742-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 32203CBA-DC87-11E2-BBEA-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228771>

From: Ramkumar Ramachandra <artagnon@gmail.com>

Introduce test_pushdefault_workflows(), and test that all push.default
modes work with central and triangular workflows as expected.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5528-push-default.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index db58e7f..6a5ac3a 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -39,6 +39,26 @@ test_push_failure () {
 	test_cmp expect actual
 }
 
+# $1 = success or failure
+# $2 = push.default value
+# $3 = branch to check for actual output (master or foo)
+# $4 = [optional] switch to triangular workflow
+test_pushdefault_workflow () {
+	workflow=central
+	pushdefault=parent1
+	if test -n "${4-}"; then
+		workflow=triangular
+		pushdefault=parent2
+	fi
+	test_expect_success "push.default = $2 $1 in $workflow workflows" "
+		test_config branch.master.remote parent1 &&
+		test_config branch.master.merge refs/heads/foo &&
+		test_config remote.pushdefault $pushdefault &&
+		test_commit commit-for-$2${4+-triangular} &&
+		test_push_$1 $2 $3 ${4+repo2}
+	"
+}
+
 test_expect_success '"upstream" pushes to configured upstream' '
 	git checkout master &&
 	test_config branch.master.remote parent1 &&
@@ -115,4 +135,41 @@ test_expect_success 'push to existing branch, upstream configured with different
 	test_cmp expect-other-name actual-other-name
 '
 
+# We are on 'master', which integrates with 'foo' from parent1
+# remote (set in test_pushdefault_workflow helper).  Push to
+# parent1 in centralized, and push to parent2 in triangular workflow.
+# The parent1 repository has 'master' and 'foo' branches, while
+# the parent2 repository has only 'master' branch.
+#
+# test_pushdefault_workflow() arguments:
+# $1 = success or failure
+# $2 = push.default value
+# $3 = branch to check for actual output (master or foo)
+# $4 = [optional] switch to triangular workflow
+
+# update parent1's master (which is not our upstream)
+test_pushdefault_workflow success current master
+
+# update parent1's foo (which is our upstream)
+test_pushdefault_workflow success upstream foo
+
+# upsream is foo which is not the name of the current branch
+test_pushdefault_workflow failure simple master
+
+# master and foo are updated
+test_pushdefault_workflow success matching master
+
+# master is updated
+test_pushdefault_workflow success current master triangular
+
+# upstream mode cannot be used in triangular
+test_pushdefault_workflow failure upstream foo triangular
+
+# in triangular, 'simple' works as 'current' and update the branch
+# with the same name.
+test_pushdefault_workflow success simple master triangular
+
+# master is updated (parent2 does not have foo)
+test_pushdefault_workflow success matching master triangular
+
 test_done
-- 
1.8.3.1-721-g0a353d3
