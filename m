From: Ryan Anderson <ryan@michonline.com>
Subject: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Sun,  9 Jul 2006 02:17:06 -0400
Message-ID: <11524258261798-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Jul 09 08:18:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzSct-00050b-SV
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 08:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWGIGSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 02:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWGIGSk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 02:18:40 -0400
Received: from h4x0r5.com ([70.85.31.202]:4626 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1161098AbWGIGSk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 02:18:40 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FzSbq-00051U-Tt; Sat, 08 Jul 2006 23:17:39 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FzSbL-0007WL-5W; Sun, 09 Jul 2006 02:17:07 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g6bdc-dirty
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23522>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

This is the first in a series to categorize the source tree a little bit more
than it is currently.

I figured I'd start with something innocuous, like the SCM interoperability
tools.

One thing I don't really like is that I had to duplicate the Perl build rule
in the subdirectory Makefile, effectively, to restructure it and leave the
built files in the root.  If we can deprecate "run from the source tree",
this can go away.  (That requires fixing up a lot of tests, but it's
straightforward, at least.)

So, flame away!


 Makefile                                           |   10 ++++++----
 scm/Makefile                                       |   20 ++++++++++++++++++++
 git-archimport.perl => scm/git-archimport.perl     |    0 
 .../git-cvsexportcommit.perl                       |    0 
 git-cvsimport.perl => scm/git-cvsimport.perl       |    0 
 git-cvsserver.perl => scm/git-cvsserver.perl       |    0 
 git-p4import.py => scm/git-p4import.py             |    0 
 git-send-email.perl => scm/git-send-email.perl     |    0 
 git-svnimport.perl => scm/git-svnimport.perl       |    0 
 9 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 202f261..e7f5b48 100644
--- a/Makefile
+++ b/Makefile
@@ -130,11 +130,10 @@ SCRIPT_SH = \
 	git-lost-found.sh git-quiltimport.sh
 
 SCRIPT_PERL = \
-	git-archimport.perl git-cvsimport.perl git-relink.perl \
+	git-relink.perl \
 	git-shortlog.perl git-rerere.perl \
-	git-annotate.perl git-cvsserver.perl \
-	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl \
-	git-send-email.perl
+	git-annotate.perl \
+	git-mv.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
@@ -176,6 +175,9 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X \
 	git-fmt-merge-msg$X
 
+
+include scm/Makefile
+
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
 
diff --git a/scm/Makefile b/scm/Makefile
new file mode 100644
index 0000000..0ce205b
--- /dev/null
+++ b/scm/Makefile
@@ -0,0 +1,20 @@
+
+SCM_PERL_BASE = \
+	git-archimport.perl \
+	git-cvsimport.perl \
+	git-cvsexportcommit.perl \
+	git-cvsserver.perl \
+	git-svnimport.perl \
+	git-send-email.perl
+
+SCRIPTS+=$(patsubst %.perl,%,$(SCM_PERL_BASE))
+
+$(patsubst %.perl,%,$(SCM_PERL_BASE)) : % : scm/%.perl
+	rm -f $@ $@+
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    $^ >$@+
+	chmod +x $@+
+	mv $@+ $@
+
+
diff --git a/git-archimport.perl b/scm/git-archimport.perl
similarity index 100%
rename from git-archimport.perl
rename to scm/git-archimport.perl
diff --git a/git-cvsexportcommit.perl b/scm/git-cvsexportcommit.perl
similarity index 100%
rename from git-cvsexportcommit.perl
rename to scm/git-cvsexportcommit.perl
diff --git a/git-cvsimport.perl b/scm/git-cvsimport.perl
similarity index 100%
rename from git-cvsimport.perl
rename to scm/git-cvsimport.perl
diff --git a/git-cvsserver.perl b/scm/git-cvsserver.perl
similarity index 100%
rename from git-cvsserver.perl
rename to scm/git-cvsserver.perl
diff --git a/git-p4import.py b/scm/git-p4import.py
similarity index 100%
rename from git-p4import.py
rename to scm/git-p4import.py
diff --git a/git-send-email.perl b/scm/git-send-email.perl
similarity index 100%
rename from git-send-email.perl
rename to scm/git-send-email.perl
diff --git a/git-svnimport.perl b/scm/git-svnimport.perl
similarity index 100%
rename from git-svnimport.perl
rename to scm/git-svnimport.perl
-- 
1.4.1.gc473b-dirty
