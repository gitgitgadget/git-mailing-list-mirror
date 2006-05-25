From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 15:32:11 +0200
Message-ID: <87hd3e5ixw.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 25 15:32:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjFwl-0004Sl-J8
	for gcvg-git@gmane.org; Thu, 25 May 2006 15:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWEYNcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 09:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWEYNcM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 09:32:12 -0400
Received: from mx.meyering.net ([82.230.74.64]:5588 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S965180AbWEYNcM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 09:32:12 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 0F3E47DE5; Thu, 25 May 2006 15:32:11 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20739>

Otherwise, if make is suspended, or killed with prejudice, or if the
system crashes, you could be left with an up-to-date, yet corrupt,
generated file.

---

 Makefile |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

59fd5cb51824364100cacd92f1ca4674853a13a8
diff --git a/Makefile b/Makefile
index dbf19c6..3af3187 100644
--- a/Makefile
+++ b/Makefile
@@ -496,37 +496,43 @@ builtin-help.o: common-cmds.h
 	rm -f $@ && ln git$X $@
 
 common-cmds.h: Documentation/git-*.txt
-	./generate-cmdlist.sh > $@
+	./generate-cmdlist.sh > t$@
+	mv t$@ $@
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	rm -f $@
+	rm -f $@ t$@
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
-	    $@.sh >$@
-	chmod +x $@
+	    $@.sh >t$@
+	chmod +x t$@
+	mv t$@ $@
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
-	rm -f $@
+	rm -f $@ t$@
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@
-	chmod +x $@
+	    $@.perl >t$@
+	chmod +x t$@
+	mv t$@ $@
 
 $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
-	rm -f $@
+	rm -f $@ t$@
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.py >$@
-	chmod +x $@
+	    $@.py >t$@
+	chmod +x t$@
+	mv t$@ $@
 
 git-cherry-pick: git-revert
-	cp $< $@
+	cp $< t$@
+	mv t$@ $@
 
 git-status: git-commit
-	cp $< $@
+	cp $< t$@
+	mv t$@ $@
 
 # These can record GIT_VERSION
 git$X git.spec \
@@ -653,7 +659,8 @@ install-doc:
 ### Maintainer's dist rules
 
 git.spec: git.spec.in
-	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
+	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > t$@
+	mv t$@ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
 dist: git.spec git-tar-tree
@@ -724,4 +731,3 @@ check-docs::
 		*) echo "no link: $$v";; \
 		esac ; \
 	done | sort
-
-- 
1.3.2
