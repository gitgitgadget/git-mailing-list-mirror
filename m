From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 19/20] try_remove_empty_parents(): teach to remove parents of reflogs, too
Date: Tue, 16 Feb 2016 14:22:32 +0100
Message-ID: <d4eee6ac9fe6d1dd35727dcd89bc1b2ad3517e69.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfbF-0005mm-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbcBPNXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:23:20 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64103 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932147AbcBPNXS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:23:18 -0500
X-AuditID: 1207440d-6b7ff7000000068f-40-56c322c58027
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 59.B2.01679.5C223C65; Tue, 16 Feb 2016 08:23:17 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOf028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:23:16 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqHtM6XCYwWUBi/mbTjBadF3pZrJo
	6L3CbPFh7SE2i97JvawWt1fMZ7b40dLD7MDu8ff9ByaPp9unMHu8OF/h8ax3D6PHxUvKHgue
	32f3+LxJLoA9itsmKbGkLDgzPU/fLoE7Y+Kuv0wFM4UqDl3+ytrA+Iavi5GTQ0LARKJh8lPW
	LkYuDiGBrYwSBz73s0A4J5gkfjZfZwKpYhPQlVjU0wxmiwioSUxsOwRWxCzwiFGia/92RpCE
	sECUxL6O9UCjODhYBFQlpn3nAAnzAoVXdj5lh9gmJ9HyYzcriM0pYCFxsqWXBcQWEjCXuPNl
	D9MERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUICjHcH4/91MocY
	BTgYlXh4OTwOhQmxJpYVV+YeYpTkYFIS5eXhPhwmxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3
	3yugct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG+HItBQwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAMxBcDowAkxQO0Nw2knbe4IDEXKArReopRUUqc
	1wUkIQCSyCjNgxsLSxuvGMWBvhTmPQ5SxQNMOXDdr4AGMwENzrkE8lBxSSJCSqqB0U9b+wr/
	xr228YLbE6erXtCMzRU1fSlpVHEqliFyl+TFtqWnVI4ue7qPs9usinVPx/6FDH7FkquZWB/c
	5nH/GxUrnOMotNL4x43766QWe2yOiPxvLtnrN0FSjsHQr2Ma+9n9K5fNuCnxxvWZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286358>

Add a new "flags" parameter that tells the function whether to remove
empty parent directories of the loose reference file, of the reflog
file, or both. The new functionality is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b2b0f39..9d9151c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2198,10 +2198,18 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
+enum {
+	REMOVE_EMPTY_PARENTS_REF = 0x01,
+	REMOVE_EMPTY_PARENTS_REFLOG = 0x02
+};
+
 /*
- * Remove empty parents, but spare refs/ and immediate subdirs.
+ * Remove empty parent directories associated with the specified
+ * reference and/or its reflog, but spare [logs/]refs/ and immediate
+ * subdirs. flags is a combination of REMOVE_EMPTY_PARENTS_REF and/or
+ * REMOVE_EMPTY_PARENTS_REFLOG.
  */
-static void try_remove_empty_parents(const char *refname)
+static void try_remove_empty_parents(const char *refname, unsigned int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
@@ -2216,7 +2224,7 @@ static void try_remove_empty_parents(const char *refname)
 			p++;
 	}
 	q = buf.buf + buf.len;
-	while (1) {
+	while (flags & (REMOVE_EMPTY_PARENTS_REF | REMOVE_EMPTY_PARENTS_REFLOG)) {
 		while (q > p && *q != '/')
 			q--;
 		if (q > p && *(q-1) == '/')
@@ -2224,8 +2232,12 @@ static void try_remove_empty_parents(const char *refname)
 		if (q == p)
 			break;
 		strbuf_setlen(&buf, q - buf.buf);
-		if (rmdir(git_path("%s", buf.buf)))
-			break;
+		if ((flags & REMOVE_EMPTY_PARENTS_REF) &&
+		    rmdir(git_path("%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REF;
+		if ((flags & REMOVE_EMPTY_PARENTS_REFLOG) &&
+		    rmdir(git_path("logs/%s", buf.buf)))
+			flags &= ~REMOVE_EMPTY_PARENTS_REFLOG;
 	}
 	strbuf_release(&buf);
 }
@@ -2251,7 +2263,7 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name);
+	try_remove_empty_parents(r->name, REMOVE_EMPTY_PARENTS_REF);
 }
 
 static void prune_refs(struct ref_to_prune *r)
-- 
2.7.0
