From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Wed, 04 Nov 2015 11:53:46 -0800
Message-ID: <xmqqd1vpa6d1.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-3-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:53:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu486-0001yQ-NL
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbbKDTxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:53:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964811AbbKDTxx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:53:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02F6227BA5;
	Wed,  4 Nov 2015 14:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6pEvPH4DEED/mZvFYYUMgoiBlA=; b=RbQDkI
	M2Wflcs3y3d17u8gp6VCb3p8KQaFNlOUboWPueZv67m4CDIN2FJIGlBReLnvzJ7T
	eGuzD2h5CKmEZrAkxj/OYroFCpl4h5VAA/tstx07mbKVkSRV78AWWe4PKAshi0W6
	bKT6LvM7pBBLcg1rvzuIoAAG5FjftGO/kFUUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OA4REk8xXuCoLYyBiYuTiNL/Ss8E4lIJ
	neBruId1gRKmBIf1j7Hzc4+QcmR02upYTtXYq6XRxKBxA3D3poBoct0LQPZLC/60
	7akWk8Stfb9EC+3AoSIdnmCPF8j+UeBszvG8+zIEdFbPq6JATVoeh/7zPuaKel2u
	Pui8BLAqrMU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF37927BA4;
	Wed,  4 Nov 2015 14:53:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7798827BA3;
	Wed,  4 Nov 2015 14:53:47 -0500 (EST)
In-Reply-To: <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Wed, 4 Nov 2015 10:13:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C31F850A-832D-11E5-91D2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280872>

Knut Franke <k.franke@science-computing.de> writes:

> @@ -337,6 +342,24 @@ static void var_override(const char **var, char *value)
>  
>  static void init_curl_proxy_auth(CURL *result)
>  {
> +	if (proxy_auth.username) {
> +		struct strbuf s = STRBUF_INIT;

Having this variable triggers compilation error with newer libcurl
version as it is only used in the #else clause X-<.

> +		if (!proxy_auth.password)
> +			credential_fill(&proxy_auth);
> +#if LIBCURL_VERSION_NUM >= 0x071301
> +		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
> +			proxy_auth.username);
> +		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
> +			proxy_auth.password);
> +#else
> +		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
> +		strbuf_addch(&s, ':');
> +		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
> +		curl_proxyuserpwd = strbuf_detach(&s, NULL);
> +		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
> +#endif
> +	}

It is probably easier to follow the flow of the logic of the primary
interface (i.e. init_curl_proxy_auth()) if you split this part into
its own helper function that deals with implementation detail, e.g.

 http.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 1f269b0..fad2ba5 100644
--- a/http.c
+++ b/http.c
@@ -340,24 +340,30 @@ static void var_override(const char **var, char *value)
 	}
 }
 
-static void init_curl_proxy_auth(CURL *result)
+static void set_proxyauth_name_password(CURL *result)
 {
-	if (proxy_auth.username) {
-		struct strbuf s = STRBUF_INIT;
-		if (!proxy_auth.password)
-			credential_fill(&proxy_auth);
 #if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
 #else
+		struct strbuf s = STRBUF_INIT;
+
 		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
 		strbuf_addch(&s, ':');
 		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
 		curl_proxyuserpwd = strbuf_detach(&s, NULL);
 		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
 #endif
+}
+
+static void init_curl_proxy_auth(CURL *result)
+{
+	if (proxy_auth.username) {
+		if (!proxy_auth.password)
+			credential_fill(&proxy_auth);
+		set_proxyauth_name_password(result);
 	}
 
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
