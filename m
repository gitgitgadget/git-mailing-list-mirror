From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/15] merge: test the top-level merge driver
Date: Wed, 29 Apr 2015 14:29:19 -0700
Message-ID: <1430342973-30344-2-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZY5-0006In-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbbD2V3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750801AbbD2V3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 814A74DA93;
	Wed, 29 Apr 2015 17:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lZtw
	gNPq1fyhIVRHRhNI1JOV5lI=; b=qfP/0oGXKQjuhz0QFwBVksyi6dVfVp2NmyUN
	gU6kSNc5CmsZY3LZQQYJ91ljD/8G/leNzjZckbuQeTh0m7OqQwsGtT8IG/PriD+7
	JUnZNNQ68RGVpsjkBXQ6V3FmnDQdpU/za0B9kIqCWaTRkQbfSI7FYin+dlCBcWAL
	9eTOoJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qN32UN
	aejGvy2Ay7fe4B8c4UenvYyJ7pAFzi8KZ4RImpARwHPKwgqJy04PyQPTl2gWzoYp
	bCCXJ/cXwntWSG61nepIX3FNiArKiA2MgJV0YWS7Lfd6381O4jAZJbO+YDx9j5cI
	+xlYx+CqkdLPbZDPedUC1IPc15mP6IXK18yZc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AA394DA92;
	Wed, 29 Apr 2015 17:29:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B58564DA90;
	Wed, 29 Apr 2015 17:29:35 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D545F216-EEB6-11E4-9651-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268010>

We seem to have tests for specific merge strategy backends
(e.g. recursive), but not much test coverage for the "git merge"
itself.  As I am planning to update the semantics of merging
"FETCH_HEAD" in such a way that these two

    git pull . topic_a topic_b...

vs.

    git fetch . topic_a topic_b...
    git merge FETCH_HEAD

are truly equivalent, let me add a few test cases to cover the
tricky ones.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3033-merge-toplevel.sh | 136 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 t/t3033-merge-toplevel.sh

diff --git a/t/t3033-merge-toplevel.sh b/t/t3033-merge-toplevel.sh
new file mode 100755
index 0000000..9d92d3c
--- /dev/null
+++ b/t/t3033-merge-toplevel.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+
+test_description='"git merge" top-level frontend'
+
+. ./test-lib.sh
+
+t3033_reset () {
+	git checkout -B master two &&
+	git branch -f left three &&
+	git branch -f right four
+}
+
+test_expect_success setup '
+	test_commit one &&
+	git branch left &&
+	git branch right &&
+	test_commit two &&
+	git checkout left &&
+	test_commit three &&
+	git checkout right &&
+	test_commit four &&
+	git checkout master
+'
+
+# Local branches
+
+test_expect_success 'merge an octopus into void' '
+	t3033_reset &&
+	git checkout --orphan test &&
+	git rm -fr . &&
+	test_must_fail git merge left right &&
+	test_must_fail git rev-parse --verify HEAD &&
+	git diff --quiet &&
+	test_must_fail git rev-parse HEAD
+'
+
+test_expect_success 'merge an octopus, fast-forward (ff)' '
+	t3033_reset &&
+	git reset --hard one &&
+	git merge left right &&
+	# one is ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^3 &&
+	git rev-parse HEAD^1 HEAD^2 | sort >actual &&
+	git rev-parse three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'merge octopus, non-fast-forward (ff)' '
+	t3033_reset &&
+	git reset --hard one &&
+	git merge --no-ff left right &&
+	# one is ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse one three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'merge octopus, fast-forward (does not ff)' '
+	t3033_reset &&
+	git merge left right &&
+	# two (master) is not an ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse two three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'merge octopus, non-fast-forward' '
+	t3033_reset &&
+	git merge --no-ff left right &&
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse two three four | sort >expect &&
+	test_cmp expect actual
+'
+
+# The same set with FETCH_HEAD
+
+test_expect_failure 'merge FETCH_HEAD octopus into void' '
+	t3033_reset &&
+	git checkout --orphan test &&
+	git rm -fr . &&
+	git fetch . left right &&
+	test_must_fail git merge FETCH_HEAD &&
+	test_must_fail git rev-parse --verify HEAD &&
+	git diff --quiet &&
+	test_must_fail git rev-parse HEAD
+'
+
+test_expect_failure 'merge FETCH_HEAD octopus fast-forward (ff)' '
+	t3033_reset &&
+	git reset --hard one &&
+	git fetch . left right &&
+	git merge FETCH_HEAD &&
+	# one is ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^3 &&
+	git rev-parse HEAD^1 HEAD^2 | sort >actual &&
+	git rev-parse three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'merge FETCH_HEAD octopus non-fast-forward (ff)' '
+	t3033_reset &&
+	git reset --hard one &&
+	git fetch . left right &&
+	git merge --no-ff FETCH_HEAD &&
+	# one is ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse one three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'merge FETCH_HEAD octopus fast-forward (does not ff)' '
+	t3033_reset &&
+	git fetch . left right &&
+	git merge FETCH_HEAD &&
+	# two (master) is not an ancestor of three (left) and four (right)
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse two three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'merge FETCH_HEAD octopus non-fast-forward' '
+	t3033_reset &&
+	git fetch . left right &&
+	git merge --no-ff FETCH_HEAD &&
+	test_must_fail git rev-parse --verify HEAD^4 &&
+	git rev-parse HEAD^1 HEAD^2 HEAD^3 | sort >actual &&
+	git rev-parse two three four | sort >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.4.0-rc3-300-g052d062
