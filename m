From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v2 4/4] Refactoring: remove duplicated code from builtin-checkout.c and merge-recursive.c
Date: Mon, 15 Feb 2010 23:26:50 +0000
Message-ID: <1266276411-5796-5-git-send-email-michael.lukashov@gmail.com>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 00:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhASH-0001Cr-2E
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204Ab0BOXeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:34:12 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:33225 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab0BOXeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 18:34:12 -0500
Received: by bwz5 with SMTP id 5so1503719bwz.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gvDfhmzG6y2EtLPFbyn7HQdhkjdN0e2MRCoAPc331Jc=;
        b=Ln8pzwnz6ZvrM+IUo9c6foPuG6dSG/6+zkQuXj7vi0hOpL8ZMisSMbHjrPO6EvFrbK
         6kDwlrNiR/I4mR5l//QcwY69DxzqBh47fH0IdiRGzNUtH7DuG7+Qv2FzFhJHOCpuyZ5h
         vVzCV+KHQCQv03dNP8g5EfNaUpPmn46gWekYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xc1uqUmAO1bqnqpf7YvTgk8MqyagtcIsks08477/LVf1v3d/q0FM9drHr0a17Rmf8q
         i/R4Hf87KO/Bp+l3XcnJEwHg7zzIcdfA5GsdZRUR+sSSgu5p3SlBcrFf9Ebj+OyLw+UD
         rUFFQdw2tzY5evYu4vsu/3bwOlVS/lcNDd3ts=
Received: by 10.204.5.91 with SMTP id 27mr467087bku.14.1266276434319;
        Mon, 15 Feb 2010 15:27:14 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 13sm2875814bwz.6.2010.02.15.15.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 15:27:13 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140047>

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
