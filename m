From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Increase some limits in git-mailinfo
Date: Mon, 26 Feb 2007 11:10:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261107060.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlFL-00025f-S9
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbXBZTKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbXBZTKs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:10:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57764 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030468AbXBZTKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:10:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QJAhhB003189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 11:10:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QJAg8M028502;
	Mon, 26 Feb 2007 11:10:42 -0800
In-Reply-To: <Pine.LNX.4.64.0702261036550.12485@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40644>



On Mon, 26 Feb 2007, Linus Torvalds wrote:
> 
> I'm not proud of this patch, and I think we should do this better, but I 
> just had trouble with an email that Eric Biederman sent me for the kernel, 
> and this is the simplest and most obvious fix..

Ok, this is the more complicated fix for the problem.

I do *not* guarantee that this works. It worked for me single test-case, 
but I think somebody should double-check my logic. Does it seem sane?

It basically considers all the continuation lines to be lines of their 
own, and if the total line is bigger than what we can fit in it, we just 
truncate the result rather than stop in the middle and then get confused 
when we try to parse the "next" line (which is just the remainder of the 
first line).

It also moves the "From " and ">From " special cases into the rfc2822 
header line checker helper function, because the flow seemed much more 
logical that way.

Is this better than my stupid one-liner that just extended the line size? 
I dunno..

		Linus

---
 builtin-mailinfo.c |   61 ++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6ee6b0b..6ccbf75 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -406,6 +406,11 @@ static int is_rfc2822_header(char *line)
 	 */
 	int ch;
 	char *cp = line;
+
+	/* Count mbox From headers as headers */
+	if (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6))
+		return 1;
+
 	while ((ch = *cp++)) {
 		if (ch == ':')
 			return cp != line;
@@ -419,28 +424,48 @@ static int is_rfc2822_header(char *line)
 
 static int read_one_header_line(char *line, int sz, FILE *in)
 {
-	int ofs = 0;
-	while (ofs < sz) {
-		int peek, len;
-		if (fgets(line + ofs, sz - ofs, in) == NULL)
-			break;
-		len = eatspace(line + ofs);
-		if ((len == 0) || !is_rfc2822_header(line)) {
-			/* Re-add the newline */
-			line[ofs + len] = '\n';
-			line[ofs + len + 1] = '\0';
-			break;
-		}
-		ofs += len;
-		/* Yuck, 2822 header "folding" */
+	int len;
+
+	/* Get the first part of the line.. */
+	if (!fgets(line, sz, in))
+		return 0;
+
+	/*
+	 * Is it an empty line or not a valid rfc2822 header?
+	 * If so, stop here, and return false ("not a header")
+	 */
+	len = eatspace(line);
+	if (!len || !is_rfc2822_header(line)) {
+		/* Re-add the newline */
+		line[len] = '\n';
+		line[len + 1] = '\0';
+		return 0;
+	}
+
+	/*
+	 * Now we need to eat all the continuation lines..
+	 * Yuck, 2822 header "folding"
+	 */
+	for (;;) {
+		int peek, addlen;
+		static char continuation[1000];
+
 		peek = fgetc(in); ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
 			break;
+		if (!fgets(continuation, sizeof(continuation), in))
+			break;
+		addlen = eatspace(continuation);
+		if (len < sz) {
+			if (addlen >= sz - len)
+				addlen = sz - len - 1;
+			memcpy(line + len, continuation, addlen);
+			len += addlen;
+		}
 	}
-	/* Count mbox From headers as headers */
-	if (!ofs && (!memcmp(line, "From ", 5) || !memcmp(line, ">From ", 6)))
-		ofs = 1;
-	return ofs;
+	line[len] = 0;
+
+	return 1;
 }
 
 static int decode_q_segment(char *in, char *ot, char *ep, int rfc2047)
