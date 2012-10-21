From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/8] normalize_ceiling_entry(): resolve symlinks
Date: Sun, 21 Oct 2012 07:57:36 +0200
Message-ID: <1350799057-13846-8-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYq-0006i8-2A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab2JUF6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:40 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:45961 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766Ab2JUF6h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:37 -0400
X-AuditID: 12074413-b7f786d0000008bb-1a-50838f0cd253
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 60.B1.02235.C0F83805; Sun, 21 Oct 2012 01:58:36 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wu013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:35 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqMvT3xxgsOumpcWRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYWt1fMZ7ZY/+4qswO7x9/3H5g83rT3MnrsnHWX3ePhqy52j4uXlD0+
	b5ILYIvitklKLCkLzkzP07dL4M64d6aTrWCmQMXDiTeZGxjn83YxcnJICJhIPHrdzwphi0lc
	uLeerYuRi0NI4DKjxMm/+9khnDNMEoc+32MEqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCxwh1Fi
	4ZU3zCAJYQFniftXO9hBbBYBVYl73Q+Bijg4eAVcJB6crIbYpijx4/sasHJOAVeJK8vmsIHY
	QkAlOze+Z5zAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkjACe9g
	3HVS7hCjAAejEg8vs3VzgBBrYllxZe4hRkkOJiVR3he9QCG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivLsFgXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneZX1AjYJF
	qempFWmZOSUIaSYOThDBBbKBB2hDI0ghb3FBYm5xZjpE0SlGRSlx3iaQhABIIqM0D24ALDW8
	YhQH+keYtxOkigeYVuC6XwENZgIabM7dCDK4JBEhJdXAaHTr99/gh27T+RcUWlrsXuaW9vf6
	yoV7T/RyKx0WbPbx2vSndl3ItIbgDma/FyUMU3tYr975eYJp8rxZi0VTpl1c9PS09lamvi/J
	S1s2XfJzeNX5M+mz9sF+QWv5e1cZnyU7JAdkchvvCBHwfJjmGad5rav2mQz/S77l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208109>

longest_ancestor_length() relies on a textual comparison of directory
parts to find the part of path that overlaps with one of the paths in
prefix_list.  But this doesn't work if any of the prefixes involves a
symbolic link, because the directories will look different even though
they might logically refer to the same directory.  So canonicalize the
paths listed in GIT_CEILING_DIRECTORIES using real_path_if_valid()
before passing them to longest_ancestor_length().

path is already in canonical form, so doesn't need to be canonicalized
again.

This fixes some problems with using GIT_CEILING_DIRECTORIES that
contains paths involving symlinks, including t4035 if run with --root
set to a path involving symlinks.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 setup.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index df97ad3..2eb5b75 100644
--- a/setup.c
+++ b/setup.c
@@ -622,24 +622,22 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 }
 
 /*
- * A "string_list_each_func_t" function that normalizes an entry from
- * GIT_CEILING_DIRECTORIES or discards it if unusable.
+ * A "string_list_each_func_t" function that canonicalizes an entry
+ * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
+ * discards it if unusable.
  */
 static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
 {
-	const char *ceil = item->string;
-	int len = strlen(ceil);
-	char buf[PATH_MAX+1];
+	char *ceil = item->string;
+	const char *real_path;
 
-	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+	if (!*ceil || !is_absolute_path(ceil))
 		return 0;
-	if (normalize_path_copy(buf, ceil) < 0)
+	real_path = real_path_if_valid(ceil);
+	if (!real_path)
 		return 0;
-	len = strlen(buf);
-	if (len > 1 && buf[len-1] == '/')
-		buf[--len] = '\0';
 	free(item->string);
-	item->string = xstrdup(buf);
+	item->string = xstrdup(real_path);
 	return 1;
 }
 
-- 
1.7.11.3
