From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] fast-export: quote paths with spaces
Date: Mon, 25 Jun 2012 16:12:00 -0400
Message-ID: <1340655120-89736-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 22:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjFeB-0001aJ-TS
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab2FYUMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 16:12:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37294 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2FYUMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 16:12:16 -0400
Received: by yenl2 with SMTP id l2so3192009yen.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hVqrTWrr2Zg3TkecNkaC4f1ZMxZ35LeXFO3jU5Qn92w=;
        b=P0DVEEpcRMIje+hJqKapiGt0XFuMroUH1zlqLjHrSs5VzPFQiq96jjVkUdPcjf8vG3
         P/Ue2ZvW42MuCqq9K/G/I+qkjuMLQfoZcPVTRaAHP8ihFpzbuvTnfRw+afNyp9qy/Xrv
         7zY8tzw0+vmtBVXZG9tHNm0QOxdHLfQf+b8WMfoJEiOZN9L5sIQJYeB0DOF4U+YKYFUJ
         t3cKzUDMgsNJA8QCydL1hf3L+E0SsUeyV7Z3xs+OTd9Sng8Btu8gltPbzLpCp3h2L3MQ
         neqUoZPik4VJHyd5ypYEeHW4+RASo329iEiUXmnbFjav5g9SBDgTECw8q2sQLEC/uX1r
         LTTw==
Received: by 10.236.73.6 with SMTP id u6mr15019895yhd.31.1340655136323;
        Mon, 25 Jun 2012 13:12:16 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id p3sm58102377ano.11.2012.06.25.13.12.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 13:12:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200596>

A path containing a space must be quoted when used as an argument to
either the copy or rename commands. 6280dfdc3b (fast-export: quote paths
in output, 2011-08-05) previously attempted to fix fast-export's quoting
by passing all paths through quote_c_style(). However, that function does
not consider the space to be a character which requires quoting, so let's
special-case the space inside print_path(). This will cause
space-containing paths to also be quoted in other commands where such
quoting is not strictly necessary, but it does not hurt to do so.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Sorry, not test added. I barely had time to get out this patch. :-(

 builtin/fast-export.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ef7c012094..cc5ef82fe6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -183,9 +183,11 @@ static int depth_first(const void *a_, const void *b_)
 static void print_path(const char *path)
 {
 	int need_quote = quote_c_style(path, NULL, NULL, 0);
-	if (need_quote)
+	if (need_quote) {
 		quote_c_style(path, NULL, stdout, 0);
-	else
+	} else if (strchr(path, ' ')) {
+		printf("\"%s\"", path);
+	} else
 		printf("%s", path);
 }
 
-- 
1.7.11
