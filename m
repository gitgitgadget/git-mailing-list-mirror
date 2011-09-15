From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Wed, 14 Sep 2011 22:51:53 -0400
Message-ID: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 04:59:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R42AG-0004g2-JK
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab1IOC6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:58:55 -0400
Received: from mail-vw0-f45.google.com ([209.85.212.45]:61247 "EHLO
	mail-vw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab1IOC6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:58:54 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Sep 2011 22:58:53 EDT
Received: by vws17 with SMTP id 17so3845592vws.4
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CMvMeEZQbPKZgOwG2YfqPe6zcBwGqR99BoeoS1FWEdM=;
        b=cFPvvnBe0P/hpH/6j0rFHJgeihA3hTgOzA4KkX3HhTgSPGsOLpXgeAQLoQYfJ3i0uQ
         nolADGiUjDR+aLEWmdt4wReGArvj4dezDFtfhg5VUzDS5DbcJbfKzldcTqckS5L0xqRk
         ElUZtACDYMW47CKieTWSbzRlNhP0H0kKcdKXY=
Received: by 10.52.96.35 with SMTP id dp3mr510898vdb.321.1316055125659;
        Wed, 14 Sep 2011 19:52:05 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id ef8sm1777965vdc.24.2011.09.14.19.52.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:52:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc1.1.g011e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181430>

This credential helper adds, searches, and removes entries from
the Mac OS X keychain. The C version links against the Security
framework and is probably the best choice for daily use.

A python version is also included primarily as a more readable
example and uses the /usr/bin/security CLI to access the keychain.

Tested with 10.6.8.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Here's a C version that no longer links to git. I also kept the original
Python version as an example. I decided not to call out to
'git credential-gitpass' as it was simple enough to manage /dev/tty
and there's no portability issues since this is OS X specific.

 contrib/credential-osxkeychain/Makefile            |   14 +
 .../git-credential-osxkeychain.c                   |  300 ++++++++++++++++++++
 .../git-credential-osxkeychain.py                  |  148 ++++++++++
 3 files changed, 462 insertions(+), 0 deletions(-)
 create mode 100644 contrib/credential-osxkeychain/Makefile
 create mode 100644 contrib/credential-osxkeychain/git-credential-osxkeychain.c
 create mode 100755 contrib/credential-osxkeychain/git-credential-osxkeychain.py

diff --git a/contrib/credential-osxkeychain/Makefile b/contrib/credential-osxkeychain/Makefile
new file mode 100644
index 0000000000..a0a7074cc6
--- /dev/null
+++ b/contrib/credential-osxkeychain/Makefile
@@ -0,0 +1,14 @@
+all:: git-credential-osxkeychain
+
+CC = gcc
+RM = rm -f
+CFLAGS = -O2 -Wall
+
+git-credential-osxkeychain: git-credential-osxkeychain.o
+	$(CC) -o $@ $< -Wl,-framework -Wl,Security
+
+git-credential-osxkeychain.o: git-credential-osxkeychain.c
+	$(CC) -c $(CFLAGS) $<
+
+clean:
+	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
diff --git a/contrib/credential-osxkeychain/git-credential-osxkeychain.c b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
new file mode 100644
index 0000000000..2f611f7348
--- /dev/null
+++ b/contrib/credential-osxkeychain/git-credential-osxkeychain.c
@@ -0,0 +1,300 @@
+/* Copyright 2011 Jay Soffian. All rights reserved.
+ * FreeBSD License.
+ *
+ * A git credential helper that interfaces with the Mac OS X keychain
+ * via the Security framework.
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <termios.h>
+#include <Security/Security.h>
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
+void *xmalloc(size_t size)
+{
+	void *ret = malloc(size);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+void *xstrdup(const char *s1)
+{
+	void *ret = strdup(s1);
+	if (!ret)
+		die("Out of memory");
+	return ret;
+}
+
+void emit_user_pass(char *username, char *password)
+{
+	if (username)
+		printf("username=%s\n", username);
+	if (password)
+		printf("password=%s\n", password);
+}
+
+typedef enum { USERNAME, PASSWORD } prompt_type;
+
+void prompt(FILE *file, const char *what, const char *desc)
+{
+	if (desc)
+		fprintf(file, "%s for '%s': ", what, desc);
+	else
+		fprintf(file, "%s: ", what);
+}
+
+char *prompt_tty(prompt_type what, char *description)
+{
+	struct termios old;
+	struct termios new;
+	char buf[128];
+	int buf_len;
+	int fd = open("/dev/tty", O_RDWR|O_NOCTTY);
+	FILE *tty = fdopen(fd, "w+");
+	if (what == USERNAME) {
+		prompt(tty, "Username", description);
+	}
+	else {
+		prompt(tty, "Password", description);
+		tcgetattr(fd, &old);
+		memcpy(&new, &old, sizeof(struct termios));
+		new.c_lflag &= ~ECHO;
+		tcsetattr(fd, TCSADRAIN, &new);
+	}
+	if (!fgets(buf, sizeof(buf), tty)) {
+		fprintf(tty, "\n");
+		fclose(tty);
+		return NULL;
+	}
+	if (what == PASSWORD) {
+		tcsetattr(fd, TCSADRAIN, &old);
+		fprintf(tty, "\n");
+	}
+	fclose(tty);
+	buf_len = strlen(buf);
+	if (buf[buf_len-1] == '\n')
+		buf[buf_len-1] = '\0';
+	return xstrdup(buf);
+}
+
+char *username_from_keychain_item(SecKeychainItemRef item)
+{
+	OSStatus status;
+	SecKeychainAttributeList list;
+	SecKeychainAttribute attr;
+	list.count = 1;
+	list.attr = &attr;
+	attr.tag = kSecAccountItemAttr;
+	char *username;
+
+	status = SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL);
+	if (status != noErr)
+		return NULL;
+	username = xmalloc(attr.length + 1);
+	strncpy(username, attr.data, attr.length);
+	username[attr.length] = '\0';
+	SecKeychainItemFreeContent(&list, NULL);
+	return username;
+}
+
+int find_internet_password(SecProtocolType protocol,
+			   char *hostname,
+			   char *username)
+{
+	void *password_buf;
+	UInt32 password_len;
+	OSStatus status;
+	char *password;
+	int free_username = 0;
+	SecKeychainItemRef item;
+
+	status = SecKeychainFindInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			username ? strlen(username) : 0, username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			&password_len, &password_buf,
+			&item);
+	if (status != noErr)
+		return -1;
+
+	password = xmalloc(password_len + 1);
+	strncpy(password, password_buf, password_len);
+	password[password_len] = '\0';
+	SecKeychainItemFreeContent(NULL, password_buf);
+	if (!username) {
+		username = username_from_keychain_item(item);
+		free_username = 1;
+	}
+	emit_user_pass(username, password);
+	if (free_username)
+		free(username);
+	free(password);
+	return 0;
+}
+
+void delete_internet_password(SecProtocolType protocol,
+			      char *hostname,
+			      char *username)
+{
+	OSStatus status;
+	SecKeychainItemRef item;
+
+	status = SecKeychainFindInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			username ? strlen(username) : 0, username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			0, NULL,
+			&item);
+	if (status != noErr)
+		return;
+	SecKeychainItemDelete(item);
+}
+
+void add_internet_password(SecProtocolType protocol,
+			   char *hostname,
+			   char *username,
+			   char *password,
+			   char *comment)
+{
+	const char *label_format = "%s (%s)";
+	char *label;
+	OSStatus status;
+	SecKeychainItemRef item;
+	SecKeychainAttributeList list;
+	SecKeychainAttribute attr;
+	list.count = 1;
+	list.attr = &attr;
+	status = SecKeychainAddInternetPassword(
+			NULL,
+			strlen(hostname), hostname,
+			0, NULL,
+			strlen(username), username,
+			0, NULL,
+			0,
+			protocol,
+			kSecAuthenticationTypeDefault,
+			strlen(password), password,
+			&item);
+	if (status != noErr)
+		return;
+
+	/* set the comment */
+	attr.tag = kSecCommentItemAttr;
+	attr.data = comment;
+	attr.length = strlen(comment);
+	SecKeychainItemModifyContent(item, &list, 0, NULL);
+
+	/* override the label */
+	label = xmalloc(strlen(hostname) + strlen(username) +
+			strlen(label_format));
+	sprintf(label, label_format, hostname, username);
+	attr.tag = kSecLabelItemAttr;
+	attr.data = label;
+	attr.length = strlen(label);
+	SecKeychainItemModifyContent(item, &list, 0, NULL);
+}
+
+int main(int argc, const char **argv)
+{
+	const char *usage =
+		"Usage: git credential-osxkeychain --unique=TOKEN [options]\n"
+		"Options:\n"
+		"    --description=DESCRIPTION\n"
+		"    --username=USERNAME\n"
+		"    --reject";
+	char *description = NULL, *username = NULL, *unique = NULL;
+	char *hostname, *password;
+	int i, free_username = 0, reject = 0;
+	SecProtocolType protocol = 0;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strncmp(arg, "--description=", 14)) {
+			description = (char *) arg + 14;
+		}
+		else if (!strncmp(arg, "--username=", 11)) {
+			username = (char *) arg + 11;
+		}
+		else if (!strncmp(arg, "--unique=", 9)) {
+			unique = (char *) arg + 9;
+		}
+		else if (!strcmp(arg, "--reject")) {
+			reject = 1;
+		}
+		else if (!strcmp(arg, "--help")) {
+			die(usage);
+		}
+		else
+			die("Unrecognized argument `%s'; try --help", arg);
+	}
+
+	if (!unique)
+		die("Must specify --unique=TOKEN; try --help");
+
+	hostname = strchr(unique, ':');
+	if (!hostname)
+		die("Invalid token `%s'", unique);
+	*hostname++ = '\0';
+
+	/* "GitHub for Mac" compatibility */
+	if (!strcmp(hostname, "github.com"))
+		hostname = "github.com/mac";
+
+	if (!strcmp(unique, "https")) {
+		protocol = kSecProtocolTypeHTTPS;
+	} else if (!strcmp(unique, "http")) {
+		protocol = kSecProtocolTypeHTTP;
+	}
+	else
+		die("Unrecognized protocol `%s'", unique);
+
+	/* if this is a rejection delete the existing creds */
+	if (reject) {
+		delete_internet_password(protocol, hostname, username);
+		return 0;
+	}
+
+	/* otherwise look for a matching keychain item */
+	if (!find_internet_password(protocol, hostname, username))
+		return 0;
+
+	/* no keychain item found, prompt the user and store the result */
+	if (!username) {
+		if (!(username = prompt_tty(USERNAME, description)))
+			return 0;
+		free_username = 1;
+	}
+	if (!(password = prompt_tty(PASSWORD, description)))
+		return 0;
+
+	add_internet_password(protocol, hostname, username, password,
+			      description ? description : "default");
+	emit_user_pass(username, password);
+	if (free_username)
+		free(username);
+	free(password);
+	return 0;
+}
diff --git a/contrib/credential-osxkeychain/git-credential-osxkeychain.py b/contrib/credential-osxkeychain/git-credential-osxkeychain.py
new file mode 100755
index 0000000000..ae5ec00d68
--- /dev/null
+++ b/contrib/credential-osxkeychain/git-credential-osxkeychain.py
@@ -0,0 +1,148 @@
+#!/usr/bin/python
+# Copyright 2011 Jay Soffian. All rights reserved.
+# FreeBSD License.
+"""
+A git credential helper that interfaces with the Mac OS X keychain via
+/usr/bin/security.
+"""
+
+import os
+import re
+import sys
+import termios
+from getpass import _raw_input
+from optparse import OptionParser
+from subprocess import Popen, PIPE
+
+USERNAME = 'USERNAME'
+PASSWORD = 'PASSWORD'
+PROMPTS = dict(USERNAME='Username', PASSWORD='Password')
+
+def prompt_tty(what, desc):
+    """Prompt on TTY for username or password with optional description"""
+    prompt = '%s%s: ' % (PROMPTS[what], " for '%s'" % desc if desc else '')
+    # Borrowed mostly from getpass.py
+    fd = os.open('/dev/tty', os.O_RDWR|os.O_NOCTTY)
+    tty = os.fdopen(fd, 'w+', 1)
+    if what == USERNAME:
+        return _raw_input(prompt, tty, tty)
+    old = termios.tcgetattr(fd) # a copy to save
+    new = old[:]
+    new[3] &= ~termios.ECHO  # 3 == 'lflags'
+    try:
+        termios.tcsetattr(fd, termios.TCSADRAIN, new)
+        return _raw_input(prompt, tty, tty)
+    finally:
+        termios.tcsetattr(fd, termios.TCSADRAIN, old)
+        tty.write('\n')
+
+def emit_user_pass(username, password):
+    if username:
+        print 'username=' + username
+    if password:
+        print 'password=' + password
+
+def make_security_args(command, protocol, hostname, username):
+    args = ['/usr/bin/security', command]
+    # tlfd is 'dflt' backwards - obvious /usr/bin/security bug
+    # but allows us to ignore matching saved web forms.
+    args.extend(['-t', 'tlfd'])
+    args.extend(['-r', protocol])
+    if hostname:
+        args.extend(['-s', hostname])
+    if username:
+        args.extend(['-a', username])
+    return args
+
+def find_internet_password(protocol, hostname, username):
+    args = make_security_args('find-internet-password',
+                              protocol, hostname, username)
+    args.append('-g') # asks for password on stderr
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    # grok stdout for username
+    out, err = p.communicate()
+    if p.returncode != 0:
+        return
+    for line in out.splitlines(): # pylint:disable-msg=E1103
+        m = re.search(r'^\s+"acct"<blob>=[^"]*"(.*)"$', line)
+        if m:
+            username = m.group(1)
+            break
+    # grok stderr for password
+    m = re.search(r'^password:[^"]*"(.*)"$', err)
+    if not m:
+        return
+    emit_user_pass(username, m.group(1))
+    return True
+
+def delete_internet_password(protocol, hostname, username):
+    args = make_security_args('delete-internet-password',
+                              protocol, hostname, username)
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    p.communicate()
+
+def add_internet_password(protocol, hostname, username, password):
+    # We do this over a pipe so that we can provide the password more
+    # securely than as an argument which would show up in ps output.
+    # Unfortunately this is possibly less robust since the security man
+    # page does not document how to quote arguments. Emprically it seems
+    # that using the double-quote, escaping \ and " works properly.
+    username = username.replace('\\', '\\\\').replace('"', '\\"')
+    password = password.replace('\\', '\\\\').replace('"', '\\"')
+    command = ' '.join([
+        'add-internet-password', '-U',
+        '-r', protocol,
+        '-s', hostname,
+        '-a "%s"' % username,
+        '-w "%s"' % password,
+        '-j default',
+        '-l "%s (%s)"' % (hostname, username),
+    ]) + '\n'
+    args = ['/usr/bin/security', '-i']
+    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
+    p.communicate(command)
+
+def main():
+    p = OptionParser()
+    p.add_option('--description')
+    p.add_option('--reject', action='store_true')
+    p.add_option('--unique', dest='token', help='REQUIRED OPTION')
+    p.add_option('--username')
+    opts, _ = p.parse_args()
+
+    if not opts.token:
+        p.error('--unique option required')
+    if not ':' in opts.token:
+        print >> sys.stderr, "Invalid token: '%s'" % opts.token
+        return 1
+    protocol, hostname = opts.token.split(':', 1)
+    if protocol not in ('http', 'https'):
+        print >> sys.stderr, "Unsupported protocol: '%s'" % protocol
+        return 1
+    if protocol == 'https':
+        protocol = 'htps'
+
+    # "GitHub for Mac" compatibility
+    if hostname == 'github.com':
+        hostname = 'github.com/mac'
+
+    # if this is a rejection delete the existing creds
+    if opts.reject:
+        delete_internet_password(protocol, hostname, opts.username)
+        return 0
+
+    # otherwise look for creds
+    if find_internet_password(protocol, hostname, opts.username):
+        return 0
+
+    # creds not found, so prompt the user then store the creds
+    username = opts.username
+    if username is None:
+        username = prompt_tty(USERNAME, opts.description)
+    password = prompt_tty(PASSWORD, opts.description)
+    add_internet_password(protocol, hostname, username, password)
+    emit_user_pass(username, password)
+    return 0
+
+if __name__ == '__main__':
+    sys.exit(main())
-- 
1.7.7.rc1.1.g011e1
