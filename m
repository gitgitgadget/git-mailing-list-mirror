From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v3 4/4] Refactoring: move duplicated code from builtin-checkout.c and merge-recursive.c to xdiff-interface.c
Date: Tue, 16 Feb 2010 23:42:55 +0000
Message-ID: <faddaa7f1cf5f49bc16deffe7a23c2788a360543.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX57-0007Y0-0H
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575Ab0BPXnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:43:33 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50925 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504Ab0BPXn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:43:29 -0500
Received: by mail-bw0-f219.google.com with SMTP id 19so5008437bwz.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=BsCuXxVClVqKdn4+7GmVGdOymwsXZCnYSMqhsUIiXJQ=;
        b=rTz8ZJzycBezCMCxsi5ite1Ejp23EbTtcTuj/ZfsIfTG8wNu7HquOwzrGXM24CsFID
         yyXipSO2htLID20WuwFnk3uk7AdYKsC/gPaR/K3b8acd1vHcYvXmU3BEWlQZraltQR9s
         lEv/PJj7DRHYu+QO1UtNxWd2B1LJ68GdwQATc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XtM5h3tX0V7v66d4SULgOIFkhbYC+hhpu+MV5I9JXdgamMyPvoiZ450mPf6UIaGHjl
         clgHERTtY4MCC9pnsUtqMVen2peFPG6Dizm5oyFNMSh/uF+7IELbnQJCpobqpob+d/kM
         sUDHXJ0tzPv6+olf/nrfCBRsd7CKfrxzebwsk=
Received: by 10.204.137.16 with SMTP id u16mr4759658bkt.165.1266363808926;
        Tue, 16 Feb 2010 15:43:28 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm3332128bwz.0.2010.02.16.15.43.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 15:43:27 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140177>

The following function is duplicated:

  fill_mm

Move it to xdiff-interface.c and rename it 'read_mmblob',
as suggested by Junio C Hamano.

Also, change parameters order for consistency.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-checkout.c |   24 +++---------------------
 merge-recursive.c  |   23 +++--------------------
 xdiff-interface.c  |   17 +++++++++++++++++
 xdiff-interface.h  |    1 +
 4 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..22ae92f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -128,24 +128,6 @@ static int checkout_stage(int stage, struct cache_entry *ce, int pos,
 		     (stage == 2) ? "our" : "their");
 }
 
-/* NEEDSWORK: share with merge-recursive */
-static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
-{
-	unsigned long size;
-	enum object_type type;
-
-	if (!hashcmp(sha1, null_sha1)) {
-		mm->ptr = xstrdup("");
-		mm->size = 0;
-		return;
-	}
-
-	mm->ptr = read_sha1_file(sha1, &type, &size);
-	if (!mm->ptr || type != OBJ_BLOB)
-		die("unable to read blob object %s", sha1_to_hex(sha1));
-	mm->size = size;
-}
-
 static int checkout_merged(int pos, struct checkout *state)
 {
 	struct cache_entry *ce = active_cache[pos];
@@ -163,9 +145,9 @@ static int checkout_merged(int pos, struct checkout *state)
 	    ce_stage(active_cache[pos+2]) != 3)
 		return error("path '%s' does not have all 3 versions", path);
 
-	fill_mm(active_cache[pos]->sha1, &ancestor);
-	fill_mm(active_cache[pos+1]->sha1, &ours);
-	fill_mm(active_cache[pos+2]->sha1, &theirs);
+	read_mmblob(&ancestor, active_cache[pos]->sha1);
+	read_mmblob(&ours, active_cache[pos+1]->sha1);
+	read_mmblob(&theirs, active_cache[pos+2]->sha1);
 
 	status = ll_merge(&result_buf, path, &ancestor,
 			  &ours, "ours", &theirs, "theirs", 0);
diff --git a/merge-recursive.c b/merge-recursive.c
index cb53b01..195ebf9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -599,23 +599,6 @@ struct merge_file_info
 		 merge:1;
 };
 
-static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
-{
-	unsigned long size;
-	enum object_type type;
-
-	if (!hashcmp(sha1, null_sha1)) {
-		mm->ptr = xstrdup("");
-		mm->size = 0;
-		return;
-	}
-
-	mm->ptr = read_sha1_file(sha1, &type, &size);
-	if (!mm->ptr || type != OBJ_BLOB)
-		die("unable to read blob object %s", sha1_to_hex(sha1));
-	mm->size = size;
-}
-
 static int merge_3way(struct merge_options *o,
 		      mmbuffer_t *result_buf,
 		      struct diff_filespec *one,
@@ -653,9 +636,9 @@ static int merge_3way(struct merge_options *o,
 		name2 = xstrdup(mkpath("%s", branch2));
 	}
 
-	fill_mm(one->sha1, &orig);
-	fill_mm(a->sha1, &src1);
-	fill_mm(b->sha1, &src2);
+	read_mmblob(&orig, one->sha1);
+	read_mmblob(&src1, a->sha1);
+	read_mmblob(&src2, b->sha1);
 
 	merge_status = ll_merge(result_buf, a->path, &orig,
 				&src1, name1, &src2, name2,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 01f14fb..ca5e3fb 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -218,6 +218,23 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
 
+void read_mmblob(mmfile_t *ptr, const unsigned char *sha1)
+{
+	unsigned long size;
+	enum object_type type;
+
+	if (!hashcmp(sha1, null_sha1)) {
+		ptr->ptr = xstrdup("");
+		ptr->size = 0;
+		return;
+	}
+
+	ptr->ptr = read_sha1_file(sha1, &type, &size);
+	if (!ptr->ptr || type != OBJ_BLOB)
+		die("unable to read blob object %s", sha1_to_hex(sha1));
+	ptr->size = size;
+}
+
 #define FIRST_FEW_BYTES 8000
 int buffer_is_binary(const char *ptr, unsigned long size)
 {
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 55572c3..abba70c 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -18,6 +18,7 @@ int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
 int read_mmfile(mmfile_t *ptr, const char *filename);
+void read_mmblob(mmfile_t *ptr, const unsigned char *sha1);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
-- 
1.7.0.1571.g856c2
