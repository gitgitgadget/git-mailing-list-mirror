From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/33] refs: extract function peel_object()
Date: Sun, 14 Apr 2013 14:54:26 +0200
Message-ID: <1365944088-10588-12-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMU8-0005OY-9S
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3DNM4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:42 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54964 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab3DNMzd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:33 -0400
X-AuditID: 1207440f-b7f0e6d000000957-26-516aa745451a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AA.7A.02391.547AA615; Sun, 14 Apr 2013 08:55:33 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk8007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:31 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqOu6PCvQYN0xHouuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M64+PsjW8FpoYpd796xNTDu5+ti5OSQEDCRuPD9FjOELSZx4d56NhBbSOAyo0RHv38X
	IxeQfZZJorV3CytIgk1AV2JRTzNTFyMHh4hAtsTutfIgYWYBB4nNnxsZQWxhAWuJ/jlnWEBs
	FgFVibdPpzOB2LwCrhI7Hy1lgtilIHF8+zawek6g+PTnx9gh9rpIzNo8m3UCI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCEBxb+DsWu9zCFGAQ5GJR5eB5asQCHW
	xLLiytxDjJIcTEqivAuXAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Dq2AuV4UxIrq1KL8mFS
	0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8r0GGChalpqdWpGXmlCCkmTg4QQQXyAYe
	oA1vQQp5iwsSc4sz0yGKTjEqSonzfgRJCIAkMkrz4AbAYv8VozjQP8K8T0GqeIBpA677FdBg
	JqDBPnvTQQaXJCKkpBoYE+42V8UG5wc+2MCwMDv6yZQjH4QPZggYz94lbeR+dGGV68+X4o53
	PPL/sCUbrH8lHvNqx76OmJRH+dM0PT+7/FSYz9d7RT7JpNDIzPmNQ/GXoJydm9W4/9Y8lXc+
	ydGy7PiNmO5GHheZo0H7vzVe25j5NOKoroDnykJ5Hg4hzuKp6r5NAaeVWIozEg21 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221123>

It is a nice, logical unit of work, and putting it in a function
removes the need to use a goto in peel_ref().  Soon it will also have
other uses.

The algorithm is unchanged.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index dfc8600..a1fe6b0 100644
--- a/refs.c
+++ b/refs.c
@@ -1272,11 +1272,38 @@ static int filter_refs(const char *refname, const unsigned char *sha1, int flags
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
 
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  Store the result to sha1
+ * and return 0 iff successful.  If the object is not a tag or is not
+ * valid, return -1 and leave sha1 unchanged.
+ */
+static int peel_object(const unsigned char *name, unsigned char *sha1)
+{
+	struct object *o = lookup_unknown_object(name);
+
+	if (o->type == OBJ_NONE) {
+		int type = sha1_object_info(name, NULL);
+		if (type < 0)
+			return -1;
+		o->type = type;
+	}
+
+	if (o->type != OBJ_TAG)
+		return -1;
+
+	o = deref_tag_noverify(o);
+	if (!o)
+		return -1;
+
+	hashcpy(sha1, o->sha1);
+	return 0;
+}
+
 int peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
-	struct object *o;
 
 	if (current_ref && (current_ref->name == refname
 		|| !strcmp(current_ref->name, refname))) {
@@ -1286,8 +1313,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 			hashcpy(sha1, current_ref->u.value.peeled);
 			return 0;
 		}
-		hashcpy(base, current_ref->u.value.sha1);
-		goto fallback;
+		return peel_object(current_ref->u.value.sha1, sha1);
 	}
 
 	if (read_ref_full(refname, base, 1, &flag))
@@ -1302,23 +1328,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		}
 	}
 
-fallback:
-	o = lookup_unknown_object(base);
-	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(base, NULL);
-		if (type < 0)
-			return -1;
-		o->type = type;
-	}
-
-	if (o->type == OBJ_TAG) {
-		o = deref_tag_noverify(o);
-		if (o) {
-			hashcpy(sha1, o->sha1);
-			return 0;
-		}
-	}
-	return -1;
+	return peel_object(base, sha1);
 }
 
 struct warn_if_dangling_data {
-- 
1.8.2.1
