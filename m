From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/33] refs: extract a function ref_resolves_to_object()
Date: Mon, 22 Apr 2013 21:52:18 +0200
Message-ID: <1366660361-21831-11-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMv3-0005u7-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab3DVUAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:00:53 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63492 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753735Ab3DVUAw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:00:52 -0400
X-AuditID: 12074412-b7f216d0000008d4-3d-517595464e38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id ED.7F.02260.64595715; Mon, 22 Apr 2013 15:53:42 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEON008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:41 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOs2tTTQYP1PPouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M54fHUKa8Fr3opXHdfYGxg7
	uLsYOTkkBEwkvr/5yQphi0lcuLeerYuRi0NI4DKjxOeFd1ggnAtMEs2d5xlBqtgEdCUW9TQz
	gdgiAmoSE9sOsYDYzAIOEps/N4LVCAt4S+yZ2cwOYrMIqEq8erAUbAOvgKvE6RN72SG2KUgc
	374NrJ4TJN5xAmyOkICLxIqDU1kmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppeb
	WaKXmlK6iRESLEI7GNeflDvEKMDBqMTDK+BeGijEmlhWXJl7iFGSg0lJlJdjClCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCK9oPlCONyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFM
	VoaDQ0mC99tkoEbBotT01Iq0zJwShDQTByeI4ALZwAO0QR5kO29xQWJucWY6RNEpRkUpcV63
	SUAJAZBERmke3ABYXL9iFAf6R5iXD6SdB5gS4LpfAQ1mAhqcmVACMrgkESEl1cC4tr3snk7T
	r/xfnlaT1Bo9XWXEp831Z2fmeZPtf9jZcMvqSekyflnvI+yfpiaxHlU+3iC7/udJG+1SQdOz
	vZ+fuVhcVZcMlFj512H15U3btNNrOZ/KSbZbL51vH+cu2qm+00id51Jd2fU1s0M3OF9LvBOz
	Mv7upl2ZNZ+UBALLpT6zKa3xm6fEUpyRaKjFXFScCAAj3Mc5xgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222072>

It is a nice unit of work and soon will be needed from multiple
locations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 1c8edb1..8b554d8 100644
--- a/refs.c
+++ b/refs.c
@@ -529,6 +529,22 @@ static void sort_ref_dir(struct ref_dir *dir)
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 /*
+ * Return true iff the reference described by entry can be resolved to
+ * an object in the database.  Emit a warning if the referred-to
+ * object does not exist.
+ */
+static int ref_resolves_to_object(struct ref_entry *entry)
+{
+	if (entry->flag & REF_ISBROKEN)
+		return 0;
+	if (!has_sha1_file(entry->u.value.sha1)) {
+		error("%s does not point to a valid object!", entry->name);
+		return 0;
+	}
+	return 1;
+}
+
+/*
  * current_ref is a performance hack: when iterating over references
  * using the for_each_ref*() functions, current_ref is set to the
  * current reference's entry before calling the callback function.  If
@@ -549,14 +565,10 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	if (prefixcmp(entry->name, base))
 		return 0;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-		if (entry->flag & REF_ISBROKEN)
-			return 0; /* ignore broken refs e.g. dangling symref */
-		if (!has_sha1_file(entry->u.value.sha1)) {
-			error("%s does not point to a valid object!", entry->name);
-			return 0;
-		}
-	}
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+	      !ref_resolves_to_object(entry))
+		return 0;
+
 	current_ref = entry;
 	retval = fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
 	current_ref = NULL;
-- 
1.8.2.1
