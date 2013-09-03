From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/11] replace: forbid replacing an object with one of a
 different type
Date: Tue, 03 Sep 2013 09:10:15 +0200
Message-ID: <20130903071026.29838.65139.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGklv-0004eS-8r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3ICHLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:11:15 -0400
Received: from [194.158.98.15] ([194.158.98.15]:42770 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751968Ab3ICHLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:11:14 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A951F42;
	Tue,  3 Sep 2013 09:10:52 +0200 (CEST)
X-git-sha1: 30c2d43b884e5f80962f1b30f89d9104f31dad45 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233688>

Users replacing an object with one of a different type were not
prevented to do so, even if it was obvious, and stated in the doc,
that bad things would result from doing that.

To avoid mistakes, it is better to just forbid that though.

If one object is replaced with one of a different type, the only way
to keep the history valid is to also replace all the other objects
that point to the replaced object. That's because:

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
1.8.4.rc1.31.g530f5ce.dirty
