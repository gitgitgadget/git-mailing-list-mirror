From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 17/19] More fixes to the git-remote-cvs installation procedure
Date: Thu, 29 Oct 2009 11:01:25 -0700
Message-ID: <1256839287-19016-18-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Johan Herland <johan@herland.net>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZLa-00051l-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbZJ2SC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbZJ2SC5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:57 -0400
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48301 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbZJ2SCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:47 -0400
Received: by mail-pw0-f42.google.com with SMTP id 9so194495pwj.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HxgeTBPKFfp6QJqHrCGJH2HZ7FJyuWJOfpJxPna8L3A=;
        b=lVBisUsPt1TgnRTvjYzaLNhnT9i8UX97wGIN2OYrk274GaRCb5CbKzqZ9hIbIru6PM
         Y89X7ou9nTZ/SZfzgxW/bXdmV+6JUK00dntH+OG0KniQgaJikCf+AUHmjNCNpL3o9f3d
         o152ZdL2CZIwoE+5c/kkhX+ZMTMknvr2gRq8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RKynqsPOTZOWbtPTcTt7E9XUv6RLEIszpgkvEtrgM03X7Y4sVlgEUThcwruEjUWazU
         Qs11OeanVNSX8XRYs5r8KtbedJjjNvI9nTRj7iPnkCgDIZAgXKQLymIyWFt0yczhUjG7
         PpobhhYF2eQ0Z3JrNuBkpL0OJuTEXi4i5aOTc=
Received: by 10.115.81.21 with SMTP id i21mr260582wal.125.1256839372464;
        Thu, 29 Oct 2009 11:02:52 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131639>

From: Johan Herland <johan@herland.net>

- Makefile: Make sure git-remote-cvs is rebuilt when 'prefix' changes
  (by adding a dependency on GIT-CFLAGS). This prevents a regular 'make'
  followed by a 'make prefix=/somewhere/else install' from installing a
  non-working git-remote-cvs.

- Makefile: When mangling git-remote-cvs to add the git_remote_cvs install
  location to the Python search path, _replace_ the initial 'current dir'
  entry in sys.path (instead of merely prepending the install location).
  Hence, if the git_remote_cvs package is not installed at the correct
  location (and also not present in any of Python's default package dirs),
  then git-remote-cvs will fail loudly instead of silently falling back on
  the git_remote_cvs subdir in git.git.

- Allow for the git_remote_cvs install path to be overridden by the
  $GITPYTHONLIB environment variable.

- t/test-lib.sh: Set $GITPYTHONLIB (unless $GIT_TEST_INSTALLED is enabled)
  so that we test the currently built version of git_remote_cvs  (the one
  that is built in git_remote_cvs/build/lib) instead of a previously
  installed version.

- Another minor check and a line length fix.

Found-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

	Unchanged.

 Makefile      |   11 +++++++++--
 t/test-lib.sh |    9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9fb2747..6d37399 100644
--- a/Makefile
+++ b/Makefile
@@ -1523,13 +1523,20 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 endif # NO_PERL
 
 ifndef NO_PYTHON
+$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s --no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s \
+		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
+		instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e '}' \
-	    -e 's|^import sys.*|&; sys.path.insert(0, "@@INSTLIBDIR@@")|' \
+	    -e 's|^import sys.*|&; \\\
+	           import os; \\\
+	           sys.path[0] = os.environ.has_key("GITPYTHONLIB") and \\\
+	                         os.environ["GITPYTHONLIB"] or \\\
+	                         "@@INSTLIBDIR@@"|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    $@.py >$@+ && \
 	chmod +x $@+ && \
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b991db..77ad23e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -638,6 +638,15 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
+if test -z "$GIT_TEST_INSTALLED"
+then
+	GITPYTHONLIB="$(pwd)/../git_remote_cvs/build/lib"
+	export GITPYTHONLIB
+	test -d ../git_remote_cvs/build || {
+		error "You haven't built git_remote_cvs yet, have you?"
+	}
+fi
+
 if ! test -x ../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
-- 
1.6.5.2.291.gf76a3
