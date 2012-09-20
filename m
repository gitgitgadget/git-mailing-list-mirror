From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] remote-curl: make dumb-http fallback configurable per
 URL
Date: Wed, 19 Sep 2012 21:14:59 -0700
Message-ID: <1348114499-22811-3-git-send-email-gitster@pobox.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <1348114499-22811-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 06:15:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEYAr-00083B-7v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 06:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab2ITEP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 00:15:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab2ITEPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 00:15:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0004851E
	for <git@vger.kernel.org>; Thu, 20 Sep 2012 00:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lmJQ
	szpoMKrDdbJvRzYYVR9af64=; b=E2X99AXEzrUseXxGM7RjB3USI2c83bMIv1NT
	Te5VSw/EEyQYWoyl+F4D7AHykpv89PQ30Oqi1dbK37NHW6MN02itzwQFARUYD+kZ
	VLlewyYlBf3Pba/nndEOhTQpA3fDVbJvWVTzL59sn4kTVRk3ScGfx26UfQTp3s/Q
	JgmScvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YvIEsN
	wjPqGLS7umKi2UdMKvGuG3OrNYV9a+lvpI513nq0Ktz6IlyOoPoVziaPPn7bYuTD
	ZfWPePZyKuAvNDgpkWL22MBZh1xfJcLhHYYuAM4S6JqmHGuwZYGzLaeCYq6PrryK
	opuqBHylkWjd+hSgnSQk8wT5lsAxChrs79m9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D461851D
	for <git@vger.kernel.org>; Thu, 20 Sep 2012 00:15:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6069851A for
 <git@vger.kernel.org>; Thu, 20 Sep 2012 00:15:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.389.g3dff30b
In-Reply-To: <1348114499-22811-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C318307A-02D9-11E2-B457-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206031>

Introduce http.$url_prefix.dumbhttpfallback configuration variables
so that users do not have to set GIT_DUMB_HTTP_FALLBACK environment
depending on which remote they are talking with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index f25cf3c..44544c7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -855,6 +855,46 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
+struct dumb_fallback_cb {
+	const char *url;
+	int value;
+};
+
+static int dumb_fallback_cb(const char *key, const char *value, void *cb_)
+{
+	struct dumb_fallback_cb *cb = cb_;
+	int i, len;
+
+	/* Is this "http.$url.dumbHttpFallback"? */
+	if (prefixcmp(key, "http."))
+		return 0;
+	len = strrchr(key, '.') - key;
+	if (len <= 5)
+		/* we found the dot at the end of "http." */
+		return 0;
+	key += 5; /* skip over http. part */
+	len -= 5;
+	if (strcmp(key + len, ".dumbhttpfallback"))
+		return 0;
+
+	/* Does the $url part match? */
+	for (i = 0; i < len; i++)
+		if (cb->url[i] != key[i])
+			return 0;
+	cb->value = git_config_bool(key, value);
+	return 0;
+}
+
+static int dumb_fallback_config(const char *url)
+{
+	struct dumb_fallback_cb cb;
+
+	cb.url = url;
+	cb.value = 1; /* defaults to true */
+	git_config(dumb_fallback_cb, &cb);
+	return cb.value;
+}
+
 static const char DUMB_HTTP_FALLBACK_ENV[] = "GIT_DUMB_HTTP_FALLBACK";
 
 int main(int argc, const char **argv)
@@ -872,12 +912,6 @@ int main(int argc, const char **argv)
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
-	options.fallback = 1;
-
-	if (getenv(DUMB_HTTP_FALLBACK_ENV)) {
-		char *fb = getenv(DUMB_HTTP_FALLBACK_ENV);
-		options.fallback = git_config_bool(DUMB_HTTP_FALLBACK_ENV, fb);
-	}
 
 	remote = remote_get(argv[1]);
 
@@ -889,6 +923,13 @@ int main(int argc, const char **argv)
 
 	url = strbuf_detach(&buf, NULL);
 
+	if (getenv(DUMB_HTTP_FALLBACK_ENV)) {
+		char *fb = getenv(DUMB_HTTP_FALLBACK_ENV);
+		options.fallback = git_config_bool(DUMB_HTTP_FALLBACK_ENV, fb);
+	} else {
+		options.fallback = dumb_fallback_config(url);
+	}
+
 	http_init(remote, url, 0);
 
 	do {
-- 
1.7.12.1.389.g3dff30b
