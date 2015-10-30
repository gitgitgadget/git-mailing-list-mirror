From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Fri, 30 Oct 2015 12:19:52 -0700
Message-ID: <xmqqd1vwkvtz.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-1-git-send-email-k.franke@science-computing.de>
	<1446025245-10128-2-git-send-email-k.franke@science-computing.de>
	<xmqqsi4vkkcf.fsf@gitster.mtv.corp.google.com>
	<20151030180129.GA6425@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:20:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFDU-0006Up-TP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760648AbbJ3TT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:19:56 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759256AbbJ3TTy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:19:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCF4F25F40;
	Fri, 30 Oct 2015 15:19:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+SrOV3w0t4AgzgKLc0YVsQZ3Q4=; b=pg5Cvu
	TfVLN/DhAqCVibyUgMP5TdNrgrxc2Y01N0TYj2mymlZCr3Ruytvg+nV2nYOK5X9C
	c3b8zB6AmtLV86O0kup53IlEmkmVAukq9uPfPrH8fsRT1w7WkfDvQhd1l2nlexHF
	1ciCl25aVEgZJ8es/5aJrAUF4Etfi17VQ6XNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9PdG/2PaCfBsyRV1GXGgz8x+lx7u07c
	Adcd5AdQillskuTiL3vHMCjy3w1rD5CVpTdrOSa3GG5oAZS4+/pFIE0gxzF8O8Fy
	Yv01PsbR+zl9yxLuh7onc8EICnhtdwL7uybYS7lFX1OughIerPWNj61k0VtHHiTJ
	HkQl0ol93E0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B45F025F3D;
	Fri, 30 Oct 2015 15:19:53 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3953A25F3B;
	Fri, 30 Oct 2015 15:19:53 -0400 (EDT)
In-Reply-To: <20151030180129.GA6425@science-computing.de> (Knut Franke's
	message of "Fri, 30 Oct 2015 19:01:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 328BE8BC-7F3B-11E5-BEC3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280527>

Knut Franke <k.franke@science-computing.de> writes:

> Maybe add a #define LIBCURL_CAN_HANDLE_PROXY_AUTH to clarify this, like we do
> with LIBCURL_CAN_HANDLE_AUTH_ANY?

Quite frankly, my first preference is to have a code that is clear
enough so that you do not need such an intermediate macro.  By
isolating implementation details that have to be version dependent
into a helper function whose purpose is well defined, the rest of
the code can be #ifdef free; it would become sufficiently clear to
switch based on curl version where implementation details matter.

By refraining from littering #ifdef all over the code, we do assign
to disable_gssnegotiate even though the value is not even used when
compiled for ancient version of libCURL, but the benefit of code
clarity outweighs such downside.  We may have to use #ifdef/#endif
in some places, but we should in general minimize their uses and
write code for the more up-to-date API.

For what I mean, see the attached patch outline to show how to get
rid of CAN_HANDLE_AUTH_ANY.

> How about env_override? Not perfect, but probably better.

Much better than anything I'd come up with myself (I am bad at
naming, even though I may sometimes be good at spotting a bad name).


 http.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/http.c b/http.c
index 7da76ed..d272b02 100644
--- a/http.c
+++ b/http.c
@@ -15,10 +15,6 @@ int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
 
-#if LIBCURL_VERSION_NUM >= 0x070a06
-#define LIBCURL_CAN_HANDLE_AUTH_ANY
-#endif
-
 static int min_curl_sessions = 1;
 static int curl_session_count;
 #ifdef USE_CURL_MULTI
@@ -79,9 +75,6 @@ static const char *user_agent;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-static unsigned long http_auth_methods = CURLAUTH_ANY;
-#endif
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -90,6 +83,19 @@ static struct active_request_slot *active_queue_head;
 
 static char *cached_accept_language;
 
+static int disable_gssnegotiate;
+
+static void set_httpauth_opt(CURL *curl)
+{
+#if LIBCURL_VERSION_NUM >= 0x070a06  /* Is CURLAUTH_ANY available? */
+	unsigned long auth_methods = CURLAUTH_ANY;
+
+	if (disable_gssnegotiate)
+		auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, auth_methods);
+#endif
+}
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -375,9 +381,7 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
-#endif
+	set_httpauth_opt(result);
 
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
@@ -681,9 +685,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-#endif
+	set_httpauth_opt(slot->curl);
 	if (http_auth.password)
 		init_curl_http_auth(slot->curl);
 
@@ -943,9 +945,7 @@ static int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-#endif
+			disable_gssnegotiate = 1;
 			return HTTP_REAUTH;
 		}
 	} else {
