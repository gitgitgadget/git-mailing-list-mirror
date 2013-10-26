From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3] remote-curl: fix large pushes with GSSAPI
Date: Sat, 26 Oct 2013 22:34:42 +0000
Message-ID: <1382826882-48704-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 00:35:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaCRj-0001sG-P4
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 00:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab3JZWfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 18:35:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33322 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753757Ab3JZWe7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Oct 2013 18:34:59 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 710282807A;
	Sat, 26 Oct 2013 22:34:56 +0000 (UTC)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236768>

Due to an interaction between the way libcurl handles GSSAPI authentication over
HTTP and the way git uses libcurl, large pushes (those over http.postBuffer
bytes) would fail due to an authentication failure requiring a rewind of the
curl buffer.  Such a rewind was not possible because the data did not fit into
the entire buffer.

Enable the use of the Expect: 100-continue header for large requests where the
server offers GSSAPI authentication to avoid this issue, since the request would
otherwise fail.  This allows git to get the authentication data right before
sending the pack contents.  Existing cases where pushes would succeed, including
small requests using GSSAPI, still disable the use of 100 Continue, as it causes
problems for some remote HTTP implementations (servers and proxies).

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index c9b891a..35698e7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -449,6 +449,7 @@ static int post_rpc(struct rpc_state *rpc)
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
 	int err, large_request = 0;
+	int needs_100_continue = 0;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -472,6 +473,8 @@ static int post_rpc(struct rpc_state *rpc)
 	}
 
 	if (large_request) {
+		long authtype = 0;
+
 		do {
 			err = probe_rpc(rpc);
 			if (err == HTTP_REAUTH)
@@ -479,11 +482,17 @@ static int post_rpc(struct rpc_state *rpc)
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
+
+		slot = get_active_slot();
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL, &authtype);
+		if (authtype & CURLAUTH_GSSNEGOTIATE)
+			needs_100_continue = 1;
 	}
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
-	headers = curl_slist_append(headers, "Expect:");
+	headers = curl_slist_append(headers, needs_100_continue ?
+		"Expect: 100-continue" : "Expect:");
 
 retry:
 	slot = get_active_slot();
-- 
1.8.4.1.635.g55556a5
