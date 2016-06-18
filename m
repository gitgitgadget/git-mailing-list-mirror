Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5094B1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbcFREPn (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52499 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239AbcFREPm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:42 -0400
X-AuditID: 12074414-62bff700000008e6-c7-5764caed45ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D0.B9.02278.DEAC4675; Sat, 18 Jun 2016 00:15:41 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJj029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:39 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/13] ref_resolves_to_object(): new function
Date:	Sat, 18 Jun 2016 06:15:14 +0200
Message-Id: <c83216533b1411628922762117ee8312593c53b5.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPv2VEq4wclTohbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M7YtzGo4DFvxaqLkxkbGP9ydTFy
	ckgImEjM+rqWrYuRi0NIYCujxO8bPVDOSSaJjsmnWECq2AR0JRb1NDOB2CICERINr1oYQYqY
	BeYwSdx+2MkMkhAWcJDoWbUCrIFFQFVi1bE9YA28AlESm86sZoFYJydxefoDNhCbU8BCYsGW
	fUA1HEDbzCX2LjacwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI
	yInsYDxyUu4QowAHoxIPb4B9SrgQa2JZcWXuIUZJDiYlUd4rlUAhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIrxbTgDleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeJee
	BGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VAfDEwBkBSPEB7N4G08xYXJOYC
	RSFaTzEqSonzLgA5SAAkkVGaBzcWlkheMYoDfSnM+wKknQeYhOC6XwENZgIarDkvGWRwSSJC
	SqqBMTX02Aq3h867dn3jMZ7JGNmldWjRxpv+QTqc5xYzMdbtf71zhQ3DhLMTJJp2rrBm6n+q
	ztGwbVOcjGHTtkzzJddCWG/3hx1U/hzlnur0gPG/wLaWu6vcGvumLe7VyrxUYLb/zcFZDSfY
	Ixe/4q558zs18EX4n42VyjlVbxbf6Jy995CnzpobCUosxRmJhlrMRcWJABw7poH/AgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Extract new function ref_resolves_to_object() from
entry_resolves_to_object(). It can be used even if there is no ref_entry
at hand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c24a78e..62280b5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -513,19 +513,32 @@ static void sort_ref_dir(struct ref_dir *dir)
 }
 
 /*
- * Return true iff the reference described by entry can be resolved to
- * an object in the database.  Emit a warning if the referred-to
- * object does not exist.
+ * Return true if refname, which has the specified oid and flags, can
+ * be resolved to an object in the database. If the referred-to object
+ * does not exist, emit a warning and return false.
+ */
+static int ref_resolves_to_object(const char *refname,
+				  const struct object_id *oid,
+				  unsigned int flags)
+{
+	if (flags & REF_ISBROKEN)
+		return 0;
+	if (!has_sha1_file(oid->hash)) {
+		error("%s does not point to a valid object!", refname);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Return true if the reference described by entry can be resolved to
+ * an object in the database; otherwise, emit a warning and return
+ * false.
  */
 static int entry_resolves_to_object(struct ref_entry *entry)
 {
-	if (entry->flag & REF_ISBROKEN)
-		return 0;
-	if (!has_sha1_file(entry->u.value.oid.hash)) {
-		error("%s does not point to a valid object!", entry->name);
-		return 0;
-	}
-	return 1;
+	return ref_resolves_to_object(entry->name,
+				      &entry->u.value.oid, entry->flag);
 }
 
 /*
-- 
2.8.1

