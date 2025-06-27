Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB628D8FF
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062189; cv=none; b=nV4eP+7Vspav2sdx1xJECJ2J9eg/wnL3q2LNBeWXBR8Bmiwod+TjxiVesTHu/Zif26EFwIMlR54xrVStS2F6JDDS2wieQNTrlXKu4rEeeJpRXz9+rI0s1123UHf/YopZk4eCJAOJ7vYj354qwDzBIMe0OpyOEO+3LUHGy4RHHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062189; c=relaxed/simple;
	bh=fcMBWJasJvBtOwVqtjd8pK6FI6UzxR4uC3D2v2Lcuh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ClR/gCk5h2O9uMaqOQNf73Wbc8K8cT4oW8TDPKOR64l4lhUtiQaWhplBI4JRtGMicrwjA/gkC2c01WjV9UQEX9a3EmvBtwvhM2HX2cBWZhsfTV4vXYPkmmFQ+Fvf7SuvbZaSkqCcjFw/1EFtyixvhunlTZ9HAnRFw6VUaIZSK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCeFnjms; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCeFnjms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751062188; x=1782598188;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=fcMBWJasJvBtOwVqtjd8pK6FI6UzxR4uC3D2v2Lcuh8=;
  b=oCeFnjms5icctn3BbLO9Y+BqaD2nCfrTm0wOCEoVdiTEcEYwCZhQ8lOP
   HPIdCeN1764dVfSxZohvu5Fnw1H+wiXNeL3P1uTb5q7sIZYmZtLysjSOU
   b6pxDv59daPDS+eBg6pExtmbBlZQqwTOyge371s8tTpm0gB6vMXMcrOnu
   2PVEHcpXLfKT51AkxvQXqSHZnJZI3sNTfjxzcLeAb8D8wW0Lymb28GMnE
   nmbjBvSJsfp1zSDVDxWlUvQ7mmmKE073fvV0ciFGKU/GdbpEBDDp/gU4G
   bHa34KOX0xs9QNk7x5gsh/u+L4R42KZfXqUraV77FW66SQaJS2FkW/xxQ
   Q==;
X-CSE-ConnectionGUID: Jx0s0+2bSe2EfV51G0+x4A==
X-CSE-MsgGUID: /KvCJ48lRTKtlBy5IIbopw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="78822289"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="78822289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:09:46 -0700
X-CSE-ConnectionGUID: aY0ag1SxR2+fJFK1Nv5Ang==
X-CSE-MsgGUID: B11pA5GkQqOuScFCkKxmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="158418859"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:09:45 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 27 Jun 2025 15:09:04 -0700
Subject: [PATCH] send-pack: clean up extra_have oid array
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIAWX2gC/x2MQQqAIBAAvxJ7bmGT0ugr0UFsq82wUIgg/HvSc
 WBmXkgchRMM1QuRb0lyhgJNXYHbbFgZZS4MilRHWhncPS7y4MHWY+Iw42WdR25NbzSRWzRBaa/
 Ixfq/45TzB15p6m9nAAAA
X-Change-ID: 20250627-jk-fix-leak-send-pack-e4787600cf60
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.15-dev-2503c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558;
 i=jacob.keller@gmail.com; h=from:subject:message-id;
 bh=7HrwyvfpRdNpt/1IdizJI/o0nLIW8McqBiCca3tF9z0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhox4sZWcTE9cRE9n3PUrULV+q1/pKcjqeVxyjYbHrxm7Y
 3Rv7I3pKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCJf3jP8z44PDl/4m6m/yGff
 hiWMN1Z5z/ocdfhOJevi18uvVRQuXMjwz0RCnmf1h4uehfc38OctPMmqmnkqQcJms0xroMfxlt2
 6zAA=
X-Developer-Key: i=jacob.keller@gmail.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jacob Keller <jacob.keller@gmail.com>

Commit c8009635785e ("fetch-pack, send-pack: clean up shallow oid
array", 2024-09-25) cleaned up the shallow oid array in cmd_send_pack,
but didn't clean up extra_have, which is still leaked at program exit.
I suspect the particular tests in t5539 don't trigger any additions to
the extra_have array, which explains why the tests can pass leak free
despite this gap.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I didn't check to see why the t5539 tests don't leak. This leak occured for
me in a day-to-day run with my local git build that happened to still have
sanitizers enabled:

=================================================================
==2930359==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 2160 byte(s) in 1 object(s) allocated from:
    #0 0x7f51af6e5e2b in realloc.part.0 (/lib64/libasan.so.8+0xe5e2b) (BuildId: 7f1aa7e2e600e8c9d54ce6e3d36f3d31bfe7949a)
    #1 0x0000010dfc26 in xrealloc ../wrapper.c:140
    #2 0x000000c5d231 in oid_array_append ../oid-array.c:9
    #3 0x00000096036a in process_ref ../connect.c:296
    #4 0x00000096036a in get_remote_heads ../connect.c:374
    #5 0x00000072f8fc in cmd_send_pack ../builtin/send-pack.c:290
    #6 0x0000007d74d4 in run_builtin ../git.c:480
    #7 0x0000007d74d4 in handle_builtin ../git.c:746
    #8 0x0000007dbeb5 in run_argv ../git.c:813
    #9 0x0000007dbeb5 in cmd_main ../git.c:953
    #10 0x000000441dbf in main ../common-main.c:9
    #11 0x7f51aec115f4 in __libc_start_call_main (/lib64/libc.so.6+0x35f4) (BuildId: 2b3c02fe7e4d3811767175b6f323692a10a4e116)
    #12 0x7f51aec116a7 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x36a7) (BuildId: 2b3c02fe7e4d3811767175b6f323692a10a4e116)
    #13 0x0000004440b4 in _start (/home/jekeller/libexec/git-core/git+0x4440b4) (BuildId: 6cd37a01505f2d67a4e7d39fd9f813b683be0300)

SUMMARY: AddressSanitizer: 2160 byte(s) leaked in 1 allocation(s)
---
 builtin/send-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c6e0e9d05186..61486e378cab 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
 	free_refs(remote_refs);
 	free_refs(local_refs);
 	refspec_clear(&rs);
+	oid_array_clear(&extra_have);
 	oid_array_clear(&shallow);
 	clear_cas_option(&cas);
 	return ret;

---
base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
change-id: 20250627-jk-fix-leak-send-pack-e4787600cf60

Best regards,
--  
Jacob Keller <jacob.keller@gmail.com>

