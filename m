From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] gitk - convert gitk-path to Windows if on Cygwin
Date: Sat, 14 Jun 2008 20:33:33 -0400
Message-ID: <1213490013-908-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: paulus@samba.org, spearc@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 02:34:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7gCc-0004wC-BK
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 02:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbYFOAdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755867AbYFOAdn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 20:33:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:42577 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858AbYFOAdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 20:33:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2816848ywe.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=15dOc2JQLDqiLXxRy537hPHKSLX2CcBUpy2L+sZhQGc=;
        b=reKeW/9mUWBl5brSy7AAl3kVeVWA/+TY2iQaS8n8Io9bWLuZeocRzYYqVEqRV1PzrS
         I0Iyb/4tm+b6hSNQs6dVXlWA2sm/B+HSay5VwyQ+qrWP56m2ZiVmMO0i2DBu6yh15JzL
         3ocU68ZxRIZ+RutvQKUXCMvYidz16gs4wSJSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rjqN6vWA8foda0Z5f1ua/GU7ST6PDiIo8Hvv4NiO06UvWgdm/QLRYvK4RTPBh/hzMF
         kH90K0yi+qCxQMFYX0FF7hfNUy1tR30fTo/yak4pg+IsBbiMnMoScxieNErdPcQsYBqP
         XX1B9ikPiYgJssa3cKEt1oGA9GTsY4Ikqx/Ps=
Received: by 10.151.155.19 with SMTP id h19mr7623313ybo.36.1213490017630;
        Sat, 14 Jun 2008 17:33:37 -0700 (PDT)
Received: from localhost.localdomain ( [71.191.242.223])
        by mx.google.com with ESMTPS id 6sm5563104ywi.1.2008.06.14.17.33.35
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 17:33:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.65.gcb6b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85056>

Cygwin does not have a recent Tcl release (it is stuck at 8.4.1), and
there is small chance this will change soon. The only way Cygwin users
can have a more recent Tcl/Tk is to use a pure Windows release. However,
these do not understand POSIX paths as used in Cygwin. This really only
matters for finding the gitk script itself, all other arguments are
interpreted by git which is POSIX. This patch modifies gitk to convert
the path to the gitk script from POSIX to Windows before execution.

This patch was inspired by a patch submitted long ago by Shawn Pierce.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e1b6045..742ae5b 100644
--- a/Makefile
+++ b/Makefile
@@ -51,9 +51,15 @@ uninstall::
 clean::
 	$(RM) gitk-wish po/*.msg
 
+OS := $(shell sh -c 'uname -o 2>/dev/null')
+ifeq ($(OS), Cygwin)
+	EXECLINE = argv0=`cygpath --windows --absolute "$$0"`; \\\nexec $(TCLTK_PATH_SQ) "$$argv0" -- "$$@"
+else
+	EXECLINE = exec $(TCLTK_PATH_SQ) "$$0" -- "$$@"
+endif
 gitk-wish: gitk
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
+	sed -e '1,3s|^exec .*|$(EXECLINE)|' <gitk >$@+ && \
 	chmod +x $@+ && \
 	mv -f $@+ $@
 
-- 
1.5.6.rc2.65.gcb6b9
