From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 18/23] http-push.c::remote_exists(): use the new http API
Date: Sat, 6 Jun 2009 00:05:57 +0800
Message-ID: <20090606000557.18c55768.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzL-00053w-6i
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbZFEQJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbZFEQJT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbZFEQJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:09:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7I/cX+AkWK0WFX8MkfQjVsI4i7rh//1mqwcuonUbmhg=;
        b=fmWpXcZbD1oNZ3u8410IUL/eAX6yxK4V+vSTbIgP/SKIzlRrfcffZWtDRpdYRIvdMw
         8vEeRbXYuFowpM063gv8T4q0wjgy6JMP/eY1IqDdeKZqFA7h6798b4bWuD/VUatNngzm
         XzMBhW2OHUMcTyPVGr83b3ZQsMuDnRKiH41Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=F6BNomxTGxLDnRH1PwQv1iM0m5s6tzMxunxc+/eNfVRIndlON0ilf2Vy4StEsbcpOx
         Clg7XLo9SeZfbvRmReVgFB9KQCajTW+NpsMLTPZ+EUyNW9ijbUq32pYyOZHS91ElkMWx
         m1oyzL1+6I/YLQ8vsBiCEDWRvMbJ4o1dbpomU=
Received: by 10.142.177.13 with SMTP id z13mr1348682wfe.79.1244218160690;
        Fri, 05 Jun 2009 09:09:20 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm444028wfg.10.2009.06.05.09.09.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:19 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120800>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 08/12] Use the new http API in update_remote_info_refs()
Date:	Sun, 18 Jan 2009 09:04:33 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/http-push.c b/http-push.c
index b01db75..455e0aa 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2005,29 +2005,22 @@ static void update_remote_info_refs(struct remote_lock *lock)
 static int remote_exists(const char *path)
 {
 	char *url = xmalloc(strlen(repo->url) + strlen(path) + 1);
-	struct active_request_slot *slot;
-	struct slot_results results;
-	int ret = -1;
+	int ret;

 	sprintf(url, "%s%s", repo->url, path);

-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.http_code == 404)
-			ret = 0;
-		else if (results.curl_result == CURLE_OK)
-			ret = 1;
-		else
-			fprintf(stderr, "HEAD HTTP error %ld\n", results.http_code);
-	} else {
-		fprintf(stderr, "Unable to start HEAD request\n");
+	switch (http_get_strbuf(url, NULL, 0)) {
+	case HTTP_OK:
+		ret = 1;
+		break;
+	case HTTP_MISSING_TARGET:
+		ret = 0;
+		break;
+	case HTTP_ERROR:
+		http_error(url, HTTP_ERROR);
+	default:
+		ret = -1;
 	}
-
 	free(url);
 	return ret;
 }
--
1.6.3.1
