Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA654FAB
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847474; cv=none; b=Lp4ItriANmBYWdiufVbWqbgOyFxlHsdjKsf4gwgSPUo7b1WCq5mocUhVDLXp0Vcmg3bp2qr+0tXkjyiP763GNQ0qm8kKODs+zAawNScrQFC3jB4L204Dhwkg0BCFj05n7VZ40BkfBf6y5tnrfrZo2ZWTrPmD/d0vIzYiH1rv8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847474; c=relaxed/simple;
	bh=ZvHqG9KyK2fn/PfbiiL0P7HCQkiSTagQKAhyGEx3gV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpf311OvXfly647mjDlEeVUWXoz8wGeIb5ck/odcLC0ic3X0SfAbbEPZG8+DqhEEf/tHseZ1VAOTD3SwGPMrbkCLME+Cu9YOPC7Avf87kmUUydedFQla7ttpZEmDVWuHUgFB1oClEn3mWRDPL5kOIgVJ0KWkvOr0AZhQa+yN1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=X4A/9JfX; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="X4A/9JfX"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42JBOO52017034
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 12:24:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710847464; bh=ZvHqG9KyK2fn/PfbiiL0P7HCQkiSTagQKAhyGEx3gV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X4A/9JfXaaB9i4adRaDr7lwVILcVgt55mXhVUCeBjnvVziCXSMKqQKxKa8TYhzPiP
	 w61YKbjylu+lD/oMjESFYOky5M2G1lE2Pw9Vx29EDeNvFEtJXEWyr5jFdCnyOqkls0
	 W0xcfmUEz6qVln5sRTOj7VTUCDAEXCBFhEGfosCI=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 5/5] MyFirstObjectWalk: add stderr to pipe processing
Date: Tue, 19 Mar 2024 12:23:15 +0100
Message-ID: <64c36dbf16108353635a7315a3bd5eb60f2aa92e.1710840596.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710840596.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the last chapter of this document, pipes are used in commands to
filter out the first/last trace messages.  But according to git(1),
trace messages are sent to stderr if GIT_TRACE is set to '1', so those
commands do not produce the described results.

Fix this by redirecting stderr to stdout prior to the pipe operator
to additionally connect stderr to stdin of the latter command.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 981dbf917b..2e6ae4d7fc 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -847,7 +847,7 @@ those lines without having to recompile.
 With only that change, run again (but save yourself some scrollback):
 
 ----
-$ GIT_TRACE=1 ./bin-wrappers/git walken | head -n 10
+$ GIT_TRACE=1 ./bin-wrappers/git walken 2>&1 | head -n 10
 ----
 
 Take a look at the top commit with `git show` and the object ID you printed; it
@@ -875,7 +875,7 @@ of the first handful:
 
 ----
 $ make
-$ GIT_TRACE=1 ./bin-wrappers git walken | tail -n 10
+$ GIT_TRACE=1 ./bin-wrappers git walken 2>&1 | tail -n 10
 ----
 
 The last commit object given should have the same OID as the one we saw at the
-- 
2.43.0

