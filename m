From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Wed,  1 May 2013 19:49:51 -0500
Message-ID: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 02:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXhjv-0002JF-O7
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 02:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759582Ab3EBAvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 20:51:12 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:49737 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758055Ab3EBAvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 20:51:10 -0400
Received: by mail-yh0-f48.google.com with SMTP id f35so16321yha.35
        for <git@vger.kernel.org>; Wed, 01 May 2013 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=lCx2YLc36NOz8aVCa9j8zxrfcaXHFP9z2u5sEU7QpYU=;
        b=ZFc+rLvJ7pPbDpGLspXF5vVug+SehAUXUbf59g1MTj5vTLkRBiMlrGnzPdMgtmKI2y
         zg1Ebk4ZYE2zQit8wyxjWqSnxKCIYl4qegt7p4OUvYNw4gd+wHG6InzM/zznv4MSlQas
         1tiyN5PomkdnNSsg5hDC9T5+QfAdlxt4u3jIBLCjZVvMSrKj+r4pkt5y4XKHRGXObN7/
         t6zulfdYtomfCa8ROJugkW/JHGreHmMWugibI5oQzfqXs5be28AZ1X7tZ2fhvKPUj4JA
         N/AT6oXw8Ou3jSRcJdUc8/sYBGAC52tWV3tdsv+/TzdBhW4JhNKqC/H5vCjdl6oKucsy
         sf0A==
X-Received: by 10.236.29.202 with SMTP id i50mr3364644yha.82.1367455869751;
        Wed, 01 May 2013 17:51:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n15sm9391284yhi.2.2013.05.01.17.51.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 17:51:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223169>

Through the years the functionality to handle @{-N} and @{u} has moved
around the code, and as a result, code that once made sense, doesn't any
more.

There is no need to call this function recursively with the branch of
@{-N} substituted because dwim_{ref,log} already replaces it.

However, there's one corner-case where @{-N} resolves to a detached
HEAD, in which case we wouldn't get any ref back.

So we parse the nth-prior manually, and deal with it depending on
weather it's a SHA-1, or a ref.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..110afbb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -431,6 +431,7 @@ static inline int upstream_mark(const char *string, int len)
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
+static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
@@ -438,6 +439,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
@@ -447,6 +449,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && str[len-1] == '}') {
 		for (at = len-2; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
+				if (at == 0 && str[2] == '-')
+					/* @{-N} syntax */
+					continue;
 				if (!upstream_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
@@ -460,20 +465,19 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len && ambiguous_path(str, len))
 		return -1;
 
-	if (!len && reflog_len) {
-		struct strbuf buf = STRBUF_INIT;
-		int ret;
-		/* try the @{-N} syntax for n-th checkout */
-		ret = interpret_branch_name(str+at, &buf);
-		if (ret > 0) {
-			/* substitute this branch name and restart */
-			return get_sha1_1(buf.buf, buf.len, sha1, 0);
-		} else if (ret == 0) {
-			return -1;
-		}
+	if (interpret_nth_prior_checkout(str, &buf) > 0) {
+		int detached;
+
+		detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
+		strbuf_release(&buf);
+		if (detached)
+			return 0;
+	}
+
+	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
-	} else if (reflog_len)
+	else if (reflog_len)
 		refs_found = dwim_log(str, len, sha1, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
-- 
1.8.3.rc0.399.gc96a135
