Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586F1CD3A
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193576; cv=none; b=izSxMgxi+P8Q0vJzfuAKwarEFN4mm2h0JryavJje7WVh+Qr8jBMFbwrxCE2R8ANGMyNH4aot1oC87djM9wFolBjfVMKVODGaF1PHuAWHA651D4rcg/xJ4911/jYfEtmo91IcO6z7F+fVGUScROUeEhGpXcwnzJEc6KWKPMj78Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193576; c=relaxed/simple;
	bh=W6lIdyhAdxlbKs7A6d+V+K9C0i4ZMNxkIms7JoQ1mpg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=TVVoXHLU3IqzMIkrUrLizSJ5qd8vXFfL02b9oHP31YjKCb2Sw2VXoprAxGfsgNZvDy3SYJ5i+dQT4yf94XPmPt0dCCaF3xM/FQsNql/bGhHcZT/lq+PcjVhxFTeDNnokAS1442NTpuwm0W1GiMZakxVcfCaiL2Arw+D5/D1myMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=JU+/Rkcu; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="JU+/Rkcu"
Received: from localhost (ip-109-42-178-223.web.vodafone.de [109.42.178.223])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42BLkBd2032120
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 11 Mar 2024 22:46:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1710193572; bh=W6lIdyhAdxlbKs7A6d+V+K9C0i4ZMNxkIms7JoQ1mpg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References;
	b=JU+/RkcuGYV4wnP5gAURsMn1WrueuVbnDeDM7lgE8zbOjGygwkXiZf+nuMAc0pNGb
	 Stb/XYVuz2puddSGQPI0/CA3I7ZbzVsgiArxSID+Yd7CsXP0KSrYKMmtpiuZvVAGAT
	 qzNLUQJtjDSKlgV9WsvWB2b120aeNeIe6eHGFc9k=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 3/5] MyFirstObjectWalk: fix filtered object walk
In-Reply-To: <cover.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 13:47:24 +0100
Message-ID: <0f67a161efc2635bb453eff2f6ab34b94c8794ae.1710192973.git.dirk@gouders.net>
References: <cover.1710192973.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Commit f0d2f849 (MyFirstObjectWalk: update recommended usage)
changed a call of parse_list_objects_filter() in a way that
probably never worked: parse_list_objects_filter() always needed a
pointer as its first argument.

Fix this by removing the CALLOC_ARRAY and passing the address of
rev->filter to parse_list_objects_filter() in accordance to
such a call in revisions.c, for example.

Fixes: f0d2f849 (MyFirstObjectWalk: update recommended usage)
Cc: Derrick Stolee <stolee@gmail.com>
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

