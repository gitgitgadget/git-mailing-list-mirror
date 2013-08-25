From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] replace: forbid replacing an object with one of a
 different type
Date: Sun, 25 Aug 2013 15:06:04 +0200
Message-ID: <20130825130609.4681.25786.chriscool@tuxfamily.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDa1p-0003bG-Bq
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab3HYNGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:06:39 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:62405 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab3HYNGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:06:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4B4CD58;
	Sun, 25 Aug 2013 15:06:34 +0200 (CEST)
X-git-sha1: 4b7250a3a260cbe1ee170417b43b2ced5491ca01 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232957>

Users replacing an object with one of a different type were not
prevented to do so, even if it was obvious, and stated in the doc,
that bad things would result from doing that.

To avoid mistakes, it is better to just forbid that though.

There is no case where one object can be replaced with one of a
different type while keeping the history valid, because:

* Annotated tags contain the type of the tagged object.

* The tree/parent lines in commits must be a tree and commits, resp.

* The object types referred to by trees are specified in the 'mode'
  field:
    100644 and 100755    blob
    160000               commit
    040000               tree
  (these are the only valid modes)

* Blobs don't point at anything.

The doc will be updated in a later patch.

Acked-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 59d3115..bc6c245 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -85,6 +85,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 			  int force)
 {
 	unsigned char object[20], prev[20], repl[20];
+	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
@@ -100,6 +101,15 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	if (check_refname_format(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
 
+	obj_type = sha1_object_info(object, NULL);
+	repl_type = sha1_object_info(repl, NULL);
+	if (obj_type != repl_type)
+		die("Objects must be of the same type.\n"
+		    "Object ref '%s' is of type '%s'\n"
+		    "while replace ref '%s' is of type '%s'.",
+		    object_ref, typename(obj_type),
+		    replace_ref, typename(repl_type));
+
 	if (read_ref(ref, prev))
 		hashclr(prev);
 	else if (!force)
-- 
1.8.4.rc1.24.g13dc82a
