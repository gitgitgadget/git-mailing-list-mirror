From: Jeff King <peff@peff.net>
Subject: [PATCH 07/13] credential: add credential.*.username
Date: Thu, 24 Nov 2011 06:02:47 -0500
Message-ID: <20111124110247.GE8417@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX4x-0004iS-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab1KXLCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:02:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49644
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978Ab1KXLCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:02:49 -0500
Received: (qmail 10239 invoked by uid 107); 24 Nov 2011 11:02:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:02:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:02:47 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185902>

Credential helpers can help users avoid having to type their
username and password over and over. However, some users may
not want a helper for their password, or they may be running
a helper which caches for a short time. In this case, it is
convenient to provide the non-secret username portion of
their credential via config.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c           |    4 ++++
 t/t0300-credentials.sh |   13 +++++++++++++
 t/t5550-http-fetch.sh  |   16 ++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/credential.c b/credential.c
index 120ea62..06e4e15 100644
--- a/credential.c
+++ b/credential.c
@@ -65,6 +65,10 @@ static int credential_config_callback(const char *var, const char *value,
 
 	if (!strcmp(key, "helper"))
 		string_list_append(&c->helpers, value);
+	else if (!strcmp(key, "username")) {
+		if (!c->username)
+			c->username = xstrdup(value);
+	}
 
 	return 0;
 }
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index e3f61f4..57751a1 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -234,4 +234,17 @@ test_expect_success 'do not match configured credential' '
 	EOF
 '
 
+test_expect_success 'pull username from config' '
+	test_config credential.https://example.com.username foo &&
+	check fill <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	username=foo
+	password=askpass-password
+	--
+	askpass: Password for '\''https://foo@example.com'\'':
+	EOF
+'
+
 test_done
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 21e2f5d..18f4d59 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -113,6 +113,22 @@ test_expect_success 'http auth respects credential helper config' '
 	expect_askpass none
 '
 
+test_expect_success 'http auth can get username from config' '
+	test_config_global "credential.$HTTPD_URL.username" user@host &&
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-user &&
+	expect_askpass pass user@host
+'
+
+test_expect_success 'configured username does not override URL' '
+	test_config_global "credential.$HTTPD_URL.username" wrong &&
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-user2 &&
+	expect_askpass pass user@host
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
1.7.7.4.5.gb32a5
