From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 1/4] git-credential-store: support multiple credential files
Date: Wed, 18 Mar 2015 15:04:33 +0800
Message-ID: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY82t-0004Cx-A3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbbCRHF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:05:28 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33158 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbCRHF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:05:26 -0400
Received: by pabxg6 with SMTP id xg6so21067663pab.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Xapfoi8/dJ8U9L5+lfF8nu1PDNgriF9MdsECwa71me4=;
        b=Bf70CRxzv6xDZYphd81JDPXUxfajfMvtXpA5J7D/WxaAJ/Qu5y7lBGODvBNIY43DTe
         GFxtMEP5JWAFaiE4dWPMqqGdObW52VFWwpm8lgA5T2Gc6rthEVfqFx5jA8LToVdUZ4Fd
         natkig2cKOYiKNS5rYqKeXAVy4doeD6eKPteQi0Yy9k7Yu7MtqabgezSw24ieCnh58sq
         PSB5ZE1xFpKcnsu09XAOduh9/mEMzMF3aXKV+Kp93TLLm6YgNbL+i50ExwDyXpImvbFK
         9Q3FO9QrBfy6UVN33Gq7wQ0Yr95EU270Qyj8Sh8Kv+oCna95O5P496B9r4s2CN6xnFPq
         J7xA==
X-Received: by 10.70.53.196 with SMTP id d4mr3041632pdp.6.1426662326162;
        Wed, 18 Mar 2015 00:05:26 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id cb9sm25822507pad.46.2015.03.18.00.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 00:05:24 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YY82b-0002MB-Tc; Wed, 18 Mar 2015 15:05:21 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265683>

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
exist, store_credential() will write to the filename specified by the
first item of the filename list. For backwards compatibility, this
filename should be "~/.git-credentials".

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

The previous version can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265309

The changes are as follows:

* Remove default_fn argument from store_credential(). It now uses the
first item of the filenames string_list. Thanks Jeff, Matthieu and
Junio for your input in this discussion.

* Change filename string_list fns to duplicate strings by default
(STRING_LIST_INIT_DUP). This is to make memory ownership explicit --
when the string_list receives the file paths from xdg_config_home()
and expand_user_path(), it is responsible for freeing those strings.
Thanks Jeff for pointing this out.

 credential-store.c | 79 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/credential-store.c b/credential-store.c
index 925d3f4..8dad479 100644
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
@@ -95,8 +87,35 @@ static void store_credential(const char *fn, struct credential *c)
 	strbuf_release(&buf);
 }
 
-static void remove_credential(const char *fn, struct credential *c)
+static void store_credential(const struct string_list *fns, struct credential *c)
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
+	/* Write credential to the filename specified by fns->items[0], thus
+	 * creating it */
+	if (fns->nr)
+		store_credential_file(fns->items[0].string, c);
+}
+
+static void remove_credential(const struct string_list *fns, struct credential *c)
+{
+	struct string_list_item *fn;
+
 	/*
 	 * Sanity check that we actually have something to match
 	 * against. The input we get is a restrictive pattern,
@@ -105,14 +124,20 @@ static void remove_credential(const char *fn, struct credential *c)
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
@@ -123,6 +148,7 @@ int main(int argc, char **argv)
 	};
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
+	struct string_list fns = STRING_LIST_INIT_DUP;
 	char *file = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "file", &file, "path",
@@ -139,20 +165,23 @@ int main(int argc, char **argv)
 
 	if (!file)
 		file = expand_user_path("~/.git-credentials");
-	if (!file)
+	if (file)
+		string_list_append(&fns, file);
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
+		store_credential(&fns, &c);
 	else
 		; /* Ignore unknown operation. */
 
+	string_list_clear(&fns, 0);
 	return 0;
 }
-- 
2.1.4
