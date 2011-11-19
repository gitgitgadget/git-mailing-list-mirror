From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/2] MSVC: Use _putenv instead of putenv to prevent a crash
Date: Sat, 19 Nov 2011 14:52:25 +0100
Message-ID: <1321710745-2341-1-git-send-email-vfr@lyx.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Cc: msysgit@googlegroups.com, gitster@pobox.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 14:53:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRlLr-0003Pr-IW
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 14:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab1KSNwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 08:52:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65070 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab1KSNwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 08:52:36 -0500
Received: by eye27 with SMTP id 27so4237049eye.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 05:52:35 -0800 (PST)
Received: by 10.213.33.65 with SMTP id g1mr899639ebd.62.1321710755547;
        Sat, 19 Nov 2011 05:52:35 -0800 (PST)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id q28sm12397101eea.6.2011.11.19.05.52.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 05:52:35 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185692>

Git crashes when trying to clear a nonexistent environment variable using
the putenv function. The crash occurs when freeing the option string. In
debug mode the assert "CrtIsValidHeapPointer" fails.

Using _putenv instead of putenv makes the crash and assert disappear.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
The strange thing is that all over the internet people are claiming
that there is no difference between putenv and _putenv. Still, using
_putenv fixes the crash for me. 

If there is someone around who is more knowledgeable in this area,
please comment.

 compat/setenv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/setenv.c b/compat/setenv.c
index 3a22ea7..b23937d 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -23,7 +23,7 @@ int gitsetenv(const char *name, const char *value, int replace)
 	memcpy(envstr + namelen + 1, value, valuelen);
 	envstr[namelen + valuelen + 1] = 0;
 
-	out = putenv(envstr);
+	out = _putenv(envstr);
 	/* putenv(3) makes the argument string part of the environment,
 	 * and changing that string modifies the environment --- which
 	 * means we do not own that storage anymore.  Do not free
-- 
1.7.4.1
