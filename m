From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] Lower priority of Cogito's default exclude patterns
Date: Sat, 07 Jan 2006 23:19:31 +0100
Message-ID: <20060107221931.10616.25897.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 23:19:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvMPV-0006i7-1G
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 23:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWAGWTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 17:19:38 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWAGWTi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 17:19:38 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:51162 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1161008AbWAGWTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 17:19:37 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060107221931.BEVV17450.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Sat, 7 Jan 2006 23:19:31 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 748D725B9;
	Sat,  7 Jan 2006 23:19:31 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14280>

Put the default exclude patterns in a file referenced with
--exclude-from, instead of on the command line with --exclude. (The
existing behavior was bad since --exclude has higher priority than
--exclude-from and --exclude-per-directory, which made it impossible
for the user to override the default patterns.)

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Makefile           |   15 +++++++++++++--
 cg-Xlib            |    6 +++++-
 cg-default-exclude |    6 ++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 700491f..9ec9d07 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,7 @@ prefix=3D$(HOME)
=20
 bindir=3D$(prefix)/bin
 libdir=3D$(prefix)/lib/cogito
+sharedir=3D$(prefix)/share/cogito
=20
 INSTALL?=3Dinstall
=20
@@ -25,6 +26,8 @@ GEN_SCRIPT=3D cg-version
=20
 VERSION=3D VERSION
=20
+SHARE_FILES=3D cg-default-exclude
+
=20
=20
 ### Build rules
@@ -62,6 +65,7 @@ test: all
 ### Installation rules
=20
 sedlibdir=3D$(shell echo $(libdir) | sed 's/\//\\\//g')
+sedsharedir=3D$(shell echo $(sharedir) | sed 's/\//\\\//g')
=20
 .PHONY: install install-cogito install-doc
 install: install-cogito
@@ -83,14 +87,20 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT)=20
 	$(INSTALL) $(LIB_SCRIPT) $(DESTDIR)$(libdir)
 	cd $(DESTDIR)$(bindir); \
 	for file in $(SCRIPT) $(GEN_SCRIPT); do \
-		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$fil=
e > $$file.new; \
+		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$fil=
e \
+		  | sed -e 's/\$${COGITO_SHARE}/"\$${COGITO_SHARE:-$(sedsharedir)\/}=
"/g' \
+		  > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
 	cd $(DESTDIR)$(libdir); \
 	for file in $(LIB_SCRIPT); do \
-		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$fil=
e > $$file.new; \
+		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$fil=
e \
+		  | sed -e 's/\$${COGITO_SHARE}/"\$${COGITO_SHARE:-$(sedsharedir)\/}=
"/g' \
+		  > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
+	$(INSTALL) -m755 -d $(DESTDIR)$(sharedir)
+	$(INSTALL) -m644 $(SHARE_FILES) $(DESTDIR)$(sharedir)
=20
 install-doc:
 	$(MAKE) -C Documentation install
@@ -98,6 +108,7 @@ install-doc:
 uninstall:
 	cd $(DESTDIR)$(bindir) && rm -f $(SCRIPT) $(GEN_SCRIPT)
 	cd $(DESTDIR)$(libdir) && rm -f $(LIB_SCRIPT)
+	cd $(DESTDIR)$(sharedir) && rm -f $(SHARE_FILES)
=20
=20
=20
diff --git a/cg-Xlib b/cg-Xlib
index 46a8a73..b1d1561 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -190,9 +190,13 @@ list_untracked_files()
 	excludeflag=3D"$1"; shift
 	EXCLUDE=3D()
 	if [ "$excludeflag" !=3D "no" -a "$excludeflag" !=3D "noexclude" ]; t=
hen
-		for excl in '*.[ao]' '.*' '!.gitignore' tags '*~' '#*' "$@"; do
+		for excl in "$@"; do
 			EXCLUDE[${#EXCLUDE[@]}]=3D"--exclude=3D$excl"
 		done
+		EXCLUDEFILE=3D"${COGITO_SHARE}cg-default-exclude"
+		if [ -f "$EXCLUDEFILE" ]; then
+			EXCLUDE[${#EXCLUDE[@]}]=3D"--exclude-from=3D$EXCLUDEFILE"
+		fi
 		EXCLUDEFILE=3D"$_git/info/exclude"
 		if [ -f "$EXCLUDEFILE" ]; then
 			EXCLUDE[${#EXCLUDE[@]}]=3D"--exclude-from=3D$EXCLUDEFILE"
diff --git a/cg-default-exclude b/cg-default-exclude
new file mode 100644
index 0000000..f24dad6
--- /dev/null
+++ b/cg-default-exclude
@@ -0,0 +1,6 @@
+*.[ao]
+.*
+!.gitignore
+tags
+*~
+#*
