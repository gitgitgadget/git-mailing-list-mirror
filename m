From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Create install target for gitweb in Makefile
Date: Fri, 30 Apr 2010 01:58:22 +0200
Message-ID: <20100429235046.29606.35311.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:15:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vgM-0005ue-Re
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759499Ab0D3TNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:13:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39791 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759363Ab0D3TNj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:13:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so234225fga.1
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=HCMFUiUg4zeFyCKI3/vXEE1OLjphH8jd5xHY7BKG8SM=;
        b=U699AXd4c9MdP8a9xl9OCWTDxduYghIvRJkkemruT/jgUhuULwZfks7UMDzlHVqGH2
         70b7bFQZX4sOBh+P28ubUlnayWxA8Bwu17xUn1WC+idX/s5B3fHtteZwNuv/l500RLVu
         nmo5SsS1pRt/OZNT0EaoW9iFQxzFJoCaArG9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=EIMO6V+j2riOHojunihZ4x4Uw+qtBvbTCADKpiotrl4S4JYClH5C3iprE1I2cZreIN
         gIS9LPD/a/w9dgigjy12PKdZITn41Tw3gSUnT136FmJLFIDkXLBZJnFHzA1xZSEEWpbz
         ZAge/2oVvTa4r7xOkoeQjFTNd6gT4pns3eQ5I=
Received: by 10.86.6.37 with SMTP id 37mr2584683fgf.7.1272585527852;
        Thu, 29 Apr 2010 16:58:47 -0700 (PDT)
Received: from localhost.localdomain (abwu68.neoplus.adsl.tpnet.pl [83.8.244.68])
        by mx.google.com with ESMTPS id l12sm8775312fgb.22.2010.04.29.16.58.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Apr 2010 16:58:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3TNwMD2029719
	for <git@vger.kernel.org>; Fri, 30 Apr 2010 01:58:35 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146048>

Installing gitweb is now as easy as
  # make gitwebdir=/var/www/cgi-bin gitweb-install  ;# as root
The gitweb/INSTALL file was updated accordingly.

Fix shell quoting, i.e. setting bindir_SQ etc., in gitweb/Makefile.
Those variables were not used previously.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There is a question whether to rely on correctly set file permissions
during build phase, i.e.

	$(INSTALL) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)'

or whether to ensure correct file permissions during installl phase

	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
	$(INSTALL) -m 644 $(GITWEB_FILES)    '$(DESTDIR_SQ)$(gitwebdir_SQ)'

Currently the first option is used.

Note that install-* targets, including new install-gitweb, are not
marked as .PHONY

 Makefile        |    3 +++
 gitweb/INSTALL  |   11 ++++-------
 gitweb/Makefile |   31 +++++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..dab5a14 100644
--- a/Makefile
+++ b/Makefile
@@ -2004,6 +2004,9 @@ endif
 	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+install-gitweb:
+	$(MAKE) -C gitweb install
+
 install-doc:
 	$(MAKE) -C Documentation install
 
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 1bfd9aa..4447e26 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -6,10 +6,8 @@ First you have to generate gitweb.cgi from gitweb.perl using
 gitweb.css, git-logo.png and git-favicon.png) to their destination.
 For example if git was (or is) installed with /usr prefix, you can do
 
-	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/*.cgi gitweb/*.css \
-	     gitweb/*.js  gitweb/*.png \
-	     /var/www/cgi-bin/                ;# as root
+	$ make prefix=/usr gitweb                            ;# as yourself
+	# make gitwebdir=/var/www/cgi-bin install-gitweb     ;# as root
 
 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -18,9 +16,8 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/*.cgi gitweb/*.css \
-	     gitweb/*.js  gitweb/*.png \
-	     /var/www/cgi-bin/               ;# as root
+	# make gitwebdir=/var/www/cgi-bin \
+	       install-gitweb                ;# as root
 
 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
diff --git a/gitweb/Makefile b/gitweb/Makefile
index f2e1d92..729cf50 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -12,7 +12,10 @@ all::
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
+gitwebdir ?= /var/www/cgi-bin
+
 RM ?= rm -f
+INSTALL ?= install
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
@@ -49,9 +52,11 @@ SHELL_PATH ?= $(SHELL)
 PERL_PATH  ?= /usr/bin/perl
 
 # Shell quote;
-bindir_SQ = $(subst ','\'',$(bindir))         #'
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
-PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))  #'
+bindir_SQ = $(subst ','\'',$(bindir))#'
+gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
+PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
+DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
 
 # Quiet generation (unless V=1)
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
@@ -80,20 +85,30 @@ endif
 
 all:: gitweb.cgi
 
+GITWEB_FILES = gitweb.cgi
+
 ifdef JSMIN
+GITWEB_FILES += gitweb.min.js
 GITWEB_JS = gitweb.min.js
 all:: gitweb.min.js
 gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
+else
+GITWEB_FILES += gitweb.js
 endif
 
 ifdef CSSMIN
+GITWEB_FILES += gitweb.min.css
 GITWEB_CSS = gitweb.min.css
 all:: gitweb.min.css
 gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
+else
+GITWEB_FILES += gitweb.css
 endif
 
+GITWEB_FILES += git-logo.png git-favicon.png
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
@@ -127,8 +142,16 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	chmod +x $@+ && \
 	mv $@+ $@
 
+### Installation rules
+
+install: all
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+
+### Cleaning rules
+
 clean:
 	$(RM) gitweb.cgi gitweb.min.js gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install .FORCE-GIT-VERSION-FILE FORCE
 
