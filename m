Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D71E868
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550888; cv=none; b=VcRD02GZL6PnWrZwQDVdnAlazic24wfOMJcVfNM5lDXDB11khQ5bG2zxLj86aH+0Vu88m/eFQpY2wwxcbJ7Qbn8TgBlhpUDqwtzVKZB6bVSwgO4SMuMWHHQbeXn3WF7UCXALoFkMtZP7jj+9iI1UUbhF6J0ahjbiK9LbmfxNILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550888; c=relaxed/simple;
	bh=FLgBKxiVqariQ8A0u8yuWnOZe32FRgRMfa63WOfzKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hco2zIj49k0wBs8VKn05zVZKjf4Tn5Zkg6b3/OOBdyrsTb7dn4y+EPO6Lz8ttJzX8WRvu0vwxTOX6Y6MwpTKxKjKkHE0O42UmvgKbtHnkooVYHKIQ5vXamqRalc7AgyPEVp7sEY0mtXf0yFhQC+8zrDQupUSitjjhrer/Wqs+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ARkah/FD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ARkah/FD"
Received: (qmail 23283 invoked by uid 109); 18 Aug 2025 21:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=FLgBKxiVqariQ8A0u8yuWnOZe32FRgRMfa63WOfzKc8=; b=ARkah/FDcIsjFIhhwx0SqorxcZEX0Hr/rUlF6a5gWqjuS2x6FeRmwTZiSljR/ZKdxqrXqt07QuhRr8CbW9w/qcKUoEuuZGDDRtYPGr9WbF3scYifsltlxm7Xrt0t8igf2XzYBgbf8bMdrw5Ov1IeGgNbB8zYugYL17d8TF90UvFA/QHTSE90VE38NiwSq+KfqCPXkSow4q6l1U4n9dkEqJbzYU8kwuUuHQwGo+IQsnDU6Qdi1UOF4SYhLfNMrIf+sPXrk/By+xkBuAYDfIUk0HhTZ0xqUAmiNMIiVx57d+pk4u2nMozCO3YcMm+gtLNVzisvUnBSNufTGASWyTFdWw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 21:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30314 invoked by uid 111); 18 Aug 2025 21:01:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 17:01:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 17:01:25 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 2/5] describe: error if blob not found
Message-ID: <20250818210125.GB1024556@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818205812.GA1018043@coredump.intra.peff.net>

If describe_blob() does not find the blob in question, it returns an
empty strbuf, and we print an empty line. This differs from
describe_commit(), which always either returns an answer or calls die()
itself. As the blob function was bolted onto the command afterwards, I
think its behavior is not intentional, and it is just a bug that it does
not report an error.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is perhaps the most controversial, as it is a change in
behavior. But the current behavior just really seems like a bug to me.

Unlike what René posted earlier, I didn't record the dst strbuf's
original size and compare against that. This is a static function with
only one caller that passes in an empty strbuf, so being overly
defensive didn't seem worth it (arguably these functions should just
return an allocated buffer anyway).

 builtin/describe.c  | 3 +++
 t/t6120-describe.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 383d3e6b9a..06e413d937 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -535,6 +535,9 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
 	reset_revision_walk();
 	release_revisions(&revs);
 	strvec_clear(&args);
+
+	if (!dst->len)
+		die(_("blob '%s' not reachable from HEAD"), oid_to_hex(oid));
 }
 
 static void describe(const char *arg, int last_one)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 256ccaefb7..470631d17d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -409,6 +409,12 @@ test_expect_success 'describe tag object' '
 	test_grep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
 
+test_expect_success 'describe an unreachable blob' '
+	blob=$(echo not-found-anywhere | git hash-object -w --stdin) &&
+	test_must_fail git describe $blob 2>actual &&
+	test_grep "blob .$blob. not reachable from HEAD" actual
+'
+
 test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 	i=1 &&
 	while test $i -lt 8000
-- 
2.51.0.326.gecbb38d78e

