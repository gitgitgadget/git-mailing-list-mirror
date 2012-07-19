From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 7/7] build: reconfigure automatically if configure.ac changes
Date: Thu, 19 Jul 2012 09:50:02 +0200
Message-ID: <173104dd1ddba55bca09e89ba090ebb852bdf1b7.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVR-00077p-E7
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab2GSHud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43518 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2GSHu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:28 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2137770bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=fcKARCUMS7UVsiBPtbf89ho8FiS/XtnBVQMdPoUQuuY=;
        b=XjQWYqtNbpuSnO3Yh4M0bjxu0JclcwTgXlZ53PYEIpdjNpmb/W3qxjOtGAhA2KL5if
         8+6dZIs6NNNwfYTzhnpKxC7BOOfY78g5B37g3XP1h/KekPSdNIIDc0Wk971mb/z+gesu
         MOGaG4XmQ8AlGhznMKFrz4BKsdLGHL7ijdZJKPW9GG7X5/qubnqdcEqey/qQdo+7uAAW
         0mOVix0YH1W/SfDtu0+TUq0hfLBut2VefMeqFTdV3FPdRWcfZHmBOtkQNqD4qTD8i9T2
         GaRgN4kLBuJYoKoJI/5BlXm1JnQN1DRRYJOdfe+u0v4yYT4ip7nb926vfwQdoTG5ryn2
         5UhQ==
Received: by 10.204.153.28 with SMTP id i28mr290245bkw.19.1342684227727;
        Thu, 19 Jul 2012 00:50:27 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201725>

This provides a reduced but still useful sibling of the Automake's
"automatic Makefile rebuild" feature.  It's important to note that
we take care to enable the new rules only if the tree that has already
be configured with './configure', so that users relying on manual
configuration won't be negatively impacted.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile     | 12 ++++++++++++
 configure.ac |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index 88a76a3..f4e8fac 100644
--- a/Makefile
+++ b/Makefile
@@ -2158,6 +2158,18 @@ configure: configure.ac GIT-VERSION-FILE
 	autoconf -o $@ $<+ && \
 	$(RM) $<+
 
+ifdef AUTOCONFIGURED
+config.status: configure
+	$(QUIET_GEN)if test -f config.status; then \
+	  ./config.status --recheck; \
+	else \
+	  ./configure; \
+	fi
+reconfigure config.mak.autogen: config.status
+	$(QUIET_GEN)./config.status
+.PHONY: reconfigure # This is a convenience target.
+endif
+
 XDIFF_OBJS += xdiff/xdiffi.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
diff --git a/configure.ac b/configure.ac
index a63fe77..df7e376 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,6 +148,8 @@ AC_CONFIG_SRCDIR([git.c])
 config_file=config.mak.autogen
 config_in=config.mak.in
 
+GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])
+
 # Directories holding "saner" versions of common or POSIX binaries.
 AC_ARG_WITH([sane-tool-path],
   [AS_HELP_STRING(
-- 
1.7.10.2.1067.g553d16e
