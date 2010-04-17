From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 05/11] http.c: Don't store destination name in request structures
Date: Sat, 17 Apr 2010 13:07:38 -0700
Message-ID: <1271534864-31944-5-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJm-0005p7-Q3
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab0DQUIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:33591 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab0DQUH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:56 -0400
Received: by ywh32 with SMTP id 32so1957603ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:55 -0700 (PDT)
Received: by 10.101.5.28 with SMTP id h28mr8386783ani.91.1271534875218;
        Sat, 17 Apr 2010 13:07:55 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 36sm1085744yxh.68.2010.04.17.13.07.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145183>

The destination name within the object store is easily computed
on demand, reusing a static buffer held by sha1_file.c.  We don't
need to copy the entire path into the request structure for safe
keeping, when it can be easily reformatted after the download has
been completed.

This reduces the size of the per-request structure, and removes
yet another PATH_MAX based limit.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http-walker.c |    2 +-
 http.c        |   14 ++++++--------
 http.h        |    2 --
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index ef99ae6..8ca76d0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -510,7 +510,7 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
-			    req->filename);
+			    sha1_file_name(req->sha1));
 	}
 
 	release_http_object_request(req);
diff --git a/http.c b/http.c
index 64e0c18..c75eb95 100644
--- a/http.c
+++ b/http.c
@@ -1014,7 +1014,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	ret = move_temp_to_file(preq->tmpfile, preq->filename);
+	ret = move_temp_to_file(preq->tmpfile, sha1_pack_name(p->sha1));
 	if (ret)
 		return ret;
 	if (verify_pack(p))
@@ -1043,7 +1043,6 @@ struct http_pack_request *new_http_pack_request(
 	preq->url = strbuf_detach(&buf, NULL);
 
 	filename = sha1_pack_name(target->sha1);
-	snprintf(preq->filename, sizeof(preq->filename), "%s", filename);
 	snprintf(preq->tmpfile, sizeof(preq->tmpfile), "%s.temp", filename);
 	preq->packfile = fopen(preq->tmpfile, "a");
 	if (!preq->packfile) {
@@ -1133,7 +1132,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	freq->localfile = -1;
 
 	filename = sha1_file_name(sha1);
-	snprintf(freq->filename, sizeof(freq->filename), "%s", filename);
 	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
 		 "%s.temp", filename);
 
@@ -1162,8 +1160,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	}
 
 	if (freq->localfile < 0) {
-		error("Couldn't create temporary file %s for %s: %s",
-		      freq->tmpfile, freq->filename, strerror(errno));
+		error("Couldn't create temporary file %s: %s",
+		      freq->tmpfile, strerror(errno));
 		goto abort;
 	}
 
@@ -1210,8 +1208,8 @@ struct http_object_request *new_http_object_request(const char *base_url,
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
 			if (ftruncate(freq->localfile, 0) < 0) {
-				error("Couldn't truncate temporary file %s for %s: %s",
-					  freq->tmpfile, freq->filename, strerror(errno));
+				error("Couldn't truncate temporary file %s: %s",
+					  freq->tmpfile, strerror(errno));
 				goto abort;
 			}
 		}
@@ -1287,7 +1285,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 	freq->rename =
-		move_temp_to_file(freq->tmpfile, freq->filename);
+		move_temp_to_file(freq->tmpfile, sha1_file_name(freq->sha1));
 
 	return freq->rename;
 }
diff --git a/http.h b/http.h
index 5c9441c..84bdbd0 100644
--- a/http.h
+++ b/http.h
@@ -152,7 +152,6 @@ struct http_pack_request
 	struct packed_git *target;
 	struct packed_git **lst;
 	FILE *packfile;
-	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	struct curl_slist *range_header;
 	struct active_request_slot *slot;
@@ -167,7 +166,6 @@ extern void release_http_pack_request(struct http_pack_request *preq);
 struct http_object_request
 {
 	char *url;
-	char filename[PATH_MAX];
 	char tmpfile[PATH_MAX];
 	int localfile;
 	CURLcode curl_result;
-- 
1.7.1.rc1.269.ga27c7
