From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/5] path.c: Don't discard the return value of vsnpath()
Date: Tue, 04 Sep 2012 18:27:54 +0100
Message-ID: <50463A1A.9000801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ySx-0001Zt-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624Ab2IDTHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:04 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40920 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932540Ab2IDTHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:02 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 6E317128078;
	Tue,  4 Sep 2012 20:07:01 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id CF1F1128075;	Tue,  4 Sep 2012 20:07:00 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:00 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204770>


The git_snpath() and git_pathdup() functions both use the (static)
function vsnpath() in their implementation. Also, they both discard
the return value of vsnpath(), which has the effect of ignoring the
side effect of calling cleanup_path() in the non-error return path.

In order to ensure that the required cleanup happens, we use the
pointer returned by vsnpath(), rather than the buffer passed into
vsnpath(), to derive the return value from git_snpath() and
git_pathdup().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 path.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 9eb5333..741ae77 100644
--- a/path.c
+++ b/path.c
@@ -70,21 +70,22 @@ bad:
 
 char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 {
+	char *ret;
 	va_list args;
 	va_start(args, fmt);
-	(void)vsnpath(buf, n, fmt, args);
+	ret = vsnpath(buf, n, fmt, args);
 	va_end(args);
-	return buf;
+	return ret;
 }
 
 char *git_pathdup(const char *fmt, ...)
 {
-	char path[PATH_MAX];
+	char path[PATH_MAX], *ret;
 	va_list args;
 	va_start(args, fmt);
-	(void)vsnpath(path, sizeof(path), fmt, args);
+	ret = vsnpath(path, sizeof(path), fmt, args);
 	va_end(args);
-	return xstrdup(path);
+	return xstrdup(ret);
 }
 
 char *mkpathdup(const char *fmt, ...)
-- 
1.7.12
