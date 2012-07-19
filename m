From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 6/7] build: "make clean" should not remove configure-generated files
Date: Thu, 19 Jul 2012 09:50:01 +0200
Message-ID: <904eb7b0b17805b5265ab70709241b7da382a0cb.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVR-00077p-TO
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab2GSHue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55322 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab2GSHu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:26 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2137760bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=7qNsEonBAKMpaYKSbiNiPR+xJBUAwjjuKyZHMDFtnLs=;
        b=vQPRYB65XIyQe1eqlQDJ1PGKLPWmrKpKF09TqkL3dV/Qc5A1DBUq4vQ1Ot3Rc3xWtN
         v+Qpnkslpk6CmMTsrII01vLO+7fx+tPA/W4AMdawnT6ao6ygHf9UEyIyZWQj7uzinGMt
         wV5vpqEhISiBWI9yxT9Nj/r+UycZVe/nu6R7AOC8R2PaD/i2Vu+whJdH2cUzKwnmikW1
         So9flp2YEV0gisQL9n6sIuU1BsUHPWTInhZcvwZtWw8QxDC0TPRkm35O2ApXffMIsiAa
         QzNftveZK1iP6I4Zh1okeLo5xVCvJvGokXyS7funfd1xMq/xHeuTD7aFXxGu8BaI4FIt
         5nVw==
Received: by 10.204.157.22 with SMTP id z22mr294626bkw.4.1342684225471;
        Thu, 19 Jul 2012 00:50:25 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201724>

Those filed hold variables, settings and information set by the
configuration process run by './configure'; in Autotools-based
build system that kind of stuff should only be removed by
"make distclean".  Having it removed by "make clean" is not only
inconsistent, but causes real confusion for that part of the Git
audience that is used to the Autotools semantics; for example,
an autotools old-timer that has run:

    ./configure --prefix /opt/git

in the past, without running "make distclean" afterwards, would
expect a "make install" issued after a "make clean" to rebuild and
install git in '/opt/git'; but with the current behaviour, the
"make clean" invocation removes (among the other things) the file
'config.mak.autogen', so that the "make install" falls back to the
default prefix of '$HOME', thus installing git in the user's home
directory -- definitely unexpected.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 285c660..88a76a3 100644
--- a/Makefile
+++ b/Makefile
@@ -2742,6 +2742,9 @@ dist-doc:
 
 distclean: clean
 	$(RM) configure
+	$(RM) config.log config.status config.cache
+	$(RM) config.mak.autogen config.mak.append
+	$(RM) -r autom4te.cache
 
 profile-clean:
 	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
@@ -2756,8 +2759,6 @@ clean: profile-clean
 	$(RM) -r $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
-	$(RM) -r autom4te.cache
-	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-- 
1.7.10.2.1067.g553d16e
