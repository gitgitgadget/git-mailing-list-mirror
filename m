From: David Kastrup <dak@gnu.org>
Subject: [PATCH 1/2] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 12:41:27 +0200
Message-ID: <6e14af24a3aa8af7e21e0a3f92c83c82e147202a.1184770193.git.dak@gnu.org>
References: <86bqe9lwy8.fsf@lola.quinscape.zz> <81b0412b0707180608j7c22631ak87f3ddd6481bccf2@mail.gmail.com> <861wf5iz6o.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 16:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBAtz-0002so-RG
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 16:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbXGROxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbXGROxL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 10:53:11 -0400
Received: from main.gmane.org ([80.91.229.2]:50030 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764379AbXGROxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 10:53:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBAth-0000zI-Ia
	for git@vger.kernel.org; Wed, 18 Jul 2007 16:53:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:53:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:53:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:IdgdrX5NbmpKaYsJG080GYRldcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52866>


This target allows you to have git installed in one location,
and have symbolic links to all of the programs installed in
another	location.  For example, if git was installed to /opt/git
with

	make prefix=/opt/git install

you can install symbolic links in /usr/local/bin with

	make symlinkprefix=/usr/local prefix=/opt/git \
		install-symlinks

This makes it reasonably easy to remove such a package, by doing

	rm -rf /opt/git

and then removing stale links with

	find /usr/local -xtype l -print0|xargs -0 rm

(be sure to first see whether you indeed get only stale links listed).

This works by copying the directory hierarchy of $prefix to
$symlinkprefix (not copying or descending to any directories of the
name git* matched case-insensitively), then linking all the rest.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 73b487f..7e53378 100644
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,7 @@ ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
 prefix = $(HOME)
+symlinkprefix = /usr/local
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
@@ -996,7 +997,13 @@ install-doc:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-
+# The somewhat strange looking lines start with an ignored $(MAKE) in
+# order to be executed also in make -n calls.
+install-symlinks:
+	@: $(MAKE) && cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@: $(MAKE) && cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.rc2.41.gb47b1
