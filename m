From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 12/17] http-push.c::remote_exists(): use the new http API
Date: Sat, 30 May 2009 01:59:30 +0800
Message-ID: <20090530015930.709d8175.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P9-0000Xl-2P
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760074AbZE2SBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbZE2SBU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24455 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759858AbZE2SBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:19 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1285295wah.21
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=W+l45ZzkedSpBs6Zf+o1RcdP5Bsnb1jQdgIib6JkkGY=;
        b=i2KbwgBvxCqHe+8sWe+6Gp1Y2rWcK2mSWdcL+qB++KwyHqYx2RhgA/NcH1MkH8a7rM
         Ylq85C9DSdocB0u8n3zNFdJcxEUj4OkFKsD3L3E81wBCJnzT1QwvS42MLgson1Ur4tln
         tN4vKKCdJDvF2KqO8/HiifbOLN2hInliFy4SA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=rifOSZqXfA96dIv661Tnf5ZkLS6iD2/fxSo0p265IpRekNqnfzWVaVnZNieUqRhx7j
         lJ/p6tLOvFXDvvYfehh3wiK/fejC3MJ0BpM+KjCowJMOniimQZds3q8jP+lsYfooW59l
         ozVOBOOJwJ49Cjll9RbT1bVo7/msUEp8yWX4g=
Received: by 10.114.157.1 with SMTP id f1mr5308573wae.43.1243620081128;
        Fri, 29 May 2009 11:01:21 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id l37sm2519303waf.5.2009.05.29.11.01.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:20 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120304>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 08/12] Use the new http API in update_remote_info_refs()
Date:	Sun, 18 Jan 2009 09:04:33 +0100

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
