From: Namhyung Kim <namhyung.kim@lge.com>
Subject: [PATCH] name-rev: Allow to omit refs/tags/ part in --refs option when --tags used
Date: Mon, 17 Jun 2013 16:53:56 +0900
Message-ID: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 09:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoUGJ-00081s-54
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 09:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab3FQHx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 03:53:58 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:43640 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab3FQHx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 03:53:58 -0400
X-AuditID: 9c930197-b7beaae000004876-69-51bec094df1c
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id 3E.C1.18550.490CEB15; Mon, 17 Jun 2013 16:53:56 +0900 (KST)
X-Mailer: git-send-email 1.7.11.7
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228049>

In its current form, when an user wants to filter specific ref using
--refs option, she needs to give something like --refs=refs/tags/v1.*.

This is not intuitive as users might think it's enough to give just
actual tag name part like --refs=v1.*.  It applies to refs other than
just tags too.  Change it for users to be able to use --refs=sth or
--refs=remotes/sth.

Also remove the leading 'tags/' part in the output when --tags option
was given since the option restricts to work with tags only.  This is
what we have if --name-only option was given also.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 builtin/name-rev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6238247..446743b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -97,7 +97,8 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
 		return 0;
 
-	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
+	if (data->ref_filter && !prefixcmp(data->ref_filter, "refs/")
+	    && fnmatch(data->ref_filter, path, 0))
 		return 0;
 
 	while (o && o->type == OBJ_TAG) {
@@ -113,12 +114,15 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		if (!prefixcmp(path, "refs/heads/"))
 			path = path + 11;
 		else if (data->tags_only
-		    && data->name_only
 		    && !prefixcmp(path, "refs/tags/"))
 			path = path + 10;
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
+		if (data->ref_filter && prefixcmp(data->ref_filter, "refs/")
+		    && fnmatch(data->ref_filter, path, 0))
+			return 0;
+
 		name_rev(commit, xstrdup(path), 0, 0, deref);
 	}
 	return 0;
-- 
1.7.11.7
