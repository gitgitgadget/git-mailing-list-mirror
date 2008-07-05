From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH 3/5] convert.c: Use 'git_config_string' to get 'smudge' and 'clean'
Date: Sat,  5 Jul 2008 01:24:42 -0400
Message-ID: <81a6961a970f77cc8166c1ae59cae6326bc5c143.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
 <fd5cae53021281c920ba48efef82dc8a8d3c7fe1.1215234749.git.whee@smaertness.net>
 <f1c8159441e6afc5021e5f087f6feaf5b53e61df.1215234749.git.whee@smaertness.net>
Cc: gitster@pobox.com, Brian Hetro <whee@smaertness.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 07:26:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF0Hd-0003MG-7W
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 07:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYGEFZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 01:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbYGEFY7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 01:24:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:57203 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbYGEFY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 01:24:58 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1046215wri.5
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 22:24:57 -0700 (PDT)
Received: by 10.90.74.7 with SMTP id w7mr2163127aga.26.1215235497250;
        Fri, 04 Jul 2008 22:24:57 -0700 (PDT)
Received: from localhost.localdomain ( [74.69.33.95])
        by mx.google.com with ESMTPS id 34sm1794628yxm.0.2008.07.04.22.24.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 22:24:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
In-Reply-To: <f1c8159441e6afc5021e5f087f6feaf5b53e61df.1215234749.git.whee@smaertness.net>
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87431>

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 convert.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/convert.c b/convert.c
index 1c66844..352b69d 100644
--- a/convert.c
+++ b/convert.c
@@ -319,8 +319,8 @@ static int apply_filter(const char *path, const char *src, size_t len,
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
-	char *smudge;
-	char *clean;
+	const char *smudge;
+	const char *clean;
 } *user_convert, **user_convert_tail;
 
 static int read_convert_config(const char *var, const char *value, void *cb)
@@ -358,19 +358,12 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	 * The command-line will not be interpolated in any way.
 	 */
 
-	if (!strcmp("smudge", ep)) {
-		if (!value)
-			return config_error_nonbool(var);
-		drv->smudge = strdup(value);
-		return 0;
-	}
+	if (!strcmp("smudge", ep))
+		return git_config_string(&drv->smudge, var, value);
+
+	if (!strcmp("clean", ep))
+		return git_config_string(&drv->clean, var, value);
 
-	if (!strcmp("clean", ep)) {
-		if (!value)
-			return config_error_nonbool(var);
-		drv->clean = strdup(value);
-		return 0;
-	}
 	return 0;
 }
 
@@ -576,7 +569,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
 	int ident = 0, ret = 0;
-	char *filter = NULL;
+	const char *filter = NULL;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
@@ -606,7 +599,7 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
 	int ident = 0, ret = 0;
-	char *filter = NULL;
+	const char *filter = NULL;
 
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
-- 
1.5.6.1.204.g699135
