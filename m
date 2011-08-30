From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] Makefile: Improve compiler header dependency check
Date: Tue, 30 Aug 2011 01:27:35 -0700
Message-ID: <1314692855-75113-1-git-send-email-davvid@gmail.com>
References: <20110830040515.GC6647@elie.gateway.2wire.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 10:28:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyJfs-0002Wp-SY
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 10:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab1H3I1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 04:27:48 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48598 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab1H3I1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 04:27:46 -0400
Received: by pzk37 with SMTP id 37so9918090pzk.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ao4pviaQQMcXmAS3peb+l/qLxaiD2Os7VavNPvZUFUs=;
        b=D7EYmP/XZk8vIUQeQkOCF7YqAvuZuaKTyq84ORBY2yzzwXXRx6TQIWUde6/7AJB+m2
         zE95M6Rl9J0RFMR3IfpkAPd4I5SGAWmEvplgr6jLrC6ilfMCaz+LM2OYuMt6Xjz9gLNW
         e+wit4diorRf2ZIkvp0ELmkD0ZfHIf0B1mlwY=
Received: by 10.142.231.9 with SMTP id d9mr3056400wfh.53.1314692865855;
        Tue, 30 Aug 2011 01:27:45 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id x6sm22846807pba.5.2011.08.30.01.27.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 01:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.326.gf688b5
In-Reply-To: <20110830040515.GC6647@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180393>

The Makefile enables CHECK_HEADER_DEPENDENCIES when the
compiler supports generating header dependencies.
Make the check use the same flags as the invocation
to avoid a false positive when user-configured compiler
flags contain incompatible options.

For example, without this patch, trying to build universal
binaries on a Mac using CFLAGS='-arch i386 -arch x86_64'
produces:

	gcc-4.2: -E, -S, -save-temps and -M options are
	not allowed with multiple -arch flags

Make the check use the same flags as the invocation to avoid
false positives when user-configured compiler flags contain
incompatible options.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index aa67142..0ea1a2b 100644
--- a/Makefile
+++ b/Makefile
@@ -1250,9 +1250,9 @@ COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
 else
 ifndef COMPUTE_HEADER_DEPENDENCIES
-dep_check = $(shell sh -c \
-	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
-	echo $$?')
+dep_check = $(shell $(CC) $(ALL_CFLAGS) \
+	-c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
+	echo $$?)
 ifeq ($(dep_check),0)
 COMPUTE_HEADER_DEPENDENCIES=YesPlease
 endif
-- 
1.7.7.rc0.326.gf688b5
