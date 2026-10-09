Received: from smtp90.iad3b.emailsrvr.com (smtp90.iad3b.emailsrvr.com [146.20.161.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACA37A822
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574655; cv=none; b=MUGHIwn5c4fkaQkm9EkXs3FBDZOOdmREZ67EqrGvxq4QlkA4zokSOA4li3WPV7jCEsGe5R1Jkoc1VzWEO4tUHkRrmLRFN9PMyxZYMaGdVsiAsztIsfgPJsDWT9D0/xHL7uIg72t2bUVZNm3ozKi9qTycPH6Bwf19IQaRCiFOjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574655; c=relaxed/simple;
	bh=AFfwUTOgTxVIaceXOP8b476P6MlCOz2lsbFaeV97aCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs9oVWL3wylFg0oilmWFWUnw8A3A8nQPhWhwa6WdMCKdvyvz+Ze5wUkB7QhoSEdYbd4BWTIGD1sT+CbJvZAm+3yScDI94HMlTf2fEHZurn+9qh1pqQHm+QE9UHSgwX9GH6Rl7Sv2aZFpHiyaZHGQWzyS8kUKCXzln8w/6ufIckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=izshtp2l; arc=none smtp.client-ip=146.20.161.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="izshtp2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791574220;
	bh=AFfwUTOgTxVIaceXOP8b476P6MlCOz2lsbFaeV97aCA=;
	h=From:To:Subject:Date:From;
	b=izshtp2lWG7AHQHmyqT8J2Rn5mfBbuKf/3vh0fx3Lbr/Ecb6GpDltBluomH3vRZUk
	 dqbLYHIEVpIVEu2sSeeMIie/POz4R5mo0NF1BX48kWauA0txtMJQRMI/mNRsgKV7sB
	 hhseBBiT81dCgdgx5j8JqdeaMjhNsIufIMnsr77s=
X-Auth-ID: jon@jonsimons.org
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 2BE232038B;
	Fri,  9 Oct 2026 15:30:20 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH 02/15] t5516: demonstrate push with "./"-prefixed source
Date: Fri,  9 Oct 2026 15:29:40 -0400
Message-ID: <20261009192953.81794-3-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009192953.81794-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 523ad08c-aaf2-41d9-9ffc-58ea03a01763-3-1

'git push <repo> ./refs/heads/main:refs/heads/frotz' succeeds today
and pushes refs/heads/main, although "./refs/heads/main" is not a
valid refname.  count_refspec_match() compares the source to each
local ref using refname_match(), which formats its given name with
mkpath(), whose cleanup_path() strips leading "./".

Add a test_expect_failure asserting that such a source is rejected
with "src refspec ./refs/heads/main does not match any".  An upcoming
commit stops using mkpath() in refname_match(), at which point the
test is toggled to test_expect_success.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 t/t5516-fetch-push.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b982b209bf..aaeb251e2f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -433,6 +433,12 @@ test_expect_success 'push with onelevel ref' '
 	test_must_fail git push testrepo HEAD:refs/onelevel
 '
 
+test_expect_failure 'push with "./"-prefixed src does not match any ref' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo ./refs/heads/main:refs/heads/frotz 2>err &&
+	test_grep "src refspec ./refs/heads/main does not match any" err
+'
+
 test_expect_success 'push with colon-less refspec (1)' '
 	mk_test testrepo heads/frotz tags/frotz &&
 	git branch -f frotz main &&
-- 
2.55.0

