From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] config: define and document exit codes
Date: Tue, 17 May 2011 17:38:52 +0200
Message-ID: <6301052eb455e9088e50f78760e6ca1b9499564a.1305646709.git.git@drmicha.warpmail.net>
References: <20110517140725.GA17193@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 17:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMMR-00068z-EB
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1EQPi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:38:58 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60237 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755047Ab1EQPi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 11:38:57 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D6F3720AFC;
	Tue, 17 May 2011 11:38:56 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 17 May 2011 11:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=jpVJ/wxOyly28hTBcp254vZxCeM=; b=MVL37bowMm7UvTj7/y28aqn51nRI/0m+zo1Yz4ljeIC3VXhhnnW4e8yVWM9sGR1Jo5f6aeIoB55a0s0w42pL2HWV0ugpsLg/c2eO0GGZv/ngXFteqtA9FCOoQJKRwFChJbxmqz6aUSkMvi+6cmbAywjvkwRxTekQQwx/ohYKrEc=
X-Sasl-enc: OujHV9UkS7XCGp1sLuXsEkSqsHSIsKBzlW/0KhxHiZLQ 1305646735
Received: from localhost (p54858FA7.dip0.t-ipconnect.de [84.133.143.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C6C63402F0C;
	Tue, 17 May 2011 11:38:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.514.gd181fb
In-Reply-To: <20110517140725.GA17193@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173806>

The return codes of git_config_set() and friends are magic numbers right
in the source. #define them in cache.h where the functions are declared,
and use the constants in the source.

Also, mention the resulting exit codes of "git config" in its man page
(and complete the list).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-config.txt |   18 ++++++++++--------
 cache.h                      |   10 ++++++++++
 config.c                     |   20 ++++++++++----------
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8804de3..e7ecf5d 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -50,16 +50,18 @@ The default is to assume the config file of the current repository,
 .git/config unless defined otherwise with GIT_DIR and GIT_CONFIG
 (see <<FILES>>).
 
-This command will fail if:
-
-. The config file is invalid,
-. Can not write to the config file,
-. no section was provided,
-. the section or key is invalid,
-. you try to unset an option which does not exist,
-. you try to unset/set an option for which multiple lines match, or
-. you use '--global' option without $HOME being properly set.
-
+This command will fail (with exit code ret) if:
+
+. The config file is invalid (ret=3),
+. can not write to the config file (ret=4),
+. no section or name was provided (ret=2),
+. the section or key is invalid (ret=1),
+. you try to unset an option which does not exist (ret=5),
+. you try to unset/set an option for which multiple lines match (ret=5),
+. you try to use an invalid regexp (ret=6), or
+. you use '--global' option without $HOME being properly set (ret=128).
+
+On success, the command returns the exit code 0.
 
 OPTIONS
 -------
diff --git a/cache.h b/cache.h
index 2225c3f..57a98d2 100644
--- a/cache.h
+++ b/cache.h
@@ -1018,6 +1018,16 @@ extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigne
 /* Dumb servers support */
 extern int update_server_info(int);
 
+/* git_config_parse_key() returns these negated: */
+#define CONFIG_INVALID_KEY 1
+#define CONFIG_NO_SECTION_OR_NAME 2
+/* git_config_set(), git_config_set_multivar() return the above or these: */
+#define CONFIG_NO_LOCK -1
+#define CONFIG_INVALID_FILE 3
+#define CONFIG_NO_WRITE 4
+#define CONFIG_NOTHING_SET 5
+#define CONFIG_INVALID_PATTERN 6
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
diff --git a/config.c b/config.c
index 671c8df..9d36848 100644
--- a/config.c
+++ b/config.c
@@ -1123,12 +1123,12 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 
 	if (last_dot == NULL || last_dot == key) {
 		error("key does not contain a section: %s", key);
-		return -2;
+		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
 		error("key does not contain variable name: %s", key);
-		return -2;
+		return -CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	baselen = last_dot - key;
@@ -1165,7 +1165,7 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 
 out_free_ret_1:
 	free(*store_key);
-	return -1;
+	return -CONFIG_INVALID_KEY;
 }
 
 /*
@@ -1221,7 +1221,7 @@ int git_config_set_multivar(const char *key, const char *value,
 	if (fd < 0) {
 		error("could not lock config file %s: %s", config_filename, strerror(errno));
 		free(store.key);
-		ret = -1;
+		ret = CONFIG_NO_LOCK;
 		goto out_free;
 	}
 
@@ -1235,12 +1235,12 @@ int git_config_set_multivar(const char *key, const char *value,
 		if ( ENOENT != errno ) {
 			error("opening %s: %s", config_filename,
 			      strerror(errno));
-			ret = 3; /* same as "invalid config file" */
+			ret = CONFIG_INVALID_FILE; /* same as "invalid config file" */
 			goto out_free;
 		}
 		/* if nothing to unset, error out */
 		if (value == NULL) {
-			ret = 5;
+			ret = CONFIG_NOTHING_SET;
 			goto out_free;
 		}
 
@@ -1268,7 +1268,7 @@ int git_config_set_multivar(const char *key, const char *value,
 					REG_EXTENDED)) {
 				error("invalid pattern: %s", value_regex);
 				free(store.value_regex);
-				ret = 6;
+				ret = CONFIG_INVALID_PATTERN;
 				goto out_free;
 			}
 		}
@@ -1290,7 +1290,7 @@ int git_config_set_multivar(const char *key, const char *value,
 				regfree(store.value_regex);
 				free(store.value_regex);
 			}
-			ret = 3;
+			ret = CONFIG_INVALID_FILE;
 			goto out_free;
 		}
 
@@ -1303,7 +1303,7 @@ int git_config_set_multivar(const char *key, const char *value,
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen == 0 && value == NULL) ||
 				(store.seen > 1 && multi_replace == 0)) {
-			ret = 5;
+			ret = CONFIG_NOTHING_SET;
 			goto out_free;
 		}
 
@@ -1364,7 +1364,7 @@ int git_config_set_multivar(const char *key, const char *value,
 
 	if (commit_lock_file(lock) < 0) {
 		error("could not commit config file %s", config_filename);
-		ret = 4;
+		ret = CONFIG_NO_WRITE;
 		goto out_free;
 	}
 
-- 
1.7.5.1.514.gd181fb
