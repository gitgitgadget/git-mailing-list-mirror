From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary directory?
Date: Sat, 5 Nov 2005 16:27:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511051625110.3316@g5.osdl.org>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org>
 <Pine.LNX.4.64.0511051535220.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Nov 06 01:28:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYYNa-00062m-Tz
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 01:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVKFA1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVKFA1T
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 19:27:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932238AbVKFA1T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 19:27:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA60RCnO003755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 5 Nov 2005 16:27:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA60RBE1004637;
	Sat, 5 Nov 2005 16:27:12 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511051535220.3316@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11187>



On Sat, 5 Nov 2005, Linus Torvalds wrote:
> 
> This is a guaranteed BUGGY thing to make the git RPM do something like 
> that.
>
> [ ... ]
> 
> WARNING! I just realized that "gitk" also ends up in that /usr/lib/git.. 
> directory, and this isn't visible. My bad. I'm a retard. 

This fixes the gitk thing, by installing it (along with git) in the 
regular $prefix/bin directory (ie default /usr/bin for the RPM).

I'm still a retard, and it's _probably_ still buggy, but at least it is no 
longer GUARANTEED to be buggy.

		Linus

---
diff --git a/Makefile b/Makefile
index 6c01dc2..6ec9dd2 100644
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
@@ -310,12 +311,12 @@ DEFINES += -DSHA1_HEADER=$(call shellquo
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
-	  gitk git-cherry-pick
+	  git-cherry-pick
 
 export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
 ### Build rules
 
-all: $(PROGRAMS) $(SCRIPTS)
+all: git gitk $(PROGRAMS) $(SCRIPTS)
 
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
+install: git gitk $(PROGRAMS) $(SCRIPTS)
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) git gitk $(call shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(gitdir))
+	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(call shellquote,$(DESTDIR)$(gitdir))
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
 	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
@@ -450,7 +454,7 @@ deb: dist
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o compat/*.o $(PROGRAMS) $(LIB_FILE)
-	rm -f $(filter-out gitk,$(SCRIPTS))
+	rm -f $(SCRIPTS)
 	rm -f git-core.spec *.pyc *.pyo
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
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
