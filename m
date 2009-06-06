From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 18/23] http-push.c::remote_exists(): use the new http API
Date: Sat, 6 Jun 2009 16:43:57 +0800
Message-ID: <20090606164357.1212eb1d.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcJ-0004Mp-SB
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZFFIu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZFFIu0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:26 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34239 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbZFFIuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:23 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305746pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=L3DQzmzif7uTZULdGZMdBfHRS2DRKK7bare7pIlEvno=;
        b=d2hVNMTEToBHkNys6N6B/pBT6g33gK2SdpOMmHJP2z8BRuhSJewqmsdP11kc7nnxqQ
         vWi+88p0pVbszNRe0o6LCWxOR/JA7VVRu4+ycma973qn1c0EOkHkh5GnPceFGNdjdwFU
         5EercpQY8WoVOHNEEV7oq7HGJo8nJHFSqA7f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=fx2qb+MZMgK1kD47wnfk5EiRlLiiyrNOXjZO6UOZy2ypprlQsvhi9iQ35bjCzMxYYc
         Ii6h+mmuKSr+2AisK7jQd1K5O6nkNJsEm+y/QORjYcI4c0UJxGiIcH6lZGMPE9OGGMUg
         8ZcDk+InXb6O00OaKI9mZ8Vw1fPoiwoMoy2ss=
Received: by 10.142.76.4 with SMTP id y4mr1603588wfa.172.1244278226363;
        Sat, 06 Jun 2009 01:50:26 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 9sm2790356wfc.16.2009.06.06.01.50.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:25 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120900>

From:	Mike Hommey <mh@glandium.org>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is based on Mike's earlier patch:

Subject: [WIP Patch 08/12] Use the new http API in update_remote_info_refs()
Date:	Sun, 18 Jan 2009 09:04:33 +0100

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
