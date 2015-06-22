From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/19] delete_refs(): new function for the refs API
Date: Mon, 22 Jun 2015 16:02:55 +0200
Message-ID: <9a6c35bd603edfc46da241b8c762f1a269ac44f8.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KK-0005gX-5x
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933642AbbFVODn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50088 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755572AbbFVODW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:22 -0400
X-AuditID: 1207440c-f79e16d000002a6e-db-558815a8e095
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id AA.D4.10862.8A518855; Mon, 22 Jun 2015 10:03:20 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc2030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:19 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLtCtCPU4MhTBYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZyxe38dScEm04vCNyawNjAsFuxg5OSQETCR+ND9jgrDFJC7cW8/WxcjFISRwmVHi+ML9
	7BDOSSaJxy+fs4FUsQnoSizqaQbrEBFQk5jYdogFpIhZoINR4sLybewgCWEBN4kX67+zgNgs
	AqoS576cAbN5BaIkPn5ZzwyxTk7i/PGfYDangIXE/H3/wXqFBMwlJs58xDKBkXcBI8MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJCg4tnB+G2dzCFGAQ5GJR5eB9v2UCHW
	xLLiytxDjJIcTEqivAdeA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8LacBcrxpiRWVqUW5cOk
	pDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4/UQ6QoUEi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQdERXwyMD5AUD9DepSDtvMUFiblAUYjWU4yKUuK8/iAJAZBERmke3FhY
	qnjFKA70pTDvT2GgKh5gmoHrfgU0mAlo8JfcNpDBJYkIKakGRlke3tnsks8K/n3ausD+2tWd
	m/yEo4SqWONZxSce518SfETl8bX1rjy9ylOu74xK/nReYOFr+7nz5n71uXYo/D97jENiV3Lq
	xYgElfUCItzce9g7Z7uuSt6y+Yz+vE/hmyM4MzwPMNxLWPzk4/I7DP7v79ke6jk3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272349>

Move the function remove_branches() from builtin/remote.c to refs.c,
rename it to delete_refs(), and make it public.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 21 +--------------------
 refs.c           | 19 +++++++++++++++++++
 refs.h           |  7 +++++++
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 53b8e13..c8dc724 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -746,25 +746,6 @@ static int mv(int argc, const char **argv)
 	return 0;
 }
 
-static int remove_branches(struct string_list *branches)
-{
-	struct strbuf err = STRBUF_INIT;
-	int i, result = 0;
-
-	if (repack_without_refs(branches, &err))
-		result |= error("%s", err.buf);
-	strbuf_release(&err);
-
-	for (i = 0; i < branches->nr; i++) {
-		const char *refname = branches->items[i].string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
-	}
-
-	return result;
-}
-
 static int rm(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -821,7 +802,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = remove_branches(&branches);
+		result = delete_refs(&branches);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
diff --git a/refs.c b/refs.c
index f0b6cec..6f62bd1 100644
--- a/refs.c
+++ b/refs.c
@@ -2818,6 +2818,25 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
+int delete_refs(struct string_list *refnames)
+{
+	struct strbuf err = STRBUF_INIT;
+	int i, result = 0;
+
+	if (repack_without_refs(refnames, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
+
+	for (i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+
+		if (delete_ref(refname, NULL, 0))
+			result |= error(_("Could not remove branch %s"), refname);
+	}
+
+	return result;
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
diff --git a/refs.h b/refs.h
index 68b5e81..1a5d44a 100644
--- a/refs.h
+++ b/refs.h
@@ -212,6 +212,13 @@ extern int reflog_exists(const char *refname);
 extern int delete_ref(const char *refname, const unsigned char *old_sha1,
 		      unsigned int flags);
 
+/*
+ * Delete the specified references. If there are any problems, emit
+ * errors but attempt to keep going (i.e., the deletes are not done in
+ * an all-or-nothing transaction).
+ */
+extern int delete_refs(struct string_list *refnames);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4
