From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 11/18] transport: use the new http API in
 get_refs_via_curl()
Date: Sun, 24 May 2009 22:19:55 +0800
Message-ID: <20090524221955.2969ab4f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eaq-0005ol-2m
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZEXOWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbZEXOWL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:22:11 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZEXOWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:22:09 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=rinZg3Whb57KcOjG3614uf8R9z+QWrncTp5Hl959IOs=;
        b=dWBUiFuYKcxYeznkHcFx6P6mASGq/Fp5wo7kKwFWpiH56iftO/J9/xNNMEOiXQUd7r
         tohjjqAweVHi0ZHfyENsofzFdRzq32OjmIvAmmg/lYQJ9htllafeCjUPSTB7qYrS3rwZ
         oMgAEG++Ev2mpKn0g+DBLPMZsXMW6EyJj6xjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=e1M4mpanlM3lhnT5g0tyYcG/xbXbUeuTKeh866CQgQ2iMFXlEsrwYDOY05an2dtwmU
         OO+vtylCUKR1zM0QV0e2DxLSV2krNGz8Op/5z9V41FjGv7HX8wyO7sYS2fmu8UhjWHPn
         CSc7S9UzAIAOvGRisFgWitkS71I+JJ5hN6kRI=
Received: by 10.114.26.18 with SMTP id 18mr12385741waz.159.1243174931701;
        Sun, 24 May 2009 07:22:11 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id k37sm12523344waf.42.2009.05.24.07.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:22:11 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119827>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/transport.c b/transport.c
index b7c1c39..ab817f0 100644
--- a/transport.c
+++ b/transport.c
@@ -439,9 +439,7 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 	char *ref_name;
 	char *refs_url;
 	int i = 0;
-
-	struct active_request_slot *slot;
-	struct slot_results results;
+	int http_ret;

 	struct ref *refs = NULL;
 	struct ref *ref = NULL;
@@ -461,25 +459,13 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);

-	slot = get_active_slot();
-	slot->results = &results;
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-
-	if (start_active_slot(slot)) {
-		run_active_slot(slot);
-		if (results.curl_result != CURLE_OK) {
-			strbuf_release(&buffer);
-			if (missing_target(&results))
-				die("%s not found: did you run git update-server-info on the server?", refs_url);
-			else
-				die("%s download error - %s", refs_url, curl_errorstr);
-		}
-	} else {
-		strbuf_release(&buffer);
-		die("Unable to start HTTP request");
+	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	if (http_ret == HTTP_MISSING_TARGET)
+		die("%s not found: did you run git update-server-info on the"
+		    " server?", refs_url);
+	else if (http_ret != HTTP_OK) {
+		http_error(refs_url, http_ret);
+		goto cleanup;
 	}

 	data = buffer.buf;
@@ -519,6 +505,8 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+cleanup:
+	strbuf_release(&buffer);
 	free(refs_url);
 	return refs;
 }
--
1.6.3.1
