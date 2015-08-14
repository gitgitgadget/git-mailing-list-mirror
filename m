From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] http: add support for specifying the SSL version
Date: Fri, 14 Aug 2015 14:32:09 -0700
Message-ID: <xmqqfv3lh7za.fsf@gitster.dls.corp.google.com>
References: <1439581063-29771-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMaH-0006X3-0c
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbbHNVcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:32:12 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34517 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbbHNVcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:32:11 -0400
Received: by pdbfa8 with SMTP id fa8so34856881pdb.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sdgDwVbMBhE4huuVwbFDywALuyIY+JBNoPLJ+0qurGY=;
        b=nNmjY4IaWS3AAajlPF3fYRGe31OmfTmTEkDVDHKEn+FqaetmQ2o+oGVy0X76J3lTWR
         O6V05cMCi37LKhX9K7RzepS/bZWJ+NMocoYP7khzbjWc5xZLGpIbQ0M33owsjbPpeCnH
         Rd1yEdXM+XqJdyzLTVqcMUagjW4jP+Eq3N8RO58Hb5tOJ0npb/yx7OmV+8YGeAGTco6r
         vHC67wbJLInLTqirmxJoDPtrXeF9LvwfweyJhpqxiWXrjv3l8cZsaGaooz3aeU4ixSFi
         uWtpqasM+rL3jnnhFtJf3OHThGGMWESRqnnSOsc6uz4o2nBrB37CGdU8o9nLs0J4/4I7
         YZWg==
X-Received: by 10.70.90.98 with SMTP id bv2mr77394748pdb.36.1439587930581;
        Fri, 14 Aug 2015 14:32:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id bf14sm7080280pdb.28.2015.08.14.14.32.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 14:32:09 -0700 (PDT)
In-Reply-To: <1439581063-29771-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 14 Aug 2015 21:37:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275962>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Teach git about a new option, "http.sslVersion", which permits one to
> specify the SSL version  to use when negotiating SSL connections.  The
> setting can be overridden by the GIT_SSL_VERSION environment
> variable.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the fifth version of the patch. Changes from the previous version:
>
> - Minor style changes (Eric)

Thanks.

I'd probably credit Eric with Helped-by: there if I were you ;-)

> diff --git a/http.c b/http.c
> index e9c6fdd..4c5a2e0 100644
> --- a/http.c
> +++ b/http.c
> @@ -37,6 +37,20 @@ static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
>  static const char *ssl_cipherlist;
> +static const char *ssl_version;
> +static struct {
> +	const char *name;
> +	long ssl_version;
> +	} sslversions[] = {
> +		{ "sslv2", CURL_SSLVERSION_SSLv2 },
> +		{ "sslv3", CURL_SSLVERSION_TLSv1 },
> +		{ "tlsv1", CURL_SSLVERSION_TLSv1 },
> +#if LIBCURL_VERSION_NUM >= 0x072200
> +		{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
> +		{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
> +		{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 }
> +#endif
> +};

The indentation of the above is somewhat screwed up.  Also even
though it is clear that you accept a comma after the last item in an
array initialization (i.e. when compiled for an older libCurl, the
last entry in the array is for tlsv1 which ends with a comma), for
newer libCurl, the last entry does not end with a comma, which is
(1) inconsistent, and (2) makes it harder to add more entries at the
end of the array in the future.

Here is with a slight edit that I'll queue for now.

Thanks.

-- >8 --
From: Elia Pinto <gitter.spiros@gmail.com>
Date: Fri, 14 Aug 2015 21:37:43 +0200
Subject: [PATCH] http: add support for specifying the SSL version

Teach git about a new option, "http.sslVersion", which permits one
to specify the SSL version to use when negotiating SSL connections.
The setting can be overridden by the GIT_SSL_VERSION environment
variable.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt               | 23 +++++++++++++++++++++++
 contrib/completion/git-completion.bash |  1 +
 http.c                                 | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43bb53c..8d334c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1576,6 +1576,29 @@ http.saveCookies::
 	If set, store cookies received during requests to the file specified by
 	http.cookieFile. Has no effect if http.cookieFile is unset.
 
+http.sslVersion::
+	The SSL version to use when negotiating an SSL connection, if you
+	want to force the default.  The available and default version
+	depend on whether libcurl was built against NSS or OpenSSL and the
+	particular configuration of the crypto library in use. Internally
+	this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
+	documentation for more details on the format of this option and
+	for the ssl version supported. Actually the possible values of
+	this option are:
+
+	- sslv2
+	- sslv3
+	- tlsv1
+	- tlsv1.0
+	- tlsv1.1
+	- tlsv1.2
+
++
+Can be overridden by the 'GIT_SSL_VERSION' environment variable.
+To force git to use libcurl's default ssl version and ignore any
+explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
+empty string.
+
 http.sslCipherList::
   A list of SSL ciphers to use when negotiating an SSL connection.
   The available ciphers depend on whether libcurl was built against
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c97c648..6e9359c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2118,6 +2118,7 @@ _git_config ()
 		http.postBuffer
 		http.proxy
 		http.sslCipherList
+		http.sslVersion
 		http.sslCAInfo
 		http.sslCAPath
 		http.sslCert
diff --git a/http.c b/http.c
index e9c6fdd..ba3cc0e 100644
--- a/http.c
+++ b/http.c
@@ -37,6 +37,20 @@ static int curl_ssl_verify = -1;
 static int curl_ssl_try;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
+static const char *ssl_version;
+static struct {
+	const char *name;
+	long ssl_version;
+} sslversions[] = {
+	{ "sslv2", CURL_SSLVERSION_SSLv2 },
+	{ "sslv3", CURL_SSLVERSION_TLSv1 },
+	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
+#if LIBCURL_VERSION_NUM >= 0x072200
+	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
+	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
+	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
+#endif
+};
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
@@ -190,6 +204,8 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.sslcipherlist", var))
 		return git_config_string(&ssl_cipherlist, var, value);
+	if (!strcmp("http.sslversion", var))
+		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
 #if LIBCURL_VERSION_NUM >= 0x070903
@@ -364,9 +380,24 @@ static CURL *get_curl_handle(void)
 	if (http_proactive_auth)
 		init_curl_http_auth(result);
 
+	if (getenv("GIT_SSL_VERSION"))
+		ssl_version = getenv("GIT_SSL_VERSION");
+	if (ssl_version && *ssl_version) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(sslversions); i++) {
+			if (!strcmp(ssl_version, sslversions[i].name)) {
+				curl_easy_setopt(result, CURLOPT_SSLVERSION,
+						 sslversions[i].ssl_version);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(sslversions))
+			warning("unsupported ssl version %s: using default",
+				ssl_version);
+	}
+
 	if (getenv("GIT_SSL_CIPHER_LIST"))
 		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
-
 	if (ssl_cipherlist != NULL && *ssl_cipherlist)
 		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
 				ssl_cipherlist);
-- 
2.5.0-487-g2edca40
