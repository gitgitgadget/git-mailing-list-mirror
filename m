From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/33] refs: extract function peel_object()
Date: Mon, 22 Apr 2013 21:52:19 +0200
Message-ID: <1366660361-21831-12-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoA-0004ng-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab3DVTxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:46 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:54687 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754873Ab3DVTxo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:44 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-69-517595479ee0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 13.DA.02380.74595715; Mon, 22 Apr 2013 15:53:43 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOO008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:42 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqOs+tTTQoO+GmkXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGe82LmPqeC0UMW+5s2MDYz7
	+boYOTkkBEwk3q+dwwxhi0lcuLeerYuRi0NI4DKjRNP9DnaQhJDABSaJ9dM0QGw2AV2JRT3N
	TCC2iICaxMS2QywgNrOAg8Tmz42MILawgJ3E/klnwHpZBFQlvuyfCLaAV8BVYve6hVDLFCSO
	b98GVs8JFD/dcYIFYpeLxIqDU1kmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrJeb
	WaKXmlK6iRESKnw7GNvXyxxiFOBgVOLhFXAvDRRiTSwrrsw9xCjJwaQkyssxBSjEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhFc0HyjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgST
	leHgUJLg/TYZqFGwKDU9tSItM6cEIc3EwQkiuEA28ABtiATZzltckJhbnJkOUXSKUVFKnNdt
	ElBCACSRUZoHNwAW1a8YxYH+Eea9BLKHB5gQ4LpfAQ1mAhqcmVACMrgkESEl1cCo/vyDwp6M
	PZH/nE9UnTnDcMG3RMHu6dIHCXUvn1xLjZijdyvLb97e03P6p8s/Fzx0mrFb+F3+g8XsSUet
	dSs0Ktv7ds9mL7ocynFm5b1lt3uSapcvWDjx2uYVzlJrIv/u/hDcr8x4M5NHpNDl4evdQQZX
	5r38y7Pqz4pdrnOn7wkV3xIpPLMmXYmlOCPRUIu5qDgRAIqzB+/FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222056>

It is a nice, logical unit of work, and putting it in a function
removes the need to use a goto in peel_ref().  Soon it will also have
other uses.

The algorithm is unchanged.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 8b554d8..b0ef129 100644
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
