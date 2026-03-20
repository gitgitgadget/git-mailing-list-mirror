Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8E1F5847
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967386; cv=none; b=P/FE2kCrbM5+qrpu+90XLE4ihTeKK8ZcQ9mxR6z9TcGwBBA7vdXw5Qonl9oB1eHaYsnI6UC7GLQ9tLzEsx7Cn1tqoumXc+odT+PzM80ocn8UnVwiIhtqfFKY25HifqxaHgi1blGOGTSTv3atk1GznvrcFGnoRNoWvtYuUZvI5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967386; c=relaxed/simple;
	bh=VtG7Dl/YuEKzki3IkfwY3NGbvQ63SbI6aFbJ8n+K9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX61CcB7FwaQf/mG5orezQQa0O5JO2Fb/32NqN6sJ/MfFclMO2BI1ynk5ldoRjUoHyiDJM8hBsSOqvUvRrkmxMP2tMVvkpwZdKJhp3zO63jaDLg6bAanG5zCGy3PVgVa3T6hCA3FM5QNaJYaCspt1fmCw2BIZ6Cp/vZPqpIumWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CKIEKUfF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CKIEKUfF"
Received: (qmail 62424 invoked by uid 106); 20 Mar 2026 00:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VtG7Dl/YuEKzki3IkfwY3NGbvQ63SbI6aFbJ8n+K9F8=; b=CKIEKUfF6kGG51o+e2dtKcXbvTPUhbGCbjqslNdL/C9Z4B5gvuaAd1/1gnVWpriKKooJuYNRbIraVbNNzkvDWJOzPmIkJN669cBIMwj3Rrssm9rzkm4XbrHdStXUjNMgkhDE5V/+6uIubYgPdtXlKA73bw6ZibZQHvH/WmdyprNmDxBHruxX579rkdhHwBfnM3rkWbscQ2DccOrS5vmIkwibjn7VbqUk3oGPQWc19dhjdnymK762o680W4Mj6LF3JyHVyN8YTgI1pig2w0djIk9vrdP+HRVDF4+H3pZGKGb/qCKVChViVOkYB4CAYBc3XOZt5ud31KvSf7XUFJmJGQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:43:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91638 invoked by uid 111); 20 Mar 2026 00:43:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:43:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:43:03 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 3/8] diff-highlight: check diff-highlight exit status in tests
Message-ID: <20260320004303.GC3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

When testing diff-highlight, we pipe the output through a sanitizing
function. This loses the exit status of diff-highlight itself, which
could mean we are missing cases where it crashes or exits unexpectedly.
Use an extra tempfile to avoid the pipe.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 2a9b68cf3b..42d331c6cd 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -41,8 +41,10 @@ dh_test () {
 		git show >commit.raw
 	} >/dev/null &&
 
-	"$DIFF_HIGHLIGHT" <diff.raw | test_strip_patch_header >diff.act &&
-	"$DIFF_HIGHLIGHT" <commit.raw | test_strip_patch_header >commit.act &&
+	"$DIFF_HIGHLIGHT" <diff.raw >diff.hi &&
+	test_strip_patch_header <diff.hi >diff.act
+	"$DIFF_HIGHLIGHT" <commit.raw >commit.hi &&
+	test_strip_patch_header <commit.hi >commit.act &&
 	test_cmp patch.exp diff.act &&
 	test_cmp patch.exp commit.act
 }
-- 
2.53.0.945.ge67b727e8d

