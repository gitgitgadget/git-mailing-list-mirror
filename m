Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB691741D7
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372791; cv=none; b=tF5zrJVu0yePUt1cXeoguoXnTGikGMGgjluh+jgyR77Md5/CV4TYWzYfQ3/OOYn0pOUIHShQVipb0IMah+Sd5+OTLF0IciDNGaWI75r183XI/TLHVvVyFSkrN8bYlQC2sjVo7DKC1mXJhkE00lzGeQZffcuk3K5/uK82VxiO0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372791; c=relaxed/simple;
	bh=9uC3WSBZkx5lJMcx9kg2PA0EIpkw/TmOx4kpx9xQTVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rd9cWxuukJS40pPbNx1AUIgPQ8mRq0ODIkcDO0i/qoPI6BUpvuy/cZ2dBqiABTOUqh2e35pM1V4E1jQ8eZVK5haRL8hijzy0VREog5rwXb8zW5SmB0S/Jp9fVObdZ8uEfrmSrik+0Ay9qVF556ecnkyipMzCCO0h7AQ5NJC4cyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Yp/BUXnN; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Yp/BUXnN"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJanL003627
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372777; bh=9uC3WSBZkx5lJMcx9kg2PA0EIpkw/TmOx4kpx9xQTVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yp/BUXnNjoszGntob2PgG/ahyzHRbR01EyUAdHsq14HVCg6KnKbyfSvfos0joh/oz
	 sIfVpKkAQWj98yLBSAkLFoLlCPkI8d/7qSZG9sskXA2ICOJlY+vjKstZlhymVKGSWa
	 JGW60BRATP6UaAWCQrZpJdlUXgDpIaLeJppqBt28=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 3/5] MyFirstObjectWalk: fix filtered object walk
Date: Mon, 25 Mar 2024 13:33:34 +0100
Message-ID: <f21348ab80718b0c6ea1ad9066e0b674b11573ad.1711368499.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f0d2f849 (MyFirstObjectWalk: update recommended usage)
changed a call of parse_list_objects_filter() in a way that
probably never worked: parse_list_objects_filter() always needed a
pointer as its first argument.

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

