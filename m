From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: What's cooking in git.git (Apr 2012, #09; Mon, 23)
Date: Tue, 24 Apr 2012 11:14:52 +0200
Message-ID: <4F966F0C.6090504@seap.minhap.es>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMazT-0007wY-6c
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab2DXIUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:20:01 -0400
Received: from luthien1.map.es ([82.150.0.102]:29233 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab2DXIUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:20:00 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 64EA024D50;
	Tue, 24 Apr 2012 10:17:34 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 300B9D4D14;
	Tue, 24 Apr 2012 10:17:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 64EA024D50.B2F60
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1335860263.41625@NsXe8mOaevnyNDihKhI8nQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196208>

On 04/24/2012 12:04 AM, Junio C Hamano wrote:
> 
> * nl/http-proxy-more (2012-04-19) 7 commits
>  - http: fix proxy password passing
>  - http: fix proxy authentication
>  - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
>  - http: Avoid limit of retrying request only twice
>  - http: handle proxy authentication failure (error 407)
>  - http: handle proxy proactive authentication
>  - http: try http_proxy env var when http.proxy config option is not set
> 

I'm a bit lost with the state of this, I read your last discussion and
you sent patches to support a proxy url without the protocol part, I assume
that's done and apart from that there is a bug in the LIBCURL_VERSION which
is an easy fix I could send a patch for.

> The code to talk to http proxies learn to use the same credential
> API used to talk to the final http destinations.  This still needs
> to peek into $ENV{HTTPS_PROXY}.

My original patch already peeked in HTTPS_PROXY env var, I post the
relevant part:
 
+	if (!curl_http_proxy) {
+		const char *env_proxy, *no_proxy;
+		char *env_proxy_var;
+		int read_http_proxy;
+		struct strbuf buf = STRBUF_INIT;
+		credential_from_url(&cre_url, url);
+		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
+		env_proxy_var = strbuf_detach(&buf, NULL);
+		env_proxy = getenv(env_proxy_var);

                ^^ HERE ^^

+		if (env_proxy) {
+			read_http_proxy = 1;
+			no_proxy = getenv("no_proxy");
+			if (no_proxy && (!strcmp("*", no_proxy) || strstr(no_proxy, cre_url.host)))
+				read_http_proxy = 0;
+			
+			if (read_http_proxy)
+				curl_http_proxy = xstrdup(env_proxy);
+		}
+		free(env_proxy_var);
+	}
 	if (curl_http_proxy) {

so are you referring to something else ?
