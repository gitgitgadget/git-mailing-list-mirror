From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 12/18] http: use the new http API in http_fetch_ref()
Date: Sun, 24 May 2009 22:19:57 +0800
Message-ID: <20090524221957.3c591ccb.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eaq-0005ol-Mk
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbZEXOWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZEXOWR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:17 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbZEXOWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:14 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=01/7jCNqRapg1lurV9H/PJJkfK96Q9ZldY/xWj/pr5M=;
        b=VhnFpg71qJ1TTDZ9wRHSMh1gzlFZjvcbfj5DVoq7IyZoOix3OzImA0uYUq9EcLgHem
         0XTtYnVSC9aWqEx3oBr7nu+vMuR0auXiSUqeU7qBq+EZlfhqVdemLQKDVcu0yr9DXjbP
         JVXc5EsWwzgrwdS7Juoq5J6uRagDAgBM9dQuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=XcrR1i1Oy9IGZH0TPi2kboenM75VO3V4MEfR4pDthMoz4wB6j1fjVEDWbZInb7v+06
         DVH/JdmKTRJiwPrps0ljHDN9PfP3dDwdfKs6munHXc57EyxtmnpL/BIYOtjitxeUr+Ix
         mBytooy+Hg/HXQ1p2bb8qNWcEZyJvBkGGKxUg=
Received: by 10.114.159.6 with SMTP id h6mr12490901wae.211.1243174936049;
        Sun, 24 May 2009 07:22:16 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id n9sm6768092wag.32.2009.05.24.07.22.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:15 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119835>

The error message ("Unable to start request") has been removed, since
the http API already prints it.

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   33 ++++++++-------------------------
 1 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 1434603..c640510 100644
--- a/http.c
+++ b/http.c
@@ -772,34 +772,17 @@ int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret;
+	int ret = -1;

 	url = quote_ref_url(base, ref->name);
-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result == CURLE_OK) {
-			strbuf_rtrim(&buffer);
-			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
-			else if (!prefixcmp(buffer.buf, "ref: ")) {
-				ref->symref = xstrdup(buffer.buf + 5);
-				ret = 0;
-			} else
-				ret = 1;
-		} else {
-			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref->name, curl_errorstr);
+	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
+		strbuf_rtrim(&buffer);
+		if (buffer.len == 40)
+			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
+		else if (!prefixcmp(buffer.buf, "ref: ")) {
+			ref->symref = xstrdup(buffer.buf + 5);
+			ret = 0;
 		}
-	} else {
-		ret = error("Unable to start request");
 	}

 	strbuf_release(&buffer);
--
1.6.3.1
