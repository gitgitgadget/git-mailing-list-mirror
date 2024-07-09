Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7C1FA3
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566236; cv=none; b=Kot5OU5YvuuasqaDKLkTmeanPyeji0s8LZGdN8Rv/KXCWZYUbwl2KedqtsiaYp4KrwrrIHxXmsNUOJq1iJ+kCyBGeLPHRgo72EdlNHnheirscxvqVzYT5u5Zvz+vYJ25y9ZiOIvSMPM9mffkb+3RbEmxMammDTQbzq6TwG0BZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566236; c=relaxed/simple;
	bh=MqljLcypEfN1LUpxpjd4hadFXxrEqMsGT6KWyxnDs6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BP1jjs+ycFhrDOmC0swKzkW/jipZJXf0UttiR5pl09f9HlG6lS7x64mR+o+qSL7e0UlEHx+BvP39pOpTF4RwHCByFZ00P7c5GbhRLjBWyqolISrmpCxN5wvW0zYSSBBC07h+qh4fc9t5CsD7RWM8FEkaMg5DHE96GKIQCwkEeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QIT5orG/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QIT5orG/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F7473CC8E;
	Tue,  9 Jul 2024 19:03:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	qljLcypEfN1LUpxpjd4hadFXxrEqMsGT6KWyxnDs6E=; b=QIT5orG/jZfz/EZCr
	zyYank2lFtb47ePgIAyhV0SMEKkoj/SGBYqSfHnhBWsDUkDkvek90IwEvWGxt6tN
	Kna/2Cnj2V8ckaUgAZeAEOdhbifpQznSmV6Kfj6T2TShFlgYjrrBPFmoDx7kUglG
	vL+N4AtyhH1Y/SlLOO3CoZnjqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0676B3CC8D;
	Tue,  9 Jul 2024 19:03:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E6CD3CC8C;
	Tue,  9 Jul 2024 19:03:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: [PATCH/RFC] http.c: cookie file tightening
Date: Tue, 09 Jul 2024 16:03:48 -0700
Message-ID: <xmqqed82cgmj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8124AB92-3E47-11EF-AE15-C38742FD603B-77302942!pb-smtp20.pobox.com

The http.cookiefile configuration variable is used to call
curl_easy_setopt() to set CURLOPT_COOKIEFILE and if http.savecookies
is set, the same value is used for CURLOPT_COOKIEJAR.  The former is
used only to read cookies at startup, the latter is used to write
cookies at the end.

The manual pages https://curl.se/libcurl/c/CURLOPT_COOKIEFILE.html
and https://curl.se/libcurl/c/CURLOPT_COOKIEJAR.html talk about two
interesting special values.

 * "" (an empty string) given to CURLOPT_COOKIEFILE means not to
   read cookies from any file upon startup.

 * It is not specified what "" (an empty string) given to
   CURLOPT_COOKIEJAR does; presumably open a file whose name is an
   empty string and write cookies to it?  In any case, that is not
   what we want to see happen, ever.

 * "-" (a dash) given to CURLOPT_COOKIEFILE makes cURL read cookies
   from the standard input, and given to CURLOPT_COOKIEJAR makes
   cURL write cookies to the standard output.  Neither of which we
   want ever to happen.

So, let's make sure we avoid these nonsense cases.  Specifically,
when http.cookies is set to "-", ignore it with a warning, and when
it is set to "" and http.savecookies is set, ignore http.savecookies
with a warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I have no confidence in me doing http correctly, so I am asking
   from folks who have touched http.c in the past 6 months for help.

   A proposed documentation update to talk about an empty string by
   Piotr, who is also on CC:, triggered this update.

 http.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git c/http.c w/http.c
index 13fa94bef3..86ccca49f0 100644
--- c/http.c
+++ w/http.c
@@ -1466,7 +1466,16 @@ struct active_request_slot *get_active_slot(void)
 	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
+
+	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
+		warning(_("refusing to read cookies from http.cookiefile '-'"));
+		FREE_AND_NULL(curl_cookie_file);
+	}
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
+	if (curl_save_cookies && (!curl_cookie_file || !curl_cookie_file[0])) {
+		curl_save_cookies = 0;
+		warning(_("ignoring http.savecookies for empty http.cookiefile"));
+	}
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
