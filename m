From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 13/17] http-push.c::fetch_symref(): use the new http API
Date: Sat, 30 May 2009 01:59:33 +0800
Message-ID: <20090530015933.030ad46b.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P9-0000Xl-QU
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760145AbZE2SBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760052AbZE2SBX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:23 -0400
Received: from mail-pz0-f109.google.com ([209.85.222.109]:61513 "EHLO
	mail-pz0-f109.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760076AbZE2SBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:22 -0400
Received: by mail-pz0-f109.google.com with SMTP id 7so4912597pzk.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=eMpsLu5PT9RCewBwLaglhhLGH14QIALosgi2J3ag848=;
        b=NgEuqlmVRdMuKczgsmiXAIDjaW7fjmZstk9LBsGvjTu2t/z5DVU4xuAdPxJlnNDTaO
         YVVhyhfM1LKkaKqAPZZJHaT4LVqwZpKCsQhZrJyekttGcCWUr1nrE/443hF7JLfuxa9C
         /lmfU6ghPNaWZm60kVWFRv2kwcYSAgOLyXK/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=QUQyg+GUfOEplhSpz6vt6ej37KCwluDSu1CbWAVDSkP8zDNZeov8t5ug2x7ECC84Up
         /TUw7jCz/8A55/XCGVo6rfIb5VLpr9duffVNiezv2rFtIykD7spxCHOZ1G7srKjtQ5cv
         Vy5zNvI1DkX3Vx421Jxk1282ZzkCT3Hl0DmIA=
Received: by 10.115.48.12 with SMTP id a12mr4465306wak.161.1243620084947;
        Fri, 29 May 2009 11:01:24 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id m31sm2497251wag.31.2009.05.29.11.01.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:24 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()
Date:	Sun, 18 Jan 2009 09:04:34 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b20cec..7aa4fc4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2024,27 +2024,13 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
-	struct active_request_slot *slot;
-	struct slot_results results;

 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);

-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			die("Couldn't get %s for remote symref\n%s",
-			    url, curl_errorstr);
-		}
-	} else {
-		die("Unable to start remote symref request");
-	}
+	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK)
+		die("Couldn't get %s for remote symref\n%s", url,
+		    curl_errorstr);
 	free(url);

 	free(*symref);
--
1.6.3.1
