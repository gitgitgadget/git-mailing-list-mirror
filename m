From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] rename_ref(): fix a mkdir()/rmdir() race
Date: Sun, 22 Dec 2013 08:14:11 +0100
Message-ID: <1387696451-32224-6-git-send-email-mhagger@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:15:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudFn-0006ZN-47
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab3LVHPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:15:05 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50298 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147Ab3LVHOn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:14:43 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-bf-52b691625add
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BE.C6.18966.26196B25; Sun, 22 Dec 2013 02:14:42 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFP023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:41 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqJs0cVuQwZaFOhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3xcuYK1oI2gYqVE+saGM/x
	dDFyckgImEic+bGODcIWk7hwbz2QzcUhJHCZUWL73UnMIAkhgRNMEl8XpIPYbAK6Eot6mplA
	bBEBNYmJbYdYQGxmAQeJzZ8bGUFsYQFbia7eyUA2BweLgKrElqmpIGFeAReJp9P7WCB2KUjs
	u3QSbAyngKvE1C8bWSFWuUjsePWIaQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6
	uZkleqkppZsYIWHCu4Px/zqZQ4wCHIxKPLwZYtuChFgTy4orcw8xSnIwKYnyck8ACvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhXeMKlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgt
	gsnKcHAoSfB6gwwVLEpNT61Iy8wpQUgzcXCCCC6QDTxAG1JBCnmLCxJzizPTIYpOMSpKifNG
	gSQEQBIZpXlwA2AR/YpRHOgfYd4MkCoeYDKA634FNJgJaLDx2k0gg0sSEVJSDYz6XgutUlWX
	VLG79fZxXGsJv13z+kdLsvd1adlFtWd5/6/P6ZF1k/92qyXy2tYZW3huJ9Z/ifm3Trv7iqrA
	WctTdzqb/1rqG+Vsv3qU1eqkwGWNL6wZs92Omb/0uD/l7Ze+v62t2a/0uVOPvip/yPtUWP1p
	hFTmhRnzfrlErFNYGKhjOH2vVIkSS3FGoqEWc1FxIgDhviR3wwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239636>

When renaming a reflog file, it was possible that an empty directory
that we just created using safe_create_leading_directories() might get
deleted by another process before we have a chance to move the new
file into it.

So if the rename fails with ENOENT, then retry from the beginning.
Make up to three attempts before giving up.

It could theoretically happen that the ENOENT comes from the
disappearance of TMP_RENAMED_LOG.  In that case three pointless
attempts will be made to move the nonexistent file, but no other harm
should come of it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3926136..3ab1491 100644
--- a/refs.c
+++ b/refs.c
@@ -2516,6 +2516,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	int attempts = 3;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2555,12 +2556,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		}
 	}
 
+ retry:
 	if (log && safe_create_leading_directories(git_path("logs/%s", newrefname))) {
 		error("unable to create directory for %s", newrefname);
 		goto rollback;
 	}
 
- retry:
 	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
 		if (errno==EISDIR || errno==ENOTDIR) {
 			/*
@@ -2574,6 +2575,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 			}
 			goto retry;
 		} else {
+			if (errno == ENOENT && --attempts)
+				/*
+				 * Perhaps somebody just pruned the empty
+				 * directory into which we wanted to move the
+				 * file.
+				 */
+				goto retry;
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
 				newrefname, strerror(errno));
 			goto rollback;
-- 
1.8.5.1
