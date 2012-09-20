From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Disable dumb HTTP fallback with
 GIT_DUMB_HTTP_FALLBACK=false
Date: Wed, 19 Sep 2012 21:14:58 -0700
Message-ID: <1348114499-22811-2-git-send-email-gitster@pobox.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <1348114499-22811-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 06:15:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEYAy-00088p-ED
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 06:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab2ITEPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 00:15:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab2ITEPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 00:15:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 923568519;
	Thu, 20 Sep 2012 00:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bXkB
	ic+M4yERdE0y98zwkxU4FZ8=; b=M+LgMisHeUgpNeLEm5X2mopmtwAO6hrWGqKR
	D1RBnWwzYBlR76doYZ9GLuISagSKaFQQQ2I6g6UXtWJZHPwb2284yRBtfEIc2Yeo
	ESDD3k/MdHFoHp85RPfVs1Em+Ft+WF5CT/SsMRdoPnz6c7Ug6kV95TF9W2kBXq4Q
	TLC2Yr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	JT7LpuA97m8cH9Ye0l1c+fxORcpz7ew8eBikltrFAFbc7IDmX0+6/LkhOz+UKf62
	2XwfdApdcfIQJnwZYM79hEv5La/kgCH/8rdXckRzideAybqtmc/35TSjpnTVkLXw
	vG1VC2acTXBE87AIYW4krtX9BtPRafpC4HsyeG97zSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 802248518;
	Thu, 20 Sep 2012 00:15:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E13BB8516; Thu, 20 Sep 2012
 00:15:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.389.g3dff30b
In-Reply-To: <1348114499-22811-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C1557B6C-02D9-11E2-B371-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206032>

From: "Shawn O. Pearce" <spearce@spearce.org>

If the user doesn't want to use the dumb HTTP protocol, she may set
GIT_DUMB_HTTP_FALLBACK=false in the environment before invoking a
Git protocol operation. This is mostly useful when testing against
servers that are known to not support the dumb protocol. If the
smart service detection fails the client should not continue with
dumb behavior, but instead provide accurate HTTP failure data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3ec474f..f25cf3c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -17,7 +17,8 @@ struct options {
 	unsigned progress : 1,
 		followtags : 1,
 		dry_run : 1,
-		thin : 1;
+		thin : 1,
+		fallback : 1;
 };
 static struct options options;
 
@@ -115,7 +116,8 @@ static struct discovery* discover_refs(const char *service)
 	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
-	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
+	if (options.fallback && http_ret != HTTP_OK
+	    && http_ret != HTTP_NOAUTH) {
 		free(refs_url);
 		strbuf_reset(&buffer);
 
@@ -853,6 +855,8 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
+static const char DUMB_HTTP_FALLBACK_ENV[] = "GIT_DUMB_HTTP_FALLBACK";
+
 int main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -868,6 +872,12 @@ int main(int argc, const char **argv)
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
+	options.fallback = 1;
+
+	if (getenv(DUMB_HTTP_FALLBACK_ENV)) {
+		char *fb = getenv(DUMB_HTTP_FALLBACK_ENV);
+		options.fallback = git_config_bool(DUMB_HTTP_FALLBACK_ENV, fb);
+	}
 
 	remote = remote_get(argv[1]);
 
-- 
1.7.12.1.389.g3dff30b
