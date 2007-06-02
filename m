From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 4/3] Simplify naming (versioning) of non-release tig tarball and rpm file
Date: Sat, 2 Jun 2007 19:52:28 +0200
Message-ID: <200706021952.28426.jnareb@gmail.com>
References: <200705281054.05376.jnareb@gmail.com> <200705300131.17137.jnareb@gmail.com> <20070531131615.GA27044@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hucqk-0007Th-NG
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 01:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761892AbXFBXR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762266AbXFBXR3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 19:17:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9527 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761892AbXFBXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 19:17:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so475507ugf
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 16:17:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fTkoi4dskOVX6IiwIYTw1kVHqaWMQnOtyOYHP7zDHWP9IwcvzLywmQhita5c4MI3Z3eXPagdAz4JmLFdU4XAtOf/HcQN1fD5dWWYpTNZUgeXzTcawvnC8PzJdXDMPRsJ2k+Gvwz1Yew9ONdY1JVfY+FEVmWI9Y0sbo7P4TjwGzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bFpHEWvhtzZVEGIsX9hmhcvahC3kRtYa4U7PPEhhWPQl5ICkECSAg8LNfDEKqwzEqvuL9OcIM3hLhpWixW0MWuxi8DqjkzymsMfb0BkUMl7yDzim8VQtjgB/MDJsCSnSMVUNKhB7fa7tJtIQI6KeST+/mnEsEe7RywTJ4PpFVII=
Received: by 10.67.21.11 with SMTP id y11mr1870069ugi.1180826247342;
        Sat, 02 Jun 2007 16:17:27 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm3928158mug.2007.06.02.16.17.25;
        Sat, 02 Jun 2007 16:17:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070531131615.GA27044@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48958>

Use the tag part of git-describe output, with `tig-' prefix stripped
off, as version number. Use number of commits since given tag as
release number, using 0 if we are at tagged version, and adding
'.dirty' suffix if working directory is dirty. Do not use 'g<sha 1>'
part of git-describe output.

For example, when git-describe output was tig-0.7-8-g26d0386, before
this commit tarball was named tig-0.7.8.g26d0386.tar.gz and rpm was
named tig-0.7.8.g26d0386-1.src.rpm (for dirty tree tarball was
tig-0.7.8.g26d0386.dirty.tar.gz), now tarball is named
tig-0.7-8.tar.gz and rpm is named tig-0.7-8.src.rpm (for dirty tree
tarball is tig-0.7-8.dirty.tar.gz).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is proposal to simplify naming of non-release tarballs and rpm file,
both for tig and also for git itself. Instead of using whole git-describe
output as version number in tarball/rpm name (BTW. it would be nice to
have command line switch to git-describe which would return old output,
without number of commits since given tag) use tag part as version number,
and number of commits since (plus optional marking dirty) as release
number.

What do you think about this?

 Makefile    |   13 ++++++++++---
 tig.spec.in |    2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b49d7f8..1e67586 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,13 @@ ifdef DIST_VERSION
 VERSION	= $(DIST_VERSION)
 endif
 
-RPM_VERSION = $(subst -,.,$(VERSION))
+# $(GITDESC) looks like either x.y, or like x.y-z-g<sha1>
+SPLIT_VERSION := $(shell echo $(GITDESC) | \
+                   sed -e 's/^\(.*\)-\([0-9]\+\)-\(g[0-9a-f]\+\)$$/\1 \2 \3/g')
+RPM_VERSION = $(subst -,.,$(word 1,$(SPLIT_VERSION)))
+RPM_RELEASE = $(strip \
+              $(subst -,.,$(if $(word 2,$(SPLIT_VERSION)),\
+                               $(word 2,$(SPLIT_VERSION)),0)$(WTDIRTY)))
 
 LDLIBS	= -lcurses
 CFLAGS	= -Wall -O2 '-DVERSION="$(VERSION)"'
@@ -26,7 +32,7 @@ PROGS	= tig
 MANDOC	= tig.1 tigrc.5
 HTMLDOC	= tig.1.html tigrc.5.html manual.html README.html
 ALLDOC	= $(MANDOC) $(HTMLDOC) manual.html-chunked manual.pdf
-TARNAME	= tig-$(RPM_VERSION)
+TARNAME	= tig-$(RPM_VERSION)-$(RPM_RELEASE)
 
 all: $(PROGS)
 all-debug: $(PROGS)
@@ -104,7 +110,8 @@ release-dist: release-doc
 	install-doc-man install-doc-html clean spell-check dist rpm
 
 tig.spec: tig.spec.in
-	sed -e 's/@@VERSION@@/$(RPM_VERSION)/g' < $< > $@
+	sed -e 's/@@VERSION@@/$(RPM_VERSION)/g' \
+	    -e 's/@@RELEASE@@/$(RPM_RELEASE)/g' < $< > $@
 
 tig: tig.c
 
diff --git a/tig.spec.in b/tig.spec.in
index 2385fb8..8606b23 100644
--- a/tig.spec.in
+++ b/tig.spec.in
@@ -4,7 +4,7 @@
 Summary: 	Tig: text-mode interface for git
 Name: 		tig
 Version: 	@@VERSION@@
-Release: 	1%{?dist}
+Release: 	@@RELEASE@@%{?dist}
 License: 	GPL
 Group: 		Development/Tools
 Vendor: 	Jonas Fonseca <fonseca@diku.dk>
-- 
1.5.2
