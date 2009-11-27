From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/2] http: maintain curl sessions
Date: Fri, 27 Nov 2009 23:42:26 +0800
Message-ID: <20091127234226.8b158336.rctay89@gmail.com>
References: <20091127234110.7b7e9993.rctay89@gmail.com>,
 <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>,
 <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>,
 <1254510286-23155-1-git-send-email-nmiell@gmail.com>,
 <25718488.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 16:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2xz-0000rb-9H
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbZK0Pm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZK0Pm2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:42:28 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:37942 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZK0Pm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 10:42:27 -0500
Received: by yxe26 with SMTP id 26so1394204yxe.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=a8ZVzSN8wu/iCdFpxrk0aGr+XJYLcrVLDQ3MZCy+y3Q=;
        b=EyDM/b3K2FbSuCZjmaWaE/ljgccyBG+adiKLkhj0wnun1C3bo9PA0dOaeDDhKtTnkL
         hPOJIX9NWx9NdLPLibjP5cgxFRZOjpTsLaCbZ0fY44xR5/lokmrrG3d7FKPuEaB1rnTh
         ch58irlmxgKray1csU7HxEB1z+lxV7oZTbsX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ORdpQd0J33Om9SvYAb55lnvVr02JDsRoLrSFiVNIcTHsaAI9tI8F4VAqr3exZNsLZP
         Jtiv2S7qEOhm9kl6DCwQuxRYC2nglHfEWV6tKEkuepUNvalykzMjs9q/4/ddOCJvHkk0
         JplorldqE6lWz4Mz1QiKCkzP7sNdTmCDlIz4c=
Received: by 10.151.95.25 with SMTP id x25mr1976732ybl.33.1259336551750;
        Fri, 27 Nov 2009 07:42:31 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 23sm639509ywh.33.2009.11.27.07.42.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 07:42:31 -0800 (PST)
In-Reply-To: <20091127234110.7b7e9993.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133904>

Allow curl sessions to be kept alive (ie. not ended with
curl_easy_cleanup()) even after the request is completed, the number of
which is determined by the configuration setting http.minSessions.

Add a count for curl sessions, and update it, across slots, when
starting and ending curl sessions.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/config.txt |    6 ++++++
 http.c                   |   19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a8e0876..b77d66d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1132,6 +1132,12 @@ http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
 	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.

+http.minSessions::
+	The number of curl sessions (counted across slots) to be kept across
+	requests. They will not be ended with curl_easy_cleanup() until
+	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
+	value will be capped at 1. Defaults to 1.
+
 http.postBuffer::
 	Maximum size in bytes of the buffer used by smart HTTP
 	transports when POSTing data to the remote system.
diff --git a/http.c b/http.c
index ed6414a..fb0a97b 100644
--- a/http.c
+++ b/http.c
@@ -7,6 +7,8 @@ int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;

+static int min_curl_sessions = 1;
+static int curl_session_count;
 #ifdef USE_CURL_MULTI
 static int max_requests = -1;
 static CURLM *curlm;
@@ -152,6 +154,14 @@ static int http_options(const char *var, const char *value, void *cb)
 			ssl_cert_password_required = 1;
 		return 0;
 	}
+	if (!strcmp("http.minsessions", var)) {
+		min_curl_sessions = git_config_int(var, value);
+#ifndef USE_CURL_MULTI
+		if (min_curl_sessions > 1)
+			min_curl_sessions = 1;
+#endif
+		return 0;
+	}
 #ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
 		max_requests = git_config_int(var, value);
@@ -372,6 +382,7 @@ void http_init(struct remote *remote)
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;

+	curl_session_count = 0;
 #ifdef USE_CURL_MULTI
 	if (max_requests < 1)
 		max_requests = DEFAULT_MAX_REQUESTS;
@@ -480,6 +491,7 @@ struct active_request_slot *get_active_slot(void)
 #else
 		slot->curl = curl_easy_duphandle(curl_default);
 #endif
+		curl_session_count++;
 	}

 	active_requests++;
@@ -558,9 +570,11 @@ void fill_active_slots(void)
 	}

 	while (slot != NULL) {
-		if (!slot->in_use && slot->curl != NULL) {
+		if (!slot->in_use && slot->curl != NULL
+			&& curl_session_count > min_curl_sessions) {
 			curl_easy_cleanup(slot->curl);
 			slot->curl = NULL;
+			curl_session_count--;
 		}
 		slot = slot->next;
 	}
@@ -633,12 +647,13 @@ static void closedown_active_slot(struct active_request_slot *slot)
 void release_active_slot(struct active_request_slot *slot)
 {
 	closedown_active_slot(slot);
-	if (slot->curl) {
+	if (slot->curl && curl_session_count > min_curl_sessions) {
 #ifdef USE_CURL_MULTI
 		curl_multi_remove_handle(curlm, slot->curl);
 #endif
 		curl_easy_cleanup(slot->curl);
 		slot->curl = NULL;
+		curl_session_count--;
 	}
 #ifdef USE_CURL_MULTI
 	fill_active_slots();
--
1.6.4.4
