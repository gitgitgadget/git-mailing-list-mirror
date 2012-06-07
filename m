From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] docs: fix cross-directory linkgit references
Date: Thu,  7 Jun 2012 23:03:23 +0200
Message-ID: <1339103003-18447-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 07 23:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scjrs-0003TR-9m
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 23:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678Ab2FGVDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 17:03:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35134 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121Ab2FGVDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 17:03:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q57KsX4E025754
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 22:54:33 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ScjrZ-0007s8-LU; Thu, 07 Jun 2012 23:03:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1ScjrZ-0004oC-Hb; Thu, 07 Jun 2012 23:03:25 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jun 2012 22:54:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57KsX4E025754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339707276.48318@M+vZ3JnHMgxrWClh1+5Q0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199452>

From: Jeff King <peff@peff.net>

Most of our documentation is in a single directory, so using
linkgit:git-config[1] just generates a relative link in the
same directory. However, this is not the case with the API
documentation in technical/*, which need to refer to
git-config from the parent directory.

We can fix this by passing a special prefix attribute when building
in a subdirectory, and respecting that prefix in our linkgit
definitions.

We only have to modify the html linkgit definition.  For
manpages, we can ignore this for two reasons:

  1. we do not generate actual links to the file in
     manpages, but instead just give the name and section of
     the linked manpage

  2. we do not currently build manpages for subdirectories,
     only html

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This if Peff's patch, with

* One missing -a in Makefile added

* Rebased on 04ab6ae77657 (api-credentials.txt: add "see also"
  section) in next to get recently added instances of linkgit:../ and
  fix them.

 Documentation/Makefile                      | 2 ++
 Documentation/asciidoc.conf                 | 2 +-
 Documentation/technical/api-config.txt      | 2 +-
 Documentation/technical/api-credentials.txt | 6 +++---
 Documentation/technical/api-merge.txt       | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9ad6a6a..d84d6f4 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -270,6 +270,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
+technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
@@ -323,6 +324,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
+howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 - >$@+ && \
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index aea8627..6d06271 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -91,5 +91,5 @@ endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
 [linkgit-inlinemacro]
-<a href="{target}.html">{target}{0?({0})}</a>
+<a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index bd4d8b8..edf8dfb 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -2,7 +2,7 @@ config API
 ==========
 
 The config API gives callers a way to access git configuration files
-(and files which have the same syntax). See linkgit:../git-config[1] for a
+(and files which have the same syntax). See linkgit:git-config[1] for a
 discussion of the config file syntax.
 
 General Usage
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 199307c..4ef1db3 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -180,7 +180,7 @@ longer than a single git process; e.g., credentials may be stored
 in-memory for a few minutes, or indefinitely on disk).
 
 Each helper is specified by a single string in the configuration
-variable `credential.helper` (and others, see linkgit:../git-config[1]).
+variable `credential.helper` (and others, see linkgit:git-config[1]).
 The string is transformed by git into a command to be executed using
 these rules:
 
@@ -293,6 +293,6 @@ helpers will just ignore the new requests).
 See also
 --------
 
-linkgit:../gitcredentials[7]
+linkgit:gitcredentials[7]
 
-linkgit:../git-config[5] (See configuration variables `credential.*`)
+linkgit:git-config[5] (See configuration variables `credential.*`)
diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 25158b8..9dc1bed 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -36,7 +36,7 @@ the operation of a low-level (single file) merge.  Some options:
 	ancestors in a recursive merge.
 	If a helper program is specified by the
 	`[merge "<driver>"] recursive` configuration, it will
-	be used (see linkgit:../gitattributes[5]).
+	be used (see linkgit:gitattributes[5]).
 
 `variant`::
 	Resolve local conflicts automatically in favor
-- 
1.7.11.rc0.57.g84a04c7
