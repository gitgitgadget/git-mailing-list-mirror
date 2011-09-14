From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] credential-store: use a better storage format
Date: Wed, 14 Sep 2011 15:21:17 -0400
Message-ID: <20110914192117.GE28267@sigill.intra.peff.net>
References: <20110914191704.GA23201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3v1R-0004tx-5a
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419Ab1INTVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:21:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36163
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430Ab1INTVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:21:19 -0400
Received: (qmail 13801 invoked by uid 107); 14 Sep 2011 19:22:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 15:22:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 15:21:17 -0400
Content-Disposition: inline
In-Reply-To: <20110914191704.GA23201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181393>

In the name of simplicity, the credential-store helper
re-used git's config file format for on-disk storage of
credentials. The scheme looked something like this:

  [credential "unique-context"]
	username = foo
	password = bar

This works fine if you have only one credential for each
context. But there's no good way to store separate passwords
for user1@unique-context versus user2@unique-context. For
end users, this meant that:

  1. Trying to access user2@host when you already have a
     cached credential for user1@host would return user2's
     username with user1's password.

  2. The stored result would also mix the credentials.

  3. Rejection would remove all entries for the host,
     regardless of username.

You can hack around it by assuming that order is important,
and that:

  [credential "unique-context"]
	username = user1
	password = pass1
	username = user2
	password = pass2

refers to two distinct credentials. But the config code
isn't well setup for that. You have to keep track of the
last username field you parsed, and assume the next password
field after it is associated with it. Which isn't too bad.
But removing just one credential (which we need to do for
--reject) is impossible.  You can say "delete the username
field that is user2", but there is no way to say "delete
the password field that comes right after the username field
that is user2" (it's tempting to find the password for user2
and say "delete the password field that is pass2", but
that's not strictly correct either).

Instead, let's define a new, very simple storage format.
Each line is a credential containing three tokens: unique,
username, and password. Each is separated by a space, and
shell-quoted to avoid ambiguity.

There's now an additional test that we can differentiate the credentials
correctly (matching the similar test we already have for
credential-cache). The test for removing credentials is also enhanced to
check that removing one credential leaves an unrelated one stored.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential-store.c     |  119 ++++++++++++++++++++++++++++++++++++++++++------
 t/t0300-credentials.sh |   38 ++++++++++++++-
 2 files changed, 140 insertions(+), 17 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 8ab8582..aae8e0c 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -2,40 +2,129 @@
 #include "credential.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "quote.h"
+
+static struct lock_file credential_lock;
+
+static int parse_credential_file(const char *fn,
+				 struct credential *c,
+				 int (*match_cb)(const char *username,
+						 const char *password,
+						 struct credential *c),
+				 int (*other_cb)(const char *buf))
+{
+	FILE *fh;
+	struct strbuf buf = STRBUF_INIT;
+	const char **argv = NULL;
+	int alloc = 0;
+	int retval = 0;
+
+	fh = fopen(fn, "r");
+	if (!fh)
+		return errno == ENOENT ? 0 : -1;
+
+	while (strbuf_getwholeline(&buf, fh, '\n') != EOF) {
+		int nr = 0;
+		char *pristine = xstrdup(buf.buf);
+
+		strbuf_trim(&buf);
+		if (!sq_dequote_to_argv(buf.buf, &argv, &nr, &alloc) &&
+		    nr == 3 &&
+		    !strcmp(c->unique, argv[0]) &&
+		    (!c->username || !strcmp(c->username, argv[1]))) {
+			if (match_cb(argv[1], argv[2], c) < 0) {
+				retval = -1;
+				break;
+			}
+		}
+		else if (other_cb) {
+			if (other_cb(pristine) < 0) {
+				retval = -1;
+				break;
+			}
+		}
+		free(pristine);
+	}
+
+	free(argv);
+	strbuf_release(&buf);
+	fclose(fh);
+	return retval;
+}
+
+
+static int copy_credential(const char *username, const char *password,
+			   struct credential *c)
+{
+	if (!c->username)
+		c->username = xstrdup(username);
+	free(c->password);
+	c->password = xstrdup(password);
+	return 0;
+}
 
 static int lookup_credential(const char *fn, struct credential *c)
 {
-	config_exclusive_filename = fn;
-	credential_from_config(c);
+	if (!c->unique)
+		return 0;
+	parse_credential_file(fn, c, copy_credential, NULL);
 	return c->username && c->password;
 }
 
-static void store_item(const char *fn, const char *unique,
-		       const char *item, const char *value)
+static int skip_match(const char *username, const char *password,
+		      struct credential *c)
 {
-	struct strbuf key = STRBUF_INIT;
+	return 0;
+}
 
-	if (!unique)
-		return;
+static int print_entry(const char *buf)
+{
+	return write_in_full(credential_lock.fd, buf, strlen(buf));
+}
 
-	config_exclusive_filename = fn;
+static int rewrite_credential_file(const char *fn, struct credential *c,
+				   int replace)
+{
 	umask(077);
+	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
+		return -1;
+	if (parse_credential_file(fn, c, skip_match, print_entry) < 0) {
+		rollback_lock_file(&credential_lock);
+		return -1;
+	}
+	if (replace) {
+		struct strbuf buf = STRBUF_INIT;
+		int r;
 
-	strbuf_addf(&key, "credential.%s.%s", unique, item);
-	git_config_set(key.buf, value);
-	strbuf_release(&key);
+		sq_quote_buf(&buf, c->unique);
+		strbuf_addch(&buf, ' ');
+		sq_quote_buf(&buf, c->username);
+		strbuf_addch(&buf, ' ');
+		sq_quote_buf(&buf, c->password);
+		strbuf_addch(&buf, '\n');
+
+		r = write_in_full(credential_lock.fd, buf.buf, buf.len);
+		strbuf_release(&buf);
+		if (r < 0) {
+			rollback_lock_file(&credential_lock);
+			return -1;
+		}
+	}
+	return commit_lock_file(&credential_lock);
 }
 
 static void store_credential(const char *fn, struct credential *c)
 {
-	store_item(fn, c->unique, "username", c->username);
-	store_item(fn, c->unique, "password", c->password);
+	if (!c->unique || !c->username || !c->password)
+		return;
+	rewrite_credential_file(fn, c, 1);
 }
 
 static void remove_credential(const char *fn, struct credential *c)
 {
-	store_item(fn, c->unique, "username", NULL);
-	store_item(fn, c->unique, "password", NULL);
+	if (!c->unique)
+		return;
+	rewrite_credential_file(fn, c, 0);
 }
 
 int main(int argc, const char **argv)
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 41ab8cc..613c3fb 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -314,6 +314,30 @@ test_expect_success 'credential-store requires matching unique token' '
 	EOF
 '
 
+test_expect_success 'credential-store requires matching usernames' '
+	test_when_finished "rm -f .git-credentials" &&
+	check --unique=host store <<-\EOF &&
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	test_when_finished "rm -f askpass-password" &&
+	echo other-password >askpass-password &&
+	check --unique=host --username=other store <<-\EOF &&
+	username=other
+	password=other-password
+	--
+	askpass: Password:
+	EOF
+	check --unique=host --username=askpass-username store <<-\EOF
+	username=askpass-username
+	password=askpass-password
+	--
+	EOF
+'
+
 test_expect_success 'credential-store removes rejected credentials' '
 	test_when_finished "rm -f .git-credentials" &&
 	check --unique=host store <<-\EOF &&
@@ -323,16 +347,26 @@ test_expect_success 'credential-store removes rejected credentials' '
 	askpass: Username:
 	askpass: Password:
 	EOF
+	check --unique=host --username=other store <<-\EOF &&
+	username=other
+	password=askpass-password
+	--
+	askpass: Password:
+	EOF
 	check --reject --unique=host --username=askpass-username store <<-\EOF &&
 	--
 	EOF
-	check --unique=host store <<-\EOF
+	check --unique=host --username=askpass-username store <<-\EOF &&
 	username=askpass-username
 	password=askpass-password
 	--
-	askpass: Username:
 	askpass: Password:
 	EOF
+	check --unique=host --username=other store <<-\EOF
+	username=other
+	password=askpass-password
+	--
+	EOF
 '
 
 test_done
-- 
1.7.6.252.ge9c18
