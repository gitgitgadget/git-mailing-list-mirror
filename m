From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary directory?
Date: Sat, 5 Nov 2005 15:52:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511051535220.3316@g5.osdl.org>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Nov 06 00:53:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYXpk-0008Gk-Lp
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 00:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVKEXwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 18:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVKEXwY
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 18:52:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932220AbVKEXwX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 18:52:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA5NqHnO002394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Nov 2005 15:52:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA5NqGQk003547;
	Sat, 5 Nov 2005 15:52:17 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11186>



On Sat, 5 Nov 2005, Linus Torvalds wrote:
> 
> So I'd really suggest that while the "git-<tab><tab>" thing is perhaps 
> useful, we'd actually be better off with an /usr/lib/git directory where 
> we put the git executables by default. And just put "git" into /usr/bin.

This is a guaranteed BUGGY thing to make the git RPM do something like 
that.

It adds a "gitdir" parameter to "make install", which defaults to the same 
as "bindir" if you don't specify it.

It installs only "git" in "bindir", and all other git programs in 
"gitdir".

It then makes the "git" script use "gitdir" for searching for the 
installed git scripts and programs, and forces PATH to have "gitdir" at 
the head while executing the sub-script (so that when the scripts do 
"git-diff-tree" etc, they'll always use the proper gitdir version).

The RPM specfile is taught to make "gitdir" be "${_libdir}/git-@@VERSION"

This means that if I got everything right, the RPM will build with

	/usr/bin/git

	/usr/lib/git-0.99.9.GIT/git-add
	/usr/lib/git-0.99.9.GIT/git-am
	/usr/lib/git-0.99.9.GIT/git-apply
	..

	/usr/share/doc/git-core-0.99.9.GIT
	/usr/share/doc/git-core-0.99.9.GIT/COPYING
	..

	/usr/share/git-core
	/usr/share/git-core/python
	..

	/usr/share/git-core/templates
	/usr/share/git-core/templates/branches
	..

	/usr/share/man/man1/git-add.1.gz
	/usr/share/man/man1/git-am.1.gz
	..

where the new thing is that "/usr/lib/git-0.99.9.GIT/" usage.

I've tested building the rpm, and that part works. I haven't actually 
tested the end result, though.

Oh, and I have not a clue in hell about how Debian works. In fact, I don't 
have a real clue how RPM files work either, this was done by doing some 
pattern matching on the existing git-core.spec.in file. Somebody who knows 
better really should fix it.

WARNING! I just realized that "gitk" also ends up in that /usr/lib/git.. 
directory, and this isn't visible. My bad. I'm a retard. 

Comments?

What do people think about this? Any daring souls willing to test this?

(Btw: word of caution on something that confused me at first: you have to 
_commit_ this diff in order for "make rpm" to work, since "make rpm" uses 
"git-tar-tree" to create the rpm file, not the current directory contents, 
heh ;)

		Linus

---
diff --git a/Makefile b/Makefile
index 6c01dc2..8df8b50 100644
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,7 @@ ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINE
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+gitdir = $(bindir)
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
@@ -86,7 +87,7 @@ SCRIPT_SH = \
 	git-prune.sh git-pull.sh git-push.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-resolve.sh git-revert.sh git-sh-setup.sh git-status.sh \
-	git-tag.sh git-verify-tag.sh git-whatchanged.sh git.sh \
+	git-tag.sh git-verify-tag.sh git-whatchanged.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh
@@ -315,7 +316,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS)
+all: git $(PROGRAMS) $(SCRIPTS)
 
 all:
 	$(MAKE) -C templates
@@ -323,6 +324,7 @@ all:
 git: git.sh Makefile
 	rm -f $@+ $@
 	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
+	    -e 's:@@GITDIR@@:$(gitdir):g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@X@@/$(X)/g' \
 	    $(GIT_LIST_TWEAK) <$@.sh >$@+
@@ -410,9 +412,11 @@ check:
 
 ### Installation rules
 
-install: $(PROGRAMS) $(SCRIPTS)
+install: git $(PROGRAMS) $(SCRIPTS)
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(gitdir))
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(gitdir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
diff --git a/git-core.spec.in b/git-core.spec.in
index 5240dd2..0d0ddf3 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -19,17 +19,19 @@ distributed source code management syste
 rudimentary tools that can be used as a SCM, but you should look
 elsewhere for tools for ordinary humans layered on top of this.
 
+%define gitdir %{_libdir}/git-@@VERSION@@
+
 %prep
 %setup -q
 
 %build
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} all %{!?_without_docs: doc}
+     gitdir=%{gitdir} prefix=%{_prefix} all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} DESTDIR=$RPM_BUILD_ROOT WITH_OWN_SUBPROCESS_PY=YesPlease \
-     prefix=%{_prefix} mandir=%{_mandir} \
+     gitdir=%{gitdir} prefix=%{_prefix} mandir=%{_mandir} \
      install %{!?_without_docs: install-doc}
 
 %clean
@@ -38,6 +40,7 @@ rm -rf $RPM_BUILD_ROOT
 %files
 %defattr(-,root,root)
 %{_bindir}/*
+%{gitdir}/*
 %{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html }
diff --git a/git.sh b/git.sh
index 94940ae..9ba1608 100755
--- a/git.sh
+++ b/git.sh
@@ -1,7 +1,8 @@
 #!/bin/sh
 
 cmd=
-path=$(dirname "$0")
+path="@@GITDIR@@"
+export PATH="$path:$PATH"
 case "$#" in
 0)	;;
 *)	cmd="$1"
