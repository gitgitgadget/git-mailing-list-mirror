From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 23/37] merge-recursive: Structure process_df_entry() to handle more cases
Date: Mon, 20 Sep 2010 02:28:56 -0600
Message-ID: <1284971350-30590-24-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblQ-0006R4-HA
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab0ITI3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:29:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab0ITI2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:18 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tFb8T7oGMBbeFl3ySkOJ83yMCz605UpydUfz8/LmEGE=;
        b=D78DYVH5ehJd7Gh0KWBZRv7Mldhx9m/A4leeheBHqooNwBskhjqprIPoU0wL3tfvKR
         Frb27a5f3qgYbg4Ayor7X9cc8ifY9MAMhvhu/5UFyRoYmxZSoaHluNFs5/KKU/0JFDbT
         nMo2aL1Y5PC2KHUZt67LddXnmgEaO/dSiIGrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=slKwaF3e7eQ5OuePCR4ZnkpJuXndCCLtsYht+2s+m6eNkwkr5btveRwIjp1QlnkXVP
         BHBrfFz1l+EuWaPi8NXQuw3AH9hjJWNfSo1mvE6MJ+VaK25m3Dr0GUdm0ilDbVohSFma
         d7bW0I27/DMezhGny+dLG7vm/okN4s9N0yMts=
Received: by 10.142.250.28 with SMTP id x28mr7378397wfh.188.1284971298662;
        Mon, 20 Sep 2010 01:28:18 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156592>

Modify process_df_entry() (mostly just indentation level changes) to
get it ready for handling more D/F conflict type cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   83 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5326f5e..b8222ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1336,13 +1336,19 @@ static int process_entry(struct merge_options *o,
 }
 
 /*
- * Per entry merge function for D/F conflicts, to be called only after
- * all files below dir have been processed.  We do this because in the
- * cases we can cleanly resolve D/F conflicts, process_entry() can clean
- * out all the files below the directory for us.
+ * Per entry merge function for D/F (and/or rename) conflicts.  In the
+ * cases we can cleanly resolve D/F conflicts, process_entry() can
+ * clean out all the files below the directory for us.  All D/F
+ * conflict cases must be handled here at the end to make sure any
+ * directories that can be cleaned out, are.
+ *
+ * Some rename conflicts may also be handled here that don't necessarily
+ * involve D/F conflicts, since the code to handle them is generic enough
+ * to handle those rename conflicts with or without D/F conflicts also
+ * being involved.
  */
 static int process_df_entry(struct merge_options *o,
-			 const char *path, struct stage_data *entry)
+			    const char *path, struct stage_data *entry)
 {
 	int clean_merge = 1;
 	unsigned o_mode = entry->stages[1].mode;
@@ -1351,42 +1357,47 @@ static int process_df_entry(struct merge_options *o,
 	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
-	const char *add_branch;
-	const char *other_branch;
-	unsigned mode;
-	const unsigned char *sha;
-	const char *conf;
 	struct stat st;
 
-	if (! ((!o_sha && a_sha && !b_sha) || (!o_sha && !a_sha && b_sha)))
-		return 1; /* we don't handle non D-F cases */
-
 	entry->processed = 1;
+	if (entry->rename_df_conflict_info) {
+		die ("Not yet implemented.");
+	} else if (!o_sha && !!a_sha != !!b_sha) {
+		/* directory -> (directory, file) */
+		const char *add_branch;
+		const char *other_branch;
+		unsigned mode;
+		const unsigned char *sha;
+		const char *conf;
 
-	if (a_sha) {
-		add_branch = o->branch1;
-		other_branch = o->branch2;
-		mode = a_mode;
-		sha = a_sha;
-		conf = "file/directory";
-	} else {
-		add_branch = o->branch2;
-		other_branch = o->branch1;
-		mode = b_mode;
-		sha = b_sha;
-		conf = "directory/file";
-	}
-	if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
-		const char *new_path = unique_path(o, path, add_branch);
-		clean_merge = 0;
-		output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
-		       "Adding %s as %s",
-		       conf, path, other_branch, path, new_path);
-		remove_file(o, 0, path, 0);
-		update_file(o, 0, sha, mode, new_path);
+		if (a_sha) {
+			add_branch = o->branch1;
+			other_branch = o->branch2;
+			mode = a_mode;
+			sha = a_sha;
+			conf = "file/directory";
+		} else {
+			add_branch = o->branch2;
+			other_branch = o->branch1;
+			mode = b_mode;
+			sha = b_sha;
+			conf = "directory/file";
+		}
+		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+			const char *new_path = unique_path(o, path, add_branch);
+			clean_merge = 0;
+			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
+			       "Adding %s as %s",
+			       conf, path, other_branch, path, new_path);
+			remove_file(o, 0, path, 0);
+			update_file(o, 0, sha, mode, new_path);
+		} else {
+			output(o, 2, "Adding %s", path);
+			update_file(o, 1, sha, mode, path);
+		}
 	} else {
-		output(o, 2, "Adding %s", path);
-		update_file(o, 1, sha, mode, path);
+		entry->processed = 0;
+		return 1; /* not handled; assume clean until processed */
 	}
 
 	return clean_merge;
-- 
1.7.3.271.g16009
