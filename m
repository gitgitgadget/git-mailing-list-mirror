From: Jeff King <peff@peff.net>
Subject: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 05:51:35 -0500
Message-ID: <20160226105135.GA30215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 11:51:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZFzv-0001ts-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 11:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbcBZKvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 05:51:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:49967 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753653AbcBZKvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 05:51:38 -0500
Received: (qmail 3514 invoked by uid 102); 26 Feb 2016 10:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:51:38 -0500
Received: (qmail 2838 invoked by uid 107); 26 Feb 2016 10:51:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:51:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 05:51:35 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287565>

Sine the credential.helper key is a multi-valued config
list, there's no way to "unset" a helper once it's been set.
So if your system /etc/gitconfig sets one, you can never
avoid running it, but only add your own helpers on top.

Since an empty value for credential.helper is nonsensical
(it would just try to run "git-credential-"), we can assume
nobody is using it. Let's define it to reset the helper
list, letting you override lower-priority instances which
have come before.

Signed-off-by: Jeff King <peff@peff.net>
---
This doesn't solve the multi-value config problem in the general sense,
but it's simple and easy. And even if we do solve it later, it's not a
big deal to keep supporting this scheme for compatibility.

 Documentation/config.txt         |  5 +++--
 Documentation/gitcredentials.txt |  5 +++++
 credential.c                     |  9 ++++++---
 t/t0300-credentials.sh           | 11 +++++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..4b85095 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1113,8 +1113,9 @@ commit.template::
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
-	storage to avoid prompting the user for the credentials. See
-	linkgit:gitcredentials[7] for details.
+	storage to avoid prompting the user for the credentials. Note
+	that multiple helpers may be defined. See linkgit:gitcredentials[7]
+	for details.
 
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1c75be0..f3a75d1 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -106,6 +106,11 @@ variable, each helper will be tried in turn, and may provide a username,
 password, or nothing. Once Git has acquired both a username and a
 password, no more helpers will be tried.
 
+If `credential.helper` is configured to the empty string, this resets
+the helper list to empty (so you may override a helper set by a
+lower-priority config file by configuring the empty-string helper,
+followed by whatever set of helpers you would like).
+
 
 CREDENTIAL CONTEXTS
 -------------------
diff --git a/credential.c b/credential.c
index 7d6501d..aa99666 100644
--- a/credential.c
+++ b/credential.c
@@ -63,9 +63,12 @@ static int credential_config_callback(const char *var, const char *value,
 		key = dot + 1;
 	}
 
-	if (!strcmp(key, "helper"))
-		string_list_append(&c->helpers, value);
-	else if (!strcmp(key, "username")) {
+	if (!strcmp(key, "helper")) {
+		if (*value)
+			string_list_append(&c->helpers, value);
+		else
+			string_list_clear(&c->helpers, 0);
+	} else if (!strcmp(key, "username")) {
 		if (!c->username)
 			c->username = xstrdup(value);
 	}
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index d7ef44b..03bd31e 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -298,4 +298,15 @@ test_expect_success 'helpers can abort the process' '
 	test_cmp expect stdout
 '
 
+test_expect_success 'empty helper spec resets helper list' '
+	test_config credential.helper "verbatim file file" &&
+	check fill "" "verbatim cmdline cmdline" <<-\EOF
+	--
+	username=cmdline
+	password=cmdline
+	--
+	verbatim: get
+	EOF
+'
+
 test_done
-- 
2.7.2.767.g705917e
