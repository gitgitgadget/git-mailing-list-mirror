Received: from mail-108-mta13.mxroute.com (mail-108-mta13.mxroute.com [136.175.108.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B32877CF
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453461; cv=none; b=nyzOtAYxUnGlCISDX+BmldPWrWhba7fr67yDYkFKnZBVEMpVuF/9gMNgQq7P/NmN/e1Pf27YeH+kCMLOpaapys4XOp2Aa5PNj57aZqd+iKdmX2oA18p/i76gZZ9VJL8nCY72pYUBiNckg4Ncp+Jf8i2udoKXF9LBrTCxuolCKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453461; c=relaxed/simple;
	bh=00sbYbgbfJ2Lo89buZLkPGnTzsY0JsvIQtBC9SVLJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKUDTR14tzmSQboefsMprB8ptOzEYpwnYuNMCCkY+h3eaEfAmIskCVXHjQ45O2SdeswDf1X8xGMuWE/nuJKgfJQTF/VLSNrzCw98wmujyyFGSbKRgSTfHkipEBPx+RFs/Nm+phvbR0UqXF54xiW/ZrUHOCdNBAlv5lVe0JuhX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=dCCuTW7y; arc=none smtp.client-ip=136.175.108.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="dCCuTW7y"
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta13.mxroute.com (ZoneMTA) with ESMTPSA id 199e32f48f5000d597.005
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 14 Oct 2025 14:45:50 +0000
X-Zone-Loop: 5d2d30761eace4b3627ef5f727ed9b3bcdf383e13d2f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=iMH+9hoAsNa9oRxSdkgyvEFej3OdgpqUc+Rm8kkWMQ4=; b=dCCuTW7yAI7wEcYnU1v6M617eZ
	BrarJC0jz7FIY6LNIH0YpCPD0mVCVFM+fsjnSCwrXyi1oN1w0Kfz1Kq950nCUG7iVh+BN9UEiSPHZ
	sA8bCzMEKlW134zYgpVEFBDatwc4X5Of1A/QAWbGkdVGr0EmeCTq0WBttQp7KyQ/DUMsz7qESBnWE
	27NACTgwOlHc+vW1eIthUFRJUlBg4XzQmH7c04bfwbhp6aCNNIrJwhQOFFgb1el8i1xs2r9b4wfBr
	7H/lNZjFzWOtay7W0+ZFQlYYYUicwQBfWKDt6iAKIXzwllIZGbzf+lizXJtuoHQwZrJkIgFp5x4dx
	iqVqlrdQ==;
From: Ashlesh Gawande <git@ashlesh.me>
To: git@vger.kernel.org
Cc: Ashlesh Gawande <git@ashlesh.me>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] http.c: prompt for username on 403
Date: Tue, 14 Oct 2025 20:13:52 +0530
Message-ID: <20251014144354.1457818-2-git@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me

Scenario:
- There are a few pre-production systems that a lot of testers and
  developers need to time share because of low availability
- Devops generates a GitHub token with pull only access
  and adds it to the netrc file on these systems
  (Pull only as we don't want testers/others to be able to push)
- Testers log in and do a git pull for the latest changes
  (via netrc credentials - though testers may not be aware)
- Developers login to debug issues and may make fixes to the test repo
- Now when developers try to push their changes they receive:
  fatal: unable to access 'https://github.com/<org>/<project>/':
  The requested URL returned error: 403
- The developer is not given the chance to supply an authorized token
  and either needs to comment the netrc file or copy the changes over
  to their own machine

Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
---
 http.c                     |  2 +-
 t/lib-httpd.sh             |  9 +++++++++
 t/lib-httpd/apache.conf    |  4 ++++
 t/lib-httpd/passwd         |  1 +
 t/t5550-http-fetch-dumb.sh | 24 ++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 7e3af1e72f..18959f63b9 100644
--- a/http.c
+++ b/http.c
@@ -1852,7 +1852,7 @@ static int handle_curl_result(struct slot_results *results)
 		return HTTP_NOMATCHPUBLICKEY;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
-	else if (results->http_code == 401) {
+	else if (results->http_code == 401 || results->http_code == 403) {
 		if ((http_auth.username && http_auth.password) ||\
 		    (http_auth.authtype && http_auth.credential)) {
 			if (http_auth.multistage) {
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5091db949b..cdc92b2916 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -325,6 +325,15 @@ set_askpass() {
 	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
 }
 
+set_netrc() {
+	# $HOME=$TRASH_DIRECTORY
+	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc
+}
+
+clear_netrc() {
+	rm "$TRASH_DIRECTORY/.netrc"
+}
+
 expect_askpass() {
 	dest=$HTTPD_DEST${3+/$3}
 
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
index ed0ad66fad..6c4c1cafb2 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -102,6 +102,30 @@ test_expect_success 'cloning password-protected repository can fail' '
 	expect_askpass both wrong
 '
 
+test_expect_success 'using credentials from netrc to clone successfully' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@host &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
+	expect_askpass none
+'
+clear_netrc
+
+test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@wrong &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
+	expect_askpass both wrong
+'
+clear_netrc
+
+test_expect_success 'netrc authorized but forbidden credentials (prompt after 403)' '
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netc-403 &&
+	expect_askpass both wrong
+'
+clear_netrc
+
 test_expect_success 'http auth can use user/pass in URL' '
 	set_askpass wrong &&
 	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
-- 
2.43.0

