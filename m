From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] git_remote_cvs: Honor DESTDIR in the Makefile
Date: Sun, 16 Aug 2009 13:38:07 -0700
Message-ID: <1250455088-23457-1-git-send-email-davvid@gmail.com>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, mhagger@alum.mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sun Aug 16 22:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McmV6-0004hc-6y
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 22:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbZHPUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbZHPUik
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 16:38:40 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:60466 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbZHPUij (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 16:38:39 -0400
Received: by pzk34 with SMTP id 34so1659201pzk.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QcVgsAV1xWk1kMUeXXZh3agsW64t8NVJGflq1uV4xEg=;
        b=WIHDS03g+HIgHw2s6mbmlo8GBw28p9u48ja8yCfFzaCCha2dO2J76r813qsFQEU8kO
         keQdPeCrsO4xuI+zAsWBmfYXIgZuQpf9w9TjLZaNwN6k2TdswVvNVxMQIheyFCJ5O7MF
         K/zvFv0C6Iw//nok6EkntoASEa5B8IhFyfbs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gaR8MDK6uVaJuwSWfP9sO3dsI3PYmYd2UC3vUkwEvEPzl8TCN17oao3IozAPtzOUMg
         RZReIQ+VygyM95QQQCep4xjmmFHwTqXJKX3Z4S9TXuUQwoMRyxQSuvmOGZmyODS7gcp4
         HCkjBG4boRE4vYbs2c8ihiyRzkrUIUfGlL6Ic=
Received: by 10.115.19.2 with SMTP id w2mr3978187wai.144.1250455120842;
        Sun, 16 Aug 2009 13:38:40 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c26sm2706803waa.50.2009.08.16.13.38.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 13:38:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.169.g64d5
In-Reply-To: <7v7hx35ym1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126073>

This adds the --root=<path> flag to setup.py so that the
user-provided DESTDIR is honored.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git_remote_cvs/Makefile |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index 8dbf3fa..f52c096 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -3,6 +3,15 @@
 #
 pysetupfile:=setup.py
 
+# Setup the DESTDIR for Python.
+ifeq ($(DESTDIR),)
+PYTHON_DESTDIR = /
+else
+PYTHON_DESTDIR = $(DESTDIR)
+endif
+# Shell quote (do not use $(call) to accommodate ancient setups);
+PYTHON_DESTDIR_SQ = $(subst ','\'',$(PYTHON_DESTDIR))
+
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
@@ -19,7 +28,10 @@ PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' %
 all: $(pysetupfile)
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
 install: $(pysetupfile)
-	$(PYTHON_PATH) $(pysetupfile) install --prefix $(prefix)
+	$(PYTHON_PATH) $(pysetupfile) install \
+		--prefix $(prefix) \
+		--root $(PYTHON_DESTDIR_SQ)
+
 instlibdir: $(pysetupfile)
 	@echo "$(prefix)/$(PYLIBDIR)"
 clean:
-- 
1.6.4.169.g64d5
