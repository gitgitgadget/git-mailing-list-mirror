Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A611E47B7
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326620; cv=none; b=tanYWS+qWWB4/o+9+wgZLLSqi9AZEZ65MU4vfkkxFszNvm44714jd9k5yEBdIVKpYCyHl86qBEs6b7EeAa5aROumRO8ZEwmOMU4T10D+e1yyGBYZks4TanRD0NaxXr4UAt3sPhNBArz+WJ9J+akV38IJB5peeWXpJtKWk2OLVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326620; c=relaxed/simple;
	bh=1mb3Oo6IJ5HKggEhxvk7wTFKjDa9nfTq9/eMnRjzePk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvSNGvfMJlt83pHsFNRATmbNPloLoAx6wyXrxuhR3UrEibssgvskK2Vm8RiujUKsG/vDngW5VGpd/vwRKJVkIBIG3yxfO4cIrz6LNTSIce9GUlhl2RAB9C4oKXLe7UxyhqkR0aPObYTKkb8ZB7oSCerwvR9X9FOelTowIdKfkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=czlFM7IB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="czlFM7IB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1zOS36mSqTgxN4aleMJ4yeFHg2ixlDji+9QOWsIqUI=;
	b=czlFM7IBY7jHsq2Gr3QSv3t3YOnRIk75P58i6Ao1g1IoTKCaM5sA3iRMRz1AjsSiWC6qYp
	nMyzVx12TX6EoMLrMzSV1pYwEVGV2FuMwN4bu8mkRKSANEBHhZmt90VgQiDVcLKUlPeknT
	rw8a1qlYXBzcl3i2kRyJMUEK3dod+20=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 04 Aug 2025 18:56:32 +0200
Subject: [PATCH 1/4] archive-zip: deduplicate code setting output buffer in
 write_zip_entry()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-toon-archive-zip-fix-v1-1-ca89858e5eaa@iotcl.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

There were two callsites setting the size and address of the output
buffer. Instead of setting them outside the loop and in the loop after
calling git_deflate(). Set them once in the loop, right before the
git_deflate() call.

Co-authored-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 archive-zip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index df8866d5ba..cc6d0cadd9 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -458,8 +458,6 @@ static int write_zip_entry(struct archiver_args *args,
 		git_deflate_init_raw(&zstream, args->compression_level);
 
 		compressed_size = 0;
-		zstream.next_out = compressed;
-		zstream.avail_out = sizeof(compressed);
 
 		for (;;) {
 			readlen = read_istream(stream, buf, sizeof(buf));
@@ -473,6 +471,8 @@ static int write_zip_entry(struct archiver_args *args,
 
 			zstream.next_in = buf;
 			zstream.avail_in = readlen;
+			zstream.next_out = compressed;
+			zstream.avail_out = sizeof(compressed);
 			result = git_deflate(&zstream, 0);
 			if (result != Z_OK)
 				die(_("deflate error (%d)"), result);
@@ -481,8 +481,6 @@ static int write_zip_entry(struct archiver_args *args,
 			if (out_len > 0) {
 				write_or_die(1, compressed, out_len);
 				compressed_size += out_len;
-				zstream.next_out = compressed;
-				zstream.avail_out = sizeof(compressed);
 			}
 
 		}

-- 
2.50.1.327.g047016eb4a

