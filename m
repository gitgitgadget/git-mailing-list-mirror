From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] path.c: Use vsnpath() in the implementation of git_path()
Date: Tue, 04 Sep 2012 18:29:22 +0100
Message-ID: <50463A72.2000209@ramsay1.demon.co.uk>
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
	id 1T8ySx-0001Zt-R7
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2IDTHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:07 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40929 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932617Ab2IDTHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:04 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 04C0D128076;
	Tue,  4 Sep 2012 20:07:04 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 53F72128075;	Tue,  4 Sep 2012 20:07:03 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:02 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204769>


The current implementation of git_path() is essentially the same as
that of vsnpath(), with two minor differences. First, git_path()
currently insists that the git directory path is no longer than
PATH_MAX-100 characters in length. However, vsnpath() does not
attempt this arbitrary 100 character reservation for the remaining
path components. Second, vsnpath() uses the "is_dir_sep()" macro,
rather than comparing directly to '/', to determine if the git_dir
path component ends with a path separator.

In order to benefit from the above improvements, along with increased
compatability with git_snpath() and git_pathdup(), we reimplement the
git_path() function using vsnpath().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 path.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/path.c b/path.c
index 741ae77..cbbdf7d 100644
--- a/path.c
+++ b/path.c
@@ -119,23 +119,14 @@ char *mkpath(const char *fmt, ...)
 
 char *git_path(const char *fmt, ...)
 {
-	const char *git_dir = get_git_dir();
 	char *pathname = get_pathname();
 	va_list args;
-	unsigned len;
+	char *ret;
 
-	len = strlen(git_dir);
-	if (len > PATH_MAX-100)
-		return bad_path;
-	memcpy(pathname, git_dir, len);
-	if (len && git_dir[len-1] != '/')
-		pathname[len++] = '/';
 	va_start(args, fmt);
-	len += vsnprintf(pathname + len, PATH_MAX - len, fmt, args);
+	ret = vsnpath(pathname, PATH_MAX, fmt, args);
 	va_end(args);
-	if (len >= PATH_MAX)
-		return bad_path;
-	return cleanup_path(pathname);
+	return ret;
 }
 
 void home_config_paths(char **global, char **xdg, char *file)
-- 
1.7.12
