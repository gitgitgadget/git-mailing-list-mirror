From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1] autoconf: Use autoconf to write installation directories to config.mak.autogen
Date: Mon, 3 Jul 2006 01:56:48 +0200
Message-ID: <200607030156.50455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 03 01:56:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxBnn-0001yV-4r
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 01:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWGBX4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGBX4a
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 19:56:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:6062 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750703AbWGBX43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 19:56:29 -0400
Received: by nf-out-0910.google.com with SMTP id k26so310821nfc
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 16:56:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TnjhCCxPPjqk1dU0ffeKBwd0OrhLSbuN2FGiMq9WB9VOgjmAbNg40POI7gLJmJD0s70Ngnc+B/T+Uqtj9ax/daknubmU9aAQpcdupNEQB0XZzMjrF8LnDU7PbfJUxjHudWPTgM+sJFB/rA9BZjl0R1eo/oaKJ7HbBa5RgZxne94=
Received: by 10.48.43.11 with SMTP id q11mr1935043nfq;
        Sun, 02 Jul 2006 16:56:28 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id k23sm3904234nfc.2006.07.02.16.56.27;
        Sun, 02 Jul 2006 16:56:28 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23137>

This is beginning of patch series introducing installation configuration
using autoconf (and no other autotools) to git. The idea is to generate
config.mak.autogen using ./configure (generated from configure.ac by running
autoconf) from config.mak.in, so one can use autoconf as an _alternative_ to
ordinary Makefile, and creating one's own config.mak. Local settings in
config.mak override generated settings in config.mak.autogen

This patch includes minimal configure.ac and config.mak.in, so one can set
installation directories using autoconf generated ./configure script
e.g. ./configure --prefix=/usr

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is to be applied on top of 'next', because to work as intended
(especially for --mandir=<path> option to ./configure) it needs
  Allow INSTALL, bindir, mandir to be set in main Makefile
  e14421b9aa85f11853a0dacae09498515daab7b8
patch (commit) to be present.

For now the following options do actually something:
	$ ./configure 
           --prefix=<prefix>         # [/usr/local]
           --exec_prefix=<prefix>    # [PREFIX]
           --bindir=<bindir>         # [EPREFIX/bin]
           --datadir=<datadir>       # [PREFIX/share]
           --mandir=<mandir>         # [PREFIX/man]

	$ ./configure --help         # hardcoded version 1.4.1

QUESTION: how to make autoconf _generate_ correct version string?


Next patch will show how this infrastructure can be used.

 .gitignore    |    6 ++++++
 INSTALL       |    9 +++++++++
 Makefile      |    1 +
 config.mak.in |   18 ++++++++++++++++++
 configure.ac  |   14 ++++++++++++++
 5 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2bcc604..616aa98 100644
--- a/.gitignore
+++ b/.gitignore
@@ -136,4 +136,10 @@ git-core.spec
 *.[ao]
 *.py[co]
 config.mak
+autom4te.cache
+config.log
+config.status
+config.mak.in
+config.mak.autogen
+configure
 git-blame
diff --git a/INSTALL b/INSTALL
index f8337e2..28245b3 100644
--- a/INSTALL
+++ b/INSTALL
@@ -13,6 +13,15 @@ that uses $prefix, the built results hav
 which are derived from $prefix, so "make all; make prefix=/usr
 install" would not work.
 
+Alternatively you can use autoconf generated ./configure script to
+set up install paths (via config.mak.autogen), so you can write instead
+
+	$ autoconf ;# as yourself if ./configure doesn't exist yet
+	$ ./configure --prefix=/usr ;# as yourself
+	$ make all doc ;# as yourself
+	# make install install-doc ;# as root
+
+
 Issues of note:
 
  - git normally installs a helper script wrapper called "git", which
diff --git a/Makefile b/Makefile
index 7dbb883..3c2c257 100644
--- a/Makefile
+++ b/Makefile
@@ -333,6 +333,7 @@ ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
 
+-include config.mak.autogen
 -include config.mak
 
 ifdef WITH_OWN_SUBPROCESS_PY
diff --git a/config.mak.in b/config.mak.in
new file mode 100644
index 0000000..82c9781
--- /dev/null
+++ b/config.mak.in
@@ -0,0 +1,18 @@
+# git Makefile configuration, included in main Makefile
+# @configure_input@
+
+prefix = @prefix@
+exec_prefix = @exec_prefix@
+bindir = @bindir@
+#gitexecdir = @libexecdir@/git-core/
+template_dir = @datadir@/git-core/templates/
+GIT_PYTHON_DIR = @datadir@/git-core/python
+
+mandir=@mandir@
+
+srcdir = @srcdir@
+VPATH = @srcdir@
+
+export exec_prefix mandir
+export srcdir VPATH
+
diff --git a/configure.ac b/configure.ac
new file mode 100644
index 0000000..a54b164
--- /dev/null
+++ b/configure.ac
@@ -0,0 +1,14 @@
+#                                               -*- Autoconf -*-
+# Process this file with autoconf to produce a configure script.
+
+AC_PREREQ(2.59)
+AC_INIT([git], [1.4.1], [git@vger.kernel.org])
+
+AC_CONFIG_SRCDIR([git.c])
+
+config_file=config.mak.autogen
+config_in=config.mak.in
+
+# Output files
+AC_CONFIG_FILES(["${config_file}":"${config_in}"]) 
+AC_OUTPUT
-- 
1.4.0
