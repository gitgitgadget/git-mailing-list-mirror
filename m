From: Jeff Lasslett <jeff.lasslett@gmail.com>
Subject: [PATCH] Check return value of ftruncate call in http.c.  Remove possible mem leak
Date: Mon, 10 Aug 2009 23:42:27 +1000
Message-ID: <1249911747-28490-1-git-send-email-jeff.lasslett@gmail.com>
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 15:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaV9V-0004e4-Q3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbZHJNmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 09:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZHJNmx
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 09:42:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:18078 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbZHJNmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 09:42:53 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1001460rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bGlHlGysgVyrXyoVdJAmXz62GrxO4DENB6J0ZvczOwE=;
        b=MN/HDHmFQQM2UorORBvb2+tRo0llUGcjNZgduPiDViTevMwJHJyirzJBrxxxPfnwqK
         NuK8fEzAH7wk2KZMPujHoVAg55WQ4x2MQuLOYpm1iskNBU2ZWiPZdH6qKv5UeVE9iWQb
         Pk2p5JmNuyBUHk86Axj69YvJaek7eahTl7KMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CMRAAUz+QnXwyETIl+MuSd5C6cC8c2dQSlE+2QdXAVTdK7WaVWzJhGuVYFTySgH2J9
         CrlX4KN4/+UtojtwVEA3mEAn8lv1FmkBxlW+aUVUZpEp6b9g03glp0hY8OQrEbEt/cba
         IlkwYbrLyijV784j+QoNp3iFiXgFoxOwa7bVs=
Received: by 10.142.192.7 with SMTP id p7mr639716wff.218.1249911774166;
        Mon, 10 Aug 2009 06:42:54 -0700 (PDT)
Received: from localhost.localdomain (CPE-58-165-23-40.vic.bigpond.net.au [58.165.23.40])
        by mx.google.com with ESMTPS id 32sm12320369wfa.13.2009.08.10.06.42.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 06:42:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.59.g4d590.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125442>

In new_http_object_request(), check ftruncate() call return value and
handle possible errors.  Remove possible leak of mem pointed to by url.

Signed-off-by: Jeff Lasslett <jeff.lasslett@gmail.com>
---
 http.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index a2720d5..e8317e1 100644
--- a/http.c
+++ b/http.c
@@ -1098,7 +1098,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char prevfile[PATH_MAX];
-	char *url;
+	char *url = NULL;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -1189,7 +1189,11 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
-			ftruncate(freq->localfile, 0);
+			if (ftruncate(freq->localfile, 0) < 0) {
+				error("Couldn't truncate temporary file %s for %s: %s",
+					  freq->tmpfile, freq->filename, strerror(errno));
+				goto abort;
+			}
 		}
 	}
 
@@ -1198,7 +1202,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
 	/*
@@ -1216,10 +1220,12 @@ struct http_object_request *new_http_object_request(const char *base_url,
 				 CURLOPT_HTTPHEADER, range_header);
 	}
 
+	free(url);
 	return freq;
 
-	free(url);
 abort:
+	free(url);
+	free(freq->url);
 	free(filename);
 	free(freq);
 	return NULL;
-- 
1.6.4.59.g4d590.dirty
