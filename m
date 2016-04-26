From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 10:20:19 -0700
Message-ID: <xmqq4maoi8x8.fsf@gitster.mtv.corp.google.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
	<921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
	<xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com>
	<20160426171238.GA7609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6fB-00020N-BX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbcDZRUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:20:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751999AbcDZRUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:20:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A192C152EF;
	Tue, 26 Apr 2016 13:20:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OEDLQqV2K9S8FX4NxM0mjozcQA0=; b=p6K0yS
	P11OColRT/m+QmMBedhcB6ux0UJIuUOGhSMciA6vGKrMIkecbbipiOzMLSKN2N8U
	4HiS2hf+3s+2yDrBsfNfNVXk7sHYy29Fo3rZtC64FXKjjFbtLPs+vcQPPqbNa8MF
	D0bCjYUbJe6doPJ7YOBLiJDMVEJ+BWPIjnvg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L05AFFaRAQQ6acQrIymAfnvpLwSo3AzN
	2IOWOU0T9WC+zx5OcYJnGpuzvA8CPSK/RbqGbEH+Sz3MFACWX4/Gvsev2c36jGD7
	MBLyaOLfIws5NWtvis9Ddw6i++6wnkoAWLKQNCPaMmeXOMZYp+pT4NNDsCXJdCnt
	QOeexw8420M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99079152EE;
	Tue, 26 Apr 2016 13:20:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6FFD152ED;
	Tue, 26 Apr 2016 13:20:20 -0400 (EDT)
In-Reply-To: <20160426171238.GA7609@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Apr 2016 13:12:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2778ADF0-0BD3-11E6-80A8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292621>

Jeff King <peff@peff.net> writes:

> But I think this block (even before my patch) also needs to handle the
> case where "value" is NULL (presumably by complaining with
> config_error_nonbool).

OK, so squashes found to be necessary so far amounts to the attached
patch.  I still haven't figured out the best way to rephrase the "by
default" in the proposed log message that made me stutter while
reading it, though.


 http.c | 13 ++++++++++---
 http.h |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 6c4d2ed..aae9944 100644
--- a/http.c
+++ b/http.c
@@ -325,8 +325,15 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.extraheader", var)) {
-		extra_http_headers =
-			curl_slist_append(extra_http_headers, value);
+		if (!value) {
+			return config_error_nonbool(var);
+		} else if (!*value) {
+			curl_slist_free_all(extra_http_headers);
+			extra_http_headers = NULL;
+		} else {
+			extra_http_headers =
+				curl_slist_append(extra_http_headers, value);
+		}
 		return 0;
 	}
 
@@ -1172,7 +1179,7 @@ int run_one_slot(struct active_request_slot *slot,
 	return handle_curl_result(results);
 }
 
-struct curl_slist *http_copy_default_headers()
+struct curl_slist *http_copy_default_headers(void)
 {
 	struct curl_slist *headers = NULL, *h;
 
diff --git a/http.h b/http.h
index 5f13695..36f558b 100644
--- a/http.h
+++ b/http.h
@@ -106,7 +106,7 @@ extern void step_active_slots(void);
 extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
 extern void http_cleanup(void);
-extern struct curl_slist *http_copy_default_headers();
+extern struct curl_slist *http_copy_default_headers(void);
 
 extern long int git_curl_ipresolve;
 extern int active_requests;
