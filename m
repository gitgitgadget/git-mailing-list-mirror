From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/20] try_remove_empty_parents(): teach to remove parents of reflogs, too
Date: Thu, 25 Feb 2016 14:16:18 +0100
Message-ID: <2b81d46035f578f0144843065b178ed428c54acb.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvnB-000412-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760605AbcBYNRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:17:11 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46502 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760590AbcBYNRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:17:09 -0500
X-AuditID: 12074412-b07ff70000006da4-0d-56cefecebae2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id FC.A8.28068.ECEFEC65; Thu, 25 Feb 2016 08:17:02 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrx024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:17:01 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHvu37kwg859OhbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bLw1lMBTOFKt5ue8HWwPiGr4uRk0NCwETi1cRL
	7CC2kMBWRom7E526GLmA7BNMEv+/n2IFSbAJ6Eos6mlmArFFBNQkJrYdYgEpYhZ4xCjRtX87
	I0hCWCBW4vHBDrAGFgFVicYLj9lAbF6BKIk3s56yQGyTk2j5sRushlPAQuLiyenMEJvNJVbd
	2MM+gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQEBPawbj+pNwh
	RgEORiUe3ojfZ8OEWBPLiitzDzFKcjApifLueX4uTIgvKT+lMiOxOCO+qDQntfgQowQHs5II
	74q/QDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQleZmAsCQkWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiC+GBgFICkeoL2KIO28xQWJuUBRiNZTjIpS
	4rzLQQ4SAElklObBjYUljleM4kBfCvOagVTxAJMOXPcroMFMQINnbgAbXJKIkJJqYFwS/SLN
	0Ft0nkgcH++KR5WuvlpGLN9vv9ojIxbxsb1j5ny5xdwRZiYv9UNWr7AJVwq292g/33Djx3vd
	/vl+3rdUNn/4XLw//gPLhhibPyf9NRaYHPG+3X963s7Wu0/502Nv73yetEVW2ari 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287378>

Add a new "flags" parameter that tells the function whether to remove
empty parent directories of the loose reference file, of the reflog
file, or both. The new functionality is not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b137171..9ebb188 100644
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
