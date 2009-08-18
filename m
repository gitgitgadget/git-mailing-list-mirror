From: Johan Herland <johan@herland.net>
Subject: [RFCv4 7/5] More fixes to the git-remote-cvs installation procedure
Date: Tue, 18 Aug 2009 02:41:00 +0200
Message-ID: <200908180241.00544.johan@herland.net>
References: <1250480161-21933-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, davvid@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 02:41:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdClE-0006Sm-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbZHRAlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbZHRAlD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:41:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:55340 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750897AbZHRAlD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 20:41:03 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOJ00MLYR8EIG00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 18 Aug 2009 02:41:02 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOJ00AK5R8C0F10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 18 Aug 2009 02:41:02 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.18.2719
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <1250480161-21933-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126331>

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

On Monday 17 August 2009, Junio C Hamano wrote:
> With your Makefile patch the test still failed.  It turns out that I had
> a broken version from the previous round installed in my PATH, and the
> test failed until I removed the faulty ones manually from the installed
> location.  This is not good.
>
> While running tests, we really should import from the build directory,
> preferrably ignoring the installed directory but at least giving
> precedence to the build directory over the installed directory, to avoid
> problems like this.

Agreed. This patch puts the build directory first in Python's search path
when running the testsuite (unless $GIT_TEST_INSTALLED is enabled). The
install directory is ignored (unless the install dir happens to be in
Python's default search path, in which case the build dir will still have
precedence).

> In my case, it was a "bad installed version masking the version we are
> testing", but a more problematic would be the other way around.  If you
> have a good version installed, and if somebody breaks it in the updated
> source, "make test" won't catch the breakage and then you "make install"
> a broken version without noticing.

Yes. This is also taken care of in this patch ('make test' sets
$GITPYTHONLIB, which forces git-remote-cvs to look for its package
in the build dir instead of the install dir).

This patch (and the previous 6/5) will be folded into the next iteration
of the jh/cvs-helper patch series.


...Johan

 Makefile      |   11 +++++++++--
 t/test-lib.sh |    9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b9a7f25..1d7bf80 100644
--- a/Makefile
+++ b/Makefile
@@ -1477,13 +1477,20 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
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
index 01ea386..a7fbfef 100644
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
1.6.4.304.g1365c.dirty
