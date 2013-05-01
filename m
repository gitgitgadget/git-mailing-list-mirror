From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] sha1_name.c: don't waste cycles in the @-parsing loop
Date: Wed,  1 May 2013 21:50:32 +0530
Message-ID: <1367425235-14998-3-git-send-email-artagnon@gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 18:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXZll-0006UK-5G
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab3EAQUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:20:32 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55134 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807Ab3EAQU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:20:29 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so807325pbc.3
        for <git@vger.kernel.org>; Wed, 01 May 2013 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q6vL0l+1iglmtyMZthwuw+MPC6oO0ZnS3uyj5sfX+VU=;
        b=sKDbg0ArnW6NQmURyJ7yd97jBKEv0Z5QhdQWpNyqzJkNChEqtqdYk/nDmL5X+M/zRd
         AxlcidGXYh907lijviMK+WsFEdEvvIhJw+LAtaCIaLaiKEPkAsKyh6hjD/mUjshRlIZv
         gBzQAaexzSPjjQsRVeMDEiDujL2Md7yQdJdPDZRba86LkCdkq5ptcOWo3zrMfxTaRuRr
         oP6FWx47meT7s73LXFfvbkaVNnB2RdGBue1Hdluvma9/anj6lCHVa6i8hQCIX7AVjUyq
         GWNoir8TLZ10feW1hligjDdyeU0hXpgYiaydO6FBClJ6LtXg1mYTi5rQJw5fWloqXhR6
         Ip7Q==
X-Received: by 10.66.240.41 with SMTP id vx9mr5715289pac.121.1367425229031;
        Wed, 01 May 2013 09:20:29 -0700 (PDT)
Received: from localhost.localdomain ([122.164.132.210])
        by mx.google.com with ESMTPSA id sg4sm3549741pbc.7.2013.05.01.09.20.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 09:20:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.24.g6456091
In-Reply-To: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223097>

The @-parsing loop unnecessarily checks for the sequence "@{" from
len - 2 unnecessarily.  We can safely check from len - 4: write out a
comment justifying this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..be1d12c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -445,7 +445,23 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (len && str[len-1] == '}') {
-		for (at = len-2; at >= 0; at--) {
+		/* str = @}
+		 *       ^
+		 *       len - 2; expression is senseless
+		 *
+		 * str = @{}
+		 *       ^
+		 *       len - 3; expression is still senseless
+		 *
+		 * str = @{.}
+		 *       ^
+		 *       len - 4 where . is any character; expression
+		 *       is worth investigating
+		 *
+		 * Therefore, if str ends with }, search three
+		 * characters earlier for @{
+		 */
+		for (at = len - 4; at >= 0; at--) {
 			if (str[at] == '@' && str[at+1] == '{') {
 				if (!upstream_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
-- 
1.8.3.rc0.24.g6456091
