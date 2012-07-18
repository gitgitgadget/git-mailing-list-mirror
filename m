From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 7/7] build: reconfigure automatically if configure.ac changes
Date: Thu, 19 Jul 2012 00:35:02 +0200
Message-ID: <553d16eabb655a82d76b1fa73b78e1f4a86122d9.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srcqk-00064c-0h
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab2GRWff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59123 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab2GRWfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:32 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so1272200wey.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Azr240oaBEF4geEpqtq5nYwP10PXwmaXVjLuNBbhKIY=;
        b=V0O3NO/+79t77axMi6mWjW7Rf03Ubvykh3PGsrGGFCia9yWcSmaQ4fwThVk6FKQO6U
         QtIeZ7NT0iR2QvvCaJ2Fs2WmHl5mD5OYMotQ04+w0MkfxmB15LhUj57weDjmpzuOFXFa
         2JMv7dpy+3UHwh0SMm2CDnOp0zmqZV5Zgt3worKCYRBlQ8aHt2EeVzRbsIG6w0bP7D38
         aSBXyi2k/QcfP/ertwOvHEePRSyC0sijRqdmkcVoHzxQEcT1u8JkP3axirLQQpmlfabb
         I2pvsjMNDAPoQOSygY6OIYFdlH9s7CgdsN+alh6elUHitRC0zZFGxUOiXqL4+7er9+i5
         CiOw==
Received: by 10.180.90.207 with SMTP id by15mr10121535wib.22.1342650931905;
        Wed, 18 Jul 2012 15:35:31 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201704>

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
index 64eecbc..8949935 100644
--- a/configure.ac
+++ b/configure.ac
@@ -149,6 +149,8 @@ AC_CONFIG_SRCDIR([git.c])
 config_file=config.mak.autogen
 config_in=config.mak.in
 
+GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])
+
 # Directories holding "saner" versions of common or POSIX binaries.
 AC_ARG_WITH([sane-tool-path],
   [AS_HELP_STRING(
-- 
1.7.10.2.1067.g553d16e
