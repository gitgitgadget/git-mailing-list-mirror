From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] exec_cmd.c: use find_last_dir_sep() for code simplification
Date: Fri, 19 Feb 2016 14:44:48 +0600
Message-ID: <1455871488-10460-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git @ vger . kernel . org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:49:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWgkR-0001wY-0x
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 09:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427309AbcBSItF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 03:49:05 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33235 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423568AbcBSItB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 03:49:01 -0500
Received: by mail-lb0-f173.google.com with SMTP id x4so43576969lbm.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZEw/gz8W4gisJWWrxzAnFOzwJBArrz8PMXcyFk6BB0Y=;
        b=KMG5SXkyXj+yFNP9hwlz0bF2E1jvDY6HvTgtQSXpxlLSPfqYkmql/J7W1+paLYGwFS
         cE+TtD6Nl40lKHVmU8jLZ6sAO/REnYGJVSCpWHVsjzSC0gY59MKk6pdOM+D2+hjO11pY
         5H7NOSnTbgqGxjeQ5dNdBUF3eUF7CSzPeJ4sGEQJyLHuqrQK+skdaE880AKwnvunX2B0
         tFszHi/kKb1AgMtHgdmFEu7N2PnfMn68MKbp2hFS4ffcoiNC31BE+fuuTZo5i3DaCUdd
         37VXP8X7mJyTIdpigb/UxMm98OIByyjrnSHViFW9R+HUGIHI1oH4DcbsqlVJlybRpRx/
         mtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZEw/gz8W4gisJWWrxzAnFOzwJBArrz8PMXcyFk6BB0Y=;
        b=SNw71dCoyXeselna5BGyUs8v4H6nU/kodeP3xeayw4KJMrTaQ13WQ/tGjQ4JEGIdrU
         WbS7zeB8waBTUFgBQULrRGzkbwipeUc1HotsF/PVuKKX5hWTG0rZ7KT10wpKJw9CdvcJ
         me8yQpppAgI8mcgdoeNwYMnCRlOsNVxg9L0zit2GEamv20T8sp2v9WST/Axp3CV7nW1P
         W08fXhsXrvyj9jgGhhTFr1AYhPsZUXe1cVaPXV8kIUCrXPtNaEhaZmh6sBPUjTauMcd/
         aAG/dbIk7yQleCWCXlzrBc0kLGrlOA9RuqoTwf3ueTC0pe2naGx/Xel/ktlHoGUULJo8
         9bLg==
X-Gm-Message-State: AG10YOTWSALeSJ++7/UW77dZE7Mj1p7XnEv+DNlwVoHTtfDaXLqqy35jcTviv2b8g8vnJA==
X-Received: by 10.112.170.73 with SMTP id ak9mr4844899lbc.92.1455871739785;
        Fri, 19 Feb 2016 00:48:59 -0800 (PST)
Received: from localhost.localhost ([92.46.116.183])
        by smtp.gmail.com with ESMTPSA id p191sm1406443lfp.39.2016.02.19.00.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 00:48:58 -0800 (PST)
X-Mailer: git-send-email 2.4.4.764.g5dbb725.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286669>

We are trying to extract dirname from argv0 in the git_extract_argv0_path().
But in the same time, the <git-compat-util.h> provides find_last_dir_sep()
to get dirname from a given path.  Let's use it instead of loop for the code
simplification.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 exec_cmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index e85f0fd..680b257 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -43,12 +43,10 @@ const char *git_extract_argv0_path(const char *argv0)
 
 	if (!argv0 || !*argv0)
 		return NULL;
-	slash = argv0 + strlen(argv0);
 
-	while (argv0 <= slash && !is_dir_sep(*slash))
-		slash--;
+	slash = find_last_dir_sep(argv0);
 
-	if (slash >= argv0) {
+	if (slash) {
 		argv0_path = xstrndup(argv0, slash - argv0);
 		return slash + 1;
 	}
-- 
2.4.4.764.g5dbb725.dirty
