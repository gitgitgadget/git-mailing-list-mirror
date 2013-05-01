From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed,  1 May 2013 21:50:33 +0530
Message-ID: <1367425235-14998-4-git-send-email-artagnon@gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 18:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXZlm-0006UK-96
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711Ab3EAQUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:20:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57806 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558Ab3EAQUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:20:32 -0400
Received: by mail-pa0-f49.google.com with SMTP id hk2so939097pac.36
        for <git@vger.kernel.org>; Wed, 01 May 2013 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+Y9EdjhrHtokTrXgJNG18o9buT7weheAz3affX3SmB0=;
        b=d1DHdJEGttWYCYXNqFG/USVeARjVl5URJgjGqvK9+GaVWKJ4Z2YzBxRUhZ7MI9iOAH
         hhNOM2SOc9abUZbtGPqbK/Fwz/EUg+LvQ+2QCooykqADuZrXNIOu9FOXm46gV2siKHIE
         iUdY0Mc/ZaVUtszG6690wOn0TcveAltYgfZcl7PGkEnAH/rz7QjjAQ/MKiGEuwkX35Qb
         G3DFFu0O66fJfrjCYJNsXSFys+1EjVsAmtCrp4VKdKjDwzPgFuLJZm7wkuSoQDHhFSZC
         UpUZHYONAJdG+rb6hl/ZnSIXeoSjGj23nXQY3BmC5+Mat4OGjgMY8tzS0czo+I49eiuL
         uAiA==
X-Received: by 10.68.135.133 with SMTP id ps5mr4761419pbb.158.1367425231880;
        Wed, 01 May 2013 09:20:31 -0700 (PDT)
Received: from localhost.localdomain ([122.164.132.210])
        by mx.google.com with ESMTPSA id sg4sm3549741pbc.7.2013.05.01.09.20.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 09:20:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.24.g6456091
In-Reply-To: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223096>

Presently, the logic for @-parsing is horribly convoluted.  Prove that
it is very straightforward by laying out the three cases (@{N},
@{u[upstream], and @{-N}) and explaining how each case should be
handled in comments.  All tests pass, and no functional changes have
been introduced.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index be1d12c..f30e344 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -463,9 +463,26 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		 */
 		for (at = len - 4; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
+				/* Set reflog_len only if we
+				 * don't see a @{u[pstream]}.  The
+				 * @{N} and @{-N} forms have to do
+				 * with reflog digging.
+				 */
+
+				/* Setting len to at means that we are
+				 * only going to process the part
+				 * before the @ until we reach "if
+				 * (reflog)" at the end of the
+				 * function.  That is only applicable
+				 * in the @{N} case; in the @{-N} and
+				 * @{u[pstream]} cases, we will run it
+				 * through interpret_branch_name().
+				 */
+
 				if (!upstream_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
-					len = at;
+					if (str[at + 2] != '-')
+						len = at;
 				}
 				break;
 			}
@@ -476,22 +493,34 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
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
+	if (reflog_len) {
+		if (!len)
+			/* In the @{N} case where there's nothing
+			 * before the @.
+			 */
+			refs_found = dwim_log("HEAD", 4, sha1, &real_ref);
+		else {
+			/* The @{N} case where there is something
+			 * before the @ for dwim_log to figure out,
+			 * and the @{-N} case.
+			 */
+			refs_found = dwim_log(str, len, sha1, &real_ref);
+
+			if (!refs_found && str[2] == '-') {
+				/* The @{-N} case that resolves to a
+				 * detached HEAD (ie. not a ref)
+				 */
+				struct strbuf buf = STRBUF_INIT;
+				if (interpret_branch_name(str, &buf) > 0) {
+					get_sha1_hex(buf.buf, sha1);
+					refs_found = 1;
+					reflog_len = 0;
+				}
+				strbuf_release(&buf);
+			}
 		}
-		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
-	} else if (reflog_len)
-		refs_found = dwim_log(str, len, sha1, &real_ref);
-	else
+	} else
+		/* The @{u[pstream]} case */
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
 	if (!refs_found)
@@ -506,10 +535,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
-		/* a @{-N} placed anywhere except the start is an error */
-		if (str[at+2] == '-')
-			return -1;
-
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
-- 
1.8.3.rc0.24.g6456091
