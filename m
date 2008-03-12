From: ludo@gnu.org (Ludovic =?iso-8859-1?Q?Court=E8s?=)
Subject: [PATCH] Fix Info documentation build with Docbook2X 0.8.8
Date: Wed, 12 Mar 2008 16:30:10 +0100
Message-ID: <87lk4o7yf1.fsf@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 16:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZSzc-0003Qs-Ha
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 16:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbYCLPfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 11:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYCLPfJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 11:35:09 -0400
Received: from main.gmane.org ([80.91.229.2]:48057 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbYCLPfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 11:35:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JZSys-0005Yc-Qb
	for git@vger.kernel.org; Wed, 12 Mar 2008 15:35:02 +0000
Received: from 193.50.110.109 ([193.50.110.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 15:35:02 +0000
Received: from ludo by 193.50.110.109 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 15:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 193.50.110.109
X-Revolutionary-Date: 23 =?iso-8859-1?Q?Vent=F4se?= an 216 de la
 =?iso-8859-1?Q?R=E9volution?=
X-PGP-Key-ID: 0xEB1F5364
X-PGP-Key: http://www.laas.fr/~lcourtes/ludovic.asc
X-PGP-Fingerprint: 821D 815D 902A 7EAB 5CEE  D120 7FBA 3D4F EB1F 5364
X-OS: i686-pc-linux-gnu
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:jhzicR77DnY0Esj6KmS4K1HjPJg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76957>

--=-=-=

Hi,

The attached patch against 1.5.4.4 (from NixOS/Nixpkgs) fixes build of
the user manual in Info (i.e., `git.info') through Docbook2X 0.8.8.
Actually, it does two things:

  1. Fix the value of `DOCBOOK2TEXI' to match the name currently used in
     Docbook2X (I don't know when that name change occurred).

  2. Disable build of `gitman.info', which cannot be built because of
     duplicate node names:

     $ makeinfo gitman.texi
     gitman.texi:273: Node `DESCRIPTION' previously defined at line 153.
     gitman.texi:281: Node `OPTIONS' previously defined at line 163.
     gitman.texi:360: Node `DISCUSSION' previously defined at line 205.
     [...]

A related patch against Docbook2X 0.8.8 is needed to make `--to-stdout'
work as expected [0].

Thanks,
Ludovic.

[0] http://sourceforge.net/tracker/index.php?func=detail&aid=1912754&group_id=7856&atid=107856


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=docbook2texi.patch
Content-Description: The patch

This patch does two things: (1) use the right name for `docbook2texi',
and (2) make sure `gitman.info' isn't produced since it's broken (duplicate
node names).

--- git-1.5.4.4/Documentation/Makefile~	2008-03-09 11:18:13.000000000 +0100
+++ git-1.5.4.4/Documentation/Makefile	2008-03-12 16:04:05.000000000 +0100
@@ -53,7 +53,7 @@ DOC_REF = origin/man
 infodir?=$(prefix)/share/info
 MAKEINFO=makeinfo
 INSTALL_INFO=install-info
-DOCBOOK2X_TEXI=docbook2x-texi
+DOCBOOK2X_TEXI=docbook2texi
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -89,7 +89,7 @@ man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
 
-info: git.info gitman.info
+info: git.info
 
 install: man
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
@@ -101,10 +101,9 @@ install: man
 
 install-info: info
 	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
-	$(INSTALL) -m 644 git.info gitman.info $(DESTDIR)$(infodir)
+	$(INSTALL) -m 644 git.info $(DESTDIR)$(infodir)
 	if test -r $(DESTDIR)$(infodir)/dir; then \
 	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
-	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) gitman.info ;\
 	else \
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi

--=-=-=--
