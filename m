From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: mailinfo: don't require "text" mime type for attachments
Date: Sun, 30 Sep 2012 15:10:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1209301458540.11079@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Don Zickus <dzickus@redhat.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 00:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIRk1-0002BP-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 00:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab2I3WLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 18:11:09 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56275 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2I3WLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 18:11:08 -0400
Received: by padhz1 with SMTP id hz1so3671901pad.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:x-x-sender:to:cc:subject:message-id:user-agent
         :mime-version:content-type;
        bh=Ay0Fp6e0m3lUKHCiIgJAvARsH3yjPMaHZCNGZ9O8g8A=;
        b=s2UoaVFRVp4O6IzBl9W+YFwUQLvCIfpokYiTZl08AsrRnKQCNA8/iacT+L5G4KLsEA
         exKI6BzFGoVE/lg8MzziVYYl661KraKcsKj2MRZvawlBKDwtRwEa2HB3QkKXoGIIOs51
         P6BMMH9siBdOayd5RIINQ1iL/Juo/v0TZun00MxA12WWd9FsFtQrxzKFEJ1mi7FarkIp
         A8GoZ2C/QUkX5sEaQCuX92Y05YUd/cfeZibGPulykxYikXywogKAgcvjaZI63cvynllJ
         dpf4XIzNScKWV94wEsxAI73DjlRsJKBHnxSjSk9fTAjENjgzypxcmHP33lWWhrEW/vUR
         57Xg==
Received: by 10.66.73.166 with SMTP id m6mr32248848pav.1.1349043066472;
        Sun, 30 Sep 2012 15:11:06 -0700 (PDT)
Received: from [192.168.1.87] (c-24-22-13-12.hsd1.or.comcast.net. [24.22.13.12])
        by mx.google.com with ESMTPS id gv1sm9204637pbc.38.2012.09.30.15.11.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Sep 2012 15:11:05 -0700 (PDT)
X-X-Sender: torvalds@i5.linux-foundation.org
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206699>


Currently "git am" does insane things if the mbox it is given contains 
attachments with a MIME type that aren't "text/*".

In particular, it will still decode them, and pass them "one line at a 
time" to the mail body filter, but because it has determined that they 
aren't text (without actually looking at the contents, just at the mime 
type) the "line" will be the encoding line (eg 'base64') rather than a 
line of *content*.

Which then will cause the text filtering to fail, because we won't 
correctly notice when the attachment text switches from the commit message 
to the actual patch. Resulting in a patch failure, even if patch may be a 
perfectly well-formed attachment, it's just that the message type may be 
(for example) "application/octet-stream" instead of "text/plain".

Just remove all the bogus games with the message_type. The only difference 
that code creates is how the data is passed to the filter function 
(chunked per-pred-code line or per post-decode line), and that difference 
is *wrong*, since chunking things per pre-decode line can never be a 
sensible operation, and cannot possibly matter for binary data anyway.

This code goes all the way back to March of 2007, in commit 87ab79923463 
("builtin-mailinfo.c infrastrcture changes"), and apparently Don used to 
pass random mbox contents to git. However, the pre-decode vs post-decode 
logic really shouldn't matter even for that case, and more importantly, "I 
fed git am crap" is not a valid reason to break *real* patch attachments.

If somebody really cares, and determines that some attachment is binary 
data (by looking at the data, not the MIME-type), the whole attachment 
should be dismissed, rather than fed in random-sized chunks to 
"handle_filter()".

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>
---
 builtin/mailinfo.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2b3f4d955eaa..da231400b327 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -19,9 +19,6 @@ static struct strbuf email = STRBUF_INIT;
 static enum  {
 	TE_DONTCARE, TE_QP, TE_BASE64
 } transfer_encoding;
-static enum  {
-	TYPE_TEXT, TYPE_OTHER
-} message_type;
 
 static struct strbuf charset = STRBUF_INIT;
 static int patch_lines;
@@ -184,8 +181,6 @@ static void handle_content_type(struct strbuf *line)
 	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
 	strbuf_init(boundary, line->len);
 
-	if (!strcasestr(line->buf, "text/"))
-		 message_type = TYPE_OTHER;
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
 		if (++content_top > &content[MAX_BOUNDARIES]) {
@@ -657,7 +652,6 @@ again:
 	/* set some defaults */
 	transfer_encoding = TE_DONTCARE;
 	strbuf_reset(&charset);
-	message_type = TYPE_TEXT;
 
 	/* slurp in this section's info */
 	while (read_one_header_line(&line, fin))
@@ -871,11 +865,6 @@ static void handle_body(void)
 			strbuf_insert(&line, 0, prev.buf, prev.len);
 			strbuf_reset(&prev);
 
-			/* binary data most likely doesn't have newlines */
-			if (message_type != TYPE_TEXT) {
-				handle_filter(&line);
-				break;
-			}
 			/*
 			 * This is a decoded line that may contain
 			 * multiple new lines.  Pass only one chunk
