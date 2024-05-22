Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032728F0
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716408993; cv=none; b=S3pYFFvnO5t4A7AuwEJEoGWXvpVQKYaCPPpjHZZv9CYsF3F4mXO1HBjDjmO+aSSMLvp6ka7AyRTK+D/ojjiT7UW2l4wLubZu6AP1FEWIxpjFEonsuOzdFab6tk7SA6mhBaxcOLWiHlNWAY1UOGKvjOjlQyXHW63kChd1nl944Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716408993; c=relaxed/simple;
	bh=rLwiPGiNzo67D21f3jr879KToLJaq9zNCBXs9KHJOL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE7USGgbjc8Nblgf/IAK0FYROsMfEAu1McrZSsI6cSg7cmZ4h9vOP74zpuE+FzSTPptD0PB9FTgAeLjOlzGNKgfwJHIb8yQ599wSf0svT6bvrfG9XM8Onj3ASu+lCwkHLf3woSkKZPsHOCHZstUATmzEoW1rDrvGHI43gVP6DqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=BJeLOTzK; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="BJeLOTzK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VQpXTKgdM36KrveZ8U489C+ClkhgTX6K410FlcYNxWo=; i=tom@compton.nu;
	t=1716408991; x=1717618591; b=BJeLOTzKgJ5D9nmIrbtkcFpg+CxawArLmHJkCx0J7s3NO5a
	Bs6LFFmpaBctfM0HW7vKMRxlUzBEDC3JBMlSLDPSuCzVUz602zElUdRBbTqIdSjdbtSDPGKZhUtw9
	uW0px1r0gsuIzBIQoCOSJi3boBzDNtdfc/HGjl3MVMhBjdwuXu5KEgh4Cby828KIYzVRVku8ybewq
	fyUoozE+LSWJZpln0DZjfFSTgMgMgJTpFtwIAti/JJDQbG8LPxz2tKJ/KRtSFx8/Cwt9RWywQFnmL
	HuPIdJ4SPETwQQjiqBMw/6mfj6rN+jmgNeSIOJzb78w06yEu0V3CR5iHLqBUmPgw==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:48404)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9sNp-00000007xyS-1JEb;
	Wed, 22 May 2024 21:16:25 +0100
Received: from tom by bericote.compton.nu with local (Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9sNp-000000072YL-0MJN;
	Wed, 22 May 2024 21:16:21 +0100
From: Tom Hughes <tom@compton.nu>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	Tom Hughes <tom@compton.nu>
Subject: [PATCH v2] push: don't fetch commit object when checking existence
Date: Wed, 22 May 2024 21:15:40 +0100
Message-ID: <20240522201559.1677959-1-tom@compton.nu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <xmqq8r014pyn.fsf@gitster.g>
References: <xmqq8r014pyn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're checking to see whether to tell the user to do a fetch
before pushing there's no need for us to actually fetch the object
from the remote if the clone is partial.

Because the promisor doesn't do negotiation actually trying to do
the fetch of the new head can be very expensive as it will try and
include history that we already have and it just results in rejecting
the push with a different message, and in behavior that is different
to a clone that is not partial.

Signed-off-by: Tom Hughes <tom@compton.nu>
---
 remote.c                 |  2 +-
 t/t0410-partial-clone.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 2b650b813b..20395bbbd0 100644
--- a/remote.c
+++ b/remote.c
@@ -1773,7 +1773,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!repo_has_object_file(the_repository, &ref->old_oid))
+			else if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 88a66f0904..7797391c03 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -689,6 +689,25 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	! grep "[?]$FILE_HASH" out
 '
 
+test_expect_success 'push should not fetch new commit objects' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	test_commit -C server server1 &&
+
+	git clone --filter=blob:none "file://$(pwd)/server" client &&
+	test_commit -C client client1 &&
+
+	test_commit -C server server2 &&
+	COMMIT=$(git -C server rev-parse server2) &&
+
+	test_must_fail git -C client push 2>err &&
+	grep "fetch first" err &&
+	git -C client rev-list --objects --missing=print "$COMMIT" >objects &&
+	grep "^[?]$COMMIT" objects
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.45.1

