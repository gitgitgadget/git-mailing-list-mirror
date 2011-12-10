From: Jeff King <peff@peff.net>
Subject: [PATCH 1/1] contrib: add credential helper for OS X Keychain
Date: Sat, 10 Dec 2011 05:53:14 -0500
Message-ID: <20111210105314.GB16478@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:53:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKYn-0003lw-Om
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1LJKxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:53:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47077
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab1LJKxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:53:16 -0500
Received: (qmail 14585 invoked by uid 107); 10 Dec 2011 10:59:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:59:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:53:14 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186757>

On Sat, Dec 10, 2011 at 05:28:27AM -0500, Jeff King wrote:

> Here's the latest re-roll of the credential helpers series. I think this
> one is probably ready to go to 'next'.
> 
> It's rebased on the latest tip of 'master' (applying it to an older
> commit will get you a minor textual conflict in strbuf.c). It
> incorporates the erase-safety we discussed, fixes a few commit message
> typos, and tweaks the test scripts to make testing the external OS X
> helper a little easier.

And here is that helper.

-- >8 --
Subject: [PATCH] contrib: add credential helper for OS X Keychain

With this installed in your $PATH, you can store
git-over-http passwords in your keychain by doing:

  git config credential.helper osxkeychain

The code is based in large part on the work of Jay Soffian,
who wrote the helper originally for the initial, unpublished
version of the credential helper protocol.

This version will pass t0303 if you do:

  GIT_TEST_CREDENTIAL_HELPER=osxkeychain \
  GIT_TEST_CREDENTIAL_HELPER_SETUP="export HOME=$HOME" \
  ./t0303-credential-external.sh

The "HOME" setup is unfortunately necessary. The test
scripts set HOME to the trash directory, but this causes the
keychain API to complain.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried clever workarounds for the HOME thing, like running "security
create-keychain" in the trash directory. But if I try to create the
"login" keychain, it says it's already there! So it's like we're in a
weird limbo where we both have and do not have access to the keychains.

I'm not too concerned with the hackishness of my solution, though; this
isn't even a part of the regular test scripts, but just a thing you can
do manually to test the helper from contrib.

Many thanks to Jay for the initial version; even though this version is
quite chopped-up, having somebody else provide a nice example of how to
use the SecKeychain functions made it much easier. I tried to trim the
code down to the bare essentials to glue our input into the SecKeychain
API, and to show good practices for other helpers to follow.

I dropped the python version, as it is redundant and I didn't feel like
porting it to the new interface. It could be added on top if somebody
feels like converting it as an exercise. :)

 contrib/credential/osxkeychain/.gitignore          |    1 +
 contrib/credential/osxkeychain/Makefile            |   14 ++
 .../osxkeychain/git-credential-osxkeychain.c       |  173 ++++++++++++++++++++
 3 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential/osxkeychain/.gitignore
 create mode 100644 contrib/credential/osxkeychain/Makefile
 create mode 100644 contrib/credential/osxkeychain/git-credential-osxkeychain.c

diff --git a/contrib/credential/osxkeychain/.gitignore b/contrib/credential/osxkeychain/.gitignore
new file mode 100644
index 0000000..6c5b702
--- /dev/null
+++ b/contrib/credential/osxkeychain/.gitignore
@@ -0,0 +1 @@
+git-credential-osxkeychain
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
new file mode 100644
index 0000000..75c07f8
--- /dev/null
+++ b/contrib/credential/osxkeychain/Makefile
@@ -0,0 +1,14 @@
+all:: git-credential-osxkeychain
+
+CC = gcc
+RM = rm -f
+CFLAGS = -g -Wall
+
+git-credential-osxkeychain: git-credential-osxkeychain.o
+	$(CC) -o $@ $< -Wl,-framework -Wl,Security
+
+git-credential-osxkeychain.o: git-credential-osxkeychain.c
+	$(CC) -c $(CFLAGS) $<
+
+clean:
+	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
new file mode 100644
index 0000000..6beed12
--- /dev/null
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -0,0 +1,173 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <Security/Security.h>
+
+static SecProtocolType protocol;
+static char *host;
+static char *path;
+static char *username;
+static char *password;
+static UInt16 port;
+
+static void die(const char *err, ...)
+{
+	char msg[4096];
+	va_list params;
+	va_start(params, err);
+	vsnprintf(msg, sizeof(msg), err, params);
+	fprintf(stderr, "%s\n", msg);
+	va_end(params);
+	exit(1);
+}
+
+static void *xstrdup(const char *s1)
+{
+	void *ret = strdup(s1);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+#define KEYCHAIN_ITEM(x) (x ? strlen(x) : 0), x
+#define KEYCHAIN_ARGS \
+	NULL, /* default keychain */ \
+	KEYCHAIN_ITEM(host), \
+	0, NULL, /* account domain */ \
+	KEYCHAIN_ITEM(username), \
+	KEYCHAIN_ITEM(path), \
+	port, \
+	protocol, \
+	kSecAuthenticationTypeDefault
+
+static void write_item(const char *what, const char *buf, int len)
+{
+	printf("%s=", what);
+	fwrite(buf, 1, len, stdout);
+	putchar('\n');
+}
+
+static void find_username_in_item(SecKeychainItemRef item)
+{
+	SecKeychainAttributeList list;
+	SecKeychainAttribute attr;
+
+	list.count = 1;
+	list.attr = &attr;
+	attr.tag = kSecAccountItemAttr;
+
+	if (SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL))
+		return;
+
+	write_item("username", attr.data, attr.length);
+	SecKeychainItemFreeContent(&list, NULL);
+}
+
+static void find_internet_password(void)
+{
+	void *buf;
+	UInt32 len;
+	SecKeychainItemRef item;
+
+	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
+		return;
+
+	write_item("password", buf, len);
+	if (!username)
+		find_username_in_item(item);
+
+	SecKeychainItemFreeContent(NULL, buf);
+}
+
+static void delete_internet_password(void)
+{
+	SecKeychainItemRef item;
+
+	/*
+	 * Require at least a protocol and host for removal, which is what git
+	 * will give us; if you want to do something more fancy, use the
+	 * Keychain manager.
+	 */
+	if (!protocol || !host)
+		return;
+
+	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, 0, NULL, &item))
+		return;
+
+	SecKeychainItemDelete(item);
+}
+
+static void add_internet_password(void)
+{
+	/* Only store complete credentials */
+	if (!protocol || !host || !username || !password)
+		return;
+
+	if (SecKeychainAddInternetPassword(
+	      KEYCHAIN_ARGS,
+	      KEYCHAIN_ITEM(password),
+	      NULL))
+		return;
+}
+
+static void read_credential(void)
+{
+	char buf[1024];
+
+	while (fgets(buf, sizeof(buf), stdin)) {
+		char *v;
+
+		if (!strcmp(buf, "\n"))
+			break;
+		buf[strlen(buf)-1] = '\0';
+
+		v = strchr(buf, '=');
+		if (!v)
+			die("bad input: %s", buf);
+		*v++ = '\0';
+
+		if (!strcmp(buf, "protocol")) {
+			if (!strcmp(v, "https"))
+				protocol = kSecProtocolTypeHTTPS;
+			else if (!strcmp(v, "http"))
+				protocol = kSecProtocolTypeHTTP;
+			else /* we don't yet handle other protocols */
+				exit(0);
+		}
+		else if (!strcmp(buf, "host")) {
+			char *colon = strchr(v, ':');
+			if (colon) {
+				*colon++ = '\0';
+				port = atoi(colon);
+			}
+			host = xstrdup(v);
+		}
+		else if (!strcmp(buf, "path"))
+			path = xstrdup(v);
+		else if (!strcmp(buf, "username"))
+			username = xstrdup(v);
+		else if (!strcmp(buf, "password"))
+			password = xstrdup(v);
+	}
+}
+
+int main(int argc, const char **argv)
+{
+	const char *usage =
+		"Usage: git credential-osxkeychain <get|store|erase>";
+
+	if (!argv[1])
+		die(usage);
+
+	read_credential();
+
+	if (!strcmp(argv[1], "get"))
+		find_internet_password();
+	else if (!strcmp(argv[1], "store"))
+		add_internet_password();
+	else if (!strcmp(argv[1], "erase"))
+		delete_internet_password();
+	/* otherwise, ignore unknown action */
+
+	return 0;
+}
-- 
1.7.8.rc2.40.gaf387
