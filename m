From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 15/18] sha1_name.c: teach lookup context to
 get_sha1_with_context()
Date: Mon,  2 Jul 2012 15:34:06 -0700
Message-ID: <1341268449-27801-16-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpD2-0003YV-8l
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933167Ab2GBWfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:35:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349Ab2GBWem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D49B3909D
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dIOc
	z8WoLUMjlGUUnUC3sK+vf1k=; b=aQApACfb7RtT13VGzvuA1jkj4Sz2bU+rY7JS
	0oxh4fzlaoQweNo0xNxVT0WWRTFOH/h0day+Jm0CIYfkWuIfkW5dt1elw0+jlRtF
	1PAqi+C2bK3S+8ARJx28UcLPWKlyK3O5fNBPDlGXBi1eLDEdjk71UpHQuxo9aPT1
	iDVXji0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n3YTFg
	bxYFkHYCOR+qeGVERgiVH2CJGWfEEDgbv7cjIrKXq7zU2qeXSXUxJltygMtgiRjp
	BajXt1yDobJCL89knvDbphvENbt1R8iz/0gh5qIXnagk9fVr+hZdo+sa7umFn7Vh
	PT7BOvzNz+L9XJzvy/n34W9Mp2x+Pv1Kd58VU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC90F909C
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AF7C9097 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1D3D34B0-C496-11E1-A1CE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200873>

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
index 1acf3b4..d97fa2d 100644
--- a/cache.h
+++ b/cache.h
@@ -814,10 +814,11 @@ struct object_context {
 #define GET_SHA1_QUIETLY 01
 #define GET_SHA1_COMMIT 02
 #define GET_SHA1_COMMITTISH 04
+#define GET_SHA1_ONLY_TO_DIE 04000
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern void die_on_misspelt_object_name(const char *name, const char *prefix);
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
index 35ad473..b5f0be5 100644
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
@@ -1239,10 +1243,10 @@ void die_on_misspelt_object_name(const char *name, const char *prefix)
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
1.7.11.1.212.g52fe12e
