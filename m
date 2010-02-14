From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH 4/4] Refactoring: remove duplicated code from builtin-checkout.c and merge-recursive.c
Date: Sun, 14 Feb 2010 21:27:43 +0000
Message-ID: <1266182863-5048-4-git-send-email-michael.lukashov@gmail.com>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 22:28:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngm0z-0000Ht-UB
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab0BNV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:28:27 -0500
Received: from mail-bw0-f216.google.com ([209.85.218.216]:51098 "EHLO
	mail-bw0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0BNV2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:28:23 -0500
Received: by mail-bw0-f216.google.com with SMTP id 8so2302859bwz.38
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gvDfhmzG6y2EtLPFbyn7HQdhkjdN0e2MRCoAPc331Jc=;
        b=OfY+G7t0uHDBMqpIxraWletv5Xaq7QAzvt/hCzIb4icZGF5KOJiESoThp/x3NHlL3G
         z6Fiq+jN2vsWSByJb2UZrLHd7EO0osaAWsmKFFIbA6TN0Pi9X6v3iTCVD0pzW8YcqRmi
         L6bo8PvgEESNNWrSpES99mNOVbIi71bhHn8Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hEKRBDvyg0kmIPxGFkF8XAEZ4xg6LM+tCK0BoTRZYFOXpZKQEtgZUQD1i6RuSfyRuG
         W6TuMrl467ZSk2Hn/nkysNUFN95ntoc8+aE9SmVuO7NqwI5T84liKgD0RAfoMANM0AZG
         4JHsoE8OP5TyCJlFPzPwDqjOuJvP56a1RBGWw=
Received: by 10.204.25.194 with SMTP id a2mr2628077bkc.191.1266182902392;
        Sun, 14 Feb 2010 13:28:22 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm2361468bwz.4.2010.02.14.13.28.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 13:28:21 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139939>

The following functions are duplicated:

  fill_mm

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 builtin-checkout.c |   18 ------------------
 merge-recursive.c  |    2 +-
 merge-recursive.h  |    3 +++
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..e53e857 100644
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
diff --git a/merge-recursive.c b/merge-recursive.c
index cb53b01..5999ae2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -599,7 +599,7 @@ struct merge_file_info
 		 merge:1;
 };
 
-static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
+void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 {
 	unsigned long size;
 	enum object_type type;
diff --git a/merge-recursive.h b/merge-recursive.h
index be8410a..ccc4002 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -2,6 +2,7 @@
 #define MERGE_RECURSIVE_H
 
 #include "string-list.h"
+#include "xdiff/xdiff.h"
 
 struct merge_options {
 	const char *branch1;
@@ -53,4 +54,6 @@ int merge_recursive_generic(struct merge_options *o,
 void init_merge_options(struct merge_options *o);
 struct tree *write_tree_from_memory(struct merge_options *o);
 
+void fill_mm(const unsigned char *sha1, mmfile_t *mm);
+
 #endif
-- 
1.7.0.1571.g856c2
