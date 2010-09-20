From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 19/37] merge-recursive: Move process_entry's content merging into a function
Date: Mon, 20 Sep 2010 02:28:52 -0600
Message-ID: <1284971350-30590-20-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjV-0005rH-CO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab0ITI2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:12 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0ITI2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:10 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jE/NslGkstLHYAoyHCZnfEQUohLBMURFG6uNk9jaGQ0=;
        b=PpGb9D//Z8shCKhLt6pMYWH+h/82Q6tFjypflGdxXxTvGuz+npnldAJrVA5G5EvEbp
         UM8MhFUi5N5ANMvveGn72tjWIfJ+n0hmNuLjiOZ/6QgDaxbhwASqQiXGfN/Xy7naQpcB
         5nD/En+35zzxSLqJCtRMqn83Jgviu+JnbdnUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wp6ZVHece5EoVgUn2YhGPZuT0SLoysuv6eS2+Em0oe+MKrpB2S+m32SkTCQ3BCuyrg
         IgOJKCvqa5dJFfG9Fc0Lehh38ut6KTubBY32NbvFHFoXVGSDa7pjDbsgPfkEOaE3zyyK
         +KjVLqxA/fUOk53reYajSXG5Y2Y5nh3dfO4RM=
Received: by 10.142.171.4 with SMTP id t4mr7335687wfe.335.1284971290679;
        Mon, 20 Sep 2010 01:28:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156567>

This move is in preparation for merge_content growing and being called from
multiple places in order to handle D/F conflicts.

I also snuck in a small change to the output in the case that the merged
content for the file matches the current file contents, to make it better
match (and thus more able to take over) how other merge_file() calls in
process_renames() are handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   71 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a6da2cc..1f8b2d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1139,6 +1139,47 @@ static void handle_delete_modify(struct merge_options *o,
 	}
 }
 
+
+static int merge_content(struct merge_options *o,
+			 const char *path,
+			 unsigned char *o_sha, int o_mode,
+			 unsigned char *a_sha, int a_mode,
+			 unsigned char *b_sha, int b_mode)
+{
+	const char *reason = "content";
+	struct merge_file_info mfi;
+	struct diff_filespec one, a, b;
+
+	if (!o_sha) {
+		reason = "add/add";
+		o_sha = (unsigned char *)null_sha1;
+	}
+	one.path = a.path = b.path = (char *)path;
+	hashcpy(one.sha1, o_sha);
+	one.mode = o_mode;
+	hashcpy(a.sha1, a_sha);
+	a.mode = a_mode;
+	hashcpy(b.sha1, b_sha);
+	b.mode = b_mode;
+
+	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
+	if (mfi.clean && sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
+		output(o, 3, "Skipped %s (merged same as existing)", path);
+	else
+		output(o, 2, "Auto-merging %s", path);
+
+	if (!mfi.clean) {
+		if (S_ISGITLINK(mfi.mode))
+			reason = "submodule";
+		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
+				reason, path);
+	}
+
+	update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+	return mfi.clean;
+
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -1207,34 +1248,8 @@ static int process_entry(struct merge_options *o,
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		const char *reason = "content";
-		struct merge_file_info mfi;
-		struct diff_filespec one, a, b;
-
-		if (!o_sha) {
-			reason = "add/add";
-			o_sha = (unsigned char *)null_sha1;
-		}
-		output(o, 2, "Auto-merging %s", path);
-		one.path = a.path = b.path = (char *)path;
-		hashcpy(one.sha1, o_sha);
-		one.mode = o_mode;
-		hashcpy(a.sha1, a_sha);
-		a.mode = a_mode;
-		hashcpy(b.sha1, b_sha);
-		b.mode = b_mode;
-
-		mfi = merge_file(o, &one, &a, &b,
-				 o->branch1, o->branch2);
-
-		clean_merge = mfi.clean;
-		if (!mfi.clean) {
-			if (S_ISGITLINK(mfi.mode))
-				reason = "submodule";
-			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
-					reason, path);
-		}
-		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+		clean_merge = merge_content(o, path,
+					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !a_sha && !b_sha) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
-- 
1.7.3.271.g16009
