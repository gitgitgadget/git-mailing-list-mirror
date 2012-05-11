From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] dir: respect string length argument of read_directory_recursive()
Date: Fri, 11 May 2012 16:53:07 +0200
Message-ID: <4FAD27D3.7070208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 16:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSrDl-0003XJ-5q
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 16:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759901Ab2EKOxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 10:53:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:60078 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab2EKOxX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 10:53:23 -0400
Received: from [192.168.2.105] (p579BEA13.dip.t-dialin.net [87.155.234.19])
	by india601.server4you.de (Postfix) with ESMTPSA id E797B2F803C;
	Fri, 11 May 2012 16:53:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197676>

A directory name is passed to read_directory_recursive() as a
length-limited string, through the parameters base and baselen.
Suprisingly, base must be a NUL-terminated string as well, as it is
passed to opendir(), ignoring baselen.

Fix this by postponing the call to opendir() until the length-limted
string is added to a strbuf, which provides a NUL in the right place.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 dir.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index c6a98cc..d5444fb 100644
--- a/dir.c
+++ b/dir.c
@@ -960,16 +960,17 @@ static int read_directory_recursive(struct dir_struct *dir,
 				    int check_only,
 				    const struct path_simplify *simplify)
 {
-	DIR *fdir = opendir(*base ? base : ".");
+	DIR *fdir;
 	int contents = 0;
 	struct dirent *de;
 	struct strbuf path = STRBUF_INIT;
 
-	if (!fdir)
-		return 0;
-
 	strbuf_add(&path, base, baselen);
 
+	fdir = opendir(path.len ? path.buf : ".");
+	if (!fdir)
+		goto out;
+
 	while ((de = readdir(fdir)) != NULL) {
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
@@ -984,12 +985,11 @@ static int read_directory_recursive(struct dir_struct *dir,
 		}
 		contents++;
 		if (check_only)
-			goto exit_early;
-		else
-			dir_add_name(dir, path.buf, path.len);
+			break;
+		dir_add_name(dir, path.buf, path.len);
 	}
-exit_early:
 	closedir(fdir);
+ out:
 	strbuf_release(&path);
 
 	return contents;
-- 
1.7.10.1
