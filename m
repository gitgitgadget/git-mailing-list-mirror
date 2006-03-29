From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 12:24:33 -0800
Message-ID: <7vd5g580e6.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
	<7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 22:24:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOhDc-0001CH-HR
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 22:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWC2UYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWC2UYg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 15:24:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16778 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751184AbWC2UYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 15:24:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329202435.YFFA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 15:24:35 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603291102440.15714@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 29 Mar 2006 11:27:46 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18181>

Linus Torvalds <torvalds@osdl.org> writes:

> In contrast, here's an alternate workflow that is much easier to explain, 
> and doesn't involve "rebase" at all:
>
> 	git checkout his
> 	git cherry-pick origin..mine

Yes, I think it would be good to deprecate/discard the current
rebase and make cherry-pick the recommended workflow.

Optionally.  I've been thinking about not using git-cherry while
cherrypicking, because falling back to three-way merge seems to
work equally well in dealing with "patch already applied" case.

Anyway, teaching the range notation to cherry-pick would be
something like this, I suppose.

---
diff --git a/git-cherry-pick.sh b/git-cherry-pick.sh
new file mode 100755
index 0000000..72a3828
--- /dev/null
+++ b/git-cherry-pick.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+. git-sh-setup
+
+git-format-patch --stdout --full-index -k "$@" |
+git-am --binary -3 -k
diff --git a/Makefile b/Makefile
index d945546..e130d8c 100644
--- a/Makefile
+++ b/Makefile
@@ -114,7 +114,7 @@ ### --- END CONFIGURATION SECTION ---
 
 SCRIPT_SH = \
 	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
-	git-cherry.sh git-clone.sh git-commit.sh \
+	git-cherry.sh git-cherry-pick.sh git-clone.sh git-commit.sh \
 	git-count-objects.sh git-diff.sh git-fetch.sh \
 	git-format-patch.sh git-log.sh git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
@@ -139,7 +139,7 @@ SCRIPT_PYTHON = \
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
-	  git-cherry-pick git-show git-status
+	  git-show git-status
 
 # The ones that do not have to link with lcrypto nor lz.
 SIMPLE_PROGRAMS = \
@@ -484,9 +484,6 @@ common-cmds.h: Documentation/git-*.txt
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.py >$@
 	chmod +x $@
-
-git-cherry-pick: git-revert
-	cp $< $@
 
 git-show: git-whatchanged
 	cp $< $@
