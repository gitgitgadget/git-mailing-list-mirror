From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/12] add a stat_validity struct
Date: Tue, 11 Jun 2013 23:48:29 +0200
Message-ID: <1370987312-6761-10-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRO-0003wo-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab3FKVtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:10 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49632 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756536Ab3FKVtG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:06 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-44-51b79b52e5b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.68.17335.25B97B15; Tue, 11 Jun 2013 17:49:06 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbix015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:05 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqBs0e3ugwfnJShZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtjxUWlgitSFeuerWRrYDwm2sXIySEhYCJxu20jE4QtJnHh3nq2LkYuDiGBy4wS6x42
	M4IkhAQuMEns3gpmswnoSizqaQZrEBFQk5jYdogFpIFZoJ1R4l3zPmaQhLCAocTLYxdYQWwW
	AVWJLee6WEBsXgEXiVOLj0Ntk5N4f2cXWJwTKL5x82ZmiGXOEt97mhgnMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRESUnw7GNvXyxxiFOBgVOLhPWC2PVCINbGs
	uDL3EKMkB5OSKC/bNKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7dXKAcb0piZVVqUT5MSpqD
	RUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC98osoEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UGTEFwNjAyTFA7T3EEg7b3FBYi5QFKL1FKMux+bzk98xCrHk5eelSonzngYp
	EgApyijNg1sBSyCvGMWBPhbm3Q9SxQNMPnCTXgEtYQJaUpQBtqQkESEl1cA4TbjZOjT9XM0d
	4fW/4hvk5v7/knXY+UXncuHJ7+48+N/QYZw2d8m+LYansjy/3M2/seR/yo6zB1WSrIucNMRK
	g6y1vudxbr4umHNj4ZU7aur65ZEP/v61nfrjqoxYoOjDJvWFCdM+6riFP/p9c8tX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227525>

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
This is *very* similar to a patch by Jeff King <peff@peff.net> [1],
except that it is based on the struct stat_data that I extracted from
cache_entry rather than using cache_entries directly.  I would have
left Peff the author except that I don't want to risk putting him on
the hook for any mistakes that I might have made.  But if it is
appropriate, don't hesitate to make him author again.

[1] http://article.gmane.org/gmane.comp.version-control.git/223526

 cache.h      | 27 +++++++++++++++++++++++++++
 read-cache.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/cache.h b/cache.h
index 207f849..15f5110 100644
--- a/cache.h
+++ b/cache.h
@@ -1358,4 +1358,31 @@ int checkout_fast_forward(const unsigned char *from,
 
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
index 4c4328e..73e85a4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1948,3 +1948,33 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
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
1.8.3
