From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Wed, 17 Feb 2016 13:05:11 -0800
Message-ID: <xmqqlh6jhwu0.fsf@gitster.mtv.corp.google.com>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
	<20160215140422.GA1747@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Egger <christoph@christoph-egger.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 22:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW9Hl-0003du-2w
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 22:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161750AbcBQVFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 16:05:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161042AbcBQVFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 16:05:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 392DB44343;
	Wed, 17 Feb 2016 16:05:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rl3XeC0joxP11RJbeNbe7mstExQ=; b=ckqbKN
	54OIIVC2rIOKT6WpQ25s4+rmwOR/bS/Ar+kyYKGaZT35CPz9l0x1Wg8u0XZJbEWb
	N4P+YcDCFDwgN+cAGDYO1XKfHCaB3rXFrlmiQckvT2nr8In9MG+wb0duTmvPA2oz
	rWl2A5kjHYNroPl6Ts0Fd8kz5aGGJP3fJG35Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OMkDfRsz4D+uh/3HypV+MGyDIXP53URK
	O2Ktr0o0/7l8YFKz/lxGGK9l1Z/PXQIU5F3U3hOkSuiQznobtuLIUQgcp+Qa6JFz
	sg3/7tTOczltELHD5plc/WruMTEo1oLQp3OACEsUxqGHUx3uQSB+HhZnKGQbE7Al
	CwgtpdGB5/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29D2A44342;
	Wed, 17 Feb 2016 16:05:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90EE744341;
	Wed, 17 Feb 2016 16:05:12 -0500 (EST)
In-Reply-To: <20160215140422.GA1747@mitoraj.siccegge.de> (Christoph Egger's
	message of "Mon, 15 Feb 2016 15:04:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 229DABFE-D5BA-11E5-AD27-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286553>

Christoph Egger <christoph@christoph-egger.org> writes:

> Add the http.pinnedpubkey configuration option for public key
> pinning. It allows any string supported by libcurl --
> base64(sha256(pubkey)) or filename of the full public key.
>
> If cURL does not support pinning (is too old) output a warning to the
> user.
>
> Signed-off-by: Christoph Egger <christoph@christoph-egger.org>
> ---

I needed this fix to unbreak it for those with older versions of
cURL.


 http.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index a6b8076..3475040 100644
--- a/http.c
+++ b/http.c
@@ -219,13 +219,6 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 #endif
-	if (!strcmp("http.pinnedpubkey", var))
-#if LIBCURL_VERSION_NUM >= 0x072c00
-		return git_config_pathname(&ssl_pinnedkey, var, value);
-#else
-		warning(_("Public key pinning not supported with cURL < 7.44.0"));
-		return 0;
-#endif
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -283,6 +276,14 @@ static int http_options(const char *var, const char *value, void *cb)
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
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
