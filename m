From: David Kastrup <dak@gnu.org>
Subject: Re: Uninstalling Git
Date: Sun, 23 Sep 2007 21:06:21 +0200
Message-ID: <85d4w9mcb6.fsf@lola.goethe.zz>
References: <46F6B0CC.3040000@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: in-call@gmx.net
X-From: git-owner@vger.kernel.org Sun Sep 23 21:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZWmp-0007Ek-A3
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbXIWTG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbXIWTG2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:06:28 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:44327 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222AbXIWTG2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 15:06:28 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 2960297B42;
	Sun, 23 Sep 2007 21:06:25 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id B24CB13F454;
	Sun, 23 Sep 2007 21:06:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 15BED1CB85B;
	Sun, 23 Sep 2007 21:06:24 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6B30F1C1F3DC; Sun, 23 Sep 2007 21:06:21 +0200 (CEST)
In-Reply-To: <46F6B0CC.3040000@gmx.net> (in-call@gmx.net's message of "Sun\, 23 Sep 2007 20\:30\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4369/Sun Sep 23 16:16:26 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58976>

in-call@gmx.net writes:

> This must be a stupid-obvious-newbie question but...
>
> Well, the point is that I installed the git version 1.5.2.1 in an
> ubuntu box.  That was done following the INSTALL instructions in the
> corresponding tarball.  I typed:
>
> $ make configure
> $ ./configure --prefix=/usr/local
> $ make all doc
> $ sudo make install install-doc
>
> First, I'd like to uninstall the thing completely, how do I do that?

Basically, you are screwed.  That being said, it might somewhat work
to do the following:

find /usr/local -depth -iname 'git*' -exec rm -rf {} \;

But I think you'll catch more if you apply the following patch, then
do

./configure --prefix=/opt/git
make all doc
sudo make install install-doc install-symlinks
sudo rm -rf /opt/git
sudo find /usr/local -lname '/opt/git/*' -delete

> Second, what would be the correct procedure to follow if I would
> like just to upgrade to a newer version? install over the older
> perhaps? Is that always safe in the sense that there won't be any
> dangling piece of bin nor doc?

There is some software called xstow which is supposed to do something
similar to the "install-symlinks" target of this patch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

From: David Kastrup <dak@gnu.org>
Date: Wed, 18 Jul 2007 16:45:36 +0200
Subject: [PATCH] Makefile: create an install-symlinks target

[commit text mostly pinched from INSTALL]

An alternative global installation method making it much easier to
uninstall is to use a package-specific prefix like /opt/git, then
create symlinks from /usr/local into that hierarchy.  Uninstalling can
then be achieved by

	# rm -rf /opt/git; find /usr/local -lname '/opt/git/*' -delete

You can create a setup like that after having used one of the above
install recipes with prefix=/opt/git by writing

	# make prefix=/opt/git symlinkprefix=/usr/local install-symlinks

This works by copying the directory hierarchy of $prefix to
$symlinkprefix (not copying or descending to any directories of the
name git* matched case-insensitively), then linking all the rest.
---
 INSTALL  |   12 ++++++++++++
 Makefile |   10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/INSTALL b/INSTALL
index 289b046..38d6fdd 100644
--- a/INSTALL
+++ b/INSTALL
@@ -21,6 +21,18 @@ set up install paths (via config.mak.autogen), so you can write instead
 	$ make all doc ;# as yourself
 	# make install install-doc ;# as root
 
+An alternative global installation method making it much easier to
+uninstall is to use a package-specific prefix like /opt/git, then
+create symlinks from /usr/local into that hierarchy.  Uninstalling can
+then be achieved by
+
+	# rm -rf /opt/git; find /usr/local -lname '/opt/git/*' -delete
+
+You can create a setup like that after having used one of the above
+install recipes with prefix=/opt/git by writing
+
+	# make prefix=/opt/git symlinkprefix=/usr/local install-symlinks
+
 
 Issues of note:
 
diff --git a/Makefile b/Makefile
index 0055eef..caea6fb 100644
--- a/Makefile
+++ b/Makefile
@@ -147,6 +147,7 @@ ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
 prefix = $(HOME)
+symlinkprefix = /usr/local
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
@@ -727,6 +728,7 @@ bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
+symlinkprefix_SQ = $(subst ','\'',$(symlinkprefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -1039,7 +1041,13 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-
+# The somewhat strange looking lines start with an ignored $(MAKE) in
+# order to be executed also in make -n calls.
+install-symlinks:
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && $(FIND) . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.1.96.g4568
