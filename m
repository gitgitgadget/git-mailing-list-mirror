Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A0142E80
	for <git@vger.kernel.org>; Fri, 17 May 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972515; cv=none; b=nkEHZEQV/DHdOAW+Ed+CRTXWW5CklVvNzU6z5CTXBepn3gyxsbakkGfS1cMWNSOf4q7JAhOAO5Ioy3qaltwN7611MGUoNCY2Dq8M2Vzk7451zOm5r/B7VQ340hjIuzCmMbHV2zKiHQxFJpXVkQ0lLau+72Di0A7154saWQGKspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972515; c=relaxed/simple;
	bh=WsoZy9kBRq41285qjHZr7hBtQp/8qC8ddutA1ZiLU80=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BAn/v0cKpbSE/GMmJc/y1jLwWDPS/SZjR23CEDkOaJw46aG1kp6+5gI5xZbVzIG40zT/3boT5EWr1CyxEARTevPgzXd2kK3foi9JZL2F02yqlKFsqtT1cnQziqJlzgWzoDykigeQ0wg64t6RNC1laBwHSer3Z6uYgdxiwFxULMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 579 invoked from network); 17 May 2024 19:01:50 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 19:01:50 -0000
Date: Fri, 17 May 2024 21:01:49 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH v2] Switch grep from non-portable BRE to portable ERE
Message-ID: <ZkepnZhGEhSveN00@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This makes the grep usage fully POSIX compliant.  The ability to
enable ERE features in BRE using backslash is a GNU extension.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 mergetools/vimdiff           | 2 +-
 t/t1404-update-ref-errors.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 734d15a03b..f8ad6b35d4 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 		fi
 
 		# If this is a single window diff with all the buffers
-		if ! echo "$tab" | grep ",\|/" >/dev/null
+		if ! echo "$tab" | grep -E ",|/" >/dev/null
 		then
 			CMD="$CMD | silent execute 'bufdo diffthis'"
 		fi
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 98e9158bd2..67ebd81a4c 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -100,7 +100,7 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&
+	grep -E "fatal:( cannot lock ref $SQ$addname$SQ:)? $SQ$delref$SQ exists; cannot create $SQ$addref$SQ" output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format="%(objectname) %(refname)" $prefix/r >actual-refs &&
 	test_cmp expected-refs actual-refs
