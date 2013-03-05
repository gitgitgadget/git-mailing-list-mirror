From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] Fix `make install` when configured with autoconf
Date: Tue,  5 Mar 2013 16:43:25 +0400
Message-ID: <1362487405-32044-1-git-send-email-kirr@mns.spb.ru>
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 13:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCrPN-0002P9-M6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 13:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3CEMz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 07:55:27 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:51932 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab3CEMz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 07:55:26 -0500
X-Greylist: delayed 704 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2013 07:55:26 EST
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1UCrDW-0007GB-4k; Tue, 05 Mar 2013 16:43:38 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1UCrDR-0008Lp-Ja; Tue, 05 Mar 2013 16:43:33 +0400
X-Mailer: git-send-email 1.8.2.rc2.353.gd2380b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217448>

Commit d8cf908c (config.mak.in: remove unused definitions) removed

    exec_prefix = @exec_prefix@

from config.mak.in, because nobody directly used ${exec_prefix}, but
overlooked that other autoconf definitions could indirectly expand that
variable.

For example the following snippet from config.mak.in

    prefix = @prefix@
    bindir = @bindir@
    gitexecdir = @libexecdir@/git-core
    datarootdir = @datarootdir@
    template_dir = @datadir@/git-core/templates
    sysconfdir = @sysconfdir@

is expanded to

    prefix = /home/kirr/local/git
    bindir = ${exec_prefix}/bin                             <-- HERE
    gitexecdir = ${exec_prefix}/libexec/git-core            <--
    datarootdir = ${prefix}/share
    template_dir = ${datarootdir}/git-core/templates
    sysconfdir = ${prefix}/etc

on my system, after `configure --prefix=$HOME/local/git`

and withot exec_prefix being defined there I get an error on
install:

    install -d -m 755 '/bin'
    install -d -m 755 '/libexec/git-core'
    install: cannot create directory `/libexec': Permission denied
    Makefile:2292: recipe for target `install' failed

Fix it.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 config.mak.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.in b/config.mak.in
index 7440687..e6a6d0f 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -12,6 +12,7 @@ PACKAGE_TARNAME = @PACKAGE_TARNAME@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 
 prefix = @prefix@
+exec_prefix = @exec_prefix@
 bindir = @bindir@
 gitexecdir = @libexecdir@/git-core
 datarootdir = @datarootdir@
-- 
1.8.2.rc2.353.gd2380b4
