From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 16/23] transport.c::get_refs_via_curl(): use the new http
 API
Date: Sat, 6 Jun 2009 00:05:54 +0800
Message-ID: <20090606000554.4e715167.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzJ-00053w-Le
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbZFEQJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755778AbZFEQJJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:09:09 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbZFEQJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:09:08 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=PZNDf4uV2PSn+p87IvAcDg7vZmSsfbTy6ri+b9OOi/M=;
        b=VBsXr1IriTM/u0RcclJX+Jtq3ZmzfqlG4PcJ9JcILTltYW0Dd7m4O0djCyuLrw04+A
         vxuH3J3UHgdVk3vn8iEpXBh2EzgRdWmn8cqpSZVbKUkJRqF/DSxexDjgHUYe/TDGw/x8
         23pDfVqKfaRv1Qjp7DEMGqyDcEu4LQDjK/k2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=c7vofgFAojsSB+9NpbWBQkVBpzsLEn4vu71h+r6Csp+EfWui8Gu2RiViyLeoIzgzsc
         0cs36nNdOm0JHHaBFKxzpqyK+IhLr0kEAUNVhxyzJKhhHSyP2IbLOeZLKPB3RfspMxPb
         t6tU3Ybf7zoDKd8bki8zChe+13EtItgDrBMfk=
Received: by 10.142.51.1 with SMTP id y1mr1443996wfy.92.1244218150547;
        Fri, 05 Jun 2009 09:09:10 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm415398wfd.21.2009.06.05.09.09.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:09:10 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120798>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 05/12] Use the new http API in get_refs_via_curl()
Date:	Sun, 18 Jan 2009 09:04:30 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/transport.c b/transport.c
index 9edd5aa..1195121 100644
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
