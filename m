From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 01/12] git-clean refactor: hold cleaning items in del_list
Date: Fri, 10 May 2013 01:14:05 +0800
Message-ID: <29d47a6c3711b558d0370b1cbc52079da11fc0fc.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQT-0002XC-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134Ab3EIROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:36 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:48423 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3EIROf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:35 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so246495pbb.14
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=XAGagFrGSvUkkqVBV9RNSNS3vvNF4Je/i/HwYughxqU=;
        b=wPnbuf7sRiYMZ/OskmfUcx3V039MqML3R1jUeOhLopHlq6DICNFMCMuQ144uRdWTX4
         GPVs9oDD2H4iCNRmhnren/MW0rj460ki6GkW4lVM7MjQa8QrvXgRZmTxUPsMO8grVRAt
         PZjwoXtG/xV9woy7DnsaR0/wariY0dRGpKgy1PoprdEOk2ybiXHA2jfR8CqlN1wPWfDa
         m4TNC4TwxdjDQHnrQZSp6LTcU0p95NB4Fr5QIol2lvTS1vtAAgAJYumyXSSnL07rf5fk
         RJr7SPAglP0DEgz/OllBQAZz37ezwcyLslZC7dF9wRvJWuqRJgOfkHiYw9R6XGYKNTOU
         bvsQ==
X-Received: by 10.66.163.38 with SMTP id yf6mr13859442pab.45.1368119674846;
        Thu, 09 May 2013 10:14:34 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223750>

Refactor git-clean operations into two phases:

 * collect cleaning candidates in del_list,
 * and remove them in a separate loop at the end.

We will introduce an interactive git-clean between the two phases.
The interactive git-clean will show what would be done and confirm
before do real cleaning.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..ccd4 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,6 +15,7 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static struct string_list del_list = STRING_LIST_INIT_DUP;
 
 static const char *const builtin_clean_usage[] = {
 	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
@@ -142,18 +143,61 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+/*
+ * Give path as relative to prefix.
+ *
+ * This function is a combination of path_relative (in quote.c) and
+ * relative_path (in path.c)
+ */
+static const char *path_relative(const char *in, const char *prefix)
+{
+	static char buf[PATH_MAX + 1];
+	int off, i;
+	int len, prefix_len;
+
+	len = strlen(in);
+	if (prefix)
+		prefix_len = strlen(prefix);
+	else
+		prefix_len = 0;
+
+	off = 0;
+	i = 0;
+	while (i < prefix_len && i < len && prefix[i] == in[i]) {
+		if (prefix[i] == '/')
+			off = i + 1;
+		i++;
+	}
+	in += off;
+	len -= off;
+
+	if (i >= prefix_len)
+		return in;
+
+	buf[0] = '\0';
+	while (i < prefix_len) {
+		if (prefix[i] == '/')
+			strcat(buf, "../");
+		i++;
+	}
+	strcat(buf, in);
+
+	return buf;
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
-	struct strbuf directory = STRBUF_INIT;
+	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
+	struct string_list_item *item;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -223,6 +267,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		int matches = 0;
 		struct cache_entry *ce;
 		struct stat st;
+		const char *rel;
 
 		/*
 		 * Remove the '/' at the end that directory
@@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				continue; /* Yup, this one exists unmerged */
 		}
 
-		/*
-		 * we might have removed this as part of earlier
-		 * recursive directory removal, so lstat() here could
-		 * fail with ENOENT.
-		 */
 		if (lstat(ent->name, &st))
 			continue;
 
@@ -257,33 +297,60 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
-					errors++;
-				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
-				}
+				rel = path_relative(ent->name, prefix);
+				string_list_append(&del_list, rel);
 			}
-			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			rel = path_relative(ent->name, prefix);
+			string_list_append(&del_list, rel);
+		}
+	}
+
+	/* TODO: do interactive git-clean here, which will modify del_list */
+
+	for_each_string_list_item(item, &del_list) {
+		struct stat st;
+
+		if (prefix) {
+			strbuf_addstr(&abs_path, prefix);
+		}
+		strbuf_addstr(&abs_path, item->string);
+
+		/*
+		 * we might have removed this as part of earlier
+		 * recursive directory removal, so lstat() here could
+		 * fail with ENOENT.
+		 */
+		if (lstat(abs_path.buf, &st))
+			continue;
+
+		if (S_ISDIR(st.st_mode)) {
+			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
+				errors++;
+			if (gone && !quiet) {
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+			}
+		} else {
+			res = dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, NULL);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
+		strbuf_reset(&abs_path);
 	}
 	free(seen);
 
-	strbuf_release(&directory);
+	strbuf_release(&abs_path);
+	string_list_clear(&del_list, 0);
 	string_list_clear(&exclude_list, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc1.341.g24a8a0f
