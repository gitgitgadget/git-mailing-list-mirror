From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/12] add a stat_validity struct
Date: Wed, 19 Jun 2013 09:51:30 +0200
Message-ID: <1371628293-28824-10-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBb-0002ed-Or
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab3FSHwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:06 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45880 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756553Ab3FSHwC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:52:02 -0400
X-AuditID: 1207440f-b7f786d000001f20-25-51c16322680d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 24.49.07968.22361C15; Wed, 19 Jun 2013 03:52:02 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWb002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:52:00 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKuUfDDQ4Nw9douuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ/w8bFnwX6xi5oGnTA2Mx4S6GDk5JARMJF6vPMICYYtJXLi3nq2L
	kYtDSOAyo8TL2VeYIZzbTBLT9mxnBqliE9CVWNTTzARiiwioSUxsO8QCUsQssJtRYvnpU+wg
	CWGgsX+vdrGC2CwCqhJ7mvvYQGxeAVeJeydnsEKsU5CY8vA90FAODk6g+NllniBhIQEXiXmn
	JrNOYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkzPh3MHatlznE
	KMDBqMTDa7juQKAQa2JZcWXuIUZJDiYlUV72pIOBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	9RyAcrwpiZVVqUX5MClpDhYlcV71Jep+QgLpiSWp2ampBalFMFkZDg4lCV4xkKGCRanpqRVp
	mTklCGkmDk4QwQWygQdow5FEkA3FBYm5xZnpEEWnGBWlxHnvgSQEQBIZpXlwA2AJ4RWjONA/
	wrysIHt4gMkErvsV0GAmoMFC3/eBDC5JREhJNTBaegnl8ZVqPxPLt5g78cbp+rANhVN6W/xW
	/Nnw6FlX73u1vIdNzuqfHn7LOx886U7TnS0TDj75tXZLjl1VVZpLcIHp3+vVDuxcuw5tv3JY
	+tmqs26a3Gsd2Ne/L/rf1VRZ8La2qaFUdo/wIbUd3fVCLvpPa8Kidscpzbwfdsqj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228361>

It can sometimes be useful to know whether a path in the
filesystem has been updated without going to the work of
opening and re-reading its content. We trust the stat()
information on disk already to handle index updates, and we
can use the same trick here.

This patch introduces a "stat_validity" struct which
encapsulates the concept of checking the stat-freshness of a
file. It is implemented on top of "struct stat_data" to
reuse the logic about which stat entries to trust for a
particular platform, but hides the complexity behind two
simple functions: check and update.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h      | 27 +++++++++++++++++++++++++++
 read-cache.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/cache.h b/cache.h
index f158fed..50f33db 100644
--- a/cache.h
+++ b/cache.h
@@ -1360,4 +1360,31 @@ int checkout_fast_forward(const unsigned char *from,
 
 int sane_execvp(const char *file, char *const argv[]);
 
+/*
+ * A struct to encapsulate the concept of whether a file has changed
+ * since we last checked it. This uses criteria similar to those used
+ * for the index.
+ */
+struct stat_validity {
+	struct stat_data *sd;
+};
+
+void stat_validity_clear(struct stat_validity *sv);
+
+/*
+ * Returns 1 if the path is a regular file (or a symlink to a regular
+ * file) and matches the saved stat_validity, 0 otherwise.  A missing
+ * or inaccessible file is considered a match if the struct was just
+ * initialized, or if the previous update found an inaccessible file.
+ */
+int stat_validity_check(struct stat_validity *sv, const char *path);
+
+/*
+ * Update the stat_validity from a file opened at descriptor fd. If
+ * the file is missing, inaccessible, or not a regular file, then
+ * future calls to stat_validity_check will match iff one of those
+ * conditions continues to be true.
+ */
+void stat_validity_update(struct stat_validity *sv, int fd);
+
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index 5660b37..b15bc09 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1950,3 +1950,33 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 		*size = sz;
 	return data;
 }
+
+void stat_validity_clear(struct stat_validity *sv)
+{
+	free(sv->sd);
+	sv->sd = NULL;
+}
+
+int stat_validity_check(struct stat_validity *sv, const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st) < 0)
+		return sv->sd == NULL;
+	if (!sv->sd)
+		return 0;
+	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
+}
+
+void stat_validity_update(struct stat_validity *sv, int fd)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode))
+		stat_validity_clear(sv);
+	else {
+		if (!sv->sd)
+			sv->sd = xcalloc(1, sizeof(struct stat_data));
+		fill_stat_data(sv->sd, &st);
+	}
+}
-- 
1.8.3.1
