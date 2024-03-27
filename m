Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7384F1FB
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538591; cv=none; b=R28berKyPqgJDMSHD44ij6VNrIwZAmuFEeUOPwOvT6u357knX0F0rT0w86tUTj9VhLIxwPmjuAB7zqK2eYrkb72B1H9MEJurvnwDlmalAuou1rn6BXCrloa8hovdTb1OJz9/0btjyV6Fqes4aPGja3GzsjYdsgHf6tIWpFZm7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538591; c=relaxed/simple;
	bh=wHBJ8IdYC9WwCmpz9ocMUeSzzlacf3sM7gPGp/X+I4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3bgNEudvHV1onG0vYpvIR+DFVQ4zn+wU4Hqbsxit0wZrCHNdqYljDpqkV2UoHqFm7evib3gM7NTd2HC1xhVC176i1gDZFCHuT25JTbjkuX7pdZX7cVRM6/Vy8mzKIVI/yVi80v/G7czVQkO8lMAiGHlLYGvJQWBJ2nUZ6pYiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=QXjGiucE; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="QXjGiucE"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42RBMvXF003308
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 12:22:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711538578; bh=wHBJ8IdYC9WwCmpz9ocMUeSzzlacf3sM7gPGp/X+I4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QXjGiucEc4RjK+642fQduyZjFq6Aug2pb3eBePrNVRkUJb+qXNptSfHEhVQ0heVoI
	 9bCKjt9R+sBfkbk3kIx25xsLhentVQRahWiR5r7BPkuhRa3hptzkagtunzpgVQ/ujw
	 QlOGjHe/JyIoXvI+mAFfykpRGvNLFXyglsF6lcDI=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v5 3/5] MyFirstObjectWalk: fix filtered object walk
Date: Wed, 27 Mar 2024 12:22:14 +0100
Message-ID: <e1b4a4c996e5d29d441a630ebccc4c55de1925e3.1711537370.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711537370.git.dirk@gouders.net>
References: <20240326130902.7111-1-dirk@gouders.net> <cover.1711537370.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f0d2f84919 (MyFirstObjectWalk: update recommended usage,
2022-03-09) changed a call of parse_list_objects_filter() in a way
that probably never worked: parse_list_objects_filter() always needed
a pointer as its first argument.

Fix this by removing the CALLOC_ARRAY and passing the address of
rev->filter to parse_list_objects_filter() in accordance to
such a call in revisions.c, for example.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index c33d22ae99..a06c712e46 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -734,8 +734,8 @@ walk we've just performed:
 	} else {
 		trace_printf(
 			_("Filtered object walk with filterspec 'tree:1'.\n"));
-		CALLOC_ARRAY(rev->filter, 1);
-		parse_list_objects_filter(rev->filter, "tree:1");
+
+		parse_list_objects_filter(&rev->filter, "tree:1");
 	}
 	traverse_commit_list(rev, walken_show_commit,
 			     walken_show_object, NULL);
-- 
2.43.0

