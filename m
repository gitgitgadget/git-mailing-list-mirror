From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] link_alt_odb_entries(): use string_list_split_in_place()
Date: Mon,  5 Nov 2012 09:41:22 +0100
Message-ID: <1352104883-21053-2-git-send-email-mhagger@alum.mit.edu>
References: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 09:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVIGG-0001oH-9g
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 09:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab2KEIl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 03:41:57 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:51910 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052Ab2KEIlz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 03:41:55 -0500
X-AuditID: 12074413-b7f786d0000008bb-9c-50977bd2da2b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 96.E5.02235.2DB77905; Mon,  5 Nov 2012 03:41:54 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA58fjnP015704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Nov 2012 03:41:53 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqHupenqAwaJ1UhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujPMr5rEW
	/JKouDL/D3MD42PhLkYODgkBE4nHCw26GDmBTDGJC/fWs3UxcnEICVxmlGje080E4Zxmkjg1
	/RQbSBWbgK7Eop5mJhBbREBW4vvhjYwgNrNArsTid7fZQWxhAV+Jx8emg9ksAqoSO7/MZQax
	eQVcJLb9aGSB2CYn8WHPI7AaTgFXibXHFoDVCAHVbPg1kXkCI+8CRoZVjHKJOaW5urmJmTnF
	qcm6xcmJeXmpRbrmermZJXqpKaWbGCHhI7yDcddJuUOMAhyMSjy8HySmBwixJpYVV+YeYpTk
	YFIS5V1ZCRTiS8pPqcxILM6ILyrNSS0+xCjBwawkwsvBAJTjTUmsrEotyodJSXOwKInzqi1R
	9xMSSE8sSc1OTS1ILYLJynBwKEnw3q4CahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwt
	yYgHRUZ8MTA2QFI8QHtXgLTzFhck5gJFIVpPMepyHH0z9yGjEEtefl6qlDjveZAiAZCijNI8
	uBWwZPGKURzoY2HegyBVPMBEAzfpFdASJqAl2y9NAVlSkoiQkmpg1N+490Tsz3Mu30PZts3l
	ymXY9vnNPj59x9bJr75xZCXtlOC8+3aVR6RCj4HtjsSoO2pnj9+IKV1ZpqMlb+g3f8td/dT0
	HVfn57wI4TrLuCpcJuL4FrvN10sDWbZucmnWmHKYZ0mB23QLq2B+kTWvj9tFHBKt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209053>

Change link_alt_odb_entry() to take a NUL-terminated string instead of
(char *, len).  Use string_list_split_in_place() rather than inline
code in link_alt_odb_entries().

This approach saves some code and also avoids the (probably harmless)
error of passing a non-NUL-terminated string to is_absolute_path().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9152974..c352413 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -7,6 +7,7 @@
  * creation etc.
  */
 #include "cache.h"
+#include "string-list.h"
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
@@ -246,7 +247,7 @@ static int git_open_noatime(const char *name);
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+static int link_alt_odb_entry(const char *entry, const char *relative_base, int depth)
 {
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
@@ -258,7 +259,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 		strbuf_addstr(&pathbuf, real_path(relative_base));
 		strbuf_addch(&pathbuf, '/');
 	}
-	strbuf_add(&pathbuf, entry, len);
+	strbuf_addstr(&pathbuf, entry);
 
 	normalize_path_copy(pathbuf.buf, pathbuf.buf);
 
@@ -319,7 +320,9 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 				 const char *relative_base, int depth)
 {
-	const char *cp, *last;
+	struct string_list entries = STRING_LIST_INIT_NODUP;
+	char *alt_copy;
+	int i;
 
 	if (depth > 5) {
 		error("%s: ignoring alternate object stores, nesting too deep.",
@@ -327,30 +330,21 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 		return;
 	}
 
-	last = alt;
-	while (last < ep) {
-		cp = last;
-		if (cp < ep && *cp == '#') {
-			while (cp < ep && *cp != sep)
-				cp++;
-			last = cp + 1;
+	alt_copy = xmemdupz(alt, ep - alt);
+	string_list_split_in_place(&entries, alt_copy, sep, -1);
+	for (i = 0; i < entries.nr; i++) {
+		const char *entry = entries.items[i].string;
+		if (entry[0] == '\0' || entry[0] == '#')
 			continue;
+		if (!is_absolute_path(entry) && depth) {
+			error("%s: ignoring relative alternate object store %s",
+					relative_base, entry);
+		} else {
+			link_alt_odb_entry(entry, relative_base, depth);
 		}
-		while (cp < ep && *cp != sep)
-			cp++;
-		if (last != cp) {
-			if (!is_absolute_path(last) && depth) {
-				error("%s: ignoring relative alternate object store %s",
-						relative_base, last);
-			} else {
-				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
-			}
-		}
-		while (cp < ep && *cp == sep)
-			cp++;
-		last = cp;
 	}
+	string_list_clear(&entries, 0);
+	free(alt_copy);
 }
 
 void read_info_alternates(const char * relative_base, int depth)
-- 
1.8.0
