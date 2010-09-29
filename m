From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3] Makefile: implement help target
Date: Wed, 29 Sep 2010 22:15:55 +0200
Message-ID: <d2da07fe51a3aba727165b0a0de299c266097145.1285791283.git.git@drmicha.warpmail.net>
References: <7vhbh8r1zj.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 22:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P134F-0005oP-Hl
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab0I2UPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:15:52 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51488 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755771Ab0I2UPw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 16:15:52 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 93DE0A44;
	Wed, 29 Sep 2010 16:15:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Sep 2010 16:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ureOEcp3q++vARslXPIYjPtsZTU=; b=HVGuJGAOZHwViX5bGKGbx+XmU0dssbRx+DjzzINtnBfOawTvtUlwOnsLeSylEGoBsiazGgikM+a8ayiEgcd8/AKMEcghK24vuEa6peogm/T1htSjA5ba6PZagHHkApz2Yyq4k4nve7LI0C+jgdF1YkaLauYFb8uz3HSFCCsTCbc=
X-Sasl-enc: 06kMCdp+em7fieQgrf7DdjgCupF9syvn1qMVUtN+Z2+H 1285791345
Received: from localhost (p54858F8F.dip0.t-ipconnect.de [84.133.143.143])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2170040695A;
	Wed, 29 Sep 2010 16:15:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
In-Reply-To: <7vhbh8r1zj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157596>

with automatic help text collection from "help-X::" targets, where X
denotes a category for the target. This has the advantage (over a
comment based solution) that we can use make's variable expansion inside
the help text. Further exploitation of this feature is left for a future
patch.

With this, "make help" produces:

Help:
    help               - Show help for main make targets
    help-X             - Show help for category X (Build, Test, Install, Clean, Develop)
Build Git and the documentation:
    all                - Build the Git suite
    doc                - Build man pages and HTML docs
    man                - Build man pages
    html               - Build HTML doc
    info               - Build info docs
    pdf                - Build PDF docs
    dist               - Build git-1.7.3.99.gacf23.dirty.tar.gz source archive
    rpm                - Build source and binary RPM packages
    dist-doc           - Build git-manpages-1.7.3.99.gacf23.dirty.tar.gz and git-htmldocs-1.7.3.99.gacf23.dirty.tar.gz
Testing source and build:
    test               - Check the build by running the test suite
    check-docs         - Check documentation coverage
    coverage           - Check test coverage
    cover_db_html      - Check test coverage and create HTML report
Installing the Git suite and documentation:
    install            - Install the Git suite
    install-doc        - Install man pages
    install-man        - Install man pages
    install-html       - Install HTML docs
    install-info       - Install info docs
    install-pdf        - Install PDF docs
    quick-install-doc  - Install pregenerated man pages from origin/man
    quick-install-man  - Install pregenerated man pages from origin/man
    quick-install-html - Install pregenerated HTML pages from origin/html
Cleaning up after a build:
    distclean          - Remove generated files and the configure script
    clean              - Remove generated files but keep the configure script
Making development easier:
    TAGS               - Generate tags using etags
    tags               - Generate tags using ctags
    cscope             - Generate cscope index

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Does it seem as if I can't let this go?

Anyhow, here's a make based variant which is a bit more chatty in the Makefile
itself but has a ton of advantages, such as make variable expansion. Making
good use of this for the install targets is left for another patch.

 Makefile |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 108 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index db2efd6..371214d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,10 @@
 # The default target of this Makefile is...
+help-Build::
+	$(H) 'Build Git and the documentation'
+
+help-Build::
+	$(HH) all 'Build the Git suite'
+
 all::
 
 # Define V=1 to have a more verbose compile.
@@ -1952,29 +1958,56 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
+help-Build::
+	$(HH) doc 'Build man pages and HTML docs'
+
 doc:
 	$(MAKE) -C Documentation all
 
+help-Build::
+	$(HH) man 'Build man pages'
+
 man:
 	$(MAKE) -C Documentation man
 
+help-Build::
+	$(HH) html 'Build HTML doc'
+
 html:
 	$(MAKE) -C Documentation html
 
+help-Build::
+	$(HH) info 'Build info docs'
+
 info:
 	$(MAKE) -C Documentation info
 
+help-Build::
+	$(HH) pdf 'Build PDF docs'
+
 pdf:
 	$(MAKE) -C Documentation pdf
 
+help-Develop::
+	$(H) 'Making development easier'
+
+help-Develop::
+	$(HH) TAGS 'Generate tags using etags'
+
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
 
+help-Develop::
+	$(HH) tags 'Generate tags using ctags'
+
 tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
+help-Develop::
+	$(HH) cscope 'Generate cscope index'
+
 cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
@@ -2040,6 +2073,12 @@ export NO_SVN_TESTS
 
 ### Testing rules
 
+help-Test::
+	$(H) 'Testing source and build'
+
+help-Test::
+	$(HH) test 'Check the build by running the test suite'
+
 test: all
 	$(MAKE) -C t/ all
 
@@ -2099,6 +2138,12 @@ export gitexec_instdir
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+help-Install::
+	$(H) 'Installing the Git suite and documentation'
+
+help-Install::
+	$(HH) install 'Install the Git suite'
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
@@ -2155,27 +2200,51 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
+help-Install::
+	$(HH) install-doc 'Install man pages'
+
 install-doc:
 	$(MAKE) -C Documentation install
 
+help-Install::
+	$(HH) install-man 'Install man pages'
+
 install-man:
 	$(MAKE) -C Documentation install-man
 
+help-Install::
+	$(HH) install-html 'Install HTML docs'
+
 install-html:
 	$(MAKE) -C Documentation install-html
 
+help-Install::
+	$(HH) install-info 'Install info docs'
+
 install-info:
 	$(MAKE) -C Documentation install-info
 
+help-Install::
+	$(HH) install-pdf 'Install PDF docs'
+
 install-pdf:
 	$(MAKE) -C Documentation install-pdf
 
+help-Install::
+	$(HH) quick-install-doc 'Install pregenerated man pages from origin/man'
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+help-Install::
+	$(HH) quick-install-man 'Install pregenerated man pages from origin/man'
+
 quick-install-man:
 	$(MAKE) -C Documentation quick-install-man
 
+help-Install::
+	$(HH) quick-install-html 'Install pregenerated HTML pages from origin/html'
+
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
@@ -2188,6 +2257,9 @@ git.spec: git.spec.in
 	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
+help-Build::
+	$(HH) dist 'Build git-$(GIT_VERSION).tar.gz source archive'
+
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -2203,6 +2275,9 @@ dist: git.spec git-archive$(X) configure
 	@$(RM) -r $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
+help-Build::
+	$(HH) rpm 'Build source and binary RPM packages'
+
 rpm: dist
 	$(RPMBUILD) \
 		--define "_source_filedigest_algorithm md5" \
@@ -2211,6 +2286,10 @@ rpm: dist
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
+
+help-Build::
+	$(HH) dist-doc 'Build $(manpages).tar.gz and $(htmldocs).tar.gz'
+
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
@@ -2230,10 +2309,18 @@ dist-doc:
 	$(RM) -r .doc-tmp-dir
 
 ### Cleaning rules
+help-Clean::
+	$(H) 'Cleaning up after a build'
+
+help-Clean::
+	$(HH) distclean 'Remove generated files and the configure script'
 
 distclean: clean
 	$(RM) configure
 
+help-Clean::
+	$(HH) clean 'Remove generated files but keep the configure script'
+
 clean:
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
@@ -2268,7 +2355,9 @@ endif
 .PHONY: FORCE TAGS tags cscope
 
 ### Check documentation
-#
+help-Test::
+	$(HH) check-docs 'Check documentation coverage'
+
 check-docs::
 	@(for v in $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git gitk; \
 	do \
@@ -2335,6 +2424,9 @@ check-builtins::
 #
 .PHONY: coverage coverage-clean coverage-build coverage-report
 
+help-Test::
+	$(HH) coverage 'Check test coverage'
+
 coverage:
 	$(MAKE) coverage-build
 	$(MAKE) coverage-report
@@ -2370,5 +2462,20 @@ coverage-untested-functions: coverage-report
 cover_db: coverage-report
 	gcov2perl -db cover_db *.gcov
 
+help-Test::
+	$(HH) cover_db_html 'Check test coverage and create HTML report'
+
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+H=@printf "%s:\n"
+HH=@printf "    %-18s - %s\n"
+
+help-Help::
+	$(H) Help
+
+help-Help::
+	$(HH) help 'Show help for main make targets'
+	$(HH) help-X 'Show help for category X (Build, Test, Install, Clean, Develop)'
+
+help: help-Help help-Build help-Test help-Install help-Clean help-Develop
-- 
1.7.3.98.g5ad7d
