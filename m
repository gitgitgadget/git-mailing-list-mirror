Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD11A286
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058625; cv=none; b=IVI8+XAfMd0q/t5xyEb+KH/XdkjRyP3si41knjB+tNVoIzcgDk9K9AAfNsfcwXNuwAngiLK+BehP6fJglFXYlHPFyc0AciDiWHFE/JPR6sxFNLg7n0ZAjxnOcu/o9Sx5ei63TCI9JnD/iVorwu6O+vQoO/AOBHBFM2axi2rfE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058625; c=relaxed/simple;
	bh=OOcab8Ehb4vNL9I39sBRFIRtuKJg+c6G5Lx9ZoG7/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S74PHU21z/N4AXDOmMwuc69skPKWtl+Jp2ys6ZISyZfhF0DEFZHb32b+m1Mut8lURZt06ufGPZQHNzz36D7Kn3kcs5lW0ue6sZZ7AqH1xlxQwVj+/WvQ9Vkfj2tILBOYn5nD2vr2Rzc6AvQXHe32mTrjsMNKjr9IU3PFB3glLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=N2r2IhND; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="N2r2IhND"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5Wszqwc; Sat, 27 Jul 2024 05:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058526;
	bh=OOcab8Ehb4vNL9I39sBRFIRtuKJg+c6G5Lx9ZoG7/Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2r2IhND4Jp2qmCYgOLNa/hHio6sVbYDR/QWx/sY2ZUFqwWACmOTS9EMwi01nq3Bc
	 l0X9znmoyVxXMoYKr5Y+HwWpsJkZk/9VAMofk+clhKXWL8hIuQ0EKU0LyAez43nrkI
	 JTsarkvLEAv/IatLjE8Wk7d4TUxOK7f3Eczwg3cyJO/oXxdt1okrxuNMTKjWie5hvC
	 F3l6nvTtpUbTzpoTr1W/dFmiZzo7J+7Mv3/xMvdTSWJoPl/v6xDxC6tM1QI3SQaMUX
	 O3XfCXMdD5u/Gl/hQo5SPK2u0pOIm3jZN3VsVBF84IQMkYXoThXJpOnED856KHbcvh
	 Qo1Ponhb/0aNw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871e
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=46kcjEQM1sjoQMFQ3FAA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/5] check-non-portable-shell: improve `VAR=val shell-func` detection
Date: Sat, 27 Jul 2024 01:35:09 -0400
Message-ID: <20240727053509.34339-6-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727053509.34339-1-ericsunshine@charter.net>
References: <20240726081522.28015-1-ericsunshine@charter.net>
 <20240727053509.34339-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBJY2PIqsITYWAVvn4y+J5Jc2KoYlau1VQl6LMdL6dirhj0Rle7wBJ1s54b1HW6wCoOi8kch1LJoq+kWB9MsQPqlv0IQaYtJclDtDVh3oOQGwv2eACNy
 B9GS0RfaFQRIrrCnVyWZECWqY1bbuiRZgbP1xaHtVgy1VFGUjFyjoRpzhTSQpFAFSYNKOKkGbg+ecqh+7od3bTzOpMuYzl3i4hj1vOZKnpA2wrcRCuJBVJ8L
 /wrX8OB/lt8RovtK7//QLMIJ0iG/53nbq1+ZaxLGqzcBNUkTJhGFLnr2rP2oCyFYPCaZkLvrlsrb6ubms5rveiYdbQ4lkUJ6Hb/vYqgkKByxAWCJJGVH0gZ1
 7s8zIzV0

From: Eric Sunshine <sunshine@sunshineco.com>

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
function. Indeed the behavior differs between shell implementations and
even different versions of the same shell, thus should be avoided.

As such, check-non-portable-shell.pl warns when it detects such usage.
However, a limitation of the check is that it only detects such
invocations when variable assignment (i.e. `VAR=val`) is the first thing
on the line. Thus, it can easily be fooled by an invocation such as:

    echo X | VAR=val shell-func

Address this shortcoming by loosening the check so that the variable
assignment can be recognized even when not at the beginning of the line.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 903af14294..6ee7700eb4 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -49,7 +49,7 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
-	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
+	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';
 	$line = '';
 	# this resets our $. for each file
-- 
2.45.2

