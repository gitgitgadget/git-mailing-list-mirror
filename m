From: "Reini Urban" <rurban@x-ray.at>
Subject: shared lib+symlinks patch for cygwin
Date: Sun, 22 Jun 2008 09:56:23 +0200
Message-ID: <6910a60806220056i1dda7f4elb4e5c69cdeea3cf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 09:57:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAKSJ-0002CO-4F
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 09:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYFVH4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 03:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYFVH4g
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 03:56:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:29356 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYFVH4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 03:56:25 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1870342fkq.5
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=B9bth/wsnHRLA+OLTPTQU/vmxCnMWM7eov0qyxlM9Qg=;
        b=W8ZeBSB7kqNALZr6BYLmmBcOvyXsWKgmxn9vxBCGsXMfOQpO599O/+mQC/Ushfnuwh
         OH7Zab/hL6ANABm61n2EvY2a8aH9yhohCIxSa0JFR1SYsQwmAPj3qoyrkZcrNxtonyeX
         us1U94pid2myP61JUNUHQDgI1ZxEjp2FANDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=pQMjDx6+ctyBvi2OlPbkWHyvTA830M0tzNJV2Z1FE3w/MRPhmgW1MtXUfTaMJBFg+N
         BZakWf/GOcspTdHwgOLzxYccaOfJCL9Voe4iKLutJ5DALzd0QGHltVF6wGcN4dxGTa/H
         JSe6067odDXdrB6odP4WTX4HOHWlXRkOXxNWQ=
Received: by 10.82.145.7 with SMTP id s7mr327814bud.71.1214121383995;
        Sun, 22 Jun 2008 00:56:23 -0700 (PDT)
Received: by 10.82.179.17 with HTTP; Sun, 22 Jun 2008 00:56:23 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: d6bc83fe05fd69f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85751>

Attached is a semi-complete patch for a significant space reduction,
esp. on cygwin where file hardlinks do not work as on linux.
old bindir 5.8MB, new 2.7MB

$ du git-1.5.6-1/inst/usr/bin git-1.5.6-2/inst/usr/bin
5.8M    git-1.5.6-1/inst/usr/bin
2.7M    git-1.5.6-2/inst/usr/bin

First it links to a shared lib for all builtins (cygwin only),
second it uses symlinks instead of hardlinks (cygwin only).

mingw could also take this approach but I cannot test this.
A shared lib for all platforms should IMHO also be considered.

The first dll approach works fine.
The second has open problems with git-gui, because the native windows app
cannot handle symlinks.
file exists returns true but we cannot call it. So I tried to change
the calling sequence from git-config to git config, but Tcl is not my
native language. Maybe someone can help.

For reference:
I found an old shared libgit patch at
  http://article.gmane.org/gmane.comp.version-control.git/8680/match=shared+lib


--- origsrc/git-1.5.6/Makefile	2008-06-19 00:49:49.000000000 +0200
+++ src/git-1.5.6/Makefile	2008-06-22 09:08:22.812500000 +0200
@@ -211,12 +211,12 @@
 AR = ar
 RM = rm -f
 TAR = tar
+LN = ln
 FIND = find
 INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
-
 export TCL_PATH TCLTK_PATH

 # sparse is architecture-neutral, which means that we need to tell it
@@ -639,20 +639,20 @@
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
-	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
-	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	OLD_ICONV = UnfortunatelyYes
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-	NO_MMAP = YesPlease
+#	NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
+	LIB_FILE=cyggit.dll
+	ALL_LDFLAGS += -Wl,--enable-auto-import
+	LN = ln -s
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
@@ -1040,7 +1040,7 @@
 		'-DGIT_INFO_PATH="$(infodir_SQ)"' $<

 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && $(LN) git$X $@

 common-cmds.h: ./generate-cmdlist.sh command-list.txt

@@ -1169,8 +1171,17 @@
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h

+ifneq (,$(findstring .dll,$(LIB_FILE)))
+$(LIB_FILE): $(LIB_OBJS) builtin-fetch-pack.o builtin-send-pack.o $(XDIFF_LIB)
+	$(QUIET_CC)$(RM) git-dll.o && $(CC) -DSHARED_LIBOBJ
-DGIT_VERSION='"$(GIT_VERSION)"' \
+		$(ALL_CFLAGS) -o git-dll.o -c git.c
+	$(QUIET_LINK)$(RM) $@ && $(CC) -shared -Wl,--export-all-symbols \
+		-o $@ $(ALL_LDFLAGS) git-dll.o $(LIB_OBJS) builtin-fetch-pack.o
builtin-send-pack.o \
+		$(filter-out $(LIB_FILE),$(LIBS)) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+else
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
+endif

 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o
@@ -1277,15 +1288,18 @@
 endif
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
-		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
+		$(LN) -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || \
 		cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
-	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p'
&& ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p'
&& $(LN) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS)
$(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
 endif
+ifneq (,$(findstring .dll,$(LIB_FILE)))
+	$(INSTALL) $(LIB_FILE) '$(DESTDIR_SQ)$(bindir_SQ)'
+endif

 install-doc:
 	$(MAKE) -C Documentation install
diff -urN  origsrc/git-1.5.6/git-gui/git-gui.sh src/git-1.5.6/git-gui/git-gui.sh
--- origsrc/git-1.5.6/git-gui/git-gui.sh	2008-06-19 00:49:49.000000000 +0200
+++ src/git-1.5.6/git-gui/git-gui.sh	2008-06-22 09:38:23.359375000 +0200
@@ -279,8 +279,12 @@
 		}

 		set p [gitexec git-$name$::_search_exe]
-		if {[file exists $p]} {
-			set v [list $p]
+		if ([file exists $p]} {
+		      	if ([is_Cygwin] && [file exists [file join $p .lnk]]) {
+			    set v [list $::_git $name]
+			} else {
+			    set v [list $p]
+			}
 		} elseif {[is_Windows] && [file exists [gitexec git-$name]]} {
 			# Try to determine what sort of magic will make
 			# git-$name go and do its thing, because native
diff -urN  origsrc/git-1.5.6/git.c src/git-1.5.6/git.c
--- origsrc/git-1.5.6/git.c	2008-06-19 00:49:49.000000000 +0200
+++ src/git-1.5.6/git.c	2008-06-21 11:10:48.953125000 +0200
@@ -384,6 +384,7 @@
 	}
 }

+#ifndef SHARED_LIBOBJ
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] ? argv[0] : "git-help";
@@ -474,3 +475,4 @@

 	return 1;
 }
+#endif




---------- Forwarded message ----------
From: Reini Urban <rurban@x-ray.at>
Date: 2008/6/21
Subject: Re: [ANNOUNCEMENT] Updated: git-1.5.6-1
To: cygwin@cygwin.com


2008/6/20 Brian Dessent:
> Reini Urban wrote:
>
>> Some attribute causes the linker to refuse to build the dll and wants
>> to build an exe.
>
> That's because you used -Wl,-shared where you should have used -shared.
> When you use -Wl the driver treats the argument as an opaque value that
> is simply passed to the linker without interpretation.  In this case it
> means the driver is unaware that you're trying to create a shared
> library and instead passes to the linker the startup object and
> corresponding options for creating a program.

[Bang on the head] Stupid me.
Thanks, that compiles fine.
Unfortunately it doesn't work yet. The testsuite works with 4 failures.

I'll try it upstream now.
They wanted a shared lib for a long time for some perl and python libs.
I just did a simple make and installation improvement.

-- 
Reini Urban
http://phpwiki.org/              http://murbreak.at/
