From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 13/18] http-push: use the new http API in remote_exists()
Date: Sun, 24 May 2009 22:19:59 +0800
Message-ID: <20090524221959.e6b1be49.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ear-0005ol-AU
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZEXOWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbZEXOWU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:20 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295AbZEXOWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:17 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ytgkqnFo87PSuzop/NpJ3oBS9lBXJUdmyHE5QAblszs=;
        b=tuZXeMrZMlQdEDpA8GHnutd1lQnabelRqR22CTjd9RNCjTk5o2ejaFzutGb+g9QAI7
         mKkGyco9NGKFhx5o2mbQg/0mb//xhMva2RDF8VFw4Rh0b6J7apqjz+PtQ9j5F5d7eDM/
         R+t+tcnDrCQMeFqNs3vutBR3qxD6Iewt7mYao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BCPrT6AZQwiDy5QuBGXq+ATqln4kFXjF3s9/4reBAsvUYATKE0cmgkUqTrEIxCqAtr
         VEqOf7MCo+apPrhqkW3UjaL4t0xgbMLkD00X+3B+6zkreVKImO69UvevKh83Hv1EQN7g
         OptiP2DEyoDHP43EIoG8LgX3aldOg2BwoBI7M=
Received: by 10.115.110.15 with SMTP id n15mr12388087wam.144.1243174939769;
        Sun, 24 May 2009 07:22:19 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id m25sm4116009waf.44.2009.05.24.07.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:19 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119823>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/http-push.c b/http-push.c
index f2c8a97..5b20cec 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2000,29 +2000,22 @@ static void update_remote_info_refs(struct remote_lock *lock)
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
