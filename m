Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69D376F2
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508942; cv=none; b=l4R8f3/Qy9uW0wXl5/DywK6eWvVRCb82IvcmDZIUfcLUsjVKyLqwCfLOLSejT7SzQsRpeWrPENoAhx52WE4r+ee1rEtuabcpt7OLHEcr6xkXCNWRpP2fwiwYJ90c6oyPDRiG7svQoMYIRGKpeF2LhlyDEUoeOU4D+kBoV67fAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508942; c=relaxed/simple;
	bh=gEfBUDKX+EWZo3N3NKgqHpPTnsDGdGR/xxS11ufNp2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugQo5HEpoANp/sXrr3j50MR3KJCcQpL0vAPNDmRB9i0y5+w3qu5d1FWfzEGYvaqQVrPso+RSpfp1LszOrfLB14zUrUktBz5p8V1OZ9CVrGdUtpSBBQkJMS+t/AJSSMk1dvjY1R5bfI2RtA4SuAFvQRI6LOzqEmZK7fXLcrN9DtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wa3NWp29; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wa3NWp29"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710508936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7Gw5d1TeGDpnKKQ36qq48VDYbrVBiARUshLsZHnnwQ=;
	b=wa3NWp29YFPYa4aHK9YQUw9aRVG5Kh3BydDYJTLdY0xNXcHC/FPVE1VqRCajs9vkZG9wQt
	rTUzw46UD4ajdoLwr61j6C/B4mMQdIndZ2ilf/0OIj+6WZdTjpXXwwrCD+uqVLY9JIJ04k
	dXvlazOtDiyGdQ+y75zZdonxv3FqRBkNkKtSgZIg+AukHA2M7H8F8rARlr9LOA8tLAIr36
	wSusP64Tw/CLFe3NmyliCSvvdCc+BgyruLNnlmK+P5QhSNbaUKMUBddd6lJECmLVt1Q7xS
	F3B2KupLh8GNN/rCLR++LyUxBQ9Ag20y3vLDdKyB+G68FGdkcoSn22BllJJigg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 3/4] t1300: add more tests for whitespace and inline comments
Date: Fri, 15 Mar 2024 14:22:09 +0100
Message-Id: <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710508691.git.dsimic@manjaro.org>
References: <cover.1710508691.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a handful of additional automated tests, to improve the coverage of
configuration file entries whose values contain internal whitespace, leading
and/or trailing whitespace, or which contain an additional inline comment.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 t/t1300-config.sh | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..6eef8a48098c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,96 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+cat > .git/config << EOF
+[section]
+	solid = rock
+	sparse = big 		 blue
+	sparseAndTail = big 		 blue 
+	sparseAndTailQuoted = "big 		 blue "
+	sparseAndBiggerTail = big 		 blue 	 	
+	sparseAndBiggerTailQuoted = "big 		 blue 	 	"
+	sparseAndBiggerTailQuotedPlus =  "big 		 blue 	 	"	 
+	headAndTail = 	big blue 
+	headAndTailQuoted = "	big blue "
+	headAndTailQuotedPlus =  "	big blue " 
+	annotated = big blue	# to be discarded
+	annotatedQuoted = "big blue"	# to be discarded
+EOF
+
+echo 'rock' > expect
+
+test_expect_success 'no internal whitespace' '
+	git config --get section.solid > output &&
+	test_cmp expect output
+'
+
+echo 'big 		 blue' > expect
+
+test_expect_success 'internal whitespace' '
+	git config --get section.sparse > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'internal and trailing whitespace' '
+	git config --get section.sparseAndTail > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'internal and more trailing whitespace' '
+	git config --get section.sparseAndBiggerTail > output &&
+	test_cmp expect output
+'
+
+echo 'big 		 blue ' > expect
+
+test_expect_success 'internal and trailing whitespace, all quoted' '
+	git config --get section.sparseAndTailQuoted > output &&
+	test_cmp expect output
+'
+
+echo 'big 		 blue 	 	' > expect
+
+test_expect_success 'internal and more trailing whitespace, all quoted' '
+	git config --get section.sparseAndBiggerTailQuoted > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'internal and more trailing whitespace, not all quoted' '
+	git config --get section.sparseAndBiggerTailQuotedPlus > output &&
+	test_cmp expect output
+'
+
+echo 'big blue' > expect
+
+test_expect_success 'leading and trailing whitespace' '
+	git config --get section.headAndTail > output &&
+	test_cmp expect output
+'
+
+echo '	big blue ' > expect
+
+test_expect_success 'leading and trailing whitespace, all quoted' '
+	git config --get section.headAndTailQuoted > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'leading and trailing whitespace, not all quoted' '
+	git config --get section.headAndTailQuotedPlus > output &&
+	test_cmp expect output
+'
+
+echo 'big blue' > expect
+
+test_expect_success 'inline comment' '
+	git config --get section.annotated > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'inline comment, quoted' '
+	git config --get section.annotatedQuoted > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'clear default config' '
 	rm -f .git/config
 '
@@ -1066,7 +1156,17 @@ test_expect_success '--null --get-regexp' '
 	test_cmp expect result
 '
 
-test_expect_success 'inner whitespace kept verbatim' '
+test_expect_success 'inner whitespace kept verbatim, spaces only' '
+	git config section.val "foo   bar" &&
+	test_cmp_config "foo   bar" section.val
+'
+
+test_expect_success 'inner whitespace kept verbatim, horizontal tabs only' '
+	git config section.val "foo		bar" &&
+	test_cmp_config "foo		bar" section.val
+'
+
+test_expect_success 'inner whitespace kept verbatim, horizontal tabs and spaces' '
 	git config section.val "foo 	  bar" &&
 	test_cmp_config "foo 	  bar" section.val
 '
