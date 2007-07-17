From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Do a better job at guessing unknown character sets
Date: Tue, 17 Jul 2007 10:34:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707171027100.19166@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqwr-00080I-AF
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbXGQRez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbXGQRey
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:34:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56734 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753017AbXGQRey (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 13:34:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HHYoO9013168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2007 10:34:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HHYig6030267;
	Tue, 17 Jul 2007 10:34:44 -0700
X-Spam-Status: No, hits=-2.649 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52784>


At least in the kernel development community, we're generally slowly 
converting to UTF-8 everywhere, and the old default of Latin1 in emails is 
being supplanted by UTF-8, and it doesn't necessarily show up as such in 
the mail headers (because, quite frankly, when people send patches 
around, they want the email client to do as little as humanly possible 
about the patch)

Despite that, it's often the case that email addresses etc still have 
Latin1, so I've seen emails where this is a mixed bag, with Signed-off 
parts being copied from email (and containing Latin1 characters), and the 
rest of the email being a patch in UTF-8.

So this suggests a very natural change: if the target character set is 
utf-8 (the default), and if the source already looks like utf-8, just 
assume that it doesn't need any conversion at all.

Only assume that it needs conversion if it isn't already valid utf-8, in 
which case we (for historical reasons) will assume it's Latin1.

Basically no really _valid_ latin1 will ever look like utf-8, so while 
this changes our historical behaviour, it doesn't do so in practice, and 
makes the default behaviour saner for the case where the input was already 
in proper format.

We could do a more fancy guess, of course, but this correctly handled a 
series of patches I just got from Andrew that had a mixture of Latin1 and 
UTF-8 (in different emails, but without any character set indication).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I think this makes sense from a "the world is moving to utf-8" standpoint, 
even if obviously some people might consider it a bit ugly to do per-line 
"guessing".

Comments?

 builtin-mailinfo.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 489c2c5..a37a4ff 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -499,15 +499,40 @@ static int decode_b_segment(char *in, char *ot, char *ep)
 	return 0;
 }
 
+/*
+ * When there is no known charset, guess.
+ *
+ * Right now we assume that if the target is UTF-8 (the default),
+ * and it already looks like UTF-8 (which includes US-ASCII as its
+ * subset, of course) then that is what it is and there is nothing
+ * to do.
+ *
+ * Otherwise, we default to assuming it is Latin1 for historical
+ * reasons.
+ */
+static const char *guess_charset(const char *line, const char *target_charset)
+{
+	if (is_encoding_utf8(target_charset)) {
+		if (is_utf8(line))
+			return NULL;
+	}
+	return "latin1";
+}
+
 static void convert_to_utf8(char *line, const char *charset)
 {
-	static const char latin_one[] = "latin1";
-	const char *input_charset = *charset ? charset : latin_one;
-	char *out = reencode_string(line, metainfo_charset, input_charset);
+	char *out;
+
+	if (!charset || !*charset) {
+		charset = guess_charset(line, metainfo_charset);
+		if (!charset)
+			return;
+	}
 
+	out = reencode_string(line, metainfo_charset, charset);
 	if (!out)
 		die("cannot convert from %s to %s\n",
-		    input_charset, metainfo_charset);
+		    charset, metainfo_charset);
 	strcpy(line, out);
 	free(out);
 }
