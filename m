From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fix crash in path.c on Windows
Date: Thu, 05 Feb 2009 00:00:46 +0100
Message-ID: <498A1E1E.8010901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUql6-00070w-58
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZBDXAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZBDXAt
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:00:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:38222 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZBDXAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:00:49 -0500
Received: from [10.0.1.101] (p57B7F3CC.dip.t-dialin.net [87.183.243.204])
	by india601.server4you.de (Postfix) with ESMTPSA id A28DD2F8056;
	Thu,  5 Feb 2009 00:00:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use PATH_SEP and is_absolute_path() instead of using Unix conventions
to enhance portability.  On Windows, the assert() fails almost always
without this change.

Also convert all backslashes in DOS-style paths to slashes, as that's
what git uses internally.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
The patch doesn't fix t1504 on Windows, but it allows one to at least
run this test without git crashing multiple times due to the failed
assertion.  The test case "first_of_two" still fails, due to the
weird translation applied to environment variables like
$GIT_CEILING_DIRECTORIES.  Is there a method to it?  Here some
experiments:

	set a=	getenv("a")
	======= ===========
	c	c
	/c	c:/
	c/	c/
	/c/	c:/
	c:c	c:c
	/c:c	c:c
	c:/c	c:/c
	/c:/c	c:/c
	c/:/c	c\;c:\
	/c:c/	c:c/
	/c/:c	/c/:c
	/c/:/c	c:\;c:\
	/c:/c/	c:/c/
	/c/:/c/	c:\;c:\

The test case can be convinced to pass by replacing "bar" with
"/bar", but I'm not sure that's the right fix.  Shouldn't we warn on
invalid paths in $GIT_CEILING_DIRECTORIES?

 path.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index a074aea..4cae7f6 100644
--- a/path.c
+++ b/path.c
@@ -387,7 +387,7 @@ int normalize_absolute_path(char *buf, const char *path)
 	assert(path);
 
 	while (*comp_start) {
-		assert(*comp_start == '/');
+		assert(is_absolute_path(comp_start));
 		while (*++comp_end && *comp_end != '/')
 			; /* nothing */
 		comp_len = comp_end - comp_start;
@@ -438,11 +438,20 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		return -1;
 
 	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
-		for (colon = ceil; *colon && *colon != ':'; colon++);
+		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
 		len = colon - ceil;
 		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
 			continue;
 		strlcpy(buf, ceil, len+1);
+
+		if (has_dos_drive_prefix(buf)) {
+			char *p;
+			for (p = buf; *p; p++) {
+				if (*p == '\\')
+					*p = '/';
+			}
+		}
+
 		len = normalize_absolute_path(buf, buf);
 		/* Strip "trailing slashes" from "/". */
 		if (len == 1)
-- 
1.6.1.2
