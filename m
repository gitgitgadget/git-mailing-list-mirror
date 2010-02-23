From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:33:48 +0200
Message-ID: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 13:34:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njtxf-0001Fd-Gz
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0BWMdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 07:33:52 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:49655 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0BWMdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 07:33:51 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id E2EE118CC0A
	for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:33:49 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00D3BD8D02; Tue, 23 Feb 2010 14:33:49 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id C36FA41C07
	for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:33:48 +0200 (EET)
X-Mailer: git-send-email 1.7.0.86.gb35cab
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140791>

According to relevant RFCs, in addition to alphanumerics, the following
characters are valid in URL scheme parts: '+', '-' and '.', but
currently only alphanumerics are allowed in remote helper names.

Allow those three characters in remote helper names (both 'foo://' and
'foo::' syntax).

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 08e4fa0..00acff1 100644
--- a/transport.c
+++ b/transport.c
@@ -872,6 +872,21 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
+static int isurlschemechar(int first_flag, int ch)
+{
+	/*
+	 * The set of valid URL schemes, as per STD66 (RFC3986) is
+	 * '[A-Za-z][A-Za-z0-9+.-]*'. But use sightly looser check
+	 * of '[A-Za-z0-9][A-Za-z0-9+.-]*' because earlier version
+	 * of check used '[A-Za-z0-9]+' so not to break any remote
+	 * helpers.
+	 */
+	int alphanumeric, special;
+	alphanumeric = ch > 0 && isalnum(ch);
+	special = ch == '+' || ch == '-' || ch == '.';
+	return alphanumeric || (!first_flag && special);
+}
+
 static int is_url(const char *url)
 {
 	const char *url2, *first_slash;
@@ -896,7 +911,7 @@ static int is_url(const char *url)
 	 */
 	url2 = url;
 	while (url2 < first_slash - 1) {
-		if (!isalnum((unsigned char)*url2))
+		if (!isurlschemechar(url2 == url, (unsigned char)*url2))
 			return 0;
 		url2++;
 	}
@@ -930,7 +945,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	if (url) {
 		const char *p = url;
 
-		while (isalnum(*p))
+		while (isurlschemechar(p == url, *p))
 			p++;
 		if (!prefixcmp(p, "::"))
 			helper = xstrndup(url, p - url);
-- 
1.7.0.86.gb35cab
