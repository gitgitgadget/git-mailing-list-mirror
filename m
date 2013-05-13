From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 2/2] add a stat_validity struct
Date: Mon, 13 May 2013 05:00:07 +0200
Message-ID: <1368414007-3819-3-git-send-email-mhagger@alum.mit.edu>
References: <5190500E.8060907@alum.mit.edu>
 <1368414007-3819-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 05:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubj0B-0007oc-So
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 05:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3EMDAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 23:00:33 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:52669 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672Ab3EMDAb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 23:00:31 -0400
X-AuditID: 12074413-b7f226d000000902-c9-5190574ec2d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 22.EF.02306.E4750915; Sun, 12 May 2013 23:00:31 -0400 (EDT)
Received: from michael.fritz.box (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4D30EGw015002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 23:00:29 -0400
X-Mailer: git-send-email 1.8.2.2
In-Reply-To: <1368414007-3819-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqOsfPiHQYPlOJouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xqb2fpeCJRMXjs8UNjL+Fuxg5OSQETCSuTLzLAmGLSVy4t56ti5GLQ0jgMqPE7CWn
	GSGcc0wSl4+2g1WxCehKLOppZgKxRQRkJb4f3ghWxCwwk1Hi+99v7CAJYaCiHdeWs4HYLAKq
	EhP7drGC2LwCzhL7Nt4EinMArVOQeHaWDyTMKeAisWjKYrCZQgKpEp+mv2adwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZISAnvYNx1Uu4QowAHoxIP7wLlCYFC
	rIllxZW5hxglOZiURHnPhwCF+JLyUyozEosz4otKc1KLDzFKcDArifDudQPK8aYkVlalFuXD
	pKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeIXCgBoFi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQZERXwyMDZAUD9Deh6Ege4sLEnOBohCtpxh1OWZtffKaUYglLz8vVUqc
	9zlIkQBIUUZpHtwKWAJ5xSgO9LEw7wuQKh5g8oGb9ApoCRPQkjMe/SBLShIRUlINjNm7HvBt
	ZbApEhM5O3H+tBkXHhbHWLFemBnaHPBjZvX3o+3Tmj+xVM8Q3/w8bmFu/PrDMxrOWv4pMY29
	KGPD9ctGWNpkk+/kgnPPlF8kp0cyb2+ezip142D1jjthF/IOzK9+rpbadWQ/z8/1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224080>

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
This is essentially the same as Peff's patch

    "[PATCH 2/4] add a stat_validity struct"

except that it uses the "struct stat_data" from the previous commit
rather than grabbing the fields directly out of cache_entry.

 cache.h      | 27 +++++++++++++++++++++++++++
 read-cache.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/cache.h b/cache.h
index 55b4b14..71385dc 100644
--- a/cache.h
+++ b/cache.h
@@ -1345,4 +1345,31 @@ int checkout_fast_forward(const unsigned char *from,
 
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
index 9c1e089..9dd157f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1958,3 +1958,33 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
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
1.8.2.2
