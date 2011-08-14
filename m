From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH resend] Makefile: Use computed header dependencies if the compiler supports it
Date: Sun, 14 Aug 2011 20:45:12 +0200
Message-ID: <1313347512-7815-1-git-send-email-frekui@gmail.com>
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 20:46:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsfi2-0004Be-R0
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 20:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab1HNSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 14:46:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45276 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab1HNSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 14:46:49 -0400
Received: by bke11 with SMTP id 11so2605614bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7Nr/oK9Wm9UnabDAvpNgcixzk76aQtJy1uT5ocT5zeY=;
        b=n+2U58rHPCtPKeFV+gEFB89ZRGcGc9GzruUDOOTdBuC4h6uSaduZTP0AUoThHgKXso
         V9rvAbOMVo7IukXdSANd6vmHb/LTYcjxmuMMfYV182Ub257sEXzFPIca3M7dlHBGmDAk
         Wu/mTICsdLyaHmky5dZZZaJSMQio5XzQkujvA=
Received: by 10.204.232.14 with SMTP id js14mr164448bkb.339.1313347608255;
        Sun, 14 Aug 2011 11:46:48 -0700 (PDT)
Received: from localhost.localdomain (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id l12sm1337037bkk.63.2011.08.14.11.46.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 11:46:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3.368.g8b1b7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179342>

Previously you had to manually define COMPUTE_HEADER_DEPENDENCIES to
enable this feature. It seemed a bit sad that such a useful feature
had to be enabled manually.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

This is a resend, it has been rebased on top of master but otherwise
the same patch was sent 2011-06-11. Jonathan Nieder has been added to
the Cc list as he implemented the computed header dependencies
feature.

 Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 8dd782f..c289074 100644
--- a/Makefile
+++ b/Makefile
@@ -250,10 +250,6 @@ all::
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
 #
-# Define COMPUTE_HEADER_DEPENDENCIES if your compiler supports the -MMD option
-# and you want to avoid rebuilding objects when an unrelated header file
-# changes.
-#
 # Define CHECK_HEADER_DEPENDENCIES to check for problems in the hard-coded
 # dependency rules.
 #
@@ -1236,6 +1232,15 @@ endif
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
+else
+dep_check = $(shell sh -c \
+	': > ++empty.c; \
+	$(CC) -c -MF /dev/null -MMD -MP ++empty.c -o /dev/null 2>&1; \
+	echo $$?; \
+	$(RM) ++empty.c')
+ifeq ($(dep_check),0)
+COMPUTE_HEADER_DEPENDENCIES=YesPlease
+endif
 endif
 
 ifdef COMPUTE_HEADER_DEPENDENCIES
-- 
1.7.5.3.368.g8b1b7.dirty
