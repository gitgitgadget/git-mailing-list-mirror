From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Don't fail when an existing directory can't be created.
Date: Fri, 22 Aug 2008 10:08:46 +0200
Message-ID: <87pro1pj3l.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRiW-0001cw-0d
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYHVIIw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 04:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYHVIIv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:08:51 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52646 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYHVIIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:08:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 626322235DB0
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 10:08:47 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17949-01-88; Fri, 22 Aug 2008 10:08:46 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id CC9F2200B2C3;
	Fri, 22 Aug 2008 10:08:46 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 76B81E4801A; Fri, 22 Aug 2008 10:08:46 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93271>

This makes it possible to install in a writable directory not owned by
the current user.
---
 Documentation/Makefile |    8 ++++----
 Makefile               |    4 ++--
 gitk-git/Makefile      |    2 +-
 templates/Makefile     |   10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

I install git in /usr/local/*, to which I have write permission, but
I'm not necessarily the owner of. The permissions may look something
like this:

  drwxrwxr-x 2 root adm 4096 2008-08-07 17:54 /usr/local/bin/

To do this I set prefix=3D/usr/local and run "make install".
Unfortunately, this fails miserably because the install rules insist
on changing the permissions on any directory it installs to to
755. This of course fails because I'm not the owner. And even if it
worked, I wouldn't want it to do that.

This patch is just a simple fix to make the install not abort when it
fails to modify the directory permissions, but I have to ask why it
tries to do this at all? Most other programs I have built and
installed do not try to do this.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 7a2130a..e6271d8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -87,15 +87,15 @@ man7: $(DOC_MAN7)
 info: git.info gitman.info
=20
 install: man
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
+	-$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
+	-$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
+	-$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
 	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
=20
 install-info: info
-	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
+	-$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
 	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(infodir)
 	if test -r $(DESTDIR)$(infodir)/dir; then \
 	  $(INSTALL_INFO) --info-dir=3D$(DESTDIR)$(infodir) git.info ;\
diff --git a/Makefile b/Makefile
index e8712e0..e6bb411 100644
--- a/Makefile
+++ b/Makefile
@@ -1341,8 +1341,8 @@ gitexec_instdir_SQ =3D $(subst ','\'',$(gitexec_i=
nstdir))
 export gitexec_instdir
=20
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	-$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
+	-$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-arch=
ive$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1b6045..117b841 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -41,7 +41,7 @@ all:: gitk-wish $(ALL_MSGFILES)
=20
 install:: all
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	-$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msg=
sdir_SQ)' &&) true
=20
 uninstall::
diff --git a/templates/Makefile b/templates/Makefile
index 67be379..58f2bdd 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -26,10 +26,10 @@ boilerplates.made : $(bpsrc)
 	$(QUIET)ls *--* 2>/dev/null | \
 	while read boilerplate; \
 	do \
-		case "$$boilerplate" in *~) continue ;; esac && \
-		dst=3D`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
-		dir=3D`expr "$$dst" : '\(.*\)/'` && \
-		$(INSTALL) -d -m 755 blt/$$dir && \
+		case "$$boilerplate" in *~) continue ;; esac ; \
+		dst=3D`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` ; \
+		dir=3D`expr "$$dst" : '\(.*\)/'` ; \
+		$(INSTALL) -d -m 755 blt/$$dir ; \
 		case "$$boilerplate" in \
 		*--) ;; \
 		*) cp -p $$boilerplate blt/$$dst ;; \
@@ -46,6 +46,6 @@ clean:
 	$(RM) -r blt boilerplates.made
=20
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
+	-$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xf -=
)
--=20
1.6.0.rc2.7.gbf8a


--=20
David K=C3=A5gedal
