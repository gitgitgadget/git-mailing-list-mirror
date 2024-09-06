Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7402E822
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594461; cv=none; b=rKOI4aJF8Ub+9RfnQjhRMQlQn2ABAnjSlQM3XpmlXHPhS3TyV+KAbtjFSvynuIBL+7SZQGtGKSJyIJPAboIAPUNi/xodhyQCCbbun+TIW3dMijSWV3NicvcGcsKkAeRLhkxOll5GrK8cK0cDDJhA5yBQC//f+YBJjqgIVtQsea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594461; c=relaxed/simple;
	bh=iDY7WwhaG9CObd4rQ5qqVaBcAMDv5T8o6kN6+4ckduE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLOvsLstKS9RkPwLv201YByHPpdGR9Sbz29fJoLYe2gkqxO4/fjVaXbPlIHeh3+fqhqLLd068xfeQ/RzshFig8hCabxRRCyWIDb/xFd2k4jPyQSslP1kC7AzyvEnQb8h3zLmw5bad7UhRdj+pKbseapG5q5PFM21LOWCbjeK1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15226 invoked by uid 109); 6 Sep 2024 03:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 03:47:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16356 invoked by uid 111); 6 Sep 2024 03:47:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 23:47:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 23:47:38 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] sparse-checkout: check commit_lock_file when writing
 patterns
Message-ID: <20240906034738.GB4168362@coredump.intra.peff.net>
References: <20240906034557.GA3693911@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906034557.GA3693911@coredump.intra.peff.net>

When writing a new "sparse-checkout" file, we do the usual strategy of
writing to a lockfile and committing it into place. But we don't check
the outcome of commit_lock_file(). Failing there would prevent us from
writing a bogus file (good), but we would ignore the error and return a
successful exit code (bad).

Fix this by calling die(). Note that we need to keep the sparse_filename
variable valid for longer, since the filename stored in the lock_file
struct will be dropped when we run commit_lock_file().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index dfefe609a1..b5e220cc44 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -338,7 +338,6 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
-	free(sparse_filename);
 
 	result = update_working_directory(pl);
 	if (result) {
@@ -355,10 +354,12 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	fflush(fp);
-	commit_lock_file(&lk);
+	if (commit_lock_file(&lk))
+		die_errno(_("unable to write %s"), sparse_filename);
 
 out:
 	clear_pattern_list(pl);
+	free(sparse_filename);
 	return result;
 }
 
-- 
2.46.0.802.g13da1a47c4

