Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17221E47B7
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326625; cv=none; b=UssrWZZIby4mzrz5BKXybkBi3Fk00JUD5Q16ooFyrCKaEt1MGJvQdLkhOJ0P2ysGkYQXZZi+HutzzCLol7JjfnvQX/UkUquv8r9eYorPBo28rUtOk4/h5XDKXa3Cpuz+0WzmsIJuR/arxT1gpeKTGrulY+4Qt6N/tqayAFdCNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326625; c=relaxed/simple;
	bh=apwkwjieKuQDP9SgTo8bXQZ2T0NK2UwAlRfg2pyAROU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2MaZCzkv0ZVm2MWYop4MQafRUFnzWpIJ/hguSAghWGdAFF0OE9IW+wRDUxtIpMLz/Fac/TZh62/0/WX+MAFzJSd0Mpkb+ul5r3Jnvt9Nmd+8ICdyzpO45uqfs7U7FAhs5oPXXx7W7l2m6wHrARR/4PKDvS5ydVAh89U2EqXTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fu+hZkOT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fu+hZkOT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754326621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEAqf/4je/7r3Hth/epsPvgxCP7bJAvSSn8A6TGEqwc=;
	b=fu+hZkOTwbFoWQj2rxKsMF4/fZlLnEqJA8McvRTpUWxSFBItO+e6ouGYC3KPXZp9EpIduD
	rtL/Xu3mRz43V18MAmlbYQMFzYQwj3wjKAQKi6j7cZgyEU+pDLGpE6wVSoZb+wzvd+XmXP
	maRp8e9Jo+S/GPwXKgK+TmzVX3sds4o=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 04 Aug 2025 18:56:34 +0200
Subject: [PATCH 3/4] archive-zip: in write_zip_entry() call git_deflate()
 in a loop
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-toon-archive-zip-fix-v1-3-ca89858e5eaa@iotcl.com>
References: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
In-Reply-To: <20250804-toon-archive-zip-fix-v1-0-ca89858e5eaa@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function git_deflate() might not complete to deflate all the input
data in one go. While the function is already being called in a loop,
every loop fresh data is read from the stream. This is not correct,
because input data might get lost.

As we see in many other callsites, git_deflate() should be called in a
loop on the existing input to make it process all the input data.

Add in a nested loop around git_deflate() to process the input buffer
completely, before continuing the parent loop that reads from more data
from the input stream.

Co-authored-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 archive-zip.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index d41a12de5f..25a0224130 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -471,15 +471,17 @@ static int write_zip_entry(struct archiver_args *args,
 
 			zstream.next_in = buf;
 			zstream.avail_in = readlen;
-			zstream.next_out = compressed;
-			zstream.avail_out = sizeof(compressed);
-			result = git_deflate(&zstream, 0);
-			if (result != Z_OK)
-				die(_("deflate error (%d)"), result);
-			out_len = zstream.next_out - compressed;
+			do {
+				zstream.next_out = compressed;
+				zstream.avail_out = sizeof(compressed);
+				result = git_deflate(&zstream, 0);
+				if (result != Z_OK)
+					die(_("deflate error (%d)"), result);
+				out_len = zstream.next_out - compressed;
 
-			write_or_die(1, compressed, out_len);
-			compressed_size += out_len;
+				write_or_die(1, compressed, out_len);
+				compressed_size += out_len;
+			} while (zstream.avail_out == 0);
 		}
 		close_istream(stream);
 		if (readlen)

-- 
2.50.1.327.g047016eb4a

