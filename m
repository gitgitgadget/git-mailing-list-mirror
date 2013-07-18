From: Drew Northup <n1xim.email@gmail.com>
Subject: [PATCH] TIG: Fix to reinstate proper operation with no arguments
Date: Thu, 18 Jul 2013 00:51:53 -0400
Message-ID: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com>
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Drew Northup <n1xim.email@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 06:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzgD1-00079P-OT
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 06:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab3GREww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 00:52:52 -0400
Received: from mail-gg0-f179.google.com ([209.85.161.179]:34873 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3GREwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 00:52:51 -0400
Received: by mail-gg0-f179.google.com with SMTP id c2so828858ggn.10
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 21:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fAeqjLaqyPKhNGPkv8wyfUUFS14uDN7QrMV/nBu6BHE=;
        b=gQRMw3XraQq0Jc2qzgxuVz3iVU1p2taJtgiyuFpC7taXpuamafPQox8HDQVYqM9l3v
         X/9eOKZ352+LMKkmlXlqcBBQKjfY5Pkj5oOKiHGefLB3yNG+wMpGdvwUW0CoRUEVE5kn
         hEYb65CeANjFjEUR2yc89uupoVi3SfIRYVsWPPbv3chavNASLYXm2uf4lC+0dbWtA+Qf
         I6jspF8U0JQkWpZk8Dpa0r/4BgK4HiIIjHbpQ5Vh+uOGDf3/bPcjaCIan7q6jA8XUdj4
         vYatQ8o7jromO67dGkYidKWBpaI9rCc9Z7Cby8d34waXqCiS+UfRLVXVmKmwIQZ01T8E
         Lvqg==
X-Received: by 10.236.49.41 with SMTP id w29mr4675819yhb.152.1374123170987;
        Wed, 17 Jul 2013 21:52:50 -0700 (PDT)
Received: from atom.sys-os.org (pool-70-16-105-6.port.east.myfairpoint.net. [70.16.105.6])
        by mx.google.com with ESMTPSA id b48sm12695532yhc.8.2013.07.17.21.52.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 21:52:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230677>

Since c7d67ab running "tig" with no options has failed with the
error "tig: No revisions match the given arguments." This was due
to a change in how the arguments for the back-end git call was
being constructed. This change caused the blank field left in
place of "(encoding_arg)" when it is empty to not overwrite
"buf" which then caused the value in "buf" to be copied into
dst_argv twice. The resulting git command failed if there was no
available revision named "log" as shown in the trace.

>From the TIG_TRACE log:
git log log --no-color --pretty=raw --parents --parents --
fatal: bad revision 'log'

This fix works by teaching tig that when it is supplied with a
blank field in the source argument buffer that it should skip
over that field and continue instead of copying the previous
field value into the destination buffer a second time.

github issue # 167

Signed-off-by: Drew Northup <n1xim.email@gmail.com>
---

This should apply cleanly to the tig public master whether the
mkstemps() patch I wrote has been applied or not.

 tig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tig.c b/tig.c
index ba9ba98..1016cfe 100644
--- a/tig.c
+++ b/tig.c
@@ -3105,10 +3105,11 @@ static bool
 format_append_arg(struct format_context *format, const char ***dst_argv, const char *arg)
 {
 	format->bufpos = 0;
+	int len = 0;
 
 	while (arg) {
 		char *next = strstr(arg, "%(");
-		int len = next ? next - arg : strlen(arg);
+		len = next ? next - arg : strlen(arg);
 
 		if (len && !string_format_from(format->buf, &format->bufpos, "%.*s", len, arg))
 			return FALSE;
@@ -3119,7 +3120,11 @@ format_append_arg(struct format_context *format, const char ***dst_argv, const c
 		arg = next ? strchr(next, ')') + 1 : NULL;
 	}
 
-	return argv_append(dst_argv, format->buf);
+	if(len){
+		return argv_append(dst_argv, format->buf);
+	} else {
+		return TRUE;
+	}
 }
 
 static bool
-- 
1.8.0
