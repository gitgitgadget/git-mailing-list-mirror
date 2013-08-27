From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] replace: forbid replacing an object with one of a
 different type
Date: Tue, 27 Aug 2013 21:48:23 +0200
Message-ID: <20130827194828.11172.73829.chriscool@tuxfamily.org>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPGW-0006qj-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab3H0TtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:49:02 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:58555 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab3H0TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:49:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id C32BCB3;
	Tue, 27 Aug 2013 21:48:58 +0200 (CEST)
X-git-sha1: e2762440a346537a7e246fb4569e0c03a0c984c1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233152>

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
index 59d3115..9a94769 100644
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
+		    "'%s' points to a replaced object of type '%s'\n"
+		    "while '%s' points to a replacement object of type '%s'.",
+		    object_ref, typename(obj_type),
+		    replace_ref, typename(repl_type));
+
 	if (read_ref(ref, prev))
 		hashclr(prev);
 	else if (!force)
-- 
1.8.4.rc1.26.gdd51ee9
