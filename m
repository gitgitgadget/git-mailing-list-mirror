From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/33] refs: extract a function ref_resolves_to_object()
Date: Sun, 14 Apr 2013 14:54:25 +0200
Message-ID: <1365944088-10588-11-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:02:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMa9-0004GQ-9o
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab3DNNCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:02:53 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59221 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751457Ab3DNNCw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 09:02:52 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2013 09:02:52 EDT
X-AuditID: 1207440d-b7fd06d000000905-45-516aa743f801
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A4.1F.02309.347AA615; Sun, 14 Apr 2013 08:55:31 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk7007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:30 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqOu8PCvQoP2TikXXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf83TmRueANb8XVq1tYGxg7ubsYOTkkBEwklq07ww5hi0lcuLeerYuRi0NI4DKjxLkP
	x9ghnLNMEv1zpzOBVLEJ6Eos6mkGsjk4RASyJXavlQcJMws4SGz+3MgIYgsLeEi83ToLzGYR
	UJW4dWwpK4jNK+Aqcbd1MSPEMgWJ49u3gdmcQPHpz4+BHSEk4CIxa/Ns1gmMvAsYGVYxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihIQU7w7G/+tkDjEKcDAq8fC+YMwKFGJN
	LCuuzD3EKMnBpCTK27MMKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE17EVKMebklhZlVqUD5OS
	5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuB9vRSoUbAoNT21Ii0zpwQhzcTBCSK4QDbw
	AG14C1LIW1yQmFucmQ5RdIpRUUqcNwXkLAGQREZpHtwAWPS/YhQH+keY9ylIOw8wccB1vwIa
	zAQ02GdvOsjgkkSElFQDo2qN9p2pR7/0Vs9oXmf+SLlebP06n8kLY657qpeveCKv4p6v3LLA
	XOWktleaGC+XxaSzWRsu/l/su+7KIs3Z09jsvvw4+T1+U9h55baX+5pLg5Zldz2fVyx7Qsl6
	6zTdrbNrNv089ohffuoFeUmZDnvG+1b5bRXHL2y6eWzyhnWXl6goJDFu/q3EUpyR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221130>

It is a nice unit of work and soon will be needed from multiple
locations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index c523978..dfc8600 100644
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
+	if (!((flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
+	      ref_resolves_to_object(entry)))
+		return 0;
+
 	current_ref = entry;
 	retval = fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
 	current_ref = NULL;
-- 
1.8.2.1
