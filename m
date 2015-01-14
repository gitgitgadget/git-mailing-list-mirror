From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/10] http.c: make finish_active_slot() and handle_curl_result() static
Date: Wed, 14 Jan 2015 15:40:46 -0800
Message-ID: <1421278855-8126-2-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYm-0002cw-H6
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbANXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751477AbbANXk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:40:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D440C2DB7B;
	Wed, 14 Jan 2015 18:40:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5L/u
	Y7a9771OaM+MP2y6rpB7Q3c=; b=L1iqi9hAZjI0pIadc/JJlmri7x4T8nmF/wHT
	kdW/cKptszudsI1tfqENA08u05EsTs/gilpmkrbd7fJqOlH8362SGoVb0rh5S9t8
	8yXyeeNwzLCzxpSCzHWrdxEzrrcIhXXo5T9I9AWoIeHWJnQNmLshkZzkUyHCQGUD
	OXzcOFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LTmghY
	+LjGm2gHjDFAqyy//okFby7ehBQKYbwr9FRQbIIdS87YVuuGu/VbC1TODG7Rg38q
	8Q8SxjVxVY8Uw7+iX3PWgZZswp75ks5pcJmnHB+ZoZ/6/BbTGOCy7CE1+5peXl04
	iQVsFuZWia0FZ8ShuuekUcyuHMmAeoJkMisaM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA4562DB7A;
	Wed, 14 Jan 2015 18:40:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DCD02DB77;
	Wed, 14 Jan 2015 18:40:58 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CA3D9364-9C46-11E4-8B0D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262440>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 http.h |  2 --
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/http.c b/http.c
index 040f362..16a6a2d 100644
--- a/http.c
+++ b/http.c
@@ -114,6 +114,37 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 	return eltsize * nmemb;
 }
 
+static void closedown_active_slot(struct active_request_slot *slot)
+{
+	active_requests--;
+	slot->in_use = 0;
+}
+
+static void finish_active_slot(struct active_request_slot *slot)
+{
+	closedown_active_slot(slot);
+	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
+
+	if (slot->finished != NULL)
+		(*slot->finished) = 1;
+
+	/* Store slot results so they can be read after the slot is reused */
+	if (slot->results != NULL) {
+		slot->results->curl_result = slot->curl_result;
+		slot->results->http_code = slot->http_code;
+#if LIBCURL_VERSION_NUM >= 0x070a08
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
+				  &slot->results->auth_avail);
+#else
+		slot->results->auth_avail = 0;
+#endif
+	}
+
+	/* Run callback if appropriate */
+	if (slot->callback_func != NULL)
+		slot->callback_func(slot->callback_data);
+}
+
 #ifdef USE_CURL_MULTI
 static void process_curl_messages(void)
 {
@@ -730,12 +761,6 @@ void run_active_slot(struct active_request_slot *slot)
 #endif
 }
 
-static void closedown_active_slot(struct active_request_slot *slot)
-{
-	active_requests--;
-	slot->in_use = 0;
-}
-
 static void release_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
@@ -752,31 +777,6 @@ static void release_active_slot(struct active_request_slot *slot)
 #endif
 }
 
-void finish_active_slot(struct active_request_slot *slot)
-{
-	closedown_active_slot(slot);
-	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
-
-	if (slot->finished != NULL)
-		(*slot->finished) = 1;
-
-	/* Store slot results so they can be read after the slot is reused */
-	if (slot->results != NULL) {
-		slot->results->curl_result = slot->curl_result;
-		slot->results->http_code = slot->http_code;
-#if LIBCURL_VERSION_NUM >= 0x070a08
-		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
-				  &slot->results->auth_avail);
-#else
-		slot->results->auth_avail = 0;
-#endif
-	}
-
-	/* Run callback if appropriate */
-	if (slot->callback_func != NULL)
-		slot->callback_func(slot->callback_data);
-}
-
 void finish_all_active_slots(void)
 {
 	struct active_request_slot *slot = active_queue_head;
@@ -839,7 +839,7 @@ char *get_remote_object_url(const char *url, const char *hex,
 	return strbuf_detach(&buf, NULL);
 }
 
-int handle_curl_result(struct slot_results *results)
+static int handle_curl_result(struct slot_results *results)
 {
 	/*
 	 * If we see a failing http code with CURLE_OK, we have turned off
diff --git a/http.h b/http.h
index 473179b..49afe39 100644
--- a/http.h
+++ b/http.h
@@ -85,9 +85,7 @@ extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 extern struct active_request_slot *get_active_slot(void);
 extern int start_active_slot(struct active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
-extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
-extern int handle_curl_result(struct slot_results *results);
 
 /*
  * This will run one slot to completion in a blocking manner, similar to how
-- 
2.3.0-rc0-134-g109a908
