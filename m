Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147C7F
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051466; cv=none; b=Mgn36V5IPwh2wqgmO/xA/ugh+CVswR6+gVbMz5JK/rroTlVC9zAkD+NCC5Tp8tas0CsgXfXrnj9YuWEvqj8EMjdOU32NBgxidY1Kg84JdkWXdbk7FMTHo57QSqSk70KocmaCaLlmyYvXH5cWZ0JEdijtDwkZYtpxm8fL4jMtQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051466; c=relaxed/simple;
	bh=2kNsVg63SAbl9Zy9Pxypxy3NQ+zHqWhmY2So6KXLIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPxHIMOmluid758hGT5P5iAnRZJfSbeuoE6/V1kwV/KdhN3Oid25MHcuUkqCh4TjVtTNl5RxsqaNpNaqMB+6MiHgKKlw4aKqD4WP6Igxnot061gqCY2dJHkF5qbOreH5+mTixEq7pPBtQlsZkSL6r/dy+m2xNwSaRw/rhdC7E8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16796 invoked by uid 109); 30 May 2024 06:44:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27639 invoked by uid 111); 30 May 2024 06:44:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:44:21 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:44:22 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <20240530064422.GC1949704@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530063857.GA1942535@coredump.intra.peff.net>

Commit b6f51e3db9 (mv: cleanup empty WORKING_DIRECTORY, 2022-08-09)
added an auxiliary array where we store directory arguments that we see
while processing the incoming arguments. After actually moving things,
we then use that array to remove now-empty directories, and then
immediately free the array.

But if the actual move queues any errors in only_match_skip_worktree,
that can cause us to jump straight to the "out" label to clean up,
skipping the free() and leaking the array.

Let's push the free() down past the "out" label so that we always clean
up (the array is initialized to NULL, so this is always safe). We'll
hold on to the memory a little longer than necessary, but clarity is
more important than micro-optimizing here.

Note that the adjacent "a_src_dir" strbuf does not suffer the same
problem; it is only allocated during the removal step.

Signed-off-by: Jeff King <peff@peff.net>
---
Reported as "new" by Coverity, but I think that is only because of the
"goto out". Before your recent patches it was a straight "return", which
was even worse. ;)

 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 81ca910de6..852b4e92c1 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -556,7 +556,6 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_release(&a_src_dir);
-	free(src_dir);
 
 	if (dirty_paths.nr)
 		advise_on_moving_dirty_path(&dirty_paths);
@@ -571,6 +570,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	ret = 0;
 
 out:
+	free(src_dir);
 	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
-- 
2.45.1.692.gbe047d9c60

