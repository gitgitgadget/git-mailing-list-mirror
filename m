Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FC1D554
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151973; cv=none; b=XyDa4H6QCwXC10Xc/uxiHasIwqI4a6NbHsdF05uKVWrvRHIOv3S4MPglWtz9YlfluJWF0OH2GIuAc/daMa4U7cISlgiO8CCUS8eOs21B683d+Occu/fDYyHl/1IJMgRrEHNr5zomj86LplKgywgy/XFpSS00jq4eP1AXnxeZ91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151973; c=relaxed/simple;
	bh=4d2RruJVL5rHCg72thBvQNXvp7qCGxXJ4S+GWttb8Cg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H1vAPqx3cGpHCtZKcksYrUVQwu11NpwT/Ppma5tSolq0C6GPgNm2WZeihAwjtHG/69zvMey5w9wtU4rE4CypcTjSLc+OYx/s6VX3s2aUAbIxraY7rknMPoZe74izkFq3ufdxxAqXW+bLU+C8pfWaNZwtYqQK4wxYxQumfjic9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rlkwV8Rf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rlkwV8Rf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A72E735F49;
	Thu,  8 Aug 2024 17:19:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	d2RruJVL5rHCg72thBvQNXvp7qCGxXJ4S+GWttb8Cg=; b=rlkwV8RfGpbL2uiwo
	E2duiEByVKS3TGLJ6j9VKTrCRDfPZEJh1zIB+Ja/AQAhuou2oPdMY9Uaxu8C0XP/
	X0lPfpWrMucM3kKfSFlyJRLx8mPD5LleE6MZYpvxoKyhW4KDPLbfeF7HiJBt6Le1
	nY6SI5hfHFjWuvKQE8zjWoaBUs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A11AF35F48;
	Thu,  8 Aug 2024 17:19:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C18AE35F47;
	Thu,  8 Aug 2024 17:19:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] tests: drop use of 'tee' that hides exit status
Date: Thu, 08 Aug 2024 14:19:25 -0700
Message-ID: <xmqq4j7uhfvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E442701A-55CB-11EF-B659-E92ED1CD468F-77302942!pb-smtp21.pobox.com

A few tests have "| tee output" downstream of a git command, and
then inspect the contents of the file.  The net effect is that we
use an extra process, and hide the exit status from the upstream git
command.

In none of these tests, I do not see a reason why we want to hide a
possible failure from these git commands.  Replace the use of tee
with a plain simple redirection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1001-read-tree-m-2way.sh | 2 +-
 t/t5523-push-upstream.sh    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git c/t/t1001-read-tree-m-2way.sh w/t/t1001-read-tree-m-2way.sh
index 88c524f655..48a1550371 100755
--- c/t/t1001-read-tree-m-2way.sh
+++ w/t/t1001-read-tree-m-2way.sh
@@ -397,7 +397,7 @@ test_expect_success 'a/b vs a, plus c/d case setup.' '
 
 test_expect_success 'a/b vs a, plus c/d case test.' '
 	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
-	git ls-files --stage | tee >treeMcheck.out &&
+	git ls-files --stage >treeMcheck.out &&
 	test_cmp treeM.out treeMcheck.out
 '
 
diff --git c/t/t5523-push-upstream.sh w/t/t5523-push-upstream.sh
index 1f859ade16..4ad36a31e1 100755
--- c/t/t5523-push-upstream.sh
+++ w/t/t5523-push-upstream.sh
@@ -124,14 +124,14 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
 test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push --quiet --no-progress upstream main 2>&1 | tee output &&
+	test_terminal git push --quiet --no-progress upstream main >output 2>&1 &&
 	test_must_be_empty output
 '
 
 test_expect_success TTY 'quiet push -u' '
 	ensure_fresh_upstream &&
 
-	test_terminal git push --quiet -u --no-progress upstream main 2>&1 | tee output &&
+	test_terminal git push --quiet -u --no-progress upstream main >output 2>&1 &&
 	test_must_be_empty output
 '
 
