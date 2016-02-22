From: Christoph Egger <christoph@christoph-egger.org>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Mon, 22 Feb 2016 16:41:55 +0100
Organization: Privat
Message-ID: <8760xg7nwc.fsf@mitoraj.siccegge.de>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
	<20160215140422.GA1747@mitoraj.siccegge.de>
	<xmqqlh6jhwu0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:42:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXsck-00007C-VI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 16:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbcBVPmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 10:42:06 -0500
Received: from chadwick.siccegge.de ([185.44.107.74]:60798 "EHLO
	chadwick.siccegge.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbcBVPmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 10:42:04 -0500
Received: by chadwick.siccegge.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86 (FreeBSD))
	(envelope-from <christoph@christoph-egger.org>)
	id 1aXscT-000DDY-NA; Mon, 22 Feb 2016 15:41:55 +0000
In-Reply-To: <xmqqlh6jhwu0.fsf@gitster.mtv.corp.google.com>
	(sfid-20160217_220456_742065_2DA8214B) (Junio C. Hamano's message of "Wed,
	17 Feb 2016 13:05:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/kfreebsd)
X-SA-Exim-Connect-IP: 131.188.6.21
X-SA-Exim-Mail-From: christoph@christoph-egger.org
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on chadwick.siccegge.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS
	autolearn=unavailable autolearn_force=no version=3.4.1
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on chadwick.siccegge.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286931>

--=-=-=
Content-Type: text/plain

Hi!

Junio C Hamano <gitster@pobox.com> writes:
> Christoph Egger <christoph@christoph-egger.org> writes:
>
>> Add the http.pinnedpubkey configuration option for public key
>> pinning. It allows any string supported by libcurl --
>> base64(sha256(pubkey)) or filename of the full public key.
>>
>> If cURL does not support pinning (is too old) output a warning to the
>> user.
>>
>> Signed-off-by: Christoph Egger <christoph@christoph-egger.org>
>> ---
>
> I needed this fix to unbreak it for those with older versions of
> cURL.

Jep sorry about that. should have run a second test with old libcurl.
I've attached a consolidated patch.

  Christoph


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Implement-https-public-key-pinning.patch

>From be8112d695de534629bcb3411634d101a74021a7 Mon Sep 17 00:00:00 2001
From: Christoph Egger <christoph@christoph-egger.org>
Date: Thu, 11 Feb 2016 23:28:20 +0100
Subject: [PATCH] Implement https public key pinning

Add the http.pinnedpubkey configuration option for public key
pinning. It allows any string supported by libcurl --
base64(sha256(pubkey)) or filename of the full public key.

If cURL does not support pinning (is too old) output a warning to the
user.

Signed-off-by: Christoph Egger <christoph@christoph-egger.org>
---
 Documentation/config.txt |  8 ++++++++
 http.c                   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27f02be..0f2643b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1727,6 +1727,14 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
 
+http.pinnedpubkey::
+	Public key of the https service. It may either be the filename of
+	a PEM or DER encoded public key file or a string starting with
+	'sha256//' followed by the base64 encoded sha256 hash of the
+	public key. See also libcurl 'CURLOPT_PINNEDPUBLICKEY'. git will
+	exit with an error if this option is set but not supported by
+	cURL.
+
 http.sslTry::
 	Attempt to use AUTH SSL/TLS and encrypted data transfers
 	when connecting via regular FTP protocol. This might be needed
diff --git a/http.c b/http.c
index dfc53c1..1c295dd 100644
--- a/http.c
+++ b/http.c
@@ -57,6 +57,9 @@ static const char *ssl_key;
 #if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+static const char *ssl_pinnedkey;
+#endif
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -299,6 +302,15 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
+	if (!strcmp("http.pinnedpubkey", var)) {
+#if LIBCURL_VERSION_NUM >= 0x072c00
+		return git_config_pathname(&ssl_pinnedkey, var, value);
+#else
+		warning(_("Public key pinning not supported with cURL < 7.44.0"));
+		return 0;
+#endif
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -499,6 +511,10 @@ static CURL *get_curl_handle(void)
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+	if (ssl_pinnedkey != NULL)
+		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
+#endif
 	if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
-- 
2.7.0


--=-=-=
Content-Type: text/plain


>  http.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/http.c b/http.c
> index a6b8076..3475040 100644
> --- a/http.c
> +++ b/http.c
> @@ -219,13 +219,6 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.sslcapath", var))
>  		return git_config_pathname(&ssl_capath, var, value);
>  #endif
> -	if (!strcmp("http.pinnedpubkey", var))
> -#if LIBCURL_VERSION_NUM >= 0x072c00
> -		return git_config_pathname(&ssl_pinnedkey, var, value);
> -#else
> -		warning(_("Public key pinning not supported with cURL < 7.44.0"));
> -		return 0;
> -#endif
>  	if (!strcmp("http.sslcainfo", var))
>  		return git_config_pathname(&ssl_cainfo, var, value);
>  	if (!strcmp("http.sslcertpasswordprotected", var)) {
> @@ -283,6 +276,14 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.useragent", var))
>  		return git_config_string(&user_agent, var, value);
>  
> +	if (!strcmp("http.pinnedpubkey", var)) {
> +#if LIBCURL_VERSION_NUM >= 0x072c00
> +		return git_config_pathname(&ssl_pinnedkey, var, value);
> +#else
> +		warning(_("Public key pinning not supported with cURL < 7.44.0"));
> +		return 0;
> +#endif
> +	}
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }

-- 

--=-=-=--
