From: Jeff King <peff@peff.net>
Subject: [PATCHv3 07/13] credential: add credential.*.username
Date: Sat, 10 Dec 2011 05:31:30 -0500
Message-ID: <20111210103129.GG16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKDT-0005y2-DZ
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab1LJKbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:31:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47016
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab1LJKbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:31:32 -0500
Received: (qmail 14012 invoked by uid 107); 10 Dec 2011 10:38:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:38:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:31:30 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186739>

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
index 96be1c2..3c17ea1 100644
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
index 42d0f5b..53e94bc 100755
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
index c59908f..3262f90 100755
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
1.7.8.rc2.40.gaf387
