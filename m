From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH] Make git-mailinfo strip whitespace from the start of the mail file.
Date: Thu,  1 Nov 2007 22:05:39 +0100
Message-ID: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com>
Cc: gitster@pobox.com, Simon Sasburg <Simon.Sasburg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 22:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhFB-0002aE-E1
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbXKAVGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbXKAVGK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:06:10 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:7532 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbXKAVGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:06:09 -0400
Received: by hu-out-0506.google.com with SMTP id 19so264527hue
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=EPyDO/zf/4qm0wIhR+zGa3BYYY6UROC1+PB/8aUh/JE=;
        b=aW3pPLgSwkxbboc9DvGDjXnEzJ30EHf3Vm+H+Fyn7maD3LDQhHMGjPsx+Unae3j7MTOGi2iK+s4G00mIURVm7uapwAGvT2erkCvj9yLLgerlhKRzbWsxcWV2znW7+gKrI2XzNWhBGgcXe+0ezEDRRpobCJMgQuNyC6eR7m/pC8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=g4GsuhNh8+qppkVEuitCHEgap/JOkx7U+Zg2TP5Xrt1AwzSmpiqBWR5WzDBvKqbip5JPoXefslWIC8ogrMqpAxDHyXkaRfwvPNTkCtIiU3bZQ4EooNnGEQzzjhHE11peK590hAVp5ShQ36jQqVYcLfHBLrw3Ly1dBt/6Q5IoXr4=
Received: by 10.78.107.8 with SMTP id f8mr834579huc.1193951167051;
        Thu, 01 Nov 2007 14:06:07 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id d24sm2008528nfh.2007.11.01.14.05.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 14:06:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.503.gbcee6f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63001>

This allows you to use files gotten through gmail's web interface via its 'Show original' option.

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---
Note that this doesn't exactly follow RFC 2822 as far as i can see, but i don't know if git prefers to be strict or tolerant in these cases, so i'm sending the patch anyway.

It certaily helps me, even if just a little bit.

 builtin-mailinfo.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index fb12248..5d4b6bf 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -915,6 +915,7 @@ static void handle_info(void)
 static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 		    const char *msg, const char *patch)
 {
+	int peek;
 	keep_subject = ks;
 	metainfo_charset = encoding;
 	fin = in;
@@ -935,6 +936,11 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
 	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(char *));
 
+	do {
+		peek = fgetc(in);
+	} while (peek == ' ' || peek == '\r' || peek == '\n');
+	ungetc(peek, in);
+
 	/* process the email header */
 	while (read_one_header_line(line, sizeof(line), fin))
 		check_header(line, sizeof(line), p_hdr_data, 1);
-- 
1.5.3.4.502.g37c97
