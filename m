From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/8] builtin-mailinfo.c: compare character encodings case insensitively
Date: Mon, 18 May 2009 18:44:40 -0500
Message-ID: <KfeKNR3Jm6YKvPIcYGBMpEj60b9ww0Dv2XSyNy2qLE-KEaaF8D8q9OHVC3tPAPSzNe1CJUXJDfA@cipher.nrlssc.navy.mil>
References: <KfeKNR3Jm6YKvPIcYGBMpCbbOxxIaBRphS4qzgN2W9mXIvp7Hl8SgBQzbAhZRV4A4Q6X14JTLR4@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpKjNOsMcmMNMJ1vr-EBr-eE371H-Rg69NOM1rMB2Oa5nCGVe2SMGKdc@cipher.nrlssc.navy.mil> <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 01:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6CW4-0003Pz-AR
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZERXpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZERXpB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:45:01 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50115 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbZERXo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 19:44:57 -0400
Received: by mail.nrlssc.navy.mil id n4INitKO024906; Mon, 18 May 2009 18:44:58 -0500
In-Reply-To: <KfeKNR3Jm6YKvPIcYGBMpLkRr97IFN82BZR2bJNHFQYwhjGgwGRoIAkKO5m1EZb7M9epcX8P-fk@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 May 2009 23:44:55.0340 (UTC) FILETIME=[A57096C0:01C9D812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119471>

When converting between character encodings, git tests whether the "from"
encoding and the "to" encoding have the same name.  git should perform this
test case insensitively so that e.g. utf-8 is not seen as a different
encoding than UTF-8.

Additionally, it is not necessary to call tolower() anymore on the encodings
extracted from the mail message.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-mailinfo.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 5ebc8b5..c68187e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -193,8 +193,7 @@ static void handle_content_type(struct strbuf *line)
 		*content_top = boundary;
 		boundary = NULL;
 	}
-	if (slurp_attr(line->buf, "charset=", &charset))
-		strbuf_tolower(&charset);
+	slurp_attr(line->buf, "charset=", &charset);
 
 	if (boundary) {
 		strbuf_release(boundary);
@@ -494,7 +493,7 @@ static void convert_to_utf8(struct strbuf *line, const char *charset)
 			return;
 	}
 
-	if (!strcmp(metainfo_charset, charset))
+	if (!strcasecmp(metainfo_charset, charset))
 		return;
 	out = reencode_string(line->buf, metainfo_charset, charset);
 	if (!out)
@@ -550,7 +549,6 @@ static int decode_header_bq(struct strbuf *it)
 		if (cp + 3 - it->buf > it->len)
 			goto decode_header_bq_out;
 		strbuf_add(&charset_q, ep, cp - ep);
-		strbuf_tolower(&charset_q);
 
 		encoding = cp[1];
 		if (!encoding || cp[2] != '?')
-- 
1.6.3.1.24.g152f4
