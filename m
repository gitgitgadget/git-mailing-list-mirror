From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon,  1 Oct 2012 14:23:06 -0700
Message-ID: <1349126586-755-1-git-send-email-spearce@spearce.org>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TInSW-0006Yi-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab2JAVXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 17:23:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48259 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab2JAVXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 17:23:09 -0400
Received: by pbbrr4 with SMTP id rr4so8128728pbb.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cWsvfIJvHZN6hhvnkuj449EnjjylgMvZWg1g6F1tLu4=;
        b=eiYBgvh+8GZkESXhu0TDYZKmH7PYL5awXJDdbRyOPgi12RACPnV0s56yPZMxgcUkGR
         MXouv2rdoayvOLbodsppCQGmMVvirOzJaYGQTJTXyowSFb35cvRIImdbTZfthprQ8NUH
         yrmlo6LwUY8Wur802C5IcrINPUSY2zwv8TbH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=cWsvfIJvHZN6hhvnkuj449EnjjylgMvZWg1g6F1tLu4=;
        b=LhUy5wPapEczxZdTMV6I0iCDc8GluzhU7A/VYzjoO/OncQxxbGze/MpgNvuIaDmJJT
         Lx2XrTmnYetfPMFuKMhO4CzvzqEw01jzR31ZRO7k9a4AkxNtuswy2jGlirB+vzZ0skNE
         8uRKBBe92vPRTIfAM5JoKqChGoM+co84TJzy2qm+J9kUXlXzL6LvlCQMLZVqQsMkZ83Z
         BJamLEzfAGtV3QcMMilpBaV1Y8m+tPYmOiiOLmvPyEnOqQJ73dCVOScX1EfhhAiyB1dS
         rbld/PFAPF8jQaPM3v4qfxvTL1WdA9dG57jLV6cHGAQphbCNafxPJLNBewwr7UU/sUvk
         Vo3A==
Received: by 10.66.78.6 with SMTP id x6mr39322657paw.41.1349126588441;
        Mon, 01 Oct 2012 14:23:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:be30:5bff:fed0:8744])
        by mx.google.com with ESMTPS id j10sm10948921pax.4.2012.10.01.14.23.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 14:23:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.590.g4bb1bc4
In-Reply-To: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmzH2oJBhPqjHXpEnrR3czXg46cnS1nniUkZ5X8xROCa6WYnCWdbNq//q3HRibYoTE/kbFa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206770>

From: "Shawn O. Pearce" <spearce@spearce.org>

When libcurl fails to connect to an SSL server always retry the
request once. Since the connection failed before the HTTP headers
can be sent, no data has exchanged hands, so the remote side has
not learned of the request and will not perform it twice.

In the wild we have seen git-remote-https fail to connect to
some load-balanced SSL servers sporadically, while modern popular
browsers (e.g. Firefox and Chromium) have no trouble with the same
server pool.

Lets assume the site operators (Hi Google!) have a clue and are
doing everything they already can to ensure secure, successful
SSL connections from a wide range of HTTP clients. Implementing a
single level of retry in the client can make it more robust against
transient failure modes.
---
 http.c        | 19 ++++++++++++-------
 remote-curl.c |  2 ++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index 345c171..953f2e6 100644
--- a/http.c
+++ b/http.c
@@ -784,7 +784,7 @@ static int http_request(const char *url, void *result, int target, int options)
 	struct slot_results results;
 	struct curl_slist *headers = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	int ret;
+	int ret, attempts;
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -820,12 +820,17 @@ static int http_request(const char *url, void *result, int target, int options)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		ret = handle_curl_result(slot);
-	} else {
-		error("Unable to start HTTP request for %s", url);
-		ret = HTTP_START_FAILED;
+	for (attempts = 0; attempts < 2; attempts++) {
+		if (start_active_slot(slot)) {
+			run_active_slot(slot);
+			if (slot->results->curl_result == CURLE_SSL_CONNECT_ERROR)
+				continue;
+			ret = handle_curl_result(slot);
+		} else {
+			error("Unable to start HTTP request for %s", url);
+			ret = HTTP_START_FAILED;
+		}
+		break;
 	}
 
 	curl_slist_free_all(headers);
diff --git a/remote-curl.c b/remote-curl.c
index a269608..04a379c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -353,6 +353,8 @@ static int run_slot(struct active_request_slot *slot)
 
 	slot->results = &results;
 	slot->curl_result = curl_easy_perform(slot->curl);
+	if (slot->curl_result == CURLE_SSL_CONNECT_ERROR)
+		slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);
 
 	err = handle_curl_result(slot);
-- 
1.7.12.1.590.g4bb1bc4
