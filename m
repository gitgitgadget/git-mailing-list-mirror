From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/11] http*: copy string returned by sha1_to_hex
Date: Sat, 16 May 2009 11:51:37 +0800
Message-ID: <20090516115137.ad454ab0.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0S-0005js-Ni
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbZEPDza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756331AbZEPDz1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:27 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61221 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbZEPDzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:23 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1344167pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Iog1u66g2Rd780yTNsMTMKyEd85QbsUxS10n3kMMym0=;
        b=Cm1l+bM1svkXju+Zgprq6u+Dakg02F4PzXdyhJzBBr9e/Pr+gUKA7OpkmW24bE7FnS
         yUiiFV/pEHd378E4PHDZvqm6Ci1oJJWMxQE436QeaS7FGlL5S/KpRobw4N1Jcq9hYUPu
         LuRUm6oFo6Wun077BdoRF1CeNMX5AmuqUz68M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=bbOc8XIGPZ9k/UKY2ziPG4XM7R7ZYmwXFOSOcc/AQxogN5JNCB87iCRCmatasp4CCu
         0m1JRYACNwD0psZ9oxA6KH8c1RTKwkB6AwmtUHcvru3+kJnTAdbQAePsMcCrvAbVY14d
         6xVNHeA595xRQiMyXCBPXJyAfBBW12vOB5LqM=
Received: by 10.114.169.20 with SMTP id r20mr6076811wae.110.1242446125173;
        Fri, 15 May 2009 20:55:25 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id n30sm2177545wag.63.2009.05.15.20.55.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:24 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119326>

In the fetch_index implementations in http-push.c and http-walker.c,
the string returned by sha1_to_hex is assumed to stay immutable.

This patch ensures that hex stays immutable by copying the string
returned by sha1_to_hex (via xstrdup) and frees it subsequently. It
also refactors free()'s and fclose()'s with labels.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |   45 ++++++++++++++++++++++++---------------------
 http-walker.c |   43 +++++++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/http-push.c b/http-push.c
index c55bd81..1011ca8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -954,7 +954,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 
 static int fetch_index(unsigned char *sha1)
 {
-	char *hex = sha1_to_hex(sha1);
+	int ret = 0;
+	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
 	char tmpfile[PATH_MAX];
@@ -976,18 +977,18 @@ static int fetch_index(unsigned char *sha1)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			return error("Unable to verify pack %s is available",
-				     hex);
+			ret = error("Unable to verify pack %s is available",
+				    hex);
+			goto cleanup_pack;
 		}
 	} else {
-		free(url);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_pack;
 	}
 
 	if (has_pack_index(sha1)) {
-		free(url);
-		return 0;
+		ret = 0;
+		goto cleanup_pack;
 	}
 
 	if (push_verbosely)
@@ -999,9 +1000,9 @@ static int fetch_index(unsigned char *sha1)
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
 	indexfile = fopen(tmpfile, "a");
 	if (!indexfile) {
-		free(url);
-		return error("Unable to open local file %s for pack index",
-			     tmpfile);
+		ret = error("Unable to open local file %s for pack index",
+			    tmpfile);
+		goto cleanup_pack;
 	}
 
 	slot = get_active_slot();
@@ -1032,21 +1033,23 @@ static int fetch_index(unsigned char *sha1)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup_index;
 		}
 	} else {
-		free(url);
-		fclose(indexfile);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_index;
 	}
 
-	free(url);
-	fclose(indexfile);
+	ret = move_temp_to_file(tmpfile, filename);
 
-	return move_temp_to_file(tmpfile, filename);
+cleanup_index:
+	fclose(indexfile);
+cleanup_pack:
+	free(url);
+	free(hex);
+	return ret;
 }
 
 static int setup_index(unsigned char *sha1)
diff --git a/http-walker.c b/http-walker.c
index cf46adb..8bf83d0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -371,7 +371,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 
 static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
 {
-	char *hex = sha1_to_hex(sha1);
+	int ret = 0;
+	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
 	char tmpfile[PATH_MAX];
@@ -394,18 +395,18 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			return error("Unable to verify pack %s is available",
+			ret = error("Unable to verify pack %s is available",
 				     hex);
+			goto cleanup_pack;
 		}
 	} else {
-		free(url);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_pack;
 	}
 
 	if (has_pack_index(sha1)) {
-		free(url);
-		return 0;
+		ret = 0;
+		goto cleanup_pack;
 	}
 
 	if (walker->get_verbosely)
@@ -417,9 +418,9 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
 	indexfile = fopen(tmpfile, "a");
 	if (!indexfile) {
-		free(url);
-		return error("Unable to open local file %s for pack index",
-			     tmpfile);
+		ret = error("Unable to open local file %s for pack index",
+			    tmpfile);
+		goto cleanup_pack;
 	}
 
 	slot = get_active_slot();
@@ -450,21 +451,23 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup_index;
 		}
 	} else {
-		free(url);
-		fclose(indexfile);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_index;
 	}
 
-	free(url);
-	fclose(indexfile);
+	ret = move_temp_to_file(tmpfile, filename);
 
-	return move_temp_to_file(tmpfile, filename);
+cleanup_index:
+	fclose(indexfile);
+cleanup_pack:
+	free(url);
+	free(hex);
+	return ret;
 }
 
 static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
-- 
1.6.3.rc0
