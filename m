From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 17:12:11 -0700
Message-ID: <7vveth6kdg.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
	<Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
	<86k69xasg0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 02:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6UU-00056z-60
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWDKAMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWDKAMP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:12:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25737 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932248AbWDKAMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 20:12:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411001213.CQCP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 20:12:13 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86k69xasg0.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "10 Apr 2006 17:04:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18603>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Wait.  Why is there a git log and a git-log?  Shouldn't those
> be *absolutely* identical?  Or have we now finally diverged, violating
> rules that were established earlier?

What rule ;-)?

I kept "git-log.sh" for two reasons.  (1) to see how long it
takes people to notice, and (2) to have a handy way to verify
potential regressions.

There is no reason for them to be *absolutely* identical -- if
the git.c embedded one turns out to be usable, useful and even
superiour, git-log.sh based one should be retired, and will be
made again as synonyms, perhaps like this:

--
diff --git a/Makefile b/Makefile
index a979205..5239526 100644
--- a/Makefile
+++ b/Makefile
@@ -116,7 +116,7 @@ SCRIPT_SH = \
 	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-count-objects.sh git-diff.sh git-fetch.sh \
-	git-format-patch.sh git-log.sh git-ls-remote.sh \
+	git-format-patch.sh git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
@@ -167,6 +167,8 @@ PROGRAMS = \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
 
+BUILT_INS = git-log$X
+
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
 
@@ -448,7 +450,7 @@ LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(ALL_PROGRAMS) git$X gitk
+all: $(ALL_PROGRAMS) git$X $(BUILT_INS) gitk
 
 all:
 	$(MAKE) -C templates
@@ -460,6 +462,9 @@ git$X: git.c common-cmds.h $(GITLIBS)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(ALL_LDFLAGS) $(LIBS)
+
+$(BUILT_INS): git$X
+	rm -f $@ && ln git$X $@
 
 common-cmds.h: Documentation/git-*.txt
 	./generate-cmdlist.sh > $@
@@ -642,7 +647,7 @@ ### Cleaning rules
 
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		$(LIB_FILE) $(XDIFF_LIB)
+		$(LIB_FILE) $(XDIFF_LIB) $(BUILT_INS)
 	rm -f $(ALL_PROGRAMS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf $(GIT_TARNAME)
