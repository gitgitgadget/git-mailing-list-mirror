From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 16/23] transport.c::get_refs_via_curl(): use the new http
 API
Date: Sat, 6 Jun 2009 16:43:54 +0800
Message-ID: <20090606164354.82d6073b.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrcI-0004Mp-FB
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbZFFIuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbZFFIuR
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:50:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:48030 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbZFFIuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:50:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so823200rvb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QfX86zwtlBfg4KYCdixulnKYfpaflQBtPEBEUpbY5U8=;
        b=N8NzkMMvH1SDuvSMPZprUDSnDrmnCpPxxAbD0Me9lIBvX1NfqnX/Nnu5OxuaYWCOcV
         DyjLqbFRHFGDWi2tB7BswjfthciIsDlxSUibX2nJPWkov2Vn0tBOBmCHHIL1FQqs0eMD
         LSCC+J+pl+oNC1oC6aXHy9Ps68aUa8oCntZf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=oUzN6FXQQYEWckW0Yj1p2ep4SAIMFaFqLOEv3iOFq2A1UG662rfHC/xVaE+DsvFj2O
         8vlKifO4pgioPjTDwlLoY6O/sq21zOkJvUykjXca1T+mpu4ldR7QFxtY28kF4OBms0Zy
         nxL7r6LorXuGB7pqcYG5bArtE0H71yb/TOh5U=
Received: by 10.142.125.4 with SMTP id x4mr1674231wfc.75.1244278218148;
        Sat, 06 Jun 2009 01:50:18 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 32sm2742002wfc.14.2009.06.06.01.50.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:50:17 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120898>

From:	Mike Hommey <mh@glandium.org>

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This is based on Mike's earlier patch:

Subject: [WIP Patch 05/12] Use the new http API in get_refs_via_curl()
Date:	Sun, 18 Jan 2009 09:04:30 +0100

I added back the die()'s like in the original, which Mike had removed.

 transport.c |   35 +++++++++++++----------------------
 1 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/transport.c b/transport.c
index 9edd5aa..af75f7b 100644
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
@@ -461,25 +459,16 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
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
+	switch (http_ret) {
+	case HTTP_OK:
+		break;
+	case HTTP_MISSING_TARGET:
+		die("%s not found: did you run git update-server-info on the"
+		    " server?", refs_url);
+	default:
+		http_error(refs_url, http_ret);
+		die("HTTP request failed");
 	}

 	data = buffer.buf;
@@ -519,6 +508,8 @@ static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 		free(ref);
 	}

+cleanup:
+	strbuf_release(&buffer);
 	free(refs_url);
 	return refs;
 }
--
1.6.3.1
