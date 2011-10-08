From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Sat,  8 Oct 2011 20:31:58 +0200
Message-ID: <1318098723-12813-2-git-send-email-jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:33:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCbi9-0007b3-KJ
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1JHSc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 14:32:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1JHSc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 14:32:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so6340946bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x6N0lAFQCXapflSGD7y2KiPS7w7oMu32cEntONbTK8I=;
        b=ezZAUCYL9GmZTbq0f/8cMl2jUhej+WSzQUKF7HiKSxV60ZsI8YGw+0G2WJSWu1S+ge
         TeFGPn9xfwZCvQ9w5QbCQZXJY+OlT0ajR5c3jYRBSgd9RioGZytxEKw2tN/+QJIYuGFW
         j9dQcnz0My1T5W8Ec8UWq4UfVyj4nF7KmBLqA=
Received: by 10.223.62.15 with SMTP id v15mr19807522fah.22.1318098775778;
        Sat, 08 Oct 2011 11:32:55 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id m26sm20180604fac.6.2011.10.08.11.32.54
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 11:32:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183167>

Gitweb documentation currently consists of gitweb/README, gitweb/INSTALL
and comments in gitweb source code.  This is harder to find, use and
browse than manpages ("man gitweb" or "git help gitweb") and HTML
documentation ("git help --web gitweb").

The goal of the next two commits is to move documentation out of
gitweb/README to gitweb.txt and gitweb.conf.txt manpages, reducing its
size 10x from around 500 to around 50 lines (two pages), and to move
information not related directly to building and installing gitweb out
of gitweb/INSTALL.

The idea is to have the gitweb manpage sources reside in AsciiDoc
format in the Documentation/ directory, like for gitk and git-gui.
This means that building git documentation (with "make doc") would
also build gitweb manpages.

An alternate solution would be to have gitweb documentation in the
gitweb/ directory, perhaps in POD format (see perlpod(1)).


This patch adds infrastructure for easy generation of only
gitweb-related manpages.  It adds a currently empty 'gitweb-doc'
target to Documentation/Makefile, and a 'doc' proxy target to
gitweb/Makefile.

This way to build only gitweb documentation in both 'man' and 'html'
formats one can use

  make -C gitweb doc

or

  cd gitweb; make doc

This somewhat follows the idea of 'full-svn-test' and 'gitweb-test' in
t/Makefile.  Note also that with alternate solution, where source of
gitweb manpages would reside in the gitweb/ directory, "make doc"
would invoke "make -C gitweb doc" to generate formatted docs.

The gitweb.conf(5) and gitweb(1) manpages will be added in subsequent
commits.

[Commit message improved with help of Jonathan Nieder]

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This commit is not strictly necessary: it only adds "doc" target to
gitweb/Makefile, and "gitweb-doc" target to Documentation/Makefile;
neither is run when e.g. generating RPM.

They are here because they would be here if documentation source was
kept along with gitweb script in the 'gitweb/' subdirectory, and to
make it easier and faster to test the changes.

 Documentation/Makefile |    3 +++
 gitweb/Makefile        |    7 ++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6346a75..44be67b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -170,6 +170,9 @@ info: git.info gitman.info
 
 pdf: user-manual.pdf
 
+GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
+gitweb-doc: $(GITWEB_DOC)
+
 install: install-man
 
 install-man: man
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 1c85b5f..3014d80 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -174,6 +174,11 @@ test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
+### Documentation
+
+doc:
+	$(MAKE) -C ../Documentation gitweb-doc
+
 ### Installation rules
 
 install: all
@@ -187,5 +192,5 @@ install: all
 clean:
 	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
 
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
+.PHONY: all clean install test test-installed doc .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.6
