From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/12] add a stat_validity struct
Date: Thu, 20 Jun 2013 10:37:51 +0200
Message-ID: <1371717474-28942-10-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaOe-0008Bz-IB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab3FTIjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:39:06 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52885 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965025Ab3FTIiW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:22 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-8c-51c2bf7ead4c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BF.D4.17335.E7FB2C15; Thu, 20 Jun 2013 04:38:22 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sH001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:20 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqFu3/1CgwddPUhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzvh52LLgv1jFzANPmRoYjwl1MXJySAiYSJx4voAdwhaTuHBvPVsX
	IxeHkMBlRon+ZY9YIJxzTBKXrp9jBKliE9CVWNTTzARiiwioSUxsOwRWxCywm1Fi+elTQKM4
	OISBxq59mQZSwyKgKnFm9lxmkDCvgKvEx7YkiGUKElMevmcGsTmBwm8Oz2EFsYUEXCS27trB
	OoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkCDj28HYvl7mEKMA
	B6MSD6/G5YOBQqyJZcWVuYcYJTmYlER5N+09FCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd1
	DlCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB+wFkqGBRanpqRVpm
	TglCmomDE0RwgWzgAdpgvA9kQ3FBYm5xZjpE0SlGRSlxXgmQhABIIqM0D24ALB28YhQH+keY
	VxqkigeYSuC6XwENZgIavGc12OCSRISUVAOjqGPXVOWIM73+8ayNVgfnPToQnbH13G7+tca5
	DvP+HcxIvnxs/uXNTJf3pNtEGf7+/TJr+5pwwynP3X5z17yLqzR8VxgjUMASPunC/HXPV097
	vsZevuPeznOiS82Tk94/dOSs8j//s+HvhBWCrv9/sZRffCbIeOIgV46dlphBd6Pq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228458>

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
