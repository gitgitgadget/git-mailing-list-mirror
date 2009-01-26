From: Jake Goulding <goulding@vivisimo.com>
Subject: [PATCH 1/3] Make opt_parse_with_commit non-static
Date: Mon, 26 Jan 2009 09:13:23 -0500
Message-ID: <1232979205-17161-1-git-send-email-goulding@vivisimo.com>
Cc: gitster@pobox.com, Jake Goulding <goulding@vivisimo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 15:15:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRSEt-0001XV-Nf
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 15:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZAZONd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 09:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZAZONc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 09:13:32 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:43821 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZAZON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 09:13:29 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id C251E85294E;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 974E02E68D2;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBuMMjuNhJH8; Mon, 26 Jan 2009 09:13:28 -0500 (EST)
Received: from localhost.localdomain (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 646E22E68CF;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107214>

Moving opt_parse_with_commit from branch to a common location in
preparation for using it in tag. Renamed it to correspond to naming
convention of other option parsing functions.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---
 builtin-branch.c |   20 ++------------------
 parse-options.c  |   17 +++++++++++++++++
 parse-options.h  |    1 +
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 02fa38f..82d6fb2 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -466,22 +466,6 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&newsection);
 }
 
-static int opt_parse_with_commit(const struct option *opt, const char *arg, int unset)
-{
-	unsigned char sha1[20];
-	struct commit *commit;
-
-	if (!arg)
-		return -1;
-	if (get_sha1(arg, sha1))
-		die("malformed object name %s", arg);
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		die("no such commit %s", arg);
-	commit_list_insert(commit, opt->value);
-	return 0;
-}
-
 static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	merge_filter = ((opt->long_name[0] == 'n')
@@ -517,13 +501,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
 			"print only branches that contain the commit",
 			PARSE_OPT_LASTARG_DEFAULT,
-			opt_parse_with_commit, (intptr_t)"HEAD",
+			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, "commit",
 			"print only branches that contain the commit",
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
-			opt_parse_with_commit, (intptr_t) "HEAD",
+			parse_opt_with_commit, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
 
diff --git a/parse-options.c b/parse-options.c
index 9eb55cc..4c5d09d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "cache.h"
+#include "commit.h"
 
 #define OPT_SHORT 1
 #define OPT_UNSET 2
@@ -506,6 +507,22 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
+{
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (!arg)
+		return -1;
+	if (get_sha1(arg, sha1))
+		return error("malformed object name %s", arg);
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		return error("no such commit %s", arg);
+	commit_list_insert(commit, opt->value);
+	return 0;
+}
+
 /*
  * This should really be OPTION_FILENAME type as a part of
  * parse_options that take prefix to do this while parsing.
diff --git a/parse-options.h b/parse-options.h
index 034162e..9122905 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -151,6 +151,7 @@ extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
+extern int parse_opt_with_commit(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
-- 
1.6.0.6
