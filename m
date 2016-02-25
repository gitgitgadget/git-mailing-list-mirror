From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/20] try_remove_empty_parents(): don't trash argument contents
Date: Thu, 25 Feb 2016 14:16:13 +0100
Message-ID: <1cdb052a14cd1fe0615697527b5e84aabff5774c.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmx-0003rh-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573AbcBYNQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:58 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57352 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760327AbcBYNQy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:54 -0500
X-AuditID: 12074411-fd3ff700000071cf-60-56cefec537a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 91.8D.29135.5CEFEC65; Thu, 25 Feb 2016 08:16:53 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrs024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:52 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHv037kwg/9LzCzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oz77zvZCuZzVxw8t52xgfEeRxcjJ4eEgInE4Zc/
	WLsYuTiEBLYyShyYuZkFwjnBJPG17ScbSBWbgK7Eop5mJhBbREBNYmLbIbAiZoFHjBJd+7cz
	giSEBYIlbq+azQxiswioSqzevgSsmVcgSuL0s6usEOvkJFp+7AazOQUsJC6enA5WLyRgLrHq
	xh72CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBJngDsYZJ+UO
	MQpwMCrx8Eb8PhsmxJpYVlyZe4hRkoNJSZR3z/NzYUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
	eFf8BcrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4mYHRJCRYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioL4YmAcgKR4gPbGgLTzFhck5gJFIVpPMSpK
	ifMuBzlIACSRUZoHNxaWOl4xigN9KcxrBlLFA0w7cN2vgAYzAQ2euQFscEkiQkqqgXG1u0G8
	yaLG2LkVt45ZnDaQ2WIW9fvPi9hl6uvabn8W5LDS6crIPO+7/vWMdVeilpqeKmCzeGQb/szC
	ftoimxKLzTxJDS8iVW5atjGlBMlePpT4ZfeaA9YPgzk0G5RXHcxYrs5ue0d5xedM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287373>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 543fd8e..1fcbb6f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2200,13 +2200,15 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *refname)
+static void try_remove_empty_parents(const char *refname)
 {
+	struct strbuf buf = STRBUF_INIT;
 	char *p, *q;
 	int i;
-	p = refname;
+
+	strbuf_addstr(&buf, refname);
+	p = buf.buf;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2214,8 +2216,7 @@ static void try_remove_empty_parents(char *refname)
 		while (*p == '/')
 			p++;
 	}
-	for (q = p; *q; q++)
-		;
+	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
@@ -2223,10 +2224,11 @@ static void try_remove_empty_parents(char *refname)
 			q--;
 		if (q == p)
 			break;
-		*q = '\0';
-		if (rmdir(git_path("%s", refname)))
+		strbuf_setlen(&buf, q - buf.buf);
+		if (rmdir(git_path("%s", buf.buf)))
 			break;
 	}
+	strbuf_release(&buf);
 }
 
 /* make sure nobody touched the ref, and unlink */
-- 
2.7.0
