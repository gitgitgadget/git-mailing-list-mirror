From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http*: cleanup slot->local after fclose
Date: Sun, 31 May 2009 00:09:55 +0800
Message-ID: <20090531000955.953725d9.rctay89@gmail.com>
References: <49F1EA6D.8080406@gmail.com>
	<20090530091755.GA13578@localhost>
	<be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	<20090530093717.GA22129@localhost>
	<be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	<20090530230153.527532b0.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 18:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAR8W-0008OP-N6
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727AbZE3QKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 12:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759655AbZE3QKK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 12:10:10 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:43675 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbZE3QKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 12:10:08 -0400
Received: by pxi29 with SMTP id 29so2035652pxi.33
        for <git@vger.kernel.org>; Sat, 30 May 2009 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UewU40JaU5rJbbisZ6JBADy53OiASbL73uf8VXv+7FY=;
        b=RBJRrjjuk81jnm5lOdiZOj5hMgJpDmVVmEJskQmEAHi/zooM6SbU7CK1dhqv2q+5an
         S9RGmSqVi1HntKJe1HLdeGvDrf4MOSTN7V2MoTt8x59TYHlX8ZLr+x6ZziYwteuQdOiq
         8CNI9eot+PU8JWUucU6ab197eKhSSq5nWSMPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=wFL8t5LiR6aCOZesdXPS0A0pYWCgpgyLibcNPA8vAKosFNXXQwcpYwszVnQROSer8C
         MElf7ya4PSdh71vKLr3Bp4JsXHsoV0k9gWZObomD2eMRtCxXmWWSa+wwA10bWcUZYo6h
         Q4Gz0HgYtXIbKxnVJZbcWucrG9E1vKjuTlykU=
Received: by 10.142.211.7 with SMTP id j7mr1201354wfg.337.1243699810339;
        Sat, 30 May 2009 09:10:10 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id 28sm4375989wfg.5.2009.05.30.09.10.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 09:10:10 -0700 (PDT)
In-Reply-To: <20090530230153.527532b0.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120356>

Set slot->local to NULL after doing a fclose on the FILE* pointer it
points to.

Move NULL assignment to request->slot from
http-push.c::finish_request() to http-push.c::release_request(). This
is safe, since the functions finish_request() invoke will overwrite
request->slot anyway.

Refactor http-push.c::fetch_index(), http-walker.c::fetch_index() and
http-walker.c::fetch_pack() to use labels while cleaning up.

This fixes the issue raised by Clemens Buchacher on 30th May:

  http://www.spinics.net/lists/git/msg104623.html

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

 This applies on master, and is a resend, this time with the subject.

 http-push.c   |   23 ++++++++++++++---------
 http-walker.c |   36 +++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/http-push.c b/http-push.c
index dac2c6e..816824a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -715,6 +715,8 @@ static void release_request(struct transfer_request *request)
 		close(request->local_fileno);
 	if (request->local_stream)
 		fclose(request->local_stream);
+	if (request->slot)
+		request->slot = NULL;
 	free(request->url);
 	free(request);
 }
@@ -727,7 +729,6 @@ static void finish_request(struct transfer_request *request)
 
 	request->curl_result = request->slot->curl_result;
 	request->http_code = request->slot->http_code;
-	request->slot = NULL;
 
 	/* Keep locks active */
 	check_locks();
@@ -823,6 +824,7 @@ static void finish_request(struct transfer_request *request)
 
 			fclose(request->local_stream);
 			request->local_stream = NULL;
+			request->slot->local = NULL;
 			if (!move_temp_to_file(request->tmpfile,
 					       request->filename)) {
 				target = (struct packed_git *)request->userData;
@@ -946,6 +948,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 
 static int fetch_index(unsigned char *sha1)
 {
+	int ret;
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
@@ -1022,21 +1025,23 @@ static int fetch_index(unsigned char *sha1)
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			free(url);
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup;
 		}
 	} else {
-		free(url);
-		fclose(indexfile);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup;
 	}
 
+	ret = move_temp_to_file(tmpfile, filename);
+
+cleanup:
 	free(url);
 	fclose(indexfile);
+	slot->local = NULL;
 
-	return move_temp_to_file(tmpfile, filename);
+	return ret;
 }
 
 static int setup_index(unsigned char *sha1)
diff --git a/http-walker.c b/http-walker.c
index 7321ccc..779947d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -364,6 +364,7 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 
 static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
 {
+	int ret;
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char *url;
@@ -417,18 +418,21 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			fclose(indexfile);
-			return error("Unable to get pack index %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack index %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup;
 		}
 	} else {
-		fclose(indexfile);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup;
 	}
 
-	fclose(indexfile);
+	ret = move_temp_to_file(tmpfile, filename);
 
-	return move_temp_to_file(tmpfile, filename);
+cleanup:
+	fclose(indexfile);
+	slot->local = NULL;
+	return ret;
 }
 
 static int setup_index(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
@@ -718,7 +722,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	FILE *packfile;
 	char *filename;
 	char tmpfile[PATH_MAX];
-	int ret;
+	int ret = 0;
 	long prev_posn = 0;
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header = NULL;
@@ -775,17 +779,23 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		if (results.curl_result != CURLE_OK) {
-			fclose(packfile);
-			return error("Unable to get pack file %s\n%s", url,
-				     curl_errorstr);
+			ret = error("Unable to get pack file %s\n%s", url,
+				    curl_errorstr);
+			goto cleanup;
 		}
 	} else {
-		fclose(packfile);
-		return error("Unable to start request");
+		ret = error("Unable to start request");
+		goto cleanup;
 	}
 
 	target->pack_size = ftell(packfile);
+
+cleanup:
 	fclose(packfile);
+	slot->local = NULL;
+
+	if (ret)
+		return ret;
 
 	ret = move_temp_to_file(tmpfile, filename);
 	if (ret)
-- 
1.6.3.1
