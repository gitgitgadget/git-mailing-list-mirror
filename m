From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] entry.c: fix possible buffer overflow in remove_subtree()
Date: Thu, 13 Mar 2014 10:19:08 +0100
Message-ID: <1394702348-6433-3-git-send-email-mhagger@alum.mit.edu>
References: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 10:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO1nZ-00028v-1R
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 10:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbaCMJTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 05:19:23 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42497 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753491AbaCMJTS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 05:19:18 -0400
X-AuditID: 1207440e-f79c76d000003e2c-f9-53217815d3ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BA.57.15916.51871235; Thu, 13 Mar 2014 05:19:17 -0400 (EDT)
Received: from michael.fritz.box (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2D9JA4S018940
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 05:19:16 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqCtaoRhssHunjkXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zA6vH3/cfmDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGfc+LiftWCTcMWl/pksDYzH+LsYOTkkBEwkjpzpYISwxSQu3FvP1sXIxSEkcJlR4uSb
	FUwgCSGB40wS2w8ZgNhsAroSi3qaweIiAmoSE9sOsYA0MAvsY5TYfnAd2CRhAT+JdbN2AxVx
	cLAIqEocPBcJEuYVcJZo/HmJGWKZnMSU3wvYQUo4BVwkzmyTgFjlLLFgyT62CYy8CxgZVjHK
	JeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEBBTfDsb29TKHGAU4GJV4eFcsVwgW
	Yk0sK67MPcQoycGkJMqrU64YLMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE17wAKMebklhZlVqU
	D5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuDNLgVqFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAfFRXwxMDJAUjxAe7lBbuItLkjMBYpCtJ5iVJQS51UpA0oIgCQySvPg
	xsLSxCtGcaAvhXnFQNp5gCkGrvsV0GAmoME/AuRBBpckIqSkGhg7mXhWVt2slb6y4xHr09Km
	3F1nmbczTK2W5bX6ceDHL57jZu1Jb/9IZGpeYIyd8rX6+cvJvxXUL7+x8oiSYXhpW5RUKyzt
	d97WIqXpUOjTI7JvlX2WTtxRbBQednGh+BRzF/Pda45P2/zxYXNTSmhZtnEAV4K2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244024>

remove_subtree() manipulated path in a fixed-size buffer even though
the length of the input, let alone the length of entries within the
directory, were not known in advance.  Change the function to take a
strbuf argument and use that object as its scratch space.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
In

    fd356f6aa8 entry.c: convert checkout_entry to use strbuf

from last October, checkout_entry() was changed to use strbuf, but
this callee must have been overlooked.

 entry.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/entry.c b/entry.c
index 9adddb6..77c6882 100644
--- a/entry.c
+++ b/entry.c
@@ -44,33 +44,33 @@ static void create_directories(const char *path, int path_len,
 	free(buf);
 }
 
-static void remove_subtree(const char *path)
+static void remove_subtree(struct strbuf *path)
 {
-	DIR *dir = opendir(path);
+	DIR *dir = opendir(path->buf);
 	struct dirent *de;
-	char pathbuf[PATH_MAX];
-	char *name;
+	int origlen = path->len;
 
 	if (!dir)
-		die_errno("cannot opendir '%s'", path);
-	strcpy(pathbuf, path);
-	name = pathbuf + strlen(path);
-	*name++ = '/';
+		die_errno("cannot opendir '%s'", path->buf);
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
+
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
-		strcpy(name, de->d_name);
-		if (lstat(pathbuf, &st))
-			die_errno("cannot lstat '%s'", pathbuf);
+
+		strbuf_addch(path, '/');
+		strbuf_addstr(path, de->d_name);
+		if (lstat(path->buf, &st))
+			die_errno("cannot lstat '%s'", path->buf);
 		if (S_ISDIR(st.st_mode))
-			remove_subtree(pathbuf);
-		else if (unlink(pathbuf))
-			die_errno("cannot unlink '%s'", pathbuf);
+			remove_subtree(path);
+		else if (unlink(path->buf))
+			die_errno("cannot unlink '%s'", path->buf);
+		strbuf_setlen(path, origlen);
 	}
 	closedir(dir);
-	if (rmdir(path))
-		die_errno("cannot rmdir '%s'", path);
+	if (rmdir(path->buf))
+		die_errno("cannot rmdir '%s'", path->buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
@@ -279,7 +279,7 @@ int checkout_entry(struct cache_entry *ce,
 				return 0;
 			if (!state->force)
 				return error("%s is a directory", path.buf);
-			remove_subtree(path.buf);
+			remove_subtree(&path);
 		} else if (unlink(path.buf))
 			return error("unable to unlink old '%s' (%s)",
 				     path.buf, strerror(errno));
-- 
1.9.0
