Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9528852C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326622; cv=none; b=UZocHpjMMfL6gtEZCbcCKv5PcX9HR+sBUlJNKapwBsCHb/2Q6eu/sXZTt7UOE45tjMcaVHk6LFJQNTtTbkJ2st9RvWShGrHGEzGVm9TSfYird5i7+M26hH1LiH7xR8N83BLRK00xz5BwuvubojTb+yx9/P9f5DWwimYNhkuZN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326622; c=relaxed/simple;
	bh=jUz7/lNjfJggHREIzN+lgVBvDGqgqH/nMjrngBDq7eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rSY4g/ScuxaPRFwXbavNRT03LQCbmc+fD7nqtK84SyQ7NF2uyathIdDJR85IuZD8gWifnI0BtIQ7Sb8bc00ARD455uzHOIczUSBwl3uBe2LLLdbboOZ8T8Y6wBb0QBECM7Han2sefkPGH2ozOMS3CcvPG5tFytO6FyYf4A0jLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OeOwGRO3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OeOwGRO3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRvnKqlDXYpOsJRKOBV9j3wfXjDKVVf0scQuwexLDjQ=;
	b=OeOwGRO3WNWi6CqpEaZWDLks0c/C0eEZ3lYRGOdjoFgvsEWBDv9sE25DDH/nxzuuyFeweB
	9m20nx35xB/lSYzREq0sVEFOsXOXwnzALkL7phP7g/KpmcYn791YbIPSo2FaUC7bcqm3tX
	hEFWJSfEnNiBqAPJZaDpBjes1iB1Mgk=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 04 Aug 2025 18:56:33 +0200
Subject: [PATCH 2/4] archive-zip: remove unneccesarry condition in
 write_zip_entry()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-toon-archive-zip-fix-v1-2-ca89858e5eaa@iotcl.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function write_or_die() can handle a length that's zero, thus we can
remove the condition that checks the value of `out_len` that surrounds
this call. The value shall never be negative as this would have caused
data being omitted in the deflated output.

Co-authored-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 archive-zip.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index cc6d0cadd9..d41a12de5f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -478,11 +478,8 @@ static int write_zip_entry(struct archiver_args *args,
 				die(_("deflate error (%d)"), result);
 			out_len = zstream.next_out - compressed;
 
-			if (out_len > 0) {
-				write_or_die(1, compressed, out_len);
-				compressed_size += out_len;
-			}
-
+			write_or_die(1, compressed, out_len);
+			compressed_size += out_len;
 		}
 		close_istream(stream);
 		if (readlen)

-- 
2.50.1.327.g047016eb4a

