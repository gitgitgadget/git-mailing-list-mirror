Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED141118D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379644; cv=none; b=p/VwhwvGxS9IW+R97AGgx5k94TrieYgIeWLctzePE+pZZ/zKK/cCERUvTSjspgI9caXHUlb7G/xWh601co2tDikObx+iZnhyrHVQ/8qfyYwtvtkSNv1P1tAJTIBZrJx+NZkN4PWaU8necSHkembJXk/yl39sZbhDD47u0AJvf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379644; c=relaxed/simple;
	bh=ShSlES6vGSR503zjkHWaPctLjbYBOClKpZyyV1ibo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fU8zADTv5l/PEjIIu3UQUKFM75g2Tdbn6+O7faq21MqtQvnm24wrEuw7EV6EF/ELWN/gUBZMzPfDtD1NBk0qs38kN8wxYVVQqGNrcNdwvcC7XCC8x93b/FwaTmPI/PCv+Y8hWEQt7HMwJby69/W75Qlaga/kCqboQjujk7kiSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20249 invoked by uid 109); 29 Apr 2024 08:34:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:34:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26938 invoked by uid 111); 29 Apr 2024 08:34:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:34:06 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:34:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 7/8] refs: check refnames as fully qualified when writing
Message-ID: <20240429083401.GF233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When a ref update is queued via ref_transaction_update(), we call
check_refname_format() to make sure the name is acceptable. We pass
REFNAME_ALLOW_ONELEVEL, which allows pseudorefs like MERGE_HEAD. But
that's not enough to forbid names outside of refs/ like "foo/bar" or
even scary stuff like "config" (though fortunately I think that should
never work because we cannot resolve "config" to read the old value).

Let's instead pass REFNAME_FULLY_QUALIFIED, which tells the checking
function that we really do have a full refname, and it can enforce
it as such.

This means that "git update-ref foo/bar HEAD" will now be rejected. Note
that _deleting_ such a ref is already forbidden (and there is a test in
t1430 for that already), due to some confusing differences between
check_refname_format() and refname_is_safe(). See the previous commit
for more details.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                  |  2 +-
 t/t1430-bad-ref-name.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 44b4419050..57663cfe9e 100644
--- a/refs.c
+++ b/refs.c
@@ -1267,7 +1267,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
 	    ((new_oid && !is_null_oid(new_oid)) ?
-		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+		     check_refname_format(refname, REFNAME_FULLY_QUALIFIED) :
 			   !refname_is_safe(refname))) {
 		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
 			    refname);
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 0c00118c2b..120e1557d7 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -390,4 +390,14 @@ test_expect_success 'branch -m can rename refs/heads/-dash' '
 	git show-ref refs/heads/dash
 '
 
+test_expect_success 'update-ref refuses lowercase outside of refs/' '
+	test_must_fail git update-ref lowercase HEAD 2>err &&
+	test_grep "refusing to update ref with bad name" err
+'
+
+test_expect_success 'update-ref refuses non-underscore outside of refs/' '
+	test_must_fail git update-ref FOO/HEAD HEAD 2>err &&
+	test_grep "refusing to update ref with bad name" err
+'
+
 test_done
-- 
2.45.0.rc1.416.gbe2a76c799

