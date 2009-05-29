From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 03/17] http*: copy string returned by sha1_to_hex
Date: Sat, 30 May 2009 01:58:45 +0800
Message-ID: <20090530015845.5c4c777c.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6Nw-0008Tp-NX
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239AbZE2SAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755935AbZE2SAn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:00:43 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:56012 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537AbZE2SAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:00:42 -0400
Received: by mail-pz0-f109.google.com with SMTP id 7so4912264pzk.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=w5Xr/iHtotmRbhkgb578hTmJTjd7P69SjR1Rhb87BqA=;
        b=niBbjDhRTuHrJuAUfSez+w8gmfvtSCkW/WK5is/LQlQy0iinPXdUrtu0bguVzFnDqh
         xoprGpcIbbn39JSAoWCInx1DGD6n2P9CCLgTmHCXlVAZSuebbee+lknZ7pD5xH580mNM
         S29PQ/fUBVssp2mKeDq5KeNp/lkbik3LNScgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=xMgc1xx3wHKTH5Kq1De13obLTsjTtzHOSNbSobzEauyrDVBYI7AKvAinOYL1frC4bs
         XGb6ozJN44rZSF+EjqchpDPqvMencgtgDrbbeUrleyI5ijGKRfrr3bnLa44wu+dsEq0y
         Mdd362iqNMNDOldk/G4DQZ0h9aNxToziJEAAM=
Received: by 10.114.58.15 with SMTP id g15mr5050168waa.186.1243620044581;
        Fri, 29 May 2009 11:00:44 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id n33sm2544951wag.69.2009.05.29.11.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:00:44 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120290>

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
