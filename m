From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] remote-curl: fix large pushes with GSSAPI
Date: Thu, 31 Oct 2013 02:36:51 -0400
Message-ID: <20131031063651.GC5812@sigill.intra.peff.net>
References: <20131031063451.GA5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 07:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VblsI-0001MQ-I1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 07:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab3JaGgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 02:36:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:59011 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752003Ab3JaGgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 02:36:54 -0400
Received: (qmail 18314 invoked by uid 102); 31 Oct 2013 06:36:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 01:36:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 02:36:51 -0400
Content-Disposition: inline
In-Reply-To: <20131031063451.GA5513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237082>

From: brian m. carlson <sandals@crustytoothpaste.net>

Due to an interaction between the way libcurl handles GSSAPI
authentication over HTTP and the way git uses libcurl, large
pushes (those over http.postBuffer bytes) would fail due to
an authentication failure requiring a rewind of the curl
buffer.  Such a rewind was not possible because the data did
not fit into the entire buffer.

Enable the use of the Expect: 100-continue header for large
requests where the server offers GSSAPI authentication to
avoid this issue, since the request would otherwise fail.
This allows git to get the authentication data right before
sending the pack contents.  Existing cases where pushes
would succeed, including small requests using GSSAPI, still
disable the use of 100 Continue, as it causes problems for
some remote HTTP implementations (servers and proxies).

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 79db21e..f646b5f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -442,6 +442,7 @@ static int post_rpc(struct rpc_state *rpc)
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
 	int err, large_request = 0;
+	int needs_100_continue = 0;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -465,16 +466,22 @@ static int post_rpc(struct rpc_state *rpc)
 	}
 
 	if (large_request) {
+		struct slot_results results;
+
 		do {
-			err = probe_rpc(rpc, NULL);
+			err = probe_rpc(rpc, &results);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
+
+		if (results.auth_avail & CURLAUTH_GSSNEGOTIATE)
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
1.8.4.1.898.g8bf8a41.dirty
