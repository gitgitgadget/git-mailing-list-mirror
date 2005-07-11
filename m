From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 06:15:02 -0400
Message-ID: <20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 12:15:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrvJl-00006F-4m
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 12:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVGKKPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 06:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVGKKPF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 06:15:05 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:19598 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261586AbVGKKPC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 06:15:02 -0400
Received: (qmail 27631 invoked from network); 11 Jul 2005 10:15:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=1+JCnM2VHGD0iWSiR+0V2Otp8DHhq2Lkea4cAKdrFpDzWAciqEfFrYLVi2oi0jsWmed2Z3H5ZUdKxIZVHki8AjYZZ9wRUfud7PHlEwTADZ73W2q697S1GOMHtYPUashmhTOEJfNtItL6RtnritlrFu58RGYcL+zA0wPs6fx8/yo=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp105.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 10:15:01 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the git Makefile to put the results of config.sh into the scripts.  
config.sh searches for gnu utilities cp, stat, date and xargs.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 Makefile |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -51,9 +51,18 @@ PROG=   git-update-cache git-diff-files 
 
 all: $(PROG)
 
-install: $(PROG) $(SCRIPTS)
+config: config.sh
+	./config.sh
+
+install: $(PROG) $(SCRIPTS) config
 	$(INSTALL) -m755 -d $(dest)$(bin)
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
+	. ./config ; \
+	cd $(dest)$(bin) ; \
+	for file in $(SCRIPTS); do \
+		sed -e "s/DATE\=date/DATE=$${DATE}/" -e "s/CP\=cp/CP=$${CP}/" -e "s/XARGS\=xargs/XARGS=$${XARGS}/" -e "s/STAT\=stat/STAT=$${STAT}/" $$file > $$file.new; \
+		cat $$file.new > $$file; rm $$file.new; \
+	done
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o date.o index.o diff-delta.o patch-delta.o entry.o path.o \
@@ -190,7 +199,7 @@ test: all
 	$(MAKE) -C t/ all
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE) config
 	$(MAKE) -C Documentation/ clean
 
 backup: clean
