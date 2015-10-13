From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 24/26] mailinfo: handle charset conversion errors in the caller
Date: Tue, 13 Oct 2015 16:16:45 -0700
Message-ID: <1444778207-859-25-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pH-0006XH-7v
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbbJMXRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33475 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbJMXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:18 -0400
Received: by pabrc13 with SMTP id rc13so34531714pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=4MywW1f7wzbD96DeXGUaFaNZLIkv62WpoRdFKrRLiVA=;
        b=eW7kazVcWc75DiExJZidCDKOts1T8+KRMENcrr0ogF1wSFYCfE77FYVOL24mw/EIAO
         /S0husIDHkT1PMft+x4Ch9BrqVkggyt1gHpNqrfU4iAa5k/Svkju8LVmn13lG1M2xhc9
         9PGXpKwWxFqUbZuBiPzeiiluciVY21xRQYpO4VhvbwQoTZgAphYr4ll/iTTSKGe8ntSG
         p7Mi9AL/C1Z5OJZgnDA4CXy9sv35Us0ymyBcyh7B85Ufnzz5BDJXpCshmT899SMbJz92
         9/oNi7Rz7m9TCTD0wism5ga2/y19AX8gNXVzknIsSFTXrZ2rEbxXeTK4h0MIj+PIMfUA
         e23A==
X-Received: by 10.68.90.34 with SMTP id bt2mr43932794pbb.145.1444778237740;
        Tue, 13 Oct 2015 16:17:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id ou1sm5856826pbb.0.2015.10.13.16.17.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279545>

Instead of dying in convert_to_utf8(), just report an error and let
the callers handle it.  Between the two callers:

 - decode_header() knows how to handle malformed line by reporting
   the breakage to the caller, so let it follow the pattern it
   already knows about;

 - handle_commit_msg() doesn't cope with a malformed line well, so
   die there for now.  We'll lift this even higher in later changes
   in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 6452a4c..f14c504 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -521,21 +521,22 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
-static void convert_to_utf8(struct mailinfo *mi,
-			    struct strbuf *line, const char *charset)
+static int convert_to_utf8(struct mailinfo *mi,
+			   struct strbuf *line, const char *charset)
 {
 	char *out;
 
 	if (!mi->metainfo_charset || !charset || !*charset)
-		return;
+		return 0;
 
 	if (same_encoding(mi->metainfo_charset, charset))
-		return;
+		return 0;
 	out = reencode_string(line->buf, mi->metainfo_charset, charset);
 	if (!out)
-		die("cannot convert from %s to %s",
-		    charset, mi->metainfo_charset);
+		return error("cannot convert from %s to %s",
+			     charset, mi->metainfo_charset);
 	strbuf_attach(line, out, strlen(out), strlen(out));
+	return 0;
 }
 
 static int decode_header(struct mailinfo *mi, struct strbuf *it)
@@ -602,7 +603,8 @@ static int decode_header(struct mailinfo *mi, struct strbuf *it)
 			dec = decode_q_segment(&piecebuf, 1);
 			break;
 		}
-		convert_to_utf8(mi, dec, charset_q.buf);
+		if (convert_to_utf8(mi, dec, charset_q.buf))
+			goto release_return;
 
 		strbuf_addbuf(&outbuf, dec);
 		strbuf_release(dec);
@@ -778,7 +780,8 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		mi->header_stage = 0;
 
 	/* normalize the log message to UTF-8. */
-	convert_to_utf8(mi, line, mi->charset.buf);
+	if (convert_to_utf8(mi, line, mi->charset.buf))
+		exit(128);
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
-- 
2.6.1-320-g86a1181
