From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 1/1] http: Fix crash when passing malformed URL
Date: Wed, 16 Mar 2016 11:54:07 +0100
Message-ID: <1458125647-32707-2-git-send-email-anton.wuerfel@fau.de>
References: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
Cc: Anton Wuerfel <anton.wuerfel@fau.de>,
	Phillip@i4.informatik.uni-erlangen.de,
	"Raffeck <phillip.raffeck"@fau.de, i4passt@cs.fau.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag95u-0000Od-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 11:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbcCPKyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 06:54:23 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:55249 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753825AbcCPKyV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 06:54:21 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id F3E0858C4CE;
	Wed, 16 Mar 2016 11:54:18 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Wed, 16 Mar 2016 11:54:18 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458125647-32707-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288957>

When passing a malformed URL to http_init() in http.c, git dies from a null
pointer dereference. An example for a malformed URL is http:/git-scm.com (note
the single slash after the protocol).
This patch adds simple error handling as git notices the malformed URL already,
but never checks the error value.

When passing a malformed URL, credential_from_url(struct credential *c, const char *url)
initializes *c with null values. When the existence of `://` in url is checked,
the function returns without further change of *c.
The null pointer dereference occurs in get_curl_handle () at http.c:593, when
the `protocol` field of struct credential is strcmp'ed:

Program received signal SIGSEGV, Segmentation fault.
0x0000000000405efd in get_curl_handle () at http.c:593
593                     if (!strcmp(http_auth.protocol, "https")) {
---
 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index 69da445..80cf752 100644
--- a/http.c
+++ b/http.c
@@ -660,6 +660,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 
 	http_is_verbose = 0;
 	normalized_url = url_normalize(url, &config.url);
+	
+	if (config.url.err)
+		die(_("libcurl: %s, URL: %s"), config.url.err, url);
 
 	git_config(urlmatch_config_entry, &config);
 	free(normalized_url);
-- 
2.8.0.rc1.108.g7827469
