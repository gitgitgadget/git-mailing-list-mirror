From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui/Makefile - Handle $DESTDIR on Cygwin
Date: Thu, 17 Jan 2008 22:50:23 -0500
Message-ID: <1200628223-2280-1-git-send-email-mlevedahl@gmail.com>
References: <20080116064012.GO24004@spearce.org>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: spearc@spearce.org
X-From: git-owner@vger.kernel.org Fri Jan 18 04:51:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFiFy-0000p0-6H
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 04:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbYARDud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 22:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYARDuc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 22:50:32 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:16367 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYARDuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 22:50:32 -0500
Received: by an-out-0708.google.com with SMTP id d31so195472and.103
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 19:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mpu545rVi5ZWM5j+qMJAyWY1wMTtNR3I4GUr4tmGRqU=;
        b=QK+1xVJmiK6cYTJ2j9Wyf8A12O8SI9Zn53IzajT1pTSf2HURo+Rs1Qa7S3PiQMX1D6raTe+EUY8Y7tLOPruY3/i4bbhhrJt0Irphg2ol0EjJOguy1gfHseY+TO9qm2VVRqjNrZdZ/Jum2T6pL0/7IeZk9ewiBBGWkqd563p8aEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BgkwBxG/g5Cp644mRKVvuH5UVG3qZ18GZtcyvMfjbiWN11IWZxgVwl+1pGA4t3QMie4vAkSo29K9YcSJp3dauV588DWZbt90Lkc2RgkO7iJsM4000eBQucCgTEX89qjEJsQ6BlWzkaZETEyj6sdtAeSMsdf6qRljcTyEMIb4uj8=
Received: by 10.100.202.9 with SMTP id z9mr6063859anf.42.1200628229795;
        Thu, 17 Jan 2008 19:50:29 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id c39sm5191997anc.25.2008.01.17.19.50.26
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Jan 2008 19:50:27 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3.26.gf961e
In-Reply-To: <20080116064012.GO24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70959>

From: Mark Levedahl <mdl123@verizon.net>

gg_libdir is converted to an absolute Windows path on Cygwin,
but a later step attempts to prefix $DESTDIR to install to a
staging directory. Explicitly separate the uses of gg_libdir for
these two purposes so installation to $DESTDIR will work.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
git-gui built with this  passed tests on cygwin + tcl/tk 8.5,
cygwin + normal tcl/tk, and linux. DESTDIR also works on cygwin,
so I would suggest this rather than the previous patch.


 git-gui/Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index c109eab..1baf4b0 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -110,7 +110,7 @@ TCLTK_PATH_SED = $(subst ','\'',$(subst \,\\,$(TCLTK_PATH)))

 gg_libdir ?= $(sharedir)/git-gui/lib
 libdir_SQ  = $(subst ','\'',$(gg_libdir))
-libdir_SED = $(subst ','\'',$(subst \,\\,$(gg_libdir)))
+libdir_SED = $(subst ','\'',$(subst \,\\,$(gg_libdir_sed_in)))
 exedir     = $(dir $(gitexecdir))share/git-gui/lib

 GITGUI_SCRIPT   := $$0
@@ -119,11 +119,12 @@ GITGUI_MACOSXAPP :=

 ifeq ($(uname_O),Cygwin)
 	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-	gg_libdir := $(shell cygpath --windows --absolute "$(gg_libdir)")
+	gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
 else
 	ifeq ($(exedir),$(gg_libdir))
 		GITGUI_RELATIVE := 1
 	endif
+	gg_libdir_sed_in := $(gg_libdir)
 endif
 ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
--
1.5.4.rc3.26.gf961e
