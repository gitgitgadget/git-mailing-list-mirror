From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 1/4] enter_repo: do not modify input
Date: Tue, 04 Oct 2011 19:06:27 -0400
Message-ID: <4E8B9173.4070000@cisco.com>
References: <4E8B8DEA.1000606@cisco.com> <CABURp0qEQdjLsUxQkf3jSAHU80NOZEqm9iEksZKST_JfK590Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 01:06:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBE4H-0004mh-HT
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 01:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933713Ab1JDXG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 19:06:29 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:48567 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158Ab1JDXG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 19:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3338; q=dns/txt;
  s=iport; t=1317769588; x=1318979188;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=GR8WqYd+z9/mQN36aStOtRni2Hs7OtapEvLYNqivtRk=;
  b=YTDhiG4LyYNLFCY66+i/ix3Gu8HqpxU6RKooR6q2ESAHRPRbkqlsDNSw
   TNPmMsQh+RhZ6iAY3kBKnbMKOdvjFUpep/1RgxeDeztOZQiy1C4lbUSpy
   i4lVvIU5kZWB3casSkSejMbECBl7fccj/2TMvbCDChRYnZ640QTm86jc8
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EADaRi06tJXHA/2dsb2JhbABCqAuBBYFTAQEBAQMSAWUBEAsVDBYPCQMCAQIBDzYGDQEFAgEBHqE/AZ1rhyMEk2aFJ4M2gUOHPg
X-IronPort-AV: E=Sophos;i="4.68,487,1312156800"; 
   d="scan'208";a="26077692"
Received: from rcdn-core2-5.cisco.com ([173.37.113.192])
  by rcdn-iport-8.cisco.com with ESMTP; 04 Oct 2011 23:06:28 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core2-5.cisco.com (8.14.3/8.14.3) with ESMTP id p94N6RkX000974;
	Tue, 4 Oct 2011 23:06:27 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <CABURp0qEQdjLsUxQkf3jSAHU80NOZEqm9iEksZKST_JfK590Qw@mail.gmail.com>
X-Enigmail-Version: 1.2.1
X-TagToolbar-Keys: D20111004190627074
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182814>

From: Erik Faye-Lund <kusmabite@gmail.com>

entr_repo(..., 0) currently modifies the input to strip away
trailing slashes. This means that we some times need to copy the
input to keep the original.

Change it to unconditionally copy it into the used_path buffer so
we can safely use the input without having to copy it. Also store
a working copy in validated_path up-front before we start
resolving anything.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/cache.h b/cache.h
index 9994a3c..7eeb8cf 100644
--- a/cache.h
+++ b/cache.h
@@ -734,7 +734,7 @@ int safe_create_leading_directories(char *path);
 int safe_create_leading_directories_const(const char *path);
 int mkdir_in_gitdir(const char *path);
 extern char *expand_user_path(const char *path);
-char *enter_repo(char *path, int strict);
+const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
diff --git a/daemon.c b/daemon.c
index 4c8346d..9253192 100644
--- a/daemon.c
+++ b/daemon.c
@@ -108,11 +108,11 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static char *path_ok(char *directory)
+static const char *path_ok(char *directory)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
-	char *path;
+	const char *path;
 	char *dir;
 
 	dir = directory;
diff --git a/path.c b/path.c
index 6f3f5d5..f3d96aa 100644
--- a/path.c
+++ b/path.c
@@ -283,7 +283,7 @@ return_null:
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-char *enter_repo(char *path, int strict)
+const char *enter_repo(const char *path, int strict)
 {
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
@@ -297,14 +297,17 @@ char *enter_repo(char *path, int strict)
 		};
 		int len = strlen(path);
 		int i;
-		while ((1 < len) && (path[len-1] == '/')) {
-			path[len-1] = 0;
+		while ((1 < len) && (path[len-1] == '/'))
 			len--;
-		}
+
 		if (PATH_MAX <= len)
 			return NULL;
-		if (path[0] == '~') {
-			char *newpath = expand_user_path(path);
+		strncpy(used_path, path, len);
+		used_path[len] = 0;
+		strcpy(validated_path, used_path);
+
+		if (used_path[0] == '~') {
+			char *newpath = expand_user_path(used_path);
 			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
 				free(newpath);
 				return NULL;
@@ -316,24 +319,18 @@ char *enter_repo(char *path, int strict)
 			 * anyway.
 			 */
 			strcpy(used_path, newpath); free(newpath);
-			strcpy(validated_path, path);
-			path = used_path;
 		}
 		else if (PATH_MAX - 10 < len)
 			return NULL;
-		else {
-			path = strcpy(used_path, path);
-			strcpy(validated_path, path);
-		}
-		len = strlen(path);
+		len = strlen(used_path);
 		for (i = 0; suffix[i]; i++) {
-			strcpy(path + len, suffix[i]);
-			if (!access(path, F_OK)) {
+			strcpy(used_path + len, suffix[i]);
+			if (!access(used_path, F_OK)) {
 				strcat(validated_path, suffix[i]);
 				break;
 			}
 		}
-		if (!suffix[i] || chdir(path))
+		if (!suffix[i] || chdir(used_path))
 			return NULL;
 		path = validated_path;
 	}
-- 
1.7.7.503.g26392.dirty
