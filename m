From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 09/23] http*: copy string returned by sha1_to_hex
Date: Sat, 6 Jun 2009 00:04:45 +0800
Message-ID: <20090606000445.326d2ef7.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzE-00053w-Im
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbZFEQIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZFEQIm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbZFEQIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:40 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dDMWftNX+Bw8AOjiEmFOs4b6iT0oy7DHBv2rYZmzbEs=;
        b=ki490oRhCbXe0sMTGm5WZSiHO2Nz9RqZ+LFDMOKZTuNhw/SOUEjMy4JcqxjBhenPXe
         cUA7gXJuSPMLeEY/98ipofGCfh+dsB0qdjIXFnBgof6sTN0e/ptvqAO6CZL5fBYqJQOd
         8mlobtVWxizJLe3Rx+tH5Ycz1xLcimi2htKHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jK2bqdudJXEcRDJvi2+QBXrq3dgzqSsksCDmK7MWaqpbC3T8OjOH9TBwZEIhZnzQNW
         tyJyNujFgsacvLOihbxcPvfm7dDGD1RUuKmW3xPIrucqV0Y0+tp26Ntdp8PfjdGOse9K
         fgPdMsPfdNH6d1xMNlHspEdpeqC5FXTWKVAUg=
Received: by 10.142.170.20 with SMTP id s20mr290216wfe.129.1244218122830;
        Fri, 05 Jun 2009 09:08:42 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm425113wfc.34.2009.06.05.09.08.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:42 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120790>

In the fetch_index implementations in http-push.c and http-walker.c,
the string returned by sha1_to_hex is assumed to stay immutable.

This patch ensures that hex stays immutable by copying the string
returned by sha1_to_hex (via xstrdup) and frees it subsequently. It
also refactors free()'s and fclose()'s with labels.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |   47 ++++++++++++++++++++++++-----------------------
 http-walker.c |   45 +++++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/http-push.c b/http-push.c
index 6ac0d63..c8cb6e4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -958,7 +958,8 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)

 static int fetch_index(unsigned char *sha1)
 {
-	char *hex = sha1_to_hex(sha1);
+	int ret = 0;
+	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
 	char tmpfile[PATH_MAX];
@@ -980,18 +981,18 @@ static int fetch_index(unsigned char *sha1)
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
@@ -1003,9 +1004,9 @@ static int fetch_index(unsigned char *sha1)
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
@@ -1036,24 +1037,24 @@ static int fetch_index(unsigned char *sha1)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			slot->local = NULL;
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup_index;
 		}
 	} else {
-		free(url);
-		fclose(indexfile);
-		slot->local = NULL;
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_index;
 	}

-	free(url);
+	ret = move_temp_to_file(tmpfile, filename);
+
+cleanup_index:
 	fclose(indexfile);
 	slot->local = NULL;
-
-	return move_temp_to_file(tmpfile, filename);
+cleanup_pack:
+	free(url);
+	free(hex);
+	return ret;
 }

 static int setup_index(unsigned char *sha1)
diff --git a/http-walker.c b/http-walker.c
index bbc3023..d6cc622 100644
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
@@ -450,24 +451,24 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			slot->local = NULL;
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup_index;
 		}
 	} else {
-		free(url);
-		fclose(indexfile);
-		slot->local = NULL;
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup_index;
 	}

-	free(url);
+	ret = move_temp_to_file(tmpfile, filename);
+
+cleanup_index:
 	fclose(indexfile);
 	slot->local = NULL;
-
-	return move_temp_to_file(tmpfile, filename);
+cleanup_pack:
+	free(url);
+	free(hex);
+	return ret;
 }

 static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
--
1.6.3.1
