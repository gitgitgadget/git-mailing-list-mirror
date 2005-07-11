From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 5/6] cogito-gnu-progs-Makefile: cogito Makefile update
Date: Mon, 11 Jul 2005 06:15:25 -0400
Message-ID: <20050711101517.10318.5359.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:16:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvK8-0000Al-Od
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVGKKPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGKKPa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:15:30 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:6824 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261590AbVGKKPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:15:25 -0400
Received: (qmail 60237 invoked from network); 11 Jul 2005 10:15:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=mg1PPbGml9y/3ErnvLyuanpkrXVDl3+51TSzl6sbrL4RvOV+Tv0mOkHimVb3+OAbetkgJ+ZjFZ0DqCfrDfVQiLmWICNnX0e+DxfMH4lijwnpYfZ6IzbYHybEaHH+QYl09pW9kPfj3hq2CYen+nnY6CebSKth1NQaG12osEjIZuU=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:15:22 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the cogito Makefile to put the results of config.sh into the scripts.  config.sh searches for gnu utilities cp, stat, date and xargs.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 Makefile |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -195,11 +195,20 @@ sedlibdir=$(shell echo $(libdir) | sed '
 .PHONY: install install-git install-cogito
 install: install-git install-cogito
 
-install-git: $(PROG) $(SCRIPTS)
+config: config.sh
+	./config.sh
+
+install-git: $(PROG) $(SCRIPTS) config
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(DESTDIR)$(bindir)
+	. ./config ; \
+	cd $(DESTDIR)$(bindir) ;\
+	for file in $(SCRIPTS); do \
+		sed -e "s/DATE\=date/DATE=$${DATE}/" -e "s/CP\=cp/CP=$${CP}/" -e "s/XARGS\=xargs/XARGS=$${XARGS}/" -e "s/STAT\=stat/STAT=$${STAT}/" $$file > $$file.new; \
+		cat $$file.new > $$file; rm $$file.new; \
+	done
 
-install-cogito: $(SCRIPT) $(LIB_SCRIPT) $(GEN_SCRIPT)
+install-cogito: $(SCRIPT) $(LIB_SCRIPT) $(GEN_SCRIPT) config
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
 	rm -f $(DESTDIR)$(bindir)/cg-cancel
@@ -211,9 +220,10 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT) 
 		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' $$file > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
+	. ./config ; \
 	cd $(DESTDIR)$(libdir); \
 	for file in $(LIB_SCRIPT); do \
-		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' $$file > $$file.new; \
+		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' -e "s/DATE\=date/DATE=$${DATE}/" -e "s/CP\=cp/CP=$${CP}/" -e "s/XARGS\=xargs/XARGS=$${XARGS}/" -e "s/STAT\=stat/STAT=$${STAT}/" $$file > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
 
@@ -232,7 +242,7 @@ dist: cogito.spec
 	gzip -9 $(tarname).tar
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE) config
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
