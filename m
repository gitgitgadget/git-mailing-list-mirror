From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Makefile: Improve compiler header dependency check
Date: Sat, 27 Aug 2011 01:41:10 -0700
Message-ID: <1314434470-7988-1-git-send-email-davvid@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 10:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxESG-0000Tg-QS
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 10:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1H0IlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 04:41:24 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34846 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1H0IlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 04:41:23 -0400
Received: by pzk37 with SMTP id 37so5514628pzk.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3CBSKNMlD1vJ5IqwKeY9rc/bMVZzBqEgbqdIt/nGZrc=;
        b=DspUfD8ojy4FwCkuAdy+oBGGZzUxxJHPvVLTyb9S+7Bw8mKE+mY5RSMuU2G9FOsaQL
         XJhMWcCZxWWjlZhzrxTBDRxcMOLlqdOGceO2u36k7IegRObU3nKjLwRNRNwzUMzQTqQu
         d/EVL+TW6w23HYgME5sN+PIFeAAzMLSPkvL8U=
Received: by 10.142.234.11 with SMTP id g11mr1086284wfh.304.1314434482715;
        Sat, 27 Aug 2011 01:41:22 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id s8sm2489194wff.5.2011.08.27.01.41.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 01:41:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180225>

The Makefile enables CHECK_HEADER_DEPENDENCIES when the
compiler supports generating header dependencies.
Make the check use the same flags as the invocation
to avoid a false positive when user-configured compiler
flags contain incompatible options.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I fired up git's next branch on a mac laptop where I
have a config.mak that builds universal git binaries:

CFLAGS = -arch i386 -arch x86_64

This configuration broke when 111ee18c31f9bac9436426399355facc79238566
was merged into next.  gcc cannot generate header dependencies when
multiple -arch statements are used but the test generated a false
positive.

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index aa67142..30f3812 100644
--- a/Makefile
+++ b/Makefile
@@ -1251,7 +1251,8 @@ USE_COMPUTED_HEADER_DEPENDENCIES =
 else
 ifndef COMPUTE_HEADER_DEPENDENCIES
 dep_check = $(shell sh -c \
-	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null 2>&1; \
+	'$(CC) -c -MF /dev/null -MMD -MP -x c /dev/null -o /dev/null \
+	$(ALL_CFLAGS) $(EXTRA_CPPFLAGS) 2>&1; \
 	echo $$?')
 ifeq ($(dep_check),0)
 COMPUTE_HEADER_DEPENDENCIES=YesPlease
-- 
1.7.6.476.g57292
