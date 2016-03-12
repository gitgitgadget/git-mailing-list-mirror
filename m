From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 02/17] sha1_name: implement get_oid() and friends
Date: Sat, 12 Mar 2016 18:46:22 +0800
Message-ID: <1457779597-6918-3-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4e-0005bI-4q
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcCLKrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:04 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34912 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbcCLKrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:01 -0500
Received: by mail-pa0-f49.google.com with SMTP id td3so92364860pab.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwspGgFGAT/k+5kNeyZKfwIG9+a78zkeuSZgTgdI5rA=;
        b=VrpLekTJR5AGTZuVy/roaojHn62HCmVKKmYmwcKuvnBtIoL9JaOJHqg3dONtiHv/UI
         OK0uhI4zoIkVwfXY5xD3OJhB6BZ26TrrBGw3v1qTLswMyx0p4DViYwtOHk9pIy2Re4v3
         3y1HT5Gk63kEwczVu/466iyHa1A/S0O6W+82OhsxIm8RMqrt7RvCwWHbGm4yvH4SHY0w
         sPIRm5SDf/a8DplqELQZhhZhJucX369Om9sB3BTQevR00vftebQi1zrnty8EefQNihYN
         vptBWrn0kNcJ+M5alElYnOCrQnwqeU1f1oakVextTHwGfmVLU4+z7XPuWb7RjySthvUi
         k8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwspGgFGAT/k+5kNeyZKfwIG9+a78zkeuSZgTgdI5rA=;
        b=O8V921/m77WzSus/Dg2eZYOlnuC+z6NRZX+DZQXiInN1sfqXArZflKMWXTOilB8hbg
         0fL7/lviM2YZdqHJITTl6EtJztnGA7L+OspEzftq8qsFKIqkeM2h7W1yk4R/skdNQuj5
         OJgIqUuEscAh5EWZCeWjgHUkB+uaw7KxR/5+qfSVN1mpMBwqDVdhMbec5HSgHEY4nXYW
         6+lMMoBbGKbgNtS5O+fXy7kxuiRoZ6JpHbcnO8/WhRGv8UhTdLI95dE/6ZVg9Pmi/YyS
         G/+66pNWZLE4jmR+eV2H6XPg8ikuDPMrS4nfl3RFl2opTgzj56R7mL3nyHy86qGKCayg
         Sqag==
X-Gm-Message-State: AD7BkJJCcKxXVHBJ6cxgKbVXbSDW6uZGuHMhxaFe7vsOh4UHkjtPaxRqZmVILVpDd5H3jA==
X-Received: by 10.66.90.136 with SMTP id bw8mr22775198pab.52.1457779621159;
        Sat, 12 Mar 2016 02:47:01 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:46:59 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288730>

5f7817c (define a structure for object IDs, 2015-03-13) introduced the
object_id struct to replace the used of unsigned char[] arrays to hold
object IDs. This gives us the benefit of compile-time checking for
misuse.

To fully take advantage of compile-time type-checking, introduce the
get_oid_*() functions which wrap the corresponding get_sha1_*()
functions.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h     |  6 ++++++
 sha1_name.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/cache.h b/cache.h
index b829410..55d443e 100644
--- a/cache.h
+++ b/cache.h
@@ -1116,11 +1116,17 @@ struct object_context {
 #define GET_SHA1_ONLY_TO_DIE    04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int get_oid(const char *str, struct object_id *oid);
 extern int get_sha1_commit(const char *str, unsigned char *sha1);
+extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_sha1_committish(const char *str, unsigned char *sha1);
+extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_sha1_tree(const char *str, unsigned char *sha1);
+extern int get_oid_tree(const char *str, struct object_id *oid);
 extern int get_sha1_treeish(const char *str, unsigned char *sha1);
+extern int get_oid_treeish(const char *str, struct object_id *oid);
 extern int get_sha1_blob(const char *str, unsigned char *sha1);
+extern int get_oid_blob(const char *str, struct object_id *oid);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
diff --git a/sha1_name.c b/sha1_name.c
index 3acf221..307dfad 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1214,6 +1214,11 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_context(name, 0, sha1, &unused);
 }
 
+int get_oid(const char *name, struct object_id *oid)
+{
+	return get_sha1(name, oid->hash);
+}
+
 /*
  * Many callers know that the user meant to name a commit-ish by
  * syntactical positions where the object name appears.  Calling this
@@ -1231,6 +1236,11 @@ int get_sha1_committish(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_oid_committish(const char *name, struct object_id *oid)
+{
+	return get_sha1_committish(name, oid->hash);
+}
+
 int get_sha1_treeish(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
@@ -1238,6 +1248,11 @@ int get_sha1_treeish(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_oid_treeish(const char *name, struct object_id *oid)
+{
+	return get_sha1_treeish(name, oid->hash);
+}
+
 int get_sha1_commit(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
@@ -1245,6 +1260,11 @@ int get_sha1_commit(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_oid_commit(const char *name, struct object_id *oid)
+{
+	return get_sha1_commit(name, oid->hash);
+}
+
 int get_sha1_tree(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
@@ -1252,6 +1272,11 @@ int get_sha1_tree(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_oid_tree(const char *name, struct object_id *oid)
+{
+	return get_sha1_tree(name, oid->hash);
+}
+
 int get_sha1_blob(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
@@ -1259,6 +1284,11 @@ int get_sha1_blob(const char *name, unsigned char *sha1)
 				     sha1, &unused);
 }
 
+int get_oid_blob(const char *name, struct object_id *oid)
+{
+	return get_sha1_blob(name, oid->hash);
+}
+
 /* Must be called only when object_name:filename doesn't exist. */
 static void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
-- 
2.7.0
