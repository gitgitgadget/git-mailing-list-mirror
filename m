From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 16/25] sha1_name.c: teach lookup context to
 get_sha1_with_context()
Date: Tue,  3 Jul 2012 14:37:06 -0700
Message-ID: <1341351435-31011-17-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAo4-00061R-C9
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768Ab2GCViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756546Ab2GCVht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C365866D
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EwDe
	B9+rRX8MrSrkTOPS5d2BR+c=; b=phT8Ljjl1febpjy8Zj2czzJmKIaxqG78JixO
	Cv1jYjVWpGAzIHTAHZMwF6llcFjS/Rz+VlMpupCKO5EUkiE2Wbeisi87cz8Pq7Yu
	HuhJPDyCHDwJbd/ezEOcoK/EuhZp30Z2kcxRaaACECnKdaWF9oHteI/2ZYkzWe3s
	+6Got14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=GL+hv6
	TXTNfVhRDToCUwEduLI22llGWzYE/usCQgrBPppCvaQTYLc7Y0hJXBZxENM/Ww4B
	Wht9ElXmS079Syt4kG/IX6duC3tZ4s7RBe9X6UCFoKAZLpZNLSHVmlKT5aV3R2al
	7/6K8Cy2dgPj/CaxCSvPJN/5pVRa7xvs8R3y8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33E37866C
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8638C8669 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 55877292-C557-11E1-825C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200959>

The function takes user input string and returns the object name
(binary SHA-1) with mode bits and path when the object was looked
up in a tree.

Additionally give hints to help disambiguation of abbreviated object
names when the caller knows what it is looking for.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c |  2 +-
 cache.h            |  3 ++-
 revision.c         |  4 ++--
 sha1_name.c        | 22 +++++++++++++---------
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 07bd984..c27268f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -90,7 +90,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	unsigned long size;
 	struct object_context obj_context;
 
-	if (get_sha1_with_context(obj_name, sha1, &obj_context))
+	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	buf = NULL;
diff --git a/cache.h b/cache.h
index 1508fdb..e1fa63b 100644
--- a/cache.h
+++ b/cache.h
@@ -814,10 +814,11 @@ struct object_context {
 #define GET_SHA1_QUIETLY 01
 #define GET_SHA1_COMMIT 02
 #define GET_SHA1_COMMITTISH 04
+#define GET_SHA1_ONLY_TO_DIE 04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc);
+extern int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc);
 
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
diff --git a/revision.c b/revision.c
index 86a14c8..7444f2e 100644
--- a/revision.c
+++ b/revision.c
@@ -1180,7 +1180,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1_with_context(arg, sha1, &oc))
+	if (get_sha1_with_context(arg, 0, sha1, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -1795,7 +1795,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		unsigned char sha1[20];
 		struct object *object;
 		struct object_context oc;
-		if (get_sha1_with_context(revs->def, sha1, &oc))
+		if (get_sha1_with_context(revs->def, 0, sha1, &oc))
 			die("bad default revision '%s'", revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
diff --git a/sha1_name.c b/sha1_name.c
index 215bb01..c045be8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -996,7 +996,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 int get_sha1(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
-	return get_sha1_with_context(name, sha1, &unused);
+	return get_sha1_with_context(name, 0, sha1, &unused);
 }
 
 /* Must be called only when object_name:filename doesn't exist. */
@@ -1112,20 +1112,24 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-static int get_sha1_with_context_1(const char *name, unsigned char *sha1,
-				   struct object_context *oc,
-				   int only_to_die, const char *prefix)
+static int get_sha1_with_context_1(const char *name,
+				   unsigned flags,
+				   const char *prefix,
+				   unsigned char *sha1,
+				   struct object_context *oc)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
+	int only_to_die = flags & GET_SHA1_ONLY_TO_DIE;
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1, 0);
+	ret = get_sha1_1(name, namelen, sha1, flags);
 	if (!ret)
 		return ret;
-	/* sha1:path --> object name of path in ent sha1
+	/*
+	 * sha1:path --> object name of path in ent sha1
 	 * :path -> object name of absolute path in index
 	 * :./path -> object name of path relative to cwd in index
 	 * :[0-3]:path -> object name of path in index at stage
@@ -1239,10 +1243,10 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
 	unsigned char sha1[20];
-	get_sha1_with_context_1(name, sha1, &oc, 1, prefix);
+	get_sha1_with_context_1(name, GET_SHA1_ONLY_TO_DIE, prefix, sha1, &oc);
 }
 
-int get_sha1_with_context(const char *str, unsigned char *sha1, struct object_context *orc)
+int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
 {
-	return get_sha1_with_context_1(str, sha1, orc, 0, NULL);
+	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
 }
-- 
1.7.11.1.229.g706c98f
