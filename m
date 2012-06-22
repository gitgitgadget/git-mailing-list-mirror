From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] git credential fill: output the whole 'struct credential'
Date: Fri, 22 Jun 2012 18:07:10 +0200
Message-ID: <1340381231-9522-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 22 18:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si6Rn-0004SK-78
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 18:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab2FVQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 12:10:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43449 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446Ab2FVQKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 12:10:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5MG70fR007522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 22 Jun 2012 18:07:00 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Si6OP-0004vO-0I; Fri, 22 Jun 2012 18:07:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Si6OO-0002UL-VH; Fri, 22 Jun 2012 18:07:28 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 22 Jun 2012 18:07:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5MG70fR007522
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340986021.53076@owY7lhk6ZhALhZog+SIjdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200443>

Instead of outputing only the username and password, print all the
attributes, even those that already appeared in the input.

This is closer to what the C API does, and allows one to take the exact
output of "git credential fill" as input to "git credential approve" or
"git credential reject".
---
Suggested by Jeff, and will be very nice to use from perl in the next
patch.

 Documentation/git-credential.txt | 15 +++++++++++----
 builtin/credential.c             |  5 +----
 credential.c                     |  2 +-
 credential.h                     |  1 +
 t/lib-credential.sh              | 25 +++++++++++++++++++++++++
 t/t0300-credentials.sh           | 14 ++++++++++++++
 6 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index b64ac30..67737de 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -62,11 +62,18 @@ credential description (don't forget the blank line at the end):
 
   2. Ask git-credential to give us a username and password for this
      description. This is done by running `git credential fill`,
-     feeding the description from step (1) to its stdin. The username
-     and password will be produced on stdout, like:
+     feeding the description from step (1) to its stdin. The complete
+     credential description will be produced on stdout, like:
 
+	protocol=https
+	host=example.com
 	username=bob
 	password=secr3t
++
+In most cases, this means the attributes given in the input will be
+repeated in the output, but git may also modify the credential
+description, for example by removing the `path` attribute when the
+protocol is HTTP(s) and `credential.useHttpPath` is false.
 
   3. Try to use the credential (e.g., by accessing the URL with the
      username and password from step (2)).
@@ -76,8 +83,8 @@ credential description (don't forget the blank line at the end):
      it can be marked with an "approve" action. If the credential was
      rejected during the operation, use the "reject" action. In either
      case, `git credential` should be fed with the credential
-     description obtained from step (2) together with the ones already
-     provided in step (1).
+     description obtained from step (2) (which also contain the ones
+     provided in step (1)).
 
 [[IOFMT]]
 INPUT/OUTPUT FORMAT
diff --git a/builtin/credential.c b/builtin/credential.c
index 4147314..b956059 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -19,10 +19,7 @@ int cmd_credential (int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(op, "fill")) {
 		credential_fill(&c);
-		if (c.username)
-			printf("username=%s\n", c.username);
-		if (c.password)
-			printf("password=%s\n", c.password);
+		credential_write(&c, stdout);
 	} else if (!strcmp(op, "approve")) {
 		credential_approve(&c);
 	} else if (!strcmp(op, "reject")) {
diff --git a/credential.c b/credential.c
index 62d1c56..2c40007 100644
--- a/credential.c
+++ b/credential.c
@@ -191,7 +191,7 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
-static void credential_write(const struct credential *c, FILE *fp)
+void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol);
 	credential_write_item(fp, "host", c->host);
diff --git a/credential.h b/credential.h
index 96ea41b..0c3e85e 100644
--- a/credential.h
+++ b/credential.h
@@ -26,6 +26,7 @@ void credential_approve(struct credential *);
 void credential_reject(struct credential *);
 
 int credential_read(struct credential *, FILE *);
+void credential_write(const struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
 int credential_match(const struct credential *have,
 		     const struct credential *want);
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 7c4826e..957ae93 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -62,6 +62,8 @@ helper_test() {
 		protocol=https
 		host=example.com
 		--
+		protocol=https
+		host=example.com
 		username=askpass-username
 		password=askpass-password
 		--
@@ -84,6 +86,8 @@ helper_test() {
 		protocol=https
 		host=example.com
 		--
+		protocol=https
+		host=example.com
 		username=store-user
 		password=store-pass
 		--
@@ -95,6 +99,8 @@ helper_test() {
 		protocol=http
 		host=example.com
 		--
+		protocol=http
+		host=example.com
 		username=askpass-username
 		password=askpass-password
 		--
@@ -108,6 +114,8 @@ helper_test() {
 		protocol=https
 		host=other.tld
 		--
+		protocol=https
+		host=other.tld
 		username=askpass-username
 		password=askpass-password
 		--
@@ -122,6 +130,8 @@ helper_test() {
 		host=example.com
 		username=other
 		--
+		protocol=https
+		host=example.com
 		username=other
 		password=askpass-password
 		--
@@ -143,6 +153,9 @@ helper_test() {
 		host=path.tld
 		path=bar.git
 		--
+		protocol=http
+		host=path.tld
+		path=bar.git
 		username=askpass-username
 		password=askpass-password
 		--
@@ -160,6 +173,8 @@ helper_test() {
 		protocol=https
 		host=example.com
 		--
+		protocol=https
+		host=example.com
 		username=askpass-username
 		password=askpass-password
 		--
@@ -186,6 +201,8 @@ helper_test() {
 		host=example.com
 		username=user1
 		--
+		protocol=https
+		host=example.com
 		username=user1
 		password=pass1
 		EOF
@@ -194,6 +211,8 @@ helper_test() {
 		host=example.com
 		username=user2
 		--
+		protocol=https
+		host=example.com
 		username=user2
 		password=pass2
 		EOF
@@ -210,6 +229,8 @@ helper_test() {
 		host=example.com
 		username=user1
 		--
+		protocol=https
+		host=example.com
 		username=user1
 		password=askpass-password
 		--
@@ -223,6 +244,8 @@ helper_test() {
 		host=example.com
 		username=user2
 		--
+		protocol=https
+		host=example.com
 		username=user2
 		password=pass2
 		EOF
@@ -244,6 +267,8 @@ helper_test_timeout() {
 		protocol=https
 		host=timeout.tld
 		--
+		protocol=https
+		host=timeout.tld
 		username=askpass-username
 		password=askpass-password
 		--
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 20e28e3..538ea5f 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -82,6 +82,9 @@ test_expect_success 'credential_fill passes along metadata' '
 	host=example.com
 	path=foo.git
 	--
+	protocol=ftp
+	host=example.com
+	path=foo.git
 	username=one
 	password=two
 	--
@@ -213,6 +216,8 @@ test_expect_success 'match configured credential' '
 	host=example.com
 	path=repo.git
 	--
+	protocol=https
+	host=example.com
 	username=foo
 	password=bar
 	--
@@ -225,6 +230,8 @@ test_expect_success 'do not match configured credential' '
 	protocol=https
 	host=bar
 	--
+	protocol=https
+	host=bar
 	username=askpass-username
 	password=askpass-password
 	--
@@ -239,6 +246,8 @@ test_expect_success 'pull username from config' '
 	protocol=https
 	host=example.com
 	--
+	protocol=https
+	host=example.com
 	username=foo
 	password=askpass-password
 	--
@@ -252,6 +261,8 @@ test_expect_success 'http paths can be part of context' '
 	host=example.com
 	path=foo.git
 	--
+	protocol=https
+	host=example.com
 	username=foo
 	password=bar
 	--
@@ -265,6 +276,9 @@ test_expect_success 'http paths can be part of context' '
 	host=example.com
 	path=foo.git
 	--
+	protocol=https
+	host=example.com
+	path=foo.git
 	username=foo
 	password=bar
 	--
-- 
1.7.11.5.g0c7e058.dirty
