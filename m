From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Wed,  4 Mar 2015 04:24:58 +0800
Message-ID: <1425414299-24000-2-git-send-email-pyokagan@gmail.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStQr-0002Sq-8k
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbbCCU2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:28:37 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42618 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938AbbCCU2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:28:33 -0500
Received: by padfa1 with SMTP id fa1so26893859pad.9
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3p4P2UR3zqP2mnvZgptEima+PhK9DGxmeJcrl834m0=;
        b=oPYOevVNx/Bh0IZr5tOA1UxjSW+bL7624AnlL84MgSLTQ9aTyOCKUaPYivSIrs/Ok9
         +xO8SAP9yKXYXY9dnETEcUX6KjYGB99n4/A4vEB6v0laHheyWb9ZFi8cbTKSN6oj3WL9
         GksNGtirT/YNw8ChDayFjg+X73DSZr2KkWNNQ7DPkYoZkxazOnjgasGv11ioTYa3ZyNi
         MmlBEsK76RZwehxwdJOGljG3obO8Zj7wgLXCbr8ndegHtr8q2dVZBSpcfn49FMJO4oTL
         FGE+fGk+fmTGHU1qORNNvU9wPJnIqu9rf490OAv9Qr0rLunahb3fZSOxpJXUs/dG3/Lf
         eRZw==
X-Received: by 10.68.234.164 with SMTP id uf4mr845182pbc.37.1425414513498;
        Tue, 03 Mar 2015 12:28:33 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id vf6sm1857445pbc.18.2015.03.03.12.28.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 12:28:31 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YStQa-0007RB-Ov; Wed, 04 Mar 2015 04:28:28 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264684>

Teach git-credential-store to read/write credentials from
$XDG_CONFIG_HOME/git/credentials and ~/.git-credentials where
appropriate:

* get: call lookup_credential() on the XDG file first if it exists. If
  the credential can't be found, call lookup_credential() on the HOME
  file.
* erase: Call remove_credential() on both the XDG file if it exists and
  the HOME file if it exists.
* store: If the XDG file exists, call store_credential() on the XDG file
  and remove_credential() on the HOME file to prevent duplicates.
* If "--file" is provided, use the file for all operations instead.

In order to support the above, parse_credential_file() now returns 1 if
it finds a matching credential, and 0 if it does not. Likewise,
lookup_credential() returns 1 if it could find the credential, and 0 if
it could not.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 credential-store.c | 60 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 925d3f4..18b8897 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -6,7 +6,7 @@
 
 static struct lock_file credential_lock;
 
-static void parse_credential_file(const char *fn,
+static int parse_credential_file(const char *fn,
 				  struct credential *c,
 				  void (*match_cb)(struct credential *),
 				  void (*other_cb)(struct strbuf *))
@@ -14,18 +14,20 @@ static void parse_credential_file(const char *fn,
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 	struct credential entry = CREDENTIAL_INIT;
+	int found_credential = 0;
 
 	fh = fopen(fn, "r");
 	if (!fh) {
 		if (errno != ENOENT)
 			die_errno("unable to open %s", fn);
-		return;
+		return 0;
 	}
 
 	while (strbuf_getline(&line, fh, '\n') != EOF) {
 		credential_from_url(&entry, line.buf);
 		if (entry.username && entry.password &&
 		    credential_match(c, &entry)) {
+			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
 				break;
@@ -38,6 +40,7 @@ static void parse_credential_file(const char *fn,
 	credential_clear(&entry);
 	strbuf_release(&line);
 	fclose(fh);
+	return found_credential;
 }
 
 static void print_entry(struct credential *c)
@@ -111,8 +114,7 @@ static void remove_credential(const char *fn, struct credential *c)
 
 static int lookup_credential(const char *fn, struct credential *c)
 {
-	parse_credential_file(fn, c, print_entry, NULL);
-	return c->username && c->password;
+	return parse_credential_file(fn, c, print_entry, NULL);
 }
 
 int main(int argc, char **argv)
@@ -124,6 +126,9 @@ int main(int argc, char **argv)
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
 	char *file = NULL;
+	char *home_file = NULL;
+	char *xdg_file = NULL;
+	int ret = 0;
 	struct option options[] = {
 		OPT_STRING(0, "file", &file, "path",
 			   "fetch and store credentials in <path>"),
@@ -137,21 +142,46 @@ int main(int argc, char **argv)
 		usage_with_options(usage, options);
 	op = argv[0];
 
-	if (!file)
-		file = expand_user_path("~/.git-credentials");
-	if (!file)
-		die("unable to set up default path; use --file");
+	if (!file) {
+		home_config_paths(NULL, &xdg_file, "credentials");
+		home_file = expand_user_path("~/.git-credentials");
+		if (!xdg_file && !home_file)
+			die("unable to set up default path; use --file");
+	}
 
 	if (credential_read(&c, stdin) < 0)
 		die("unable to read credential");
 
-	if (!strcmp(op, "get"))
-		lookup_credential(file, &c);
-	else if (!strcmp(op, "erase"))
-		remove_credential(file, &c);
-	else if (!strcmp(op, "store"))
-		store_credential(file, &c);
-	else
+	if (!strcmp(op, "get")) {
+		if (file) {
+			lookup_credential(file, &c);
+		} else {
+			if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
+				ret = lookup_credential(xdg_file, &c);
+			if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
+				lookup_credential(home_file, &c);
+		}
+	} else if (!strcmp(op, "erase")) {
+		if (file) {
+			remove_credential(file, &c);
+		} else {
+			if (xdg_file && access(xdg_file, F_OK) == 0)
+				remove_credential(xdg_file, &c);
+			if (home_file && access(home_file, F_OK) == 0)
+				remove_credential(home_file, &c);
+		}
+	} else if (!strcmp(op, "store")) {
+		if (file) {
+			store_credential(file, &c);
+		} else if (xdg_file && access(xdg_file, F_OK) == 0) {
+			store_credential(xdg_file, &c);
+			if (home_file && access(home_file, F_OK) == 0 &&
+			    c.protocol && (c.host || c.path) && c.username
+			    && c.password)
+				remove_credential(home_file, &c);
+		} else
+			store_credential(home_file, &c);
+	} else
 		; /* Ignore unknown operation. */
 
 	return 0;
-- 
2.1.4
