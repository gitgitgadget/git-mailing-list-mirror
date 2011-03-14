From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] smart-http: Really never use Expect: 100-continue
Date: Mon, 14 Mar 2011 11:28:17 -0700
Message-ID: <1300127297-8025-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:28:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzCVG-0002BK-MG
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 19:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab1CNS2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 14:28:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48433 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab1CNS2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 14:28:20 -0400
Received: by ywj3 with SMTP id 3so2163132ywj.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 11:28:20 -0700 (PDT)
Received: by 10.236.27.98 with SMTP id d62mr6527052yha.5.1300127300084;
        Mon, 14 Mar 2011 11:28:20 -0700 (PDT)
Received: from localhost (sop.mtv.corp.google.com [172.18.74.69])
        by mx.google.com with ESMTPS id l65sm5471735yhn.39.2011.03.14.11.28.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 11:28:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.408.gb6b16.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169004>

libcurl may choose to try and use Expect: 100-continue for
any type of POST, not just a Transfer: chunked-encoding type.
Force it to disable this feature, as not all proxy servers support
100-continue and leaving it enabled can cause 1 second stalls during
the negotiation phase of fetch-pack/upload-pack.

In ("206b099d26 smart-http: Don't use Expect: 100-Continue") we
tried to disable this for only large POST bodies, but it should be
disabled for every POST body.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This should be applied onto the tip of sp/maint-smart-http-sans-100-continue.

 remote-curl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 256326a..1f41a90 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -453,12 +453,12 @@ static int post_rpc(struct rpc_state *rpc)
 
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
+	headers = curl_slist_append(headers, "Expect:");
 
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
 		 */
-		headers = curl_slist_append(headers, "Expect:");
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
-- 
1.7.4.1.408.gb6b16.dirty
