From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 1/4] git-credential-store: support multiple credential files
Date: Sun,  8 Mar 2015 15:58:49 +0800
Message-ID: <1425801532-8483-2-git-send-email-pyokagan@gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 08:59:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW7A-0000aG-Jk
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbCHH7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:59:04 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46574 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbCHH7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:59:02 -0400
Received: by pabli10 with SMTP id li10so64096309pab.13
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4eayHt0OKou5PMzVyyLNqauGlq9TTf7+pk2xWpePPY=;
        b=lj/dUbvMpek4g4sHzrpWswptEhh2osYpwpumXv6SXrIMygz5W91LTu5rC3anffITUE
         dLgUR68Tx4vWC6UfafIPTzfYiEMv/TtoHtArqHVRETeWFZ9Vf6pZrZn2Ksw2YUv41Hky
         yua7JGZhNQAWk2A/sudNShrd9UbMZQH1NApl+Mu0EsnAjnt4EdhvmpfwC7euc4ARJ2xF
         TC0nXwXx8B7k+4N7FnsJSUhNxgp/9jXIJ90gR5dFyaoGnoBs2Nk98brl/sKrwuJzm2oM
         DJUtlcKvpKWZwPkvMTXowVwxc7QOg7BHeLAbBo4m1DAiCYHWY2aBpkdn5V8IPmsPIhbL
         a3+g==
X-Received: by 10.68.137.41 with SMTP id qf9mr41110008pbb.115.1425801541450;
        Sat, 07 Mar 2015 23:59:01 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id qn14sm14212511pab.33.2015.03.07.23.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 23:59:00 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YUW6z-0002Du-CT; Sun, 08 Mar 2015 15:58:57 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265038>

Previously, git-credential-store only supported storing credentials in a
single file: ~/.git-credentials. In order to support the XDG base
directory specification[1], git-credential-store needs to be able to
lookup and erase credentials from multiple files, as well as to pick the
appropriate file to write to so that the credentials can be found on
subsequent lookups.

[1] http://standards.freedesktop.org/basedir-spec/basedir-spec-0.7.html

Note that some credential storage files may not be owned, readable or
writable by the user, as they may be system-wide files that are meant to
apply to every user.

Instead of a single file path, lookup_credential(), remove_credential()
and store_credential() now take a precedence-ordered string_list of
file paths. lookup_credential() expects both user-specific and
system-wide credential files to be provided to support the use case of
system administrators setting default credentials for users.
remove_credential() and store_credential() expect only the user-specific
credential files to be provided as usually the only config files that
users are allowed to edit are their own user-specific ones.

lookup_credential() will read these (user-specific and system-wide) file
paths in order until it finds the 1st matching credential and print it.
As some files may be private and thus unreadable, any file which cannot
be read will be ignored silently.

remove_credential() will erase credentials from all (user-specific)
files in the list.  This is because if credentials are only erased from
the file with the highest precedence, a matching credential may still be
found in a file further down the list. (Note that due to the lockfile
code, this requires the directory to be writable, which should be so for
user-specific config files)

store_credential() will write the credentials to the first existing
(user-specific) file in the list. If none of the files in the list
exist, store_credential() will write to the filename specified by
default_index, thus creating it. For backwards compatibility,
~/.git-credentials should be the file specified by default_index.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 credential-store.c | 77 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 925d3f4..3455d7a 100644
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
-		if (errno != ENOENT)
+		if (errno != ENOENT && errno != EACCES)
 			die_errno("unable to open %s", fn);
-		return;
+		return found_credential;
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
@@ -64,21 +67,10 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 		die_errno("unable to commit credential store");
 }
 
-static void store_credential(const char *fn, struct credential *c)
+static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	/*
-	 * Sanity check that what we are storing is actually sensible.
-	 * In particular, we can't make a URL without a protocol field.
-	 * Without either a host or pathname (depending on the scheme),
-	 * we have no primary key. And without a username and password,
-	 * we are not actually storing a credential.
-	 */
-	if (!c->protocol || !(c->host || c->path) ||
-	    !c->username || !c->password)
-		return;
-
 	strbuf_addf(&buf, "%s://", c->protocol);
 	strbuf_addstr_urlencode(&buf, c->username, 1);
 	strbuf_addch(&buf, ':');
@@ -95,8 +87,34 @@ static void store_credential(const char *fn, struct credential *c)
 	strbuf_release(&buf);
 }
 
-static void remove_credential(const char *fn, struct credential *c)
+static void store_credential(const struct string_list *fns, struct credential *c,
+			     unsigned int default_index)
 {
+	struct string_list_item *fn;
+
+	/*
+	 * Sanity check that what we are storing is actually sensible.
+	 * In particular, we can't make a URL without a protocol field.
+	 * Without either a host or pathname (depending on the scheme),
+	 * we have no primary key. And without a username and password,
+	 * we are not actually storing a credential.
+	 */
+	if (!c->protocol || !(c->host || c->path) || !c->username || !c->password)
+		return;
+
+	for_each_string_list_item(fn, fns)
+		if (!access(fn->string, F_OK)) {
+			store_credential_file(fn->string, c);
+			return;
+		}
+	/* Write credential to the filename at default_index, creating it */
+	store_credential_file(fns->items[default_index].string, c);
+}
+
+static void remove_credential(const struct string_list *fns, struct credential *c)
+{
+	struct string_list_item *fn;
+
 	/*
 	 * Sanity check that we actually have something to match
 	 * against. The input we get is a restrictive pattern,
@@ -105,14 +123,20 @@ static void remove_credential(const char *fn, struct credential *c)
 	 * to empty input. So explicitly disallow it, and require that the
 	 * pattern have some actual content to match.
 	 */
-	if (c->protocol || c->host || c->path || c->username)
-		rewrite_credential_file(fn, c, NULL);
+	if (!c->protocol && !c->host && !c->path && !c->username)
+		return;
+	for_each_string_list_item(fn, fns)
+		if (!access(fn->string, F_OK))
+			rewrite_credential_file(fn->string, c, NULL);
 }
 
-static int lookup_credential(const char *fn, struct credential *c)
+static void lookup_credential(const struct string_list *fns, struct credential *c)
 {
-	parse_credential_file(fn, c, print_entry, NULL);
-	return c->username && c->password;
+	struct string_list_item *fn;
+
+	for_each_string_list_item(fn, fns)
+		if (parse_credential_file(fn->string, c, print_entry, NULL))
+			return; /* Found credential */
 }
 
 int main(int argc, char **argv)
@@ -123,6 +147,7 @@ int main(int argc, char **argv)
 	};
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
+	struct string_list fns = STRING_LIST_INIT_NODUP;
 	char *file = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "file", &file, "path",
@@ -139,18 +164,20 @@ int main(int argc, char **argv)
 
 	if (!file)
 		file = expand_user_path("~/.git-credentials");
-	if (!file)
+	if (file)
+		string_list_append_nodup(&fns, file);
+	else
 		die("unable to set up default path; use --file");
 
 	if (credential_read(&c, stdin) < 0)
 		die("unable to read credential");
 
 	if (!strcmp(op, "get"))
-		lookup_credential(file, &c);
+		lookup_credential(&fns, &c);
 	else if (!strcmp(op, "erase"))
-		remove_credential(file, &c);
+		remove_credential(&fns, &c);
 	else if (!strcmp(op, "store"))
-		store_credential(file, &c);
+		store_credential(&fns, &c, fns.nr - 1);
 	else
 		; /* Ignore unknown operation. */
 
-- 
2.1.4
