From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/7] replace: forbid replacing an object with one of a
 different type
Date: Fri, 06 Sep 2013 07:10:53 +0200
Message-ID: <20130906051100.6657.41248.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoL3-0005Eb-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785Ab3IFFL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:11:58 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:48935 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750767Ab3IFFLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:55 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9452872;
	Fri,  6 Sep 2013 07:11:33 +0200 (CEST)
X-git-sha1: 66693943be8dc815228ceebf14e4de6b01541f7b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234023>

Users replacing an object with one of a different type were not
prevented to do so, even if it was obvious, and stated in the doc,
that bad things would result from doing that.

To avoid mistakes, it is better to just forbid that though.

If -f option, which means '--force', is used, we can allow an object
to be replaced with one of a different type, as the user should know
what (s)he is doing.

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
index 59d3115..95736d9 100644
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
+	if (!force && obj_type != repl_type)
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
1.8.4.rc1.28.ge2684af
