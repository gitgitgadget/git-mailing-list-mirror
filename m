From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 10/17] transport.c::get_refs_via_curl(): use the new http
 API
Date: Sat, 30 May 2009 01:59:20 +0800
Message-ID: <20090530015920.8c607da7.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P7-0000Xl-IV
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759771AbZE2SBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759694AbZE2SBM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:01:12 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:53739 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759638AbZE2SBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:01:11 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1678194pxi.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MSJ0uvqTV/EgznfYxhbp4oVI146ebk8LQYvdhIc4Jm4=;
        b=e5tTRSoWtT7TZEW5z20vWJ12ev08z+CNq5t1xjgbi/dpggwnXCEKbntt4nb1WnELsU
         AH5E7ymfIFhQJHU8mbkSxvdcH1u9VzxOxK/k/TzH58fqB+LH+6o6/fdCcvD+DKGCB7M3
         LLzxJK09m+4ju6BX5Q/0QYi8qDXVJugfl4JO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=lLSeB3HgXdZR8iKt9H9dccdJNsMVOVFUhJekXhehATslt+4QgAjZEpBJo7k/m/VvO7
         4QBB36mh0MEoI+U4ITTysLzJUNIyAfL/7guiDIWHe4Ame7AI1oGUt9P5LrySOFBdEJzz
         6e6EGzUWEm9hWm0YrJDE58VF8ewWlCpgK6yVs=
Received: by 10.114.95.1 with SMTP id s1mr4529837wab.20.1243620073242;
        Fri, 29 May 2009 11:01:13 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id l27sm2503580waf.20.2009.05.29.11.01.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:01:12 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120298>

From:	Mike Hommey <mh@glandium.org>
Subject: [WIP Patch 05/12] Use the new http API in get_refs_via_curl()
Date:	Sun, 18 Jan 2009 09:04:30 +0100

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.c |   32 ++++++++++----------------------
 1 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/transport.c b/transport.c
index 0aa57bd..45b8e4c 100644
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
