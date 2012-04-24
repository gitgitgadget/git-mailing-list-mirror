From: mhagger@alum.mit.edu
Subject: [PATCH 07/30] do_for_each_reflog(): return early on error
Date: Wed, 25 Apr 2012 00:45:13 +0200
Message-ID: <1335307536-26914-8-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoh0-00010Q-M6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534Ab2DXW6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:58:06 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60967 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758448Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 19C5D248148;
	Wed, 25 Apr 2012 00:46:00 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196285>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   70 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 8670c2e..1d25151 100644
--- a/refs.c
+++ b/refs.c
@@ -2246,47 +2246,47 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 {
 	DIR *d = opendir(git_path("logs/%s", base));
 	int retval = 0;
+	struct dirent *de;
+	int baselen;
+	char *log;
 
-	if (d) {
-		struct dirent *de;
-		int baselen = strlen(base);
-		char *log = xmalloc(baselen + 257);
+	if (!d)
+		return *base ? errno : 0;
 
-		memcpy(log, base, baselen);
-		if (baselen && base[baselen-1] != '/')
-			log[baselen++] = '/';
+	baselen = strlen(base);
+	log = xmalloc(baselen + 257);
+	memcpy(log, base, baselen);
+	if (baselen && base[baselen-1] != '/')
+		log[baselen++] = '/';
 
-		while ((de = readdir(d)) != NULL) {
-			struct stat st;
-			int namelen;
+	while ((de = readdir(d)) != NULL) {
+		struct stat st;
+		int namelen;
 
-			if (de->d_name[0] == '.')
-				continue;
-			namelen = strlen(de->d_name);
-			if (namelen > 255)
-				continue;
-			if (has_extension(de->d_name, ".lock"))
-				continue;
-			memcpy(log + baselen, de->d_name, namelen+1);
-			if (stat(git_path("logs/%s", log), &st) < 0)
-				continue;
-			if (S_ISDIR(st.st_mode)) {
-				retval = do_for_each_reflog(log, fn, cb_data);
-			} else {
-				unsigned char sha1[20];
-				if (read_ref_full(log, sha1, 0, NULL))
-					retval = error("bad ref for %s", log);
-				else
-					retval = fn(log, sha1, 0, cb_data);
-			}
-			if (retval)
-				break;
+		if (de->d_name[0] == '.')
+			continue;
+		namelen = strlen(de->d_name);
+		if (namelen > 255)
+			continue;
+		if (has_extension(de->d_name, ".lock"))
+			continue;
+		memcpy(log + baselen, de->d_name, namelen+1);
+		if (stat(git_path("logs/%s", log), &st) < 0)
+			continue;
+		if (S_ISDIR(st.st_mode)) {
+			retval = do_for_each_reflog(log, fn, cb_data);
+		} else {
+			unsigned char sha1[20];
+			if (read_ref_full(log, sha1, 0, NULL))
+				retval = error("bad ref for %s", log);
+			else
+				retval = fn(log, sha1, 0, cb_data);
 		}
-		free(log);
-		closedir(d);
+		if (retval)
+			break;
 	}
-	else if (*base)
-		return errno;
+	free(log);
+	closedir(d);
 	return retval;
 }
 
-- 
1.7.10
