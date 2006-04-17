From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 6/7] cleanups: prevent leak of two strduped strings in config.c
Date: Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
Message-ID: <20060417151448.271D719B913@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRL-0006b0-I6
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWDQPOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWDQPOy
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:54 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:61914 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751093AbWDQPOt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEno6010257
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFIBb9184512
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:18:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEn1K019215
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:49 -0600
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmET019176
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id 271D719B913; Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18826>

Config_filename and lockfile are strduped and then leaked in
git_config_set_multivar.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 config.c |   37 +++++++++++++++++++++++++++----------
 1 files changed, 27 insertions(+), 10 deletions(-)

c96b9a1a358f8929a2525dd4e15551d286aec361
diff --git a/config.c b/config.c
index 95ec349..a37bb2d 100644
--- a/config.c
+++ b/config.c
@@ -420,6 +420,7 @@ int git_config_set_multivar(const char* 
 {
 	int i;
 	int fd, in_fd;
+	int ret;
 	char* config_filename = strdup(git_path("config"));
 	char* lock_file = strdup(git_path("config.lock"));
 	const char* last_dot = strrchr(key, '.');
@@ -431,7 +432,8 @@ int git_config_set_multivar(const char* 
 
 	if (last_dot == NULL) {	
 		fprintf(stderr, "key does not contain a section: %s\n", key);
-		return 2;
+		ret = 2;
+		goto out_free;
 	}
 	store.baselen = last_dot - key;
 
@@ -447,7 +449,8 @@ int git_config_set_multivar(const char* 
 				 (i == store.baselen+1 && !isalpha(key[i])))) {
 			fprintf(stderr, "invalid key: %s\n", key);
 			free(store.key);
-			return 1;
+			ret = 1;
+			goto out_free;
 		} else
 			store.key[i] = tolower(key[i]);
 	store.key[i] = 0;
@@ -460,7 +463,8 @@ int git_config_set_multivar(const char* 
 	if (fd < 0) {
 		fprintf(stderr, "could not lock config file\n");
 		free(store.key);
-		return -1;
+		ret = -1;
+		goto out_free;
 	}
 
 	/*
@@ -475,13 +479,15 @@ int git_config_set_multivar(const char* 
 			      strerror(errno));
 			close(fd);
 			unlink(lock_file);
-			return 3; /* same as "invalid config file" */
+			ret = 3; /* same as "invalid config file" */
+			goto out_free;
 		}
 		/* if nothing to unset, error out */
 		if (value == NULL) {
 			close(fd);
 			unlink(lock_file);
-			return 5;
+			ret = 5;
+			goto out_free;
 		}
 
 		store.key = (char*)key;
@@ -507,7 +513,8 @@ int git_config_set_multivar(const char* 
 				fprintf(stderr, "Invalid pattern: %s\n",
 					value_regex);
 				free(store.value_regex);
-				return 6;
+				ret = 6;
+				goto out_free;
 			}
 		}
 
@@ -528,7 +535,8 @@ int git_config_set_multivar(const char* 
 				regfree(store.value_regex);
 				free(store.value_regex);
 			}
-			return 3;
+			ret = 3;
+			goto out_free;
 		}
 
 		free(store.key);
@@ -542,7 +550,8 @@ int git_config_set_multivar(const char* 
 				(store.seen > 1 && multi_replace == 0)) {
 			close(fd);
 			unlink(lock_file);
-			return 5;
+			ret = 5;
+			goto out_free;
 		}
 
 		fstat(in_fd, &st);
@@ -593,10 +602,18 @@ int git_config_set_multivar(const char* 
 
 	if (rename(lock_file, config_filename) < 0) {
 		fprintf(stderr, "Could not rename the lock file?\n");
-		return 4;
+		ret = 4;
+		goto out_free;
 	}
 
-	return 0;
+	ret = 0;
+
+out_free:
+	if (config_filename)
+		free(config_filename);
+	if (lock_file)
+		free(lock_file);
+	return ret;
 }
 
 
-- 
1.2.5
