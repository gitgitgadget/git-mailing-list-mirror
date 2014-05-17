From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/10] replace: refactor checking ref validity
Date: Sat, 17 May 2014 08:41:28 +0200
Message-ID: <20140517064133.18932.16751.chriscool@tuxfamily.org>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:44:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYLd-0006qT-Kg
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998AbaEQGnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:43:37 -0400
Received: from [194.158.98.45] ([194.158.98.45]:61580 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756816AbaEQGne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:43:34 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 2EC0053;
	Sat, 17 May 2014 08:43:13 +0200 (CEST)
X-git-sha1: 60c651438fc96f7d0a97565b351e955f741b8d97 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249448>

This will be useful in a following commit when we will
want to check if the ref already exists before we let the
user edit an object.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 0751804..3d6edaf 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -124,6 +124,25 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
+static void check_ref_valid(unsigned char object[20],
+			    unsigned char prev[20],
+			    char *ref,
+			    int ref_size,
+			    int force)
+{
+	if (snprintf(ref, ref_size,
+		     "refs/replace/%s",
+		     sha1_to_hex(object)) > ref_size - 1)
+		die("replace ref name too long: %.*s...", 50, ref);
+	if (check_refname_format(ref, 0))
+		die("'%s' is not a valid ref name.", ref);
+
+	if (read_ref(ref, prev))
+		hashclr(prev);
+	else if (!force)
+		die("replace ref '%s' already exists", ref);
+}
+
 static int replace_object_sha1(const char *object_ref,
 			       unsigned char object[20],
 			       const char *replace_ref,
@@ -135,13 +154,6 @@ static int replace_object_sha1(const char *object_ref,
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
-	if (snprintf(ref, sizeof(ref),
-		     "refs/replace/%s",
-		     sha1_to_hex(object)) > sizeof(ref) - 1)
-		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_refname_format(ref, 0))
-		die("'%s' is not a valid ref name.", ref);
-
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
 	if (!force && obj_type != repl_type)
@@ -151,10 +163,7 @@ static int replace_object_sha1(const char *object_ref,
 		    object_ref, typename(obj_type),
 		    replace_ref, typename(repl_type));
 
-	if (read_ref(ref, prev))
-		hashclr(prev);
-	else if (!force)
-		die("replace ref '%s' already exists", ref);
+	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
 	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
 	if (!lock)
-- 
1.9.rc0.17.g651113e
