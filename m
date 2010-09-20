From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 20/37] merge-recursive: New data structures for deferring of D/F conflicts
Date: Mon, 20 Sep 2010 02:28:53 -0600
Message-ID: <1284971350-30590-21-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblG-0006R4-VO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab0ITI2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:15 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab0ITI2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:12 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TcHsB3D8eb4DfbrpzRBKbZJvN2jXYCzoAJrQA9wqjCU=;
        b=RjMd1OSy1Krf8SdVMyUEu28mQnDnIFky1akE+BBZ9I1AC09Ky1E+9sr7WQQ9Z8Lhr1
         3S02RA4ltUBIK4qXF/MTnq5Xl5xAUK8YkIYBZMlDKvqjYmroCcsBJAgOz32WQq/kAeDW
         XQlXO3tjUEISjX5sYe1tpYVF3juLCG/yx2ecQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Cc9S8xe+nridDAJKmlwzLfMT6cwAd/BoF7750PlsYneJsgBz++gkGh4a3bP6wtdxQ3
         ETXSLNuMRt++CbCnPDZALvO0nBxlIa36fH9EQVCX2zbknEm+o8silHVIvMDQKocjeIUa
         ho3qgD0yONeD2KzoHSKWnn+75R151FYjsP8b8=
Received: by 10.142.155.8 with SMTP id c8mr7426458wfe.18.1284971292696;
        Mon, 20 Sep 2010 01:28:12 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156584>

Since we need to resolve paths (including renames) in-core first and defer
checking of D/F conflicts (namely waiting to see if directories are still
in the way after all paths are resolved) before updating files involved in
D/F conflicts, we will need to first process_renames, then record some
information about the rename needed at D/F resolution time, and then make
use of that information when resolving D/F conflicts at the end.

This commit adds some relevant data structures for storing the necessary
information.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1f8b2d5..f15291e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -63,6 +63,23 @@ static int sha_eq(const unsigned char *a, const unsigned char *b)
 	return a && b && hashcmp(a, b) == 0;
 }
 
+enum rename_type {
+	RENAME_NORMAL = 0,
+	RENAME_DELETE,
+	RENAME_ONE_FILE_TO_TWO
+};
+
+struct rename_df_conflict_info
+{
+	enum rename_type rename_type;
+	struct diff_filepair *pair1;
+	struct diff_filepair *pair2;
+	const char *branch1;
+	const char *branch2;
+	struct stage_data *dst_entry1;
+	struct stage_data *dst_entry2;
+};
+
 /*
  * Since we want to write the index eventually, we cannot reuse the index
  * for these (temporary) data.
@@ -74,9 +91,37 @@ struct stage_data
 		unsigned mode;
 		unsigned char sha[20];
 	} stages[4];
+	struct rename_df_conflict_info *rename_df_conflict_info;
 	unsigned processed:1;
 };
 
+static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
+						 struct diff_filepair *pair1,
+						 struct diff_filepair *pair2,
+						 const char *branch1,
+						 const char *branch2,
+						 struct stage_data *dst_entry1,
+						 struct stage_data *dst_entry2)
+{
+	struct rename_df_conflict_info *ci = xcalloc(1, sizeof(struct rename_df_conflict_info));
+	ci->rename_type = rename_type;
+	ci->pair1 = pair1;
+	ci->branch1 = branch1;
+	ci->branch2 = branch2;
+
+	ci->dst_entry1 = dst_entry1;
+	dst_entry1->rename_df_conflict_info = ci;
+	dst_entry1->processed = 0;
+
+	assert(!pair2 == !dst_entry2);
+	if (dst_entry2) {
+		ci->dst_entry2 = dst_entry2;
+		ci->pair2 = pair2;
+		dst_entry2->rename_df_conflict_info = ci;
+		dst_entry2->processed = 0;
+	}
+}
+
 static int show(struct merge_options *o, int v)
 {
 	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
-- 
1.7.3.271.g16009
