From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 12:41:27 +0200
Message-ID: <86bqe9lwy8.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 14:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB8c8-0005eb-88
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 14:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbXGRM0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 08:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbXGRM0l
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 08:26:41 -0400
Received: from main.gmane.org ([80.91.229.2]:48036 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbXGRM0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 08:26:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IB8by-0008V8-Ej
	for git@vger.kernel.org; Wed, 18 Jul 2007 14:26:34 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:26:34 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 14:26:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:mwCDxm9PR66mKofucNHs3nsg7uI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52857>


Use this, for example, to do
rm -rf /opt/git
make prefix=/opt/git install
make symlinkprefix=/usr/local prefix=/opt/git install-symlinks
---
 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 73b487f..df2fe8d 100644
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
+	@: $(MAKE) && cd '$(prefix_SQ)' && find . -mindepth 1 -type d ! \( -iname 'git*' -prune -exec echo rm -rf '$(symlinkprefix)/{}' \; \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && find . -mindepth 1 -type d ! \( -iname 'git*' -prune -exec rm -rf '$(symlinkprefix)/{}' \; \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix)/{}' \;
+	@: $(MAKE) && cd '$(prefix_SQ)' && find . -mindepth 1 \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo ln -snf '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
+	@cd '$(prefix_SQ)' && find . -mindepth 1 \( -type d -iname 'git*' -prune -o ! -type d \) -exec ln -snf '$(prefix_SQ)/{}' '$(symlinkprefix)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.rc2.41.gb47b1
