Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AF79F5
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631693; cv=none; b=k1k/p+2aa09Lxf+XnUmrZtoovezD2+5v0NkjEOV+Gw2kA/9Ba4mJ2wpkMfVtkjtvLKU1haY9DoPI+BYYpiR+U7agpfawvHKhr+edzwR7aqLg5T4gM40pZh9QPVCLjt/0hSBdDm1Aiodlqh2kgHBAu4rC6eFvkXsKQ7KgZvmY348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631693; c=relaxed/simple;
	bh=rQCs9qzUuPPDjweHat98e/6punUwV6cE3F1lasJp11Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH5I0ttkyKEyF3/1hAm68rvxngbmHM5DXuRd9YzD12o0gvjhb8Tt/j8VWR4IeKxm8LWhvuUhI9Iqy74XT4OXFWYwPwtZSZRrSUMf4T7QYGrGCaJUuaPDUNlEa6SAEMUtv5Rj4RO2jZyIfdLfpTyg9F2ZAvSxMDDk2mTjcYqGLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=GKd4a9lw; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="GKd4a9lw"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Vn1PsPWKO6kyQVn1WsyViy; Mon, 22 Jul 2024 06:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721631595;
	bh=rQCs9qzUuPPDjweHat98e/6punUwV6cE3F1lasJp11Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKd4a9lwvhUKZzXMTb4nxISpnn3qa1u5RfZ2Ymdixg8frZ1/R3unC9tPDGVkFqON9
	 +c3E8sON+dhpSbfJgxoA82Z8PKVnZE/rTpG4js+cnCYeIN5Bdv4VNCMTqTUcnxlnZV
	 Lzgrv7Pj604Ctn1NksngSUs4ovvKwdgYSRE29UmlKpfFOTcZwyghGM2UoFLm9LVR5I
	 BlcWf7caG64C2fjwcA4wnkczuRa95tbinhimSBghjDnced+6WzvbwDubx7ks0tNFYW
	 pIPOArWybcyGuhd8vTDyNzDEPK3PGb1t35UO1ot7MJ0kAEKLLeZOIZdW1WU/JJNbHB
	 dg3DLTYwf6g+Q==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=669e036b
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=46kcjEQM1sjoQMFQ3FAA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] check-non-portable-shell: improve `VAR=val shell-func` detection
Date: Mon, 22 Jul 2024 02:59:13 -0400
Message-ID: <20240722065915.80760-4-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK654EkRlGYxjL4b4/f9qU7qg3N5wjZgQCRwYOJj9qrcE9pNr1nbK5o4tYl8jmyESG+69SiDIEMoA6etlxcjc71CJPFs5qgCcN+eyhMayf8MR3e4xeej
 ODYLJ0OxuaSfjrHPGFEXqnjOe7PGuGe3FxHQTWeina6rfqAuLn4Tv1y6wy/LU/rEkmXY3MiWbQsrcr1HhRZ4BZyC0E95TvREh+RtOrdmPY47yKPHwtXjTbjk
 vDLO0s1BgfdCPqytbC/vmKlrV89XkAYq7R/dXoXIdyBSV3UwiFoWF75w1GZbHMNZ

From: Eric Sunshine <sunshine@sunshineco.com>

Unlike "VAR=val cmd" one-shot environment variable assignments which
exist only for the invocation of 'cmd', those assigned by "VAR=val
shell-func" exist within the running shell and continue to do so until
the process exits. check-non-portable-shell.pl warns when it detects
such usage since, more often than not, the author who writes such an
invocation is unaware of the undesirable behavior.

However, a limitation of the check is that it only detects such
invocations when variable assignment (i.e. `VAR=val`) is the first
thing on the line. Thus, it can easily be fooled by an invocation such
as:

    echo X | VAR=val shell-func

Address this shortcoming by loosening the check so that the variable
assignment can be recognized even when not at the beginning of the line.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b2b28c2ced..44b23d6ddd 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -49,7 +49,7 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
-	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
+	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
 	$line = '';
 	# this resets our $. for each file
-- 
2.45.2

