From: "Tim O Callaghan" <timo@dspsrv.com>
Subject: [PATCH] First cut of a Cygwin package creation target.
Date: Tue, 11 Oct 2005 15:26:33 +0100 (IST)
Message-ID: <23711.145.36.10.111.1129040793.squirrel@www.dspsrv.com>
Reply-To: timo@dspsrv.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Oct 11 16:30:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPL5v-0006cP-JD
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 16:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVJKO1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVJKO1E
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 10:27:04 -0400
Received: from vir.dspsrv.com ([193.120.211.34]:45802 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S932100AbVJKO1C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 10:27:02 -0400
Received: from www-data by dspsrv.com with local (Exim 3.36 #1)
	id 1EPL5N-0001lL-00
	for git@vger.kernel.org; Tue, 11 Oct 2005 15:26:33 +0100
Received: from 145.36.10.111
        (SquirrelMail authenticated user timo)
        by www.dspsrv.com with HTTP;
        Tue, 11 Oct 2005 15:26:33 +0100 (IST)
To: git@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9966>


The new make target 'cygwinpackage' creates dist tars based on the
Cygwin package guidelines at:http://cygwin.com/setup.html

The tar packages when created are placed in the cygwin directory with
the Cygwin setup specific setup.hint file, ready for distribution.

Signed-off-by: Tim O'Callaghan <timo@dspsrv.com>

---

 Makefile          |   20 ++++++++++++++++++++
 cygwin/setup.hint |   11 +++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 Makefile
 create mode 100755 cygwin/setup.hint

applies-to: 2bab3caf63fc29f249c792289365abaf1cfa071b
ba3be06048f361afc80baae30b00dd6e022386d0
diff --git a/Makefile b/Makefile
old mode 100644
new mode 100755
index c31af7b..1a227ed
--- a/Makefile
+++ b/Makefile
@@ -441,6 +441,26 @@ deb: dist
        dpkg-source -b $(GIT_TARNAME)
        cd $(GIT_TARNAME) && fakeroot debian/rules binary

+unexport prefix
+export prefix=/
+export DESTDIR=/tmp/cygwin/usr
+cygwinpackage: all
+       strip -s *.exe
+       rm -f $(GIT_TARNAME)*.tar*
+       ./git-tar-tree HEAD $(GIT_TARNAME) > $(GIT_TARNAME)-src.tar
+       mkdir -p $(GIT_TARNAME)
+       cp README $(GIT_TARNAME)/git-core-$(GIT_VERSION).README
+       $(TAR) rf $(GIT_TARNAME).tar
$(GIT_TARNAME)/git-core-$(GIT_VERSION).README
+       @rm -rf $(GIT_TARNAME)
+       bzip2 $(GIT_TARNAME)-src.tar
+       rm -rf $(DESTDIR)
+       mkdir -p $(DESTDIR)/man/man1 $(DESTDIR)/man/man7
$(DESTDIR)/share/Cygwin
+       cp README $(DESTDIR)/share/Cygwin/git-core-$(GIT_VERSION).README
+       $(MAKE) install
+       $(MAKE) -C Documentation install
+       cd /tmp/cygwin; $(TAR) -jcf /tmp/$(GIT_TARNAME).tar.bz2 *
+       mv /tmp/$(GIT_TARNAME).tar.bz2 ./$(GIT_TARNAME)-src.tar.bz2 ./cygwin
+
 ### Cleaning rules

 clean:
diff --git a/cygwin/setup.hint b/cygwin/setup.hint
new file mode 100755
index 0000000..580eecc
--- /dev/null
+++ b/cygwin/setup.hint
@@ -0,0 +1,11 @@
+# git-core setup.hint - file required by cygwin package manager
+#
+# short description
+sdesc: "Git-core - SCM Developed for the Linux kernel"
+# long description
+ldesc: "Git-core - SCM Developed for the Linux kernel - now available to
the windows masses via the magic of Cygwin"
+# package category
+category: Archive Devel
+# dependencies
+requires: cygwin libiconv zlib openssl curl-devel diff merge ssh
+
---
0.99.8.GIT
