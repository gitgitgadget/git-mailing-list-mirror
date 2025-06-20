Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AA1FDA8C
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750392805; cv=none; b=QPHQSSQVA/wkIvETKCbmorvpYx2kgOzESKB57kUsRpWoVq5DnPBnDVp5nLfQVQzeHI9w+CKhNEdDZ/1ULriOZf0OVVimxVnh7avv/ot80GBPF70nZl+oAWmaAGJ4f9S5iMH3GKEsQx/6M5FeCiZJ0EmsfJ9EsknyPxhLLnnaFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750392805; c=relaxed/simple;
	bh=z6bfsCkTJlJIq2nr6iCwJbQkfekwI2fHHHf8rYYhT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZReBkeAaAjqPqwjumMgkLujUGIyOSPFLteSaofHByGoTvqLoy2HpGr65fHAKTtGDebY7BYR4IIb4s1NDrM+IHBGHr7vy/Au2OBs9SpjW5cT5IZSFrcYFHp9IfPLWRQFUHGteMQb669IHjrAUlGsIf1fVDBbkr7pGxrIVeTLcAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=pue1klSn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="pue1klSn"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uST7n-00Gccy-2F
	for git@vger.kernel.org; Fri, 20 Jun 2025 06:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From;
	bh=G9lcJf1KcH4jrnOLvOTszlKfViOigTrhBfqAXAD+iMY=; b=pue1klSnHJIN1rfqEVkEWWcRC/
	B5/iA205dXEnyiJcVqWQUCKCpeUBEAts5CnAPi5qZb9gZbo9Df9E4sLp5VYP/7hFcwQLzosZilTEZ
	ngbO48b7RtLU84aYsib5r/uUW8mcHm9dGfaqgrzJSCkybowFtAic/L2uB7ZKIXY+mGa0YgBbWJmzg
	wpIkY/l6+cBOq6KeXJ7Uji6T3E86/uoljx1PN4917vMf62bOiMVWP0+XFgBnTlrglsb7m5cRErzSn
	11/9rLGcKkSfqMPxyjaePNUozUEkYRW2KpkWIRe9J79Q3un6LB0xSJ0tTV8gJPm+I+fRlWbcP7KJk
	gnLHARSw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uST7m-00018d-Qa
	for git@vger.kernel.org; Fri, 20 Jun 2025 06:13:10 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uST7g-008ooa-4P; Fri, 20 Jun 2025 06:13:04 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>
Subject: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
Date: Fri, 20 Jun 2025 13:12:39 +0900
Message-ID: <20250620041239.27839-1-maxim@guixotic.coop>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symbolic ports were previously silently dropped, which made it
impossible to use them with git-credential-netrc. This is a supported
use case according to 'man git-send-email', for --smtp-server-port:

   [...] symbolic port names (e.g. "submission" instead of 587) are
   also accepted.
---
 contrib/credential/netrc/git-credential-netrc.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc.perl b/contrib/credential/netrc/git-credential-netrc.perl
index 9fb998ae09..ad06000b9f 100755
--- a/contrib/credential/netrc/git-credential-netrc.perl
+++ b/contrib/credential/netrc/git-credential-netrc.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
@@ -267,7 +267,9 @@ sub load_netrc {
 		if (!defined $nentry->{machine}) {
 			next;
 		}
-		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
+		if (defined $nentry->{port} && $nentry->{port} =~ m/^[[:alnum:]]+$/) {
+			# Port may be either an integer or a symbolic
+			# name, e.g. "smtps".
 			$num_port = $nentry->{port};
 			delete $nentry->{port};
 		}

base-commit: 9520f7d9985d8879bddd157309928fc0679c8e92
-- 
2.49.0

