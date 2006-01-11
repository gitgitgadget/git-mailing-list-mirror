From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 16:42:44 -0800
Message-ID: <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	<1136924980.11717.603.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 01:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwU4f-0001D9-Gh
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 01:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWAKAmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 19:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWAKAmq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 19:42:46 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46589 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030201AbWAKAmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 19:42:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111004250.KBYD25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 19:42:50 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14469>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> How about searching for executables in the following places, and in this
> order:
>
> 1. --exec-path setting, if any
> 2. GIT_EXEC_PATH env var, if set
> 3. PATH (never modified)
> 4. Value of ${bindir} at build time

My preference is to first do this to the Makefile:

-- >8 --
diff --git a/Makefile b/Makefile
index 5817e86..b1e3055 100644
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,7 @@ ALL_LDFLAGS = $(LDFLAGS)
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+gitexecdir = $(prefix)/bin
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
@@ -144,7 +145,7 @@ PROGRAMS = \
 	git-describe$X
 
 # what 'all' will build and 'install' will install.
-ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) git$X
+ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
@@ -368,13 +369,13 @@ LIB_OBJS += $(COMPAT_OBJS)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(ALL_PROGRAMS)
+all: $(ALL_PROGRAMS) git$X
 
 all:
 	$(MAKE) -C templates
 
 git$X: git.c $(LIB_FILE)
-	$(CC) -DGIT_EXEC_PATH='"$(bindir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
+	$(CC) -DGIT_EXEC_PATH='"$(gitexecdir)"' -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
@@ -470,7 +471,9 @@ check:
 
 install: all
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(ALL_PROGRAMS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(gitexecdir))
+	$(INSTALL) $(ALL_PROGRAMS) $(call shellquote,$(DESTDIR)$(gitexecdir))
+	$(INSTALL) git$X $(call shellquote,$(DESTDIR)$(bindir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))

-- 8< --

and then make the rule for git things:

 1. --exec-path
 2. GIT_EXEC_PATH environment
 3. $(gitexecdir)

in this order.  Non git things should just use $PATH without
looking at anything else --- as long as a hook script calls a git
wrapper (i.e. "git foo" not "git-foo") I think things should
work fine.

> ...  The patch I sent out this morning
> attempts to do this.  (I'll append again to avoid confusion with
> previous patches)...

> +		if (flags & RUN_GIT_CMD) {
> +			execv_git_cmd(argv);
> +		} else {
> +			execvp(argv[0], (char *const*) argv);
>  		}

This bit sounds good, but if you were to go this route I'd
suggest to rename your exec_git_cmd() to execl_git_cmd() (and
terminate the vararg list with NULL) for naming consistency.
execv_git_cmd() is good---we do not *want* execvp_git_cmd(),
because we do not run git subcommand using PATH.
