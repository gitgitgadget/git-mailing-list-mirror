Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701A10F4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242795; cv=none; b=BFMv7FTVlWdsTzKz1z4jhy9xLMuQM6+QQCIMcS57muieYC7zJYdlIbb2FfyU4PD0iBwEdJgoM4ojlRtQ/ntr8k32tRx4/CtdK4G+vz/qKkkLl/X6f56O38y1FBYayExVnOYndr+9i6E3CnhVMZjmM+TnZ270GiuCNhspau7L+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242795; c=relaxed/simple;
	bh=OYUDDWVtX0rJQqZYjpAXqg4Jc5rZmv2VJh935Jl/Ws0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWGX3Juyrtq9qvuBXEePDg8qEmxaFDw86QcKPgoT46IL07bJVqWM6FuUiEN14z+5A8BjkMl/b475fSsV8J9OqXYffVk18AET+i6HrU8CVHjxnPmgIWjwDvK6nRyyU/hlHQVd9dOkre+iklV/TatjkvnDnBzVxd4PJD0DVbuiyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UG6kpjKc; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UG6kpjKc"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5B8895D415;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=OYUDDWVtX0rJQqZYjpAXqg4Jc5rZmv2VJh935Jl/Ws0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=UG6kpjKclQEeFn0b0o/Ya7tUAc2l7UCwUWopBbySNWb5jGxRU/Bv9pB9wp5QZK7QL
	 kJujpZecbycSj+OsYTR9SOUOdzUdy1cn+FAkLjA6sirw9GjLszOv72r7DooXkJe7Ji
	 PPQQEgpXUdsYPqxrSjU2u29btfIrVFuSuKGK4HE/cNJA9s7vA0m3zm4mFPxjghdjIw
	 Vb4doHfk5qjth8MzVWh2B2xe11hpj5WwKFCORfjuEEcy83kAtN2dYWXl4gjELb/gWM
	 Z5UZPYS1Zi5EacnpE+QHyIv/6tDHXM6nH2vMsKO6Ar42KEfjlmKNpGwYdd1s5IsWEb
	 SSaumovlk+UhtTHmAutizpWOpeg1AD/QUTrpqLEyrYZMR1hh4vOVoKbAWVRE8hrL/u
	 DYwOT7akZf4w8hMhYUaMgbc7cTbzYlmasMwc+0fwQCChLp6EMQ/7Ap7GUm33jir1Hi
	 fyEuSpxRIKfIhi/Fq3He7gwAh0q/hCd+9EER/zRbBhQMVN0isNq
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 11/13] t5563: refactor for multi-stage authentication
Date: Sun, 24 Mar 2024 01:12:59 +0000
Message-ID: <20240324011301.1553072-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some HTTP authentication schemes, such as NTLM- and Kerberos-based
options, require more than one round trip to authenticate.  Currently,
these can only be supported in libcurl, since Git does not have support
for this in the credential helper protocol.

However, in a future commit, we'll add support for this functionality
into the credential helper protocol and Git itself. Because we don't
really want to implement either NTLM or Kerberos, both of which are
complex protocols, we'll want to test this using a fake credential
authentication scheme.  In order to do so, update t5563 and its backend
to allow us to accept multiple sets of credentials and respond with
different behavior in each case.

Since we can now provide any number of possible status codes, provide a
non-specific reason phrase so we don't have to generate a more specific
one based on the response.  The reason phrase is mandatory according to
the status-line production in RFC 7230, but clients SHOULD ignore it,
and curl does (except to print it).

Each entry in the authorization and challenge fields contains an ID,
which indicates a corresponding credential and response.  If the
response is a 200 status, then we continue to execute git-http-backend.
Otherwise, we print the corresponding status and response.  If no ID is
matched, we use the default response with a status of 401.

Note that there is an implicit order to the parameters.  The ID is
always first and the creds or response value is always last, and
therefore may contain spaces, equals signs, or other arbitrary data.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-httpd/nph-custom-auth.sh | 17 ++++--
 t/t5563-simple-http-auth.sh    | 96 +++++++++++++++++++---------------
 2 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
index f5345e775e..d408d2caad 100644
--- a/t/lib-httpd/nph-custom-auth.sh
+++ b/t/lib-httpd/nph-custom-auth.sh
@@ -19,21 +19,30 @@ CHALLENGE_FILE=custom-auth.challenge
 #
 
 if test -n "$HTTP_AUTHORIZATION" && \
-	grep -Fqsx "${HTTP_AUTHORIZATION}" "$VALID_CREDS_FILE"
+	grep -Fqs "creds=${HTTP_AUTHORIZATION}" "$VALID_CREDS_FILE"
 then
+	idno=$(grep -F "creds=${HTTP_AUTHORIZATION}" "$VALID_CREDS_FILE" | sed -e 's/^id=\([a-z0-9-][a-z0-9-]*\) .*$/\1/')
+	status=$(sed -ne "s/^id=$idno.*status=\\([0-9][0-9][0-9]\\).*\$/\\1/p" "$CHALLENGE_FILE" | head -n1)
 	# Note that although git-http-backend returns a status line, it
 	# does so using a CGI 'Status' header. Because this script is an
 	# No Parsed Headers (NPH) script, we must return a real HTTP
 	# status line.
 	# This is only a test script, so we don't bother to check for
 	# the actual status from git-http-backend and always return 200.
-	echo 'HTTP/1.1 200 OK'
-	exec "$GIT_EXEC_PATH"/git-http-backend
+	echo "HTTP/1.1 $status Nonspecific Reason Phrase"
+	if test "$status" -eq 200
+	then
+		exec "$GIT_EXEC_PATH"/git-http-backend
+	else
+		sed -ne "s/^id=$idno.*response=//p" "$CHALLENGE_FILE"
+		echo
+		exit
+	fi
 fi
 
 echo 'HTTP/1.1 401 Authorization Required'
 if test -f "$CHALLENGE_FILE"
 then
-	cat "$CHALLENGE_FILE"
+	sed -ne 's/^id=default.*response=//p' "$CHALLENGE_FILE"
 fi
 echo
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index b098cd0fdf..515185ae00 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -63,11 +63,12 @@ test_expect_success 'access using basic auth' '
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -100,11 +101,12 @@ test_expect_success 'access using basic auth via authtype' '
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -137,11 +139,12 @@ test_expect_success 'access using basic auth invalid credentials' '
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -174,13 +177,14 @@ test_expect_success 'access using basic auth with extra challenges' '
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: FooBar param1="value1" param2="value2"
-	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: FooBar param1="value1" param2="value2"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -214,13 +218,14 @@ test_expect_success 'access using basic auth mixed-case wwwauth header name' '
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	www-authenticate: foobar param1="value1" param2="value2"
-	WWW-AUTHENTICATE: BEARER authorize_uri="id.example.com" p=1 q=0
-	WwW-aUtHeNtIcAtE: baSiC realm="example.com"
+	id=1 status=200
+	id=default response=www-authenticate: foobar param1="value1" param2="value2"
+	id=default response=WWW-AUTHENTICATE: BEARER authorize_uri="id.example.com" p=1 q=0
+	id=default response=WwW-aUtHeNtIcAtE: baSiC realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -254,18 +259,19 @@ test_expect_success 'access using basic auth with wwwauth header continuations'
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	# Note that leading and trailing whitespace is important to correctly
 	# simulate a continuation/folded header.
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: FooBar param1="value1"
-	 param2="value2"
-	WWW-Authenticate: Bearer authorize_uri="id.example.com"
-	 p=1
-	 q=0
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: FooBar param1="value1"
+	id=default response= param2="value2"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com"
+	id=default response= p=1
+	id=default response= q=0
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -299,21 +305,22 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
 
 	# Note that leading and trailing whitespace is important to correctly
 	# simulate a continuation/folded header.
-	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >"$CHALLENGE" &&
-	printf " \r\n" >>"$CHALLENGE" &&
-	printf " param2=\"value2\"\r\n" >>"$CHALLENGE" &&
-	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>"$CHALLENGE" &&
-	printf " p=1\r\n" >>"$CHALLENGE" &&
-	printf " \r\n" >>"$CHALLENGE" &&
-	printf " q=0\r\n" >>"$CHALLENGE" &&
-	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>"$CHALLENGE" &&
+	printf "id=1 status=200\n" >"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: FooBar param1=\"value1\"\r\n" >>"$CHALLENGE" &&
+	printf "id=default response= \r\n" >>"$CHALLENGE" &&
+	printf "id=default response= param2=\"value2\"\r\n" >>"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>"$CHALLENGE" &&
+	printf "id=default response= p=1\r\n" >>"$CHALLENGE" &&
+	printf "id=default response= \r\n" >>"$CHALLENGE" &&
+	printf "id=default response= q=0\r\n" >>"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>"$CHALLENGE" &&
 
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
@@ -346,17 +353,18 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 
 	# Basic base64(alice:secret-passwd)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
 	EOF
 
 	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
 
 	# Note that leading and trailing whitespace is important to correctly
 	# simulate a continuation/folded header.
-	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >"$CHALLENGE" &&
-	printf " \r\n" >>"$CHALLENGE" &&
-	printf "\tparam2=\"value2\"\r\n" >>"$CHALLENGE" &&
-	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>"$CHALLENGE" &&
+	printf "id=1 status=200\n" >"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: FooBar param1=\"value1\"\r\n" >>"$CHALLENGE" &&
+	printf "id=default response= \r\n" >>"$CHALLENGE" &&
+	printf "id=default response=\tparam2=\"value2\"\r\n" >>"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: Basic realm=\"example.com\"" >>"$CHALLENGE" &&
 
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
@@ -389,15 +397,16 @@ test_expect_success 'access using bearer auth' '
 
 	# Basic base64(a-git-token)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Bearer YS1naXQtdG9rZW4=
+	id=1 creds=Bearer YS1naXQtdG9rZW4=
 	EOF
 
 	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: FooBar param1="value1" param2="value2"
-	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: FooBar param1="value1" param2="value2"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
@@ -433,15 +442,16 @@ test_expect_success 'access using bearer auth with invalid credentials' '
 
 	# Basic base64(a-git-token)
 	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
-	Bearer YS1naXQtdG9rZW4=
+	id=1 creds=Bearer YS1naXQtdG9rZW4=
 	EOF
 
 	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
 
 	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
-	WWW-Authenticate: FooBar param1="value1" param2="value2"
-	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
-	WWW-Authenticate: Basic realm="example.com"
+	id=1 status=200
+	id=default response=WWW-Authenticate: FooBar param1="value1" param2="value2"
+	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	id=default response=WWW-Authenticate: Basic realm="example.com"
 	EOF
 
 	test_config_global credential.helper test-helper &&
