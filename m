Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632E273D9A
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647231; cv=none; b=DSi6x+eHUMUf1dVUSslU6+s6iuenjI4REOw5A3vnxjycGsKqqqBz0WBv+WxVOuNH6rW5AUDWZI66ITCwRjDjLgLyeIESwZ9SNUabPzgWdy/sx4r/gA/81i+SJlhPlOdPFPwWWn8bEyvITN3lJcOgKvRbFFNCKr/rDh5GiCuOuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647231; c=relaxed/simple;
	bh=swIHskq0jXvOB5B0qAaqFGBZzQg4OvG8LAod6ZtA/Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2RRtFgsHZCOIpkV0Tsc8h6YtI3sJA3uux0V/Y1nvq0k5fPFXXmJN+00PUkkst1PylwcMAjJjPXUEueXduC8Y/Ce6DiV636LG0Vz+nY+iKmcZSi+CtmbURjn9wNy99MVtpKHaEG0ACTRZWp7p3lHjxCjhdqTKupVFaLyPZ3Fv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=IZScnw4S; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IZScnw4S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754647226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMVSlFwLJM6XE42od8ZXGr7MKMD/nkDLeLb/f8RGt6E=;
	b=IZScnw4SRy62D1KnCFmmSc3FbvpzFDz8edtWe1rcq5B+krgROtFJvcKXxjsswPsD4cJdhf
	S9WcgpxvqwRmrrDgXCXDnd2D3mOLHQ26sx/Ennrb/RnFCLRp5NFf90yTiWv4I9oGlwJ+je
	C2eFXmTy3ZH9U72YOKYWnm5e6TVIciw=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 2/2] t0450: add allowlist for builtins with missing .adoc
Date: Fri,  8 Aug 2025 11:59:43 +0200
Message-ID: <20250808095943.3312265-3-toon@iotcl.com>
In-Reply-To: <20250804073002.1586332-1-toon@iotcl.com>
References: <20250804073002.1586332-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Before we were silently skipping all builtins that don't have a matching
.adoc file. This is overly loose and might skip documentation files
when it shouldn't, for example when there was a typo in the filename.

To ensure no new builtins are added without documentation, add an
allowlist: t0450/adoc-missing. In this file only builtin commands that
do *not* have a corresponding .adoc file shall be listed. If there is a
mismatch, fail the test. This should force future contributions to
either add an .adoc, or add the builtin name to the allowlist file.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/t0450-txt-doc-vs-help.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index da2d0af5b0..980130be78 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -112,10 +112,16 @@ do
 	adoc="$(builtin_to_adoc "$builtin")" &&
 	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-	if test -f "$adoc"
+	# if and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing
+	result=success
+	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
 	then
 		test_set_prereq "$preq"
+		result=failure
 	fi &&
+	test_expect_$result "$builtin appropriately marked as having missing .adoc" '
+		test -f "$adoc"
+	'
 
 	# *.adoc output assertions
 	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
-- 
2.50.1.327.g047016eb4a

