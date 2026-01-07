Received: from mail-108-mta141.mxroute.com (mail-108-mta141.mxroute.com [136.175.108.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612919B5B1
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772405; cv=none; b=N8eYyKiqch756opkSBila6Enrkos9Dy0BoA/U9K0A6W+Dn6N2dkOE2fmI+w8QpRDEVsjX6GyHKtD56yxuqCareMyLuCYaF9kjhCVbcAV27kaMcnOCOs6f8PnZ/jE5pCaYenHCCYVpwlCajTs6xjzoEFoVYogCNbatcVORLmeipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772405; c=relaxed/simple;
	bh=g7KWoecvuz+ML5N26aN+WM7dMQvNN0BnDvmDre6l9ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEyYgVmDaSE3W7MULzuwT97T2b5gJGTT5AL6PrfQVYxkg9A5cHvO2jPqVLm/OEeRPqvV8VlTyDpijf9DgiJ73WhaxjiOnL0Kyf9qhPUxSudF7ifSAndW0e+JwXYzw1Esnb8uLUr8zpBIRZa37cbJ6kbOXLZOYdIxl3mW9wvaJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=Rljvvn17; arc=none smtp.client-ip=136.175.108.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="Rljvvn17"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta141.mxroute.com (ZoneMTA) with ESMTPSA id 19b976d82aa0004eea.003
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 07 Jan 2026 07:48:15 +0000
X-Zone-Loop: edbda4edae7a4af260a166b32372ab3488411d55581d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=c3+7BXft7B/y8CwVfzdei7GPDJee9TAqlfCHg01Cbp0=; b=Rljvvn
	17vGI7QX1u+L252pACtTg/AOteEDSbquBiuaw6+Ji5K2uycnJ03JDeQwEpcu1t3djx6Q7X3FCRj5H
	AoaZuubvQYGg907ULdJrvbLs2TCmsG8QqIOtFNTQSQpS8e9LlSPNM6LPR5tIcui90p4eu1wC76O2r
	rxNCvJegDUepVXOmYP5xmMAa69F2MChTn5ofVdf0nkPsl5QLUK//d8MQROrNoYLFWZEVl9xLjSUR3
	L5oRcNinSUwMFycdkg6o6nPJolb7nJZl3o7zt+vrH7RaLpxIKpH+6VmqVYwdcysJ4A/1gI2zc26aZ
	1mesfu56FMWjva+uPt7XOzjOTsUg==;
From: Ashlesh Gawande <git@ashlesh.me>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Ashlesh Gawande <git@ashlesh.me>
Subject: [PATCH v3] t5550: add netrc tests for http 401/403
Date: Wed,  7 Jan 2026 13:17:24 +0530
Message-ID: <20260107074724.13165-1-git@ashlesh.me>
In-Reply-To: <20260106114029.763351-1-git@ashlesh.me>
References: <20260106114029.763351-1-git@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me

git allows using .netrc file to supply credentials for HTTP auth.
Three test cases are added in this patch to provide missing coverage
when cloning over HTTP using .netrc file:

  - First test case checks that the git clone is successful when credentials
    are provided via .netrc file
  - Second test case checks that the git clone fails when the .netrc file
    provides invalid credentials. The HTTP server is expected to return
    401 Unauthorized in such a case. The test checks that the user is
    provided with a prompt for username/password on 401 to provide
    the valid ones.
  - Third test case checks that the git clone fails when the .netrc file
    provides credentials that are valid but do not have permission for
    this user. For example one may have multiple tokens in GitHub
    and uses the one which was not authorized for cloning this repo.
    In such a case the HTTP server returns 403 Forbidden.
    For this test, the apache.conf is modified to return a 403
    on finding a forbidden-user. No prompt for username/password is
    expected after the 403 (unlike 401). This is because prompting may wipe
    out existing credentials or conflict with custom credential helpers.

Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
---
Range-diff against v2:
1:  0b68f1d1af ! 1:  25ef751f28 t5550: add netrc tests for http 401/403
    @@ Metadata
      ## Commit message ##
         t5550: add netrc tests for http 401/403
     
    +    git allows using .netrc file to supply credentials for HTTP auth.
    +    Three test cases are added in this patch to provide missing coverage
    +    when cloning over HTTP using .netrc file:
    +
    +      - First test case checks that the git clone is successful when credentials
    +        are provided via .netrc file
    +      - Second test case checks that the git clone fails when the .netrc file
    +        provides invalid credentials. The HTTP server is expected to return
    +        401 Unauthorized in such a case. The test checks that the user is
    +        provided with a prompt for username/password on 401 to provide
    +        the valid ones.
    +      - Third test case checks that the git clone fails when the .netrc file
    +        provides credentials that are valid but do not have permission for
    +        this user. For example one may have multiple tokens in GitHub
    +        and uses the one which was not authorized for cloning this repo.
    +        In such a case the HTTP server returns 403 Forbidden.
    +        For this test, the apache.conf is modified to return a 403
    +        on finding a forbidden-user. No prompt for username/password is
    +        expected after the 403 (unlike 401). This is because prompting may wipe
    +        out existing credentials or conflict with custom credential helpers.
    +
         Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
     
      ## t/lib-httpd.sh ##

 t/lib-httpd.sh             | 13 +++++++++++--
 t/lib-httpd/apache.conf    |  4 ++++
 t/lib-httpd/passwd         |  1 +
 t/t5550-http-fetch-dumb.sh | 25 +++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5091db949b..5f42c311c2 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -319,13 +319,22 @@ setup_askpass_helper() {
 	'
 }
 
-set_askpass() {
+set_askpass () {
 	>"$TRASH_DIRECTORY/askpass-query" &&
 	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
 	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
 }
 
-expect_askpass() {
+set_netrc () {
+	# $HOME=$TRASH_DIRECTORY
+	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
+}
+
+clear_netrc () {
+	rm -f "$TRASH_DIRECTORY/.netrc"
+}
+
+expect_askpass () {
 	dest=$HTTPD_DEST${3+/$3}
 
 	{
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index e631ab0eb5..6b8c50a51a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -238,6 +238,10 @@ SSLEngine On
 	AuthName "git-auth"
 	AuthUserFile passwd
 	Require valid-user
+
+	# return 403 for authenticated user: forbidden-user@host
+	RewriteCond "%{REMOTE_USER}" "^forbidden-user@host"
+	RewriteRule ^ - [F]
 </Location>
 
 <LocationMatch "^/auth-push/.*/git-receive-pack$">
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index d9c122f348..3bab7b6423 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1,2 @@
 user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
+forbidden-user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ed0ad66fad..9530f01b9e 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -102,6 +102,31 @@ test_expect_success 'cloning password-protected repository can fail' '
 	expect_askpass both wrong
 '
 
+test_expect_success 'using credentials from netrc to clone successfully' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@host &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
+	expect_askpass none
+'
+
+test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@wrong &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
+	expect_askpass both wrong
+'
+
+test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
+	expect_askpass none &&
+	grep "The requested URL returned error: 403" err
+'
+
 test_expect_success 'http auth can use user/pass in URL' '
 	set_askpass wrong &&
 	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
-- 
2.43.0

