From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] Move SCM interoperability tools into interop/
Date: Mon, 10 Jul 2006 00:54:08 -0400
Message-ID: <11525072492717-git-send-email-ryan@michonline.com>
References: <1152507249880-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 10 06:55:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FznoH-0003Lw-ED
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 06:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWGJEzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161336AbWGJEzu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 00:55:50 -0400
Received: from h4x0r5.com ([70.85.31.202]:4616 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1161335AbWGJEzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 00:55:49 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fznn6-0004Dv-QD; Sun, 09 Jul 2006 21:54:40 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1Fznmb-0003VJ-LZ; Mon, 10 Jul 2006 00:54:09 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g6bdc-dirty
In-Reply-To: <1152507249880-git-send-email-ryan@michonline.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23588>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 Makefile                                           |   12 +++--
 interop/Makefile                                   |   45 ++++++++++++++++++++
 git-archimport.perl => interop/git-archimport.perl |    0 
 .../git-cvsexportcommit.perl                       |    0 
 git-cvsimport.perl => interop/git-cvsimport.perl   |    0 
 git-cvsserver.perl => interop/git-cvsserver.perl   |    0 
 git-p4import.py => interop/git-p4import.py         |    0 
 git-quiltimport.sh => interop/git-quiltimport.sh   |    0 
 git-send-email.perl => interop/git-send-email.perl |    0 
 git-svnimport.perl => interop/git-svnimport.perl   |    0 
 10 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 13f7c89..d6e2b0f 100644
--- a/Makefile
+++ b/Makefile
@@ -127,14 +127,13 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh
 
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
+include interop/Makefile
+
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
 
diff --git a/interop/Makefile b/interop/Makefile
new file mode 100644
index 0000000..b1a11d1
--- /dev/null
+++ b/interop/Makefile
@@ -0,0 +1,45 @@
+
+INTEROP_PERL_BASE = \
+	git-archimport.perl \
+	git-cvsimport.perl \
+	git-cvsexportcommit.perl \
+	git-cvsserver.perl \
+	git-svnimport.perl \
+	git-send-email.perl
+
+INTEROP_PYTHON_BASE = \
+	git-p4import.py
+
+INTEROP_SH_BASE = \
+	git-quiltimport.sh
+
+SCRIPTS+=$(patsubst %.perl,%,$(INTEROP_PERL_BASE))
+SCRIPTS+=$(patsubst %.py,%,$(INTEROP_PYTHON_BASE))
+SCRIPTS+=$(patsubst %.sh,%,$(INTEROP_SH_BASE))
+
+$(patsubst %.sh,%,$(INTEROP_SH_BASE)) : % : interop/%.sh
+	rm -f $@ $@+
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
+	    $^ >$@+
+	chmod +x $@+
+	mv $@+ $@
+
+$(patsubst %.perl,%,$(INTEROP_PERL_BASE)) : % : interop/%.perl
+	rm -f $@ $@+
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    $^ >$@+
+	chmod +x $@+
+	mv $@+ $@
+
+$(patsubst %.py,%,$(INTEROP_PYTHON_BASE)) : % : interop/%.py GIT-CFLAGS
+	rm -f $@ $@+
+	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_SQ)|g' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    $^ >$@+
+	chmod +x $@+
+	mv $@+ $@
diff --git a/git-archimport.perl b/interop/git-archimport.perl
similarity index 100%
rename from git-archimport.perl
rename to interop/git-archimport.perl
diff --git a/git-cvsexportcommit.perl b/interop/git-cvsexportcommit.perl
similarity index 100%
rename from git-cvsexportcommit.perl
rename to interop/git-cvsexportcommit.perl
diff --git a/git-cvsimport.perl b/interop/git-cvsimport.perl
similarity index 100%
rename from git-cvsimport.perl
rename to interop/git-cvsimport.perl
diff --git a/git-cvsserver.perl b/interop/git-cvsserver.perl
similarity index 100%
rename from git-cvsserver.perl
rename to interop/git-cvsserver.perl
diff --git a/git-p4import.py b/interop/git-p4import.py
similarity index 100%
rename from git-p4import.py
rename to interop/git-p4import.py
diff --git a/git-quiltimport.sh b/interop/git-quiltimport.sh
similarity index 100%
rename from git-quiltimport.sh
rename to interop/git-quiltimport.sh
diff --git a/git-send-email.perl b/interop/git-send-email.perl
similarity index 100%
rename from git-send-email.perl
rename to interop/git-send-email.perl
diff --git a/git-svnimport.perl b/interop/git-svnimport.perl
similarity index 100%
rename from git-svnimport.perl
rename to interop/git-svnimport.perl
-- 
1.4.1.gc473b-dirty
