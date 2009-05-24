From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/18] http*: copy string returned by sha1_to_hex
Date: Sun, 24 May 2009 22:19:44 +0800
Message-ID: <20090524221944.ae3cb551.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eal-0005ol-JI
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbZEXOVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbZEXOVk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:40 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbZEXOVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:39 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=w5Xr/iHtotmRbhkgb578hTmJTjd7P69SjR1Rhb87BqA=;
        b=ncD4euqHI9BvbYWpGPL9iITho+RGssdwEkj20asb/ypaXdlyGVqW7n4hcDLfgZnfEc
         QSsOpKBKZAIkToKd3lUotuf9uDcvc1CPRENYTTmlwl6zQJ3KX4VLEHvcQlrDwVhrsZh/
         IYJnbD7xv94Ciz/yhFUp8RN5OYtT/d0ekVSTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=sRuOcvVbG0kK3JCPxZV0G1VLNZlX940hOZEZKKbJ4xKNRm2c7BT5O/dx2Oh2SScU+2
         KZeNp81LMdrYV9IK73OyEvJLZq0KMWRny9g2G6Ckqa1GVspO4r5sAffk4zeHc/ii/G+c
         0x5BVVmYtzdh7uisD7Fa9+2VccSx+J2kQB8N0=
Received: by 10.114.102.20 with SMTP id z20mr12449558wab.53.1243174900469;
        Sun, 24 May 2009 07:21:40 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id l27sm11932565waf.55.2009.05.24.07.21.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:40 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119830>

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
index 024f05b..9655b2c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -955,7 +955,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)

 static int fetch_index(unsigned char *sha1)
 {
-	char *hex = sha1_to_hex(sha1);
+	int ret = 0;
+	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
 	char tmpfile[PATH_MAX];
@@ -977,18 +978,18 @@ static int fetch_index(unsigned char *sha1)
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
@@ -1000,9 +1001,9 @@ static int fetch_index(unsigned char *sha1)
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
@@ -1033,21 +1034,23 @@ static int fetch_index(unsigned char *sha1)
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
index 13ca934..a2c9810 100644
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
1.6.3.1
