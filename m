From: Bruno Haible <bruno@clisp.org>
Subject: Re: git: avoiding merges, rebasing
Date: Tue, 9 Oct 2007 14:03:26 +0200
Message-ID: <200710091403.26047.bruno@clisp.org>
References: <200709301421.52192.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr> <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O42CHCD/uTA+MUD"
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfDoW-0003Bs-Cn
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbXJIMDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXJIMDf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:03:35 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:8946 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXJIMDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:03:32 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (mrclete mo34) (RZmta 13.4)
	with ESMTP id j00bdej99B7jFH ; Tue, 9 Oct 2007 14:03:28 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr>
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60389>


--Boundary-00=_O42CHCD/uTA+MUD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Benoit,

Thanks for working on this. But this merge driver has a few major nits.


1) While my ChangeLog file was locally unmodified but some pulled in commits
   should modify it, "git pull" stopped and said:

ChangeLog: needs update
fatal: Entry 'ChangeLog' not uptodate. Cannot merge.

[I cannot swear on this, because I did not do a "git status" before the
"git pull", but this is in a directory where I usually have no pending diffs.]

The ChangeLog in question is the one from gnulib
(git clone git://git.sv.gnu.org/gnulib).


2) This "merge driver" did much more than sorting in a merge: it sorted the
entire file! In doing so,
  - It changed the order of ChangeLog entries in a way that does not represent
    the historical commit order.
  - For ChangeLog entries with multiple contributors, it shuffled around these
    extra contributors to other ChangeLog entries.
  - Near the end of the file, it made a change that I cannot explain.

Find attached a context diff of all the bad changes that it did.


In my opinion, a merge driver should not do changes to the file except
in the range of lines where the conflict occurred. For a ChangeLog driver,
all uncommitted entries should be collected at the top of the file, because
1. ChangeLogs are kept in the order of historical commit in the central
   repository,
2. other developers always look at the top of the ChangeLog; if a ChangeLog
   entries is inserted second or third after some already present entries,
   the danger is too high that the change gets unnoticed.

So "git-merge-changelog OLD CURRENT OTHERS" should IMO do the following:
1) Collect the changes between OLD and HEAD (I don't know if that is CURRENT
   or OTHERS?), in two categories:
     - added entries,
     - changed and removed entries.
2) Back out the added entries, keeping only the changed and removed entries
   as modifications.
3) Do a normal merge between this and the pulled in remote branch (I don't
   know if that is OTHERS or CURRENT?). If that merge gives a conflict,
   bail out.
4) Insert the added entries at the top, in the same order as they were
   originally (no sorting).

Bruno

--Boundary-00=_O42CHCD/uTA+MUD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="git-merge-changelog-blunder"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-merge-changelog-blunder"

*** ChangeLog.orig	2007-10-09 13:16:56.000000000 +0200
--- ChangeLog	2007-10-09 13:12:29.000000000 +0200
***************
*** 3560,3569 ****
  	* doc/functions/lseek.texi: Update.
  	Reported by Gary V. Vaughan <gary@gnu.org>.
  
- 2007-05-28  Bruno Haible  <bruno@clisp.org>
- 
- 	* m4/intl.m4 (AM_INTL_SUBDIR): Substitute variables WOE32, WINDRES.
- 
  2007-05-31  Eric Blake  <ebb9@byu.net>
  
  	* m4/frexpl.m4 (gl_FUNC_FREXPL_WORKS): Guess no on mingw when
--- 3560,3565 ----
***************
*** 3631,3636 ****
--- 3627,3636 ----
  	* m4/isnanf.m4 (gl_FUNC_ISNANF_NO_LIBM): Avoid syntax error on
  	cross compiles.
  
+ 2007-05-28  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* m4/intl.m4 (AM_INTL_SUBDIR): Substitute variables WOE32, WINDRES.
+ 
  2007-05-28  Eric Blake  <ebb9@byu.net>
  
  	* modules/closein-tests (test_closein_LDADD): Support test on
***************
*** 4310,4319 ****
  	* doc/functions/vsnprintf.texi: Update.
  	* doc/functions/vsprintf.texi: Update.
  
- 2007-05-01  Bruno Haible  <bruno@clisp.org>
- 
- 	* tests/test-argp-2.sh (func_compare): Drop .exe suffix.
- 
  2007-05-03  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* m4/d-ino.m4 (gl_CHECK_TYPE_STRUCT_DIRENT_D_INO): Use better
--- 4310,4315 ----
***************
*** 4333,4338 ****
--- 4329,4338 ----
  
  2007-05-01  Bruno Haible  <bruno@clisp.org>
  
+ 	* tests/test-argp-2.sh (func_compare): Drop .exe suffix.
+ 
+ 2007-05-01  Bruno Haible  <bruno@clisp.org>
+ 
  	* doc/functions/_Exit_C99.texi: Renamed from doc/functions/_Exit.texi.
  	Reported by Eric Blake.
  	* doc/gnulib.texi (Function Substitutes): Update.
***************
*** 5358,5371 ****
  	* modules/crypto/rijndael-tests: Moved from ../.
  	* modules/crypto/sha1: Moved from ../.
  
- 2007-03-30  James Youngman  <jay@gnu.org>
- 
- 	* tests/test-stat-time.c (prepare_test): use chmod() rather than
- 	rename() to change the ctime of a file (because ctime is unaffected
- 	by rename on jfs2 on AIX 5.1).
- 	(main): Start by doing cleanup, in case a previous run failed leaving
- 	test files behind.
- 
  2007-03-31  Bruno Haible  <bruno@clisp.org>
  
  	Support old proprietary implementations of iconv.
--- 5358,5363 ----
***************
*** 5442,5447 ****
--- 5434,5447 ----
  	gnulib is available through git.
  	* doc/gnulib-tool.texi (CVS Issues): Mention git and svn as well.
  
+ 2007-03-30  James Youngman  <jay@gnu.org>
+ 
+ 	* tests/test-stat-time.c (prepare_test): use chmod() rather than
+ 	rename() to change the ctime of a file (because ctime is unaffected
+ 	by rename on jfs2 on AIX 5.1).
+ 	(main): Start by doing cleanup, in case a previous run failed leaving
+ 	test files behind.
+ 
  2007-03-30  Bruno Haible  <bruno@clisp.org>
  
  	* lib/alloca_.h: Change prefix of double-inclusion guard macro to _GL_.
***************
*** 6010,6019 ****
  	* lib/argp-help.c (fill_in_uparams, canon_doc_option): Cast the
  	arguments of isspace, isalpha, isalnum, isdigit to 'unsigned char'.
  
- 2007-03-22  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/strptime.c (__strptime_internal): Use ANSI C syntax.
- 
  2007-03-23  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* MODULES.html.sh (File system functions): New module write-any-file.
--- 6010,6015 ----
***************
*** 6032,6037 ****
--- 6028,6037 ----
  
  2007-03-22  Bruno Haible  <bruno@clisp.org>
  
+ 	* lib/strptime.c (__strptime_internal): Use ANSI C syntax.
+ 
+ 2007-03-22  Bruno Haible  <bruno@clisp.org>
+ 
  	* lib/poll.c (MSG_PEEK): New fallback definition.
  
  2007-03-22  Bruno Haible  <bruno@clisp.org>
***************
*** 6284,6293 ****
  	* build-aux/bootstrap (gnulib_name): New variable.
  	(gnulib_tool_options): Use it.
  
- 2007-03-13  Simon Josefsson  <simon@josefsson.org>
- 
- 	* tests/test-des.c: Use new namespace.
- 
  2007-03-15  Bruno Haible  <bruno@clisp.org>
  
  	* lib/dummy.c (gl_dummy_symbol): Renamed from 'dummy'.
--- 6284,6289 ----
***************
*** 6364,6369 ****
--- 6360,6369 ----
  	* tests/test-rbtree_oset.c (main): Update.
  	* lib/gl_anytreehash_list1.h (add_to_bucket): Update.
  
+ 2007-03-13  Simon Josefsson  <simon@josefsson.org>
+ 
+ 	* tests/test-des.c: Use new namespace.
+ 
  2007-03-13  Bruno Haible  <bruno@clisp.org>
  
  	* tests/test-stdbool.c (i): Update after last patch.
***************
*** 6386,6395 ****
  	* build-aux/bootstrap: New file.
  	* build-aux/bootstrap.conf: New file, from coreutils.
  
- 2007-03-11  Bruno Haible  <bruno@clisp.org>
- 
- 	* m4/cycle-check.m4 (gl_CYCLE_CHECK): Require AC_C_INLINE.
- 
  2007-03-12  Simon Josefsson  <simon@josefsson.org>
  
  	* lib/des.h, lib/des.c, lib/gc-gnulib.c: Use gl_ namespace, to
--- 6386,6391 ----
***************
*** 6398,6403 ****
--- 6394,6403 ----
  
  2007-03-11  Bruno Haible  <bruno@clisp.org>
  
+ 	* m4/cycle-check.m4 (gl_CYCLE_CHECK): Require AC_C_INLINE.
+ 
+ 2007-03-11  Bruno Haible  <bruno@clisp.org>
+ 
  	* m4/locale-tr.m4 (gt_LOCALE_TR_UTF8): If the test program fails to
  	compile, set LOCALE_TR_UTF8 to 'none' instead of empty.
  
***************
*** 6519,6524 ****
--- 6519,6531 ----
  	* modules/dirname-tests (test_dirname_SOURCES): Remove redundant
  	variable.
  
+ 2007-03-10  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/stdio_.h (__attribute__): New macro.
+ 	(fprintf, vfprintf, printf, vprintf, snprintf, vsnprintf, sprintf,
+ 	vsprintf): Specify __attribute__ __format__ for GCC.
+ 	Suggested by Eric Blake.
+ 
  2007-03-09  Eric Blake  <ebb9@byu.net>
  	and Matthew Woehlke  <mw_triad@users.sourceforge.net>  (tiny change)
  
***************
*** 6527,6539 ****
  	(GL_INT64_T, GL_UINT64_T): New witnesses of whether gnulib 64-bit
  	types are supported.
  
- 2007-03-10  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/stdio_.h (__attribute__): New macro.
- 	(fprintf, vfprintf, printf, vprintf, snprintf, vsnprintf, sprintf,
- 	vsprintf): Specify __attribute__ __format__ for GCC.
- 	Suggested by Eric Blake.
- 
  2007-03-09  Bruno Haible  <bruno@clisp.org>
  
  	* modules/printf-posix-tests: New file.
--- 6534,6539 ----
***************
*** 6661,6703 ****
  
  	* m4/printf.m4: Make the shell script snippets copy&pastable.
  
- 2007-03-02  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/netinet_in_.h: New file.
- 	* m4/netinet_in_h.m4 (gl_HEADER_NETINET_IN): Test whether netinet/in.h
- 	is self-contained. Set ABSOLUTE_NETINET_IN_H, HAVE_NETINET_IN_H.
- 	* modules/netinet_in (Files): Add lib/netinet_in_.h.
- 	(Depends-on): Add absolute-header.
- 	(Makefile.am): Substitute ABSOLUTE_NETINET_IN_H, HAVE_NETINET_IN_H
- 	into netinet/in.h.
- 
- 2007-03-03  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/sys_select_.h: New file.
- 	* m4/sys_socket_h.m4 (gl_HEADER_SYS_SELECT): Test whether sys/select.h
- 	is self-contained. Set ABSOLUTE_SYS_SELECT_H, HAVE_SYS_SELECT_H.
- 	* modules/sys_select (Files): Add lib/sys_select_.h.
- 	(Depends-on): Add absolute-header.
- 	(Makefile.am): Substitute ABSOLUTE_SYS_SELECT_H, HAVE_SYS_SELECT_H
- 	into sys/select.h.
- 
- 2007-03-02  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/socket_.h: If sys/socket.h exists, include that and <sys/types.h>
- 	before it. Turn HAVE_WINSOCK2_H and HAVE_WS2TCPIP_H into configute-time
- 	values.
- 	* m4/sys_socket_h.m4 (gl_HEADER_SYS_SOCKET): Test also whether
- 	<sys/socket.h> is self-contained. Set ABSOLUTE_SYS_SOCKET_H,
- 	HAVE_SYS_SOCKET_H, HAVE_WINSOCK2_H, HAVE_WS2TCPIP_H.
- 	* modules/sys_socket (Depends-on): Add absolute-header.
- 	(Makefile.am): Substitute ABSOLUTE_SYS_SOCKET_H, HAVE_SYS_SOCKET_H,
- 	HAVE_WINSOCK2_H, HAVE_WS2TCPIP_H into sys/socket.h.
- 	(Include): Remove requirement of inclusion of <sys/types.h>.
- 
- 2007-03-02  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/byteswap_.h (bswap_32): Fix formula.
- 
  2007-03-06  Bruno Haible  <bruno@clisp.org>
  
  	* modules/sprintf-posix-tests: New file.
--- 6661,6666 ----
***************
*** 6934,6939 ****
--- 6897,6912 ----
  
  2007-03-03  Bruno Haible  <bruno@clisp.org>
  
+ 	* lib/sys_select_.h: New file.
+ 	* m4/sys_socket_h.m4 (gl_HEADER_SYS_SELECT): Test whether sys/select.h
+ 	is self-contained. Set ABSOLUTE_SYS_SELECT_H, HAVE_SYS_SELECT_H.
+ 	* modules/sys_select (Files): Add lib/sys_select_.h.
+ 	(Depends-on): Add absolute-header.
+ 	(Makefile.am): Substitute ABSOLUTE_SYS_SELECT_H, HAVE_SYS_SELECT_H
+ 	into sys/select.h.
+ 
+ 2007-03-03  Bruno Haible  <bruno@clisp.org>
+ 
  	* modules/relocatable-prog (Depends-on): Add back progreloc's
  	dependencies: canonicalize-lgpl, xalloc, xreadlink, stdbool, unistd.
  
***************
*** 7019,7024 ****
--- 6992,7024 ----
  
  2007-03-02  Bruno Haible  <bruno@clisp.org>
  
+ 	* lib/netinet_in_.h: New file.
+ 	* m4/netinet_in_h.m4 (gl_HEADER_NETINET_IN): Test whether netinet/in.h
+ 	is self-contained. Set ABSOLUTE_NETINET_IN_H, HAVE_NETINET_IN_H.
+ 	* modules/netinet_in (Files): Add lib/netinet_in_.h.
+ 	(Depends-on): Add absolute-header.
+ 	(Makefile.am): Substitute ABSOLUTE_NETINET_IN_H, HAVE_NETINET_IN_H
+ 	into netinet/in.h.
+ 
+ 2007-03-02  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/socket_.h: If sys/socket.h exists, include that and <sys/types.h>
+ 	before it. Turn HAVE_WINSOCK2_H and HAVE_WS2TCPIP_H into configute-time
+ 	values.
+ 	* m4/sys_socket_h.m4 (gl_HEADER_SYS_SOCKET): Test also whether
+ 	<sys/socket.h> is self-contained. Set ABSOLUTE_SYS_SOCKET_H,
+ 	HAVE_SYS_SOCKET_H, HAVE_WINSOCK2_H, HAVE_WS2TCPIP_H.
+ 	* modules/sys_socket (Depends-on): Add absolute-header.
+ 	(Makefile.am): Substitute ABSOLUTE_SYS_SOCKET_H, HAVE_SYS_SOCKET_H,
+ 	HAVE_WINSOCK2_H, HAVE_WS2TCPIP_H into sys/socket.h.
+ 	(Include): Remove requirement of inclusion of <sys/types.h>.
+ 
+ 2007-03-02  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/byteswap_.h (bswap_32): Fix formula.
+ 
+ 2007-03-02  Bruno Haible  <bruno@clisp.org>
+ 
  	* modules/gettext (configure.ac): Require gettext infrastructure
  	from version 0.16.1.
  
***************
*** 7116,7147 ****
  	* modules/xreadlink (Maintainer): Add my name.
  	* modules/xreadlink-with-size (Depends-on): Alphabetize.
  
- 2007-02-26  Ben Pfaff  <blp@cs.stanford.edu>
- 	    Bruno Haible  <bruno@clisp.org>
- 
- 	* build-aux/install-reloc: Compile also c-ctype.c.
- 	* build-aux/relocatable.sh.in: New file.
- 	* doc/relocatable.texi: New file.
- 	* doc/relocatable-maint.texi: New file.
- 	* doc/gnulib.texi: Include relocatable-maint.texi.
- 	* lib/progreloc.c: Include unistd.h unconditionally.
- 	* lib/relocwrapper.c: Include unistd.h unconditionally.
- 	Include c-ctype.h.
- 	(add_dotbin): Use c_tolower.
- 	* m4/relocatable-lib.m4: New file, extracted from m4/relocatable.m4.
- 	(gl_RELOCATABLE_LIBRARY): Renamed from AC_RELOCATABLE_LIBRARY.
- 	(gl_RELOCATABLE_NOP): Renamed from AC_RELOCATABLE_NOP.
- 	* m4/relocatable.m4 (AC_RELOCATABLE_LIBRARY, AC_RELOCATABLE_NOP): Move
- 	to m4/relocatable-lib.m4.
- 	(gl_RELOCATABLE): Renamed from AC_RELOCATABLE. Set also
- 	RELOCATABLE_CONFIG_H_DIR, RELOCATABLE_SRC_DIR, RELOCATABLE_BUILD_DIR.
- 	(gl_RELOCATABLE_BODY): Renamed from AC_RELOCATABLE_BODY. Don't
- 	require obsolete macro AC_EXEEXT. Don't check for unistd.h. Don't set
- 	SET_RELOCATABLE. Instead set RELOCATABLE_LDFLAGS, INSTALL_PROGRAM_ENV.
- 	* modules/relocatable: New file.
- 	* modules/relocatable-lib: New file.
- 	* modules/relocatable-script: New file.
- 
  2007-02-28  Bruno Haible  <bruno@clisp.org>
  
  	Import --enable-relocatable infrastructure.
--- 7116,7121 ----
***************
*** 7175,7180 ****
--- 7149,7180 ----
  	xreadlink-with-size.
  	* lib/canonicalize.c (canonicalize_filename_mode): Update.
  
+ 2007-02-26  Ben Pfaff  <blp@cs.stanford.edu>
+ 	    Bruno Haible  <bruno@clisp.org>
+ 
+ 	* build-aux/install-reloc: Compile also c-ctype.c.
+ 	* build-aux/relocatable.sh.in: New file.
+ 	* doc/relocatable.texi: New file.
+ 	* doc/relocatable-maint.texi: New file.
+ 	* doc/gnulib.texi: Include relocatable-maint.texi.
+ 	* lib/progreloc.c: Include unistd.h unconditionally.
+ 	* lib/relocwrapper.c: Include unistd.h unconditionally.
+ 	Include c-ctype.h.
+ 	(add_dotbin): Use c_tolower.
+ 	* m4/relocatable-lib.m4: New file, extracted from m4/relocatable.m4.
+ 	(gl_RELOCATABLE_LIBRARY): Renamed from AC_RELOCATABLE_LIBRARY.
+ 	(gl_RELOCATABLE_NOP): Renamed from AC_RELOCATABLE_NOP.
+ 	* m4/relocatable.m4 (AC_RELOCATABLE_LIBRARY, AC_RELOCATABLE_NOP): Move
+ 	to m4/relocatable-lib.m4.
+ 	(gl_RELOCATABLE): Renamed from AC_RELOCATABLE. Set also
+ 	RELOCATABLE_CONFIG_H_DIR, RELOCATABLE_SRC_DIR, RELOCATABLE_BUILD_DIR.
+ 	(gl_RELOCATABLE_BODY): Renamed from AC_RELOCATABLE_BODY. Don't
+ 	require obsolete macro AC_EXEEXT. Don't check for unistd.h. Don't set
+ 	SET_RELOCATABLE. Instead set RELOCATABLE_LDFLAGS, INSTALL_PROGRAM_ENV.
+ 	* modules/relocatable: New file.
+ 	* modules/relocatable-lib: New file.
+ 	* modules/relocatable-script: New file.
+ 
  2007-02-25  Jim Meyering  <jim@meyering.net>
  
  	* build-aux/announce-gen: When complaining about excess arguments,
***************
*** 7277,7282 ****
--- 7277,7289 ----
  	* modules/stdint-tests: Likewise.
  	* modules/tls-tests: Likewise.
  
+ 2007-02-25  Jim Meyering  <jim@meyering.net>
+ 
+ 	Avoid conflicting types for 'unsetenv' on FreeBSD.
+ 	* lib/putenv.c (_unsetenv): Rename from "unsetenv", to avoid
+ 	conflicting with FreeBSD's (5.0 and 6.1) function declaration
+ 	in stdlib.h.
+ 
  2007-02-24  Bruno Haible  <bruno@clisp.org>
  
  	* lib/isnanl.h (isnanl): Define through isnan if isnan is a macro.
***************
*** 7294,7306 ****
  	* lib/isnanl.c: Remove all code. Just include isnan.c.
  	* modules/isnanl-nolibm (Files): Add lib/isnan.c.
  
- 2007-02-25  Jim Meyering  <jim@meyering.net>
- 
- 	Avoid conflicting types for 'unsetenv' on FreeBSD.
- 	* lib/putenv.c (_unsetenv): Rename from "unsetenv", to avoid
- 	conflicting with FreeBSD's (5.0 and 6.1) function declaration
- 	in stdlib.h.
- 
  2007-02-24  Bruno Haible  <bruno@clisp.org>
  
  	* modules/isnanl-nolibm-tests: New file.
--- 7301,7306 ----
***************
*** 8439,8469 ****
  	* modules/nanosleep (Link): New section.
  	* modules/readline (Link): New section.
  
- 2007-01-27  Bruno Haible  <bruno@clisp.org>
- 
- 	Enforce the use of gnulib modules for unportable <string.h> functions.
- 	* m4/string_h.m4 (gl_STRING_MODULE_INDICATOR): New macro.
- 	(gl_STRING_MODULE_INDICATOR_DEFAULTS): New macro.
- 	(gl_HEADER_STRING_H_BODY): Require it.
- 	* lib/string_.h: If the gnulib module XYZ is not present, redefine
- 	the symbol XYZ to one that gives a link error.
- 	* modules/string (Makefile.am): Also substitute the GNULIB_* variables.
- 	* modules/memmem (configure.ac): Invoke gl_STRING_MODULE_INDICATOR.
- 	* modules/mempcpy (configure.ac): Likewise.
- 	* modules/memrchr (configure.ac): Likewise.
- 	* modules/stpcpy (configure.ac): Likewise.
- 	* modules/stpncpy (configure.ac): Likewise.
- 	* modules/strcase (configure.ac): Likewise.
- 	* modules/strcasestr (configure.ac): Likewise.
- 	* modules/strchrnul (configure.ac): Likewise.
- 	* modules/strdup (configure.ac): Likewise.
- 	* modules/strndup (configure.ac): Likewise.
- 	* modules/strnlen (configure.ac): Likewise.
- 	* modules/strpbrk (configure.ac): Likewise.
- 	* modules/strsep (configure.ac): Likewise.
- 	* modules/strstr (configure.ac): Likewise.
- 	* modules/strtok_r (configure.ac): Likewise.
- 
  2007-01-31  Jean-Louis Martineau  <martineau@zmanda.com>  (tiny change)
  
  	* lib/gai_strerror.c (values): Add EAI_OVERFLOW.
--- 8439,8444 ----
***************
*** 8582,8587 ****
--- 8557,8587 ----
  
  2007-01-27  Bruno Haible  <bruno@clisp.org>
  
+ 	Enforce the use of gnulib modules for unportable <string.h> functions.
+ 	* m4/string_h.m4 (gl_STRING_MODULE_INDICATOR): New macro.
+ 	(gl_STRING_MODULE_INDICATOR_DEFAULTS): New macro.
+ 	(gl_HEADER_STRING_H_BODY): Require it.
+ 	* lib/string_.h: If the gnulib module XYZ is not present, redefine
+ 	the symbol XYZ to one that gives a link error.
+ 	* modules/string (Makefile.am): Also substitute the GNULIB_* variables.
+ 	* modules/memmem (configure.ac): Invoke gl_STRING_MODULE_INDICATOR.
+ 	* modules/mempcpy (configure.ac): Likewise.
+ 	* modules/memrchr (configure.ac): Likewise.
+ 	* modules/stpcpy (configure.ac): Likewise.
+ 	* modules/stpncpy (configure.ac): Likewise.
+ 	* modules/strcase (configure.ac): Likewise.
+ 	* modules/strcasestr (configure.ac): Likewise.
+ 	* modules/strchrnul (configure.ac): Likewise.
+ 	* modules/strdup (configure.ac): Likewise.
+ 	* modules/strndup (configure.ac): Likewise.
+ 	* modules/strnlen (configure.ac): Likewise.
+ 	* modules/strpbrk (configure.ac): Likewise.
+ 	* modules/strsep (configure.ac): Likewise.
+ 	* modules/strstr (configure.ac): Likewise.
+ 	* modules/strtok_r (configure.ac): Likewise.
+ 
+ 2007-01-27  Bruno Haible  <bruno@clisp.org>
+ 
  	* modules/unistr/base: Update.
  
  2007-01-27  Bruno Haible  <bruno@clisp.org>
***************
*** 9257,9264 ****
  	HAVE_GETTIMEOFDAY && !GETTIMEOFDAY_CLOBBERS_LOCALTIME. Use the
  	maximum possible value for tv->tv_usec, rather than the minimum one.
  
- 2005-10-08  Martin Lambers  <marlam@marlam.de>
- 2005-10-08  Paul Eggert  <eggert@cs.ucla.edu>
  2007-01-16  Bruno Haible  <bruno@clisp.org>
  
  	* modules/gettimeofday (Files): Add lib/gettimeofday.h.
--- 9257,9262 ----
***************
*** 9407,9449 ****
  	* modules/fchdir (Depends-on): Add absolute-header.
  	* modules/unistd (Depends-on): Likewise.
  
- 2006-12-30  Bruno Haible  <bruno@clisp.org>
- 
- 	* modules/fchdir: New file.
- 	* modules/unistd (Files): Add lib/unistd_.h.
- 	(Makefile.am): Generate unistd.h from unistd_.h.
- 	* lib/fchdir.c: New file.
- 	* lib/dirent_.h: New file.
- 	* lib/unistd_.h: New file.
- 	* lib/fcntl_.h (open) [FCHDIR_REPLACEMENT]: New replacement.
- 	* m4/fchdir.m4: New file.
- 	* m4/unistd_h.m4 (gl_PREREQ_UNISTD): New macro.
- 	(gl_HEADER_UNISTD): Invoke it.
- 	* lib/dup-safer.c (dup_safer) [FCHDIR_REPLACEMENT]: Use the dup
- 	function.
- 	* lib/backupfile.c (opendir, closedir): Undefine.
- 	* lib/chown.c (open, close): Undefine.
- 	* lib/clean-temp.c (open, close): Undefine.
- 	* lib/copy-file.c (open, close): Undefine.
- 	* lib/execute.c (open, close): Undefine.
- 	* lib/fsusage.c (open, close): Undefine.
- 	* lib/gc-gnulib.c (open, close): Undefine.
- 	* lib/getcwd.c (opendir, closedir): Undefine.
- 	* lib/glob.c (opendir, closedir): Undefine.
- 	* lib/javacomp.c (open, close): Undefine.
- 	* lib/mountlist.c (open, close, opendir, closedir): Undefine.
- 	* lib/openat-proc.c (open, close): Undefine.
- 	* lib/pagealign_alloc.c (open, close): Undefine.
- 	* lib/pipe.c (open, close): Undefine.
- 	* lib/progreloc.c (open, close): Undefine.
- 	* lib/savedir.c (opendir, closedir): Undefine.
- 	* lib/utime.c (open, close): Undefine.
- 	* MODULES.html.sh (Support for systems lacking POSIX:2001): Add fchdir.
- 
- 2007-01-10  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/striconv.c (mem_cd_iconv): Align the temporary buffer.
- 
  2007-01-12  Eric Blake  <ebb9@byu.net>
  
  	Provide a robust <wchar.h>.  Further simplifications are now
--- 9405,9410 ----
***************
*** 9474,9479 ****
--- 9435,9444 ----
  	* gnulib-tool (func_all_modules): Exclude all files inside the CVS
  	directory.
  
+ 2007-01-10  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/striconv.c (mem_cd_iconv): Align the temporary buffer.
+ 
  2007-01-10  Paul Eggert  <eggert@cs.ucla.edu>
  
  	Use @...@ consistently in lib/wctype_.h.
***************
*** 9842,9859 ****
  	* lib/fts.c: Likewise.
  	* modules/fts (configure.ac): Use gl_MODULE_INDICATOR.
  
- 2006-12-25  Bruno Haible  <bruno@clisp.org>
- 
- 	* modules/utf8-ucs4-safe: New file.
- 	* lib/utf8-ucs4-safe.h: New file.
- 	* lib/unistr/utf8-ucs4-safe.c: New file.
- 
- 	* modules/utf16-ucs4-safe: New file.
- 	* lib/utf16-ucs4-safe.h: New file.
- 	* lib/unistr/utf16-ucs4-safe.c: New file.
- 
- 	* MODULES.html.sh (Unicode string functions): Add the new modules.
- 
  2007-01-08  Bruno Haible  <bruno@clisp.org>
  
  	* modules/utf8-ucs4 (Files, lib_SOURCES): Add unistr/utf8-ucs4.c.
--- 9807,9812 ----
***************
*** 9884,9897 ****
  	(u16_uctomb): Use ucs4_t, uint16_t types.
  	* lib/unistr/ucs4-utf16.c: New file.
  
- 2006-12-25  Bruno Haible  <bruno@clisp.org>
- 
- 	* modules/unitypes: New file.
- 	* lib/unitypes.h: New file.
- 	* MODULES.html.sh (func_all_modules): New section "Unicode string
- 	functions". Move ucs4-utf8, ucs4-utf16, utf8-ucs4, utf16-ucs4 to
- 	this section. Add unitypes.
- 
  2007-01-08  Bruno Haible  <bruno@clisp.org>
  
  	Avoid variable names that conflict with those from libtool.
--- 9837,9842 ----
***************
*** 10018,10027 ****
  	to follow.  Don't set event bits that were not requested (except
  	POLLERR and POLLHUP).
  
- 2007-01-01  Bruno Haible  <bruno@clisp.org>
- 
- 	* modules/lchmod (Include): Require lchmod.h, not lchown.h.
- 
  2007-01-03  Jim Meyering  <jim@meyering.net>
  
  	* modules/fts-lgpl (Depends-on): Add i-ring.  Reported by Bruno Haible.
--- 9963,9968 ----
***************
*** 10033,10038 ****
--- 9974,9983 ----
  
  2007-01-01  Bruno Haible  <bruno@clisp.org>
  
+ 	* modules/lchmod (Include): Require lchmod.h, not lchown.h.
+ 
+ 2007-01-01  Bruno Haible  <bruno@clisp.org>
+ 
  	* gnulib-tool (func_emit_copyright_notice): Bump year.
  	(func_get_autoconf_snippet): Emit a GNULIB_<modulename> macro.
  
***************
*** 10049,10054 ****
--- 9994,10032 ----
  
  	* lib/version-etc.c (COPYRIGHT_YEAR): Bump for new year.
  
+ 2006-12-30  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* modules/fchdir: New file.
+ 	* modules/unistd (Files): Add lib/unistd_.h.
+ 	(Makefile.am): Generate unistd.h from unistd_.h.
+ 	* lib/fchdir.c: New file.
+ 	* lib/dirent_.h: New file.
+ 	* lib/unistd_.h: New file.
+ 	* lib/fcntl_.h (open) [FCHDIR_REPLACEMENT]: New replacement.
+ 	* m4/fchdir.m4: New file.
+ 	* m4/unistd_h.m4 (gl_PREREQ_UNISTD): New macro.
+ 	(gl_HEADER_UNISTD): Invoke it.
+ 	* lib/dup-safer.c (dup_safer) [FCHDIR_REPLACEMENT]: Use the dup
+ 	function.
+ 	* lib/backupfile.c (opendir, closedir): Undefine.
+ 	* lib/chown.c (open, close): Undefine.
+ 	* lib/clean-temp.c (open, close): Undefine.
+ 	* lib/copy-file.c (open, close): Undefine.
+ 	* lib/execute.c (open, close): Undefine.
+ 	* lib/fsusage.c (open, close): Undefine.
+ 	* lib/gc-gnulib.c (open, close): Undefine.
+ 	* lib/getcwd.c (opendir, closedir): Undefine.
+ 	* lib/glob.c (opendir, closedir): Undefine.
+ 	* lib/javacomp.c (open, close): Undefine.
+ 	* lib/mountlist.c (open, close, opendir, closedir): Undefine.
+ 	* lib/openat-proc.c (open, close): Undefine.
+ 	* lib/pagealign_alloc.c (open, close): Undefine.
+ 	* lib/pipe.c (open, close): Undefine.
+ 	* lib/progreloc.c (open, close): Undefine.
+ 	* lib/savedir.c (opendir, closedir): Undefine.
+ 	* lib/utime.c (open, close): Undefine.
+ 	* MODULES.html.sh (Support for systems lacking POSIX:2001): Add fchdir.
+ 
  2006-12-30  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* gnulib-tool (SORT): Remove, since we no longer assume GNU sort.
***************
*** 10121,10126 ****
--- 10099,10124 ----
  	* MODULES.html.sh (Support for building libraries and
  	executables): Document it.
  
+ 2006-12-25  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* modules/utf8-ucs4-safe: New file.
+ 	* lib/utf8-ucs4-safe.h: New file.
+ 	* lib/unistr/utf8-ucs4-safe.c: New file.
+ 
+ 	* modules/utf16-ucs4-safe: New file.
+ 	* lib/utf16-ucs4-safe.h: New file.
+ 	* lib/unistr/utf16-ucs4-safe.c: New file.
+ 
+ 	* MODULES.html.sh (Unicode string functions): Add the new modules.
+ 
+ 2006-12-25  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* modules/unitypes: New file.
+ 	* lib/unitypes.h: New file.
+ 	* MODULES.html.sh (func_all_modules): New section "Unicode string
+ 	functions". Move ucs4-utf8, ucs4-utf16, utf8-ucs4, utf16-ucs4 to
+ 	this section. Add unitypes.
+ 
  2006-12-25  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* gnulib-tool (SED): Remove, undoing previous change.
***************
*** 10363,10380 ****
  
  	* m4/ptrdiff_max.m4: Remove file.
  
- 2006-11-21  Bruno Haible  <bruno@clisp.org>
- 
- 	* m4/eoverflow.m4 (gl_EOVERFLOW): Use AC_COMPUTE_INT instead of
- 	_AC_COMPUTE_INT.
- 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
- 	* m4/ptrdiff_max.m4 (gl_PTRDIFF_MAX): Use AC_COMPUTE_INT instead of
- 	_AC_COMPUTE_INT.
- 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
- 	* m4/size_max.m4 (gl_SIZE_MAX): Use AC_COMPUTE_INT instead of
- 	_AC_COMPUTE_INT.
- 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
- 
  2006-11-28  Jim Meyering  <jim@meyering.net>
  
  	* lib/regcomp.c (parse_branch): Rename local, exp->expr, to avoid
--- 10361,10366 ----
***************
*** 10389,10400 ****
  2006-11-27  Bruno Haible  <bruno@clisp.org>
  	    Paul Eggert  <eggert@cs.ucla.edu>
  
! 	* lib/regex.h (__restrict_arr): Redo logic of #if, for clarity.
! 
! 2006-11-26  Bruno Haible  <bruno@clisp.org>
! 
! 	* gnulib-tool (func_emit_lib_Makefile_am): Initialize also
! 	noinst_LTLIBRARIES.
  
  2006-11-27  Paul Eggert  <eggert@cs.ucla.edu>
  	    Bruno Haible  <bruno@clisp.org>
--- 10375,10381 ----
  2006-11-27  Bruno Haible  <bruno@clisp.org>
  	    Paul Eggert  <eggert@cs.ucla.edu>
  
! 	* lib/regex.h (__restrict_arr): Redo logic of #if, for clarity.
  
  2006-11-27  Paul Eggert  <eggert@cs.ucla.edu>
  	    Bruno Haible  <bruno@clisp.org>
***************
*** 10402,10407 ****
--- 10383,10393 ----
  	* lib/gettext.h (_LIBGETTEXT_HAVE_VARIABLE_SIZE_ARRAYS): Define to 0
  	if compiling with "gcc -ansi".
  
+ 2006-11-26  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* gnulib-tool (func_emit_lib_Makefile_am): Initialize also
+ 	noinst_LTLIBRARIES.
+ 
  2006-11-26  Paul Eggert  <eggert@cs.ucla.edu>
  
  	Fix some incompatibilities with gcc -ansi -pedantic.
***************
*** 10420,10433 ****
  	Don't close an fd more than once. Identical atimes indicate
  	success, not failure.
  
- 2006-11-22  Robinson Mittmann <bob@hoplon.com>  (tiny change)
- 
- 	* lib/sincosl.c (kernel_sinl): Fix typo in threshold.
- 
  2006-11-23  Jim Meyering  <jim@meyering.net>
  
  	* build-aux/announce-gen: New file.  From coreutils.
  
  2006-11-22  Jim Meyering  <jim@meyering.net>
  
  	Work around a compile-time error from the HP-UX 11.00 /bin/cc.
--- 10406,10419 ----
  	Don't close an fd more than once. Identical atimes indicate
  	success, not failure.
  
  2006-11-23  Jim Meyering  <jim@meyering.net>
  
  	* build-aux/announce-gen: New file.  From coreutils.
  
+ 2006-11-22  Robinson Mittmann <bob@hoplon.com>  (tiny change)
+ 
+ 	* lib/sincosl.c (kernel_sinl): Fix typo in threshold.
+ 
  2006-11-22  Jim Meyering  <jim@meyering.net>
  
  	Work around a compile-time error from the HP-UX 11.00 /bin/cc.
***************
*** 10438,10448 ****
  	* m4/clock_time.m4 (gl_CLOCK_TIME): Quote AC_SUBST argument.
  	* m4/euidaccess.m4 (gl_PREREQ_EUIDACCESS): Likewise.
  
! 2006-11-20  Bruno Haible  <bruno@clisp.org>
  
! 	* gettext.m4 (AM_GNU_GETTEXT): Revert 2005-07-28 patch: Use
! 	changequote instead of pairs of brackets.
! 	Reported by Andreas Schwab <schwab@suse.de>.
  
  2006-11-21  Jim Meyering  <jim@meyering.net>
  
--- 10424,10440 ----
  	* m4/clock_time.m4 (gl_CLOCK_TIME): Quote AC_SUBST argument.
  	* m4/euidaccess.m4 (gl_PREREQ_EUIDACCESS): Likewise.
  
! 2006-11-21  Bruno Haible  <bruno@clisp.org>
  
! 	* m4/eoverflow.m4 (gl_EOVERFLOW): Use AC_COMPUTE_INT instead of
! 	_AC_COMPUTE_INT.
! 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
! 	* m4/ptrdiff_max.m4 (gl_PTRDIFF_MAX): Use AC_COMPUTE_INT instead of
! 	_AC_COMPUTE_INT.
! 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
! 	* m4/size_max.m4 (gl_SIZE_MAX): Use AC_COMPUTE_INT instead of
! 	_AC_COMPUTE_INT.
! 	(AC_COMPUTE_INT): Add fallback definition for autoconf < 2.61.
  
  2006-11-21  Jim Meyering  <jim@meyering.net>
  
***************
*** 10450,10455 ****
--- 10442,10453 ----
  	so as to remain compatible with older compilers.
  	Patch from Michael Deutschmann.
  
+ 2006-11-20  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* gettext.m4 (AM_GNU_GETTEXT): Revert 2005-07-28 patch: Use
+ 	changequote instead of pairs of brackets.
+ 	Reported by Andreas Schwab <schwab@suse.de>.
+ 
  2006-11-20  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* MODULES.html.sh (File system functions): Add openat.
***************
*** 10507,10519 ****
  	* modules/i-ring (Depends-on): Add verify.
  	(License): Change to LGPL.
  
- 2006-11-16  Paul Eggert  <eggert@cs.ucla.edu>
- 
- 	* modules/getaddinfo (Depends-on): Remove inttostr; add snprintf.
- 	* lib/getaddrinfo.c: Include snprintf.h rather than intprops.h
- 	and inttostr.h.  Use snprintf rather than uinttostr, so that
- 	LGPLed code doesn't depend on GPLed.
- 
  2006-11-17  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* modules/inline (License): Change from GPL to LGPL.
--- 10505,10510 ----
***************
*** 10522,10527 ****
--- 10513,10525 ----
  
  	* modules/d-type (License): Switch to LGPL.
  
+ 2006-11-16  Paul Eggert  <eggert@cs.ucla.edu>
+ 
+ 	* modules/getaddinfo (Depends-on): Remove inttostr; add snprintf.
+ 	* lib/getaddrinfo.c: Include snprintf.h rather than intprops.h
+ 	and inttostr.h.  Use snprintf rather than uinttostr, so that
+ 	LGPLed code doesn't depend on GPLed.
+ 
  2006-11-15  Bruno Haible  <bruno@clisp.org>
  
  	* m4/alloca.m4 (gl_FUNC_ALLOCA): Fix the AC_CACHE_CHECK message.
***************
*** 10573,10591 ****
  
  	* modules/c-ctype (License): Change to LGPL.
  
- 2006-11-12  Bruno Haible  <bruno@clisp.org>
- 
- 	* m4/lib-link.m4 (AC_LIB_LINKFLAGS, AC_LIB_HAVE_LINKFLAGS,
- 	AC_LIB_LINKFLAGS_BODY): Also set a LIB${NAME}_PREFIX variable. Needed
- 	for GNOME libraries, for which the include files are installed in
- 	subdirectories of $prefix/include.
- 
- 2006-11-12  Bruno Haible  <bruno@clisp.org>
- 
- 	* m4/lib-link.m4: Require at least autoconf-2.54.
- 	(AC_LIB_LINKFLAGS_BODY) [autoconf < 2.61]: Turn dots into the library
- 	name to underscores for the --with option.
- 
  2006-11-13  Bruno Haible  <bruno@clisp.org>
  
  	* gnulib-tool (func_create_testdir): Set gl_source_base correctly in
--- 10571,10576 ----
***************
*** 10606,10611 ****
--- 10591,10609 ----
  
  2006-11-12  Bruno Haible  <bruno@clisp.org>
  
+ 	* m4/lib-link.m4 (AC_LIB_LINKFLAGS, AC_LIB_HAVE_LINKFLAGS,
+ 	AC_LIB_LINKFLAGS_BODY): Also set a LIB${NAME}_PREFIX variable. Needed
+ 	for GNOME libraries, for which the include files are installed in
+ 	subdirectories of $prefix/include.
+ 
+ 2006-11-12  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* m4/lib-link.m4: Require at least autoconf-2.54.
+ 	(AC_LIB_LINKFLAGS_BODY) [autoconf < 2.61]: Turn dots into the library
+ 	name to underscores for the --with option.
+ 
+ 2006-11-12  Bruno Haible  <bruno@clisp.org>
+ 
  	* gnulib-tool (func_emit_lib_Makefile_am): Replace occurrences of
  	'$(top_srcdir)/build-aux/', taking into account the real auxdir.
  
***************
*** 10681,10696 ****
  
  	* lib/fts.c [FTS_DEBUG]: Don't try to print a pointer via %s.
  
- 2006-11-09  Paul Eggert  <eggert@cs.ucla.edu>
- 
- 	* lib/gettext.h (dgettext, dcgettext, ngettext) [! ENABLE_NLS]:
- 	(dngettext, dcngettext, bindtextdomain) [! ENABLE_NLS]:
- 	(bind_textdomain_codeset) [! ENABLE_NLS]:
- 	Evaluate all the arguments.  That way, callers get compatible behavior
- 	if the arguments have side effects.  Also, it avoids some GCC
- 	diagnostics in some cases; Joel E. Denny reported problems when Bison
- 	was configured with --enable-gcc-warnigs.
- 
  2006-11-10  Jim Meyering  <jim@meyering.net>
  
  	* m4/inline.m4 (gl_INLINE): Check with the compiler, not cpp, so that
--- 10679,10684 ----
***************
*** 10707,10712 ****
--- 10695,10710 ----
  
  2006-11-09  Paul Eggert  <eggert@cs.ucla.edu>
  
+ 	* lib/gettext.h (dgettext, dcgettext, ngettext) [! ENABLE_NLS]:
+ 	(dngettext, dcngettext, bindtextdomain) [! ENABLE_NLS]:
+ 	(bind_textdomain_codeset) [! ENABLE_NLS]:
+ 	Evaluate all the arguments.  That way, callers get compatible behavior
+ 	if the arguments have side effects.  Also, it avoids some GCC
+ 	diagnostics in some cases; Joel E. Denny reported problems when Bison
+ 	was configured with --enable-gcc-warnigs.
+ 
+ 2006-11-09  Paul Eggert  <eggert@cs.ucla.edu>
+ 
  	* lib/stdint_.h (uintmax_t): Fix typo: int64_t -> uint64_t.
  	Problem reported by Matthew Woehlke.
  
***************
*** 10949,10959 ****
  
  	* m4/mkstemp.m4 (gl_FUNC_MKSTEMP): Allow C++ configuration.
  
- 2006-10-29  Bruno Haible  <bruno@clisp.org>
- 
- 	Make it compile in C++ mode.
- 	* lib/full-write.c (full_rw): Add a cast.
- 
  2006-11-01  Bruno Haible  <bruno@clisp.org>
  
  	* gnulib-tool (func_get_automake_snippet): Change sed_combine_lines to
--- 10947,10952 ----
***************
*** 10989,10994 ****
--- 10982,10992 ----
  2006-10-29  Bruno Haible  <bruno@clisp.org>
  
  	Make it compile in C++ mode.
+ 	* lib/full-write.c (full_rw): Add a cast.
+ 
+ 2006-10-29  Bruno Haible  <bruno@clisp.org>
+ 
+ 	Make it compile in C++ mode.
  	* lib/striconv.c (mem_cd_iconv): Cast malloc/realloc result.
  	* lib/strnlen1.c (strnlen1): Cast memchr result.
  	* lib/mbchar.h (mb_copy): Rename arguments to 'new_mbc', 'old_mbc'.
***************
*** 11000,11013 ****
  	* lib/linebreak.c (mbs_width_linebreaks): Cast malloc result.
  	* lib/wait-process.c (register_slave_subprocess): Likewise.
  
- 2006-10-22  Bruno Haible  <bruno@clisp.org>
- 
- 	* modules/tsearch: New file.
- 	* lib/tsearch.h: New file.
- 	* lib/tsearch.c: New file, from glibc-2.5 with small modifications.
- 	* m4/tsearch.m4: New file.
- 	* MODULES.html.sh (Support for systems lacking POSIX:2001): Add tsearch.
- 
  2006-10-29  Eric Blake  <ebb9@byu.net>
  
  	* lib/arcfour.c: Assume config.h.
--- 10998,11003 ----
***************
*** 11190,11203 ****
  	* MODULES.html.sh: Remove uinttostr.  It's not a module.
  	Reported by Karl Berry.
  
- 2006-10-23  Bruno Haible  <bruno@clisp.org>
- 
- 	* lib/fts.c (fts_build): Move variable declaration, for C89 compliance.
- 
  2006-10-24  Bruno Haible  <bruno@clisp.org>
  
  	* lib/gl_list.h: Use C comment style, not C++ comment style.
  
  2006-10-23  Eric Blake  <ebb9@byu.net>
  
  	* lib/getaddrinfo.c (includes): Add missing include.
--- 11180,11193 ----
  	* MODULES.html.sh: Remove uinttostr.  It's not a module.
  	Reported by Karl Berry.
  
  2006-10-24  Bruno Haible  <bruno@clisp.org>
  
  	* lib/gl_list.h: Use C comment style, not C++ comment style.
  
+ 2006-10-23  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/fts.c (fts_build): Move variable declaration, for C89 compliance.
+ 
  2006-10-23  Eric Blake  <ebb9@byu.net>
  
  	* lib/getaddrinfo.c (includes): Add missing include.
***************
*** 11218,11223 ****
--- 11208,11234 ----
  	__argc, __argv from the declaration. (They are defined as macros on
  	mingw.)
  
+ 2006-10-23  Jim Meyering  <jim@meyering.net>
+ 
+ 	* lib/getaddrinfo.c (getnameinfo): Use new lightweight uinttostr,
+ 	in place of snprintf.
+ 
+ 	* modules/inttostr (Files): Add lib/uinttostr.c.
+ 	* lib/uinttostr.c (inttostr): New file/function.
+ 	* lib/inttostr.h (uinttostr): Declare.
+ 	* m4/inttostr.m4: Add AC_LIBOBJ([uinttostr]).
+ 	* MODULES.html.sh (Numeric conversion functions <stdlib.h>):
+ 	Add uinttostr.
+ 	* modules/getaddrinfo (Depends-on): Remove snprintf.  Add inttostr.
+ 
+ 2006-10-22  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* modules/tsearch: New file.
+ 	* lib/tsearch.h: New file.
+ 	* lib/tsearch.c: New file, from glibc-2.5 with small modifications.
+ 	* m4/tsearch.m4: New file.
+ 	* MODULES.html.sh (Support for systems lacking POSIX:2001): Add tsearch.
+ 
  2006-10-22  Bruno Haible  <bruno@clisp.org>
  
  	* doc/gnulib-intro.texi: New file.
***************
*** 11234,11252 ****
  	Change mostlyclean-local rule to avoid sh syntax error from bash
  	versions 2.00..2.05 when $(MOSTLYCLEANDIRS) is empty.
  
- 2006-10-23  Jim Meyering  <jim@meyering.net>
- 
- 	* lib/getaddrinfo.c (getnameinfo): Use new lightweight uinttostr,
- 	in place of snprintf.
- 
- 	* modules/inttostr (Files): Add lib/uinttostr.c.
- 	* lib/uinttostr.c (inttostr): New file/function.
- 	* lib/inttostr.h (uinttostr): Declare.
- 	* m4/inttostr.m4: Add AC_LIBOBJ([uinttostr]).
- 	* MODULES.html.sh (Numeric conversion functions <stdlib.h>):
- 	Add uinttostr.
- 	* modules/getaddrinfo (Depends-on): Remove snprintf.  Add inttostr.
- 
  2006-10-21  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* lib/canonicalize.c (ELOOP): Define if not already defined.
--- 11245,11250 ----
***************
*** 11290,11298 ****
  	* gnulib-tool (func_create_testdir): Don't include ftruncate and
  	mountlist by default.
  
! 2006-10-16  Bruno Haible  <bruno@clisp.org>
  
! 	* lib/c-strstr.c: Include c-strstr.h.
  
  2006-10-18  Charles Wilson  <cygwin@cwilson.fastmail.fm>
  
--- 11288,11306 ----
  	* gnulib-tool (func_create_testdir): Don't include ftruncate and
  	mountlist by default.
  
! 2006-10-19  Paul Eggert  <eggert@cs.ucla.edu>
  
! 	* lib/xstrtol.h: Include gettext.h.
! 	(_STRTOL_ERROR): Wrap English-language formats inside gettext.
! 	Problem reported by Eric Blake.
! 	* modules/xstrtol (Depends-on): Add gettext-h.
! 
! 2006-10-19  Paul Eggert  <eggert@cs.ucla.edu>  (tiny change)
! 
! 	* lib/strftime.c (advance): New macro.
! 	(add): Use it to avoid adding 0 to a FILE *.  FILE can be an
! 	incomplete type, so you can't add 0 to it.  Problem and patch
! 	reported by Eelco Dolstra for dietlibc.
  
  2006-10-18  Charles Wilson  <cygwin@cwilson.fastmail.fm>
  
***************
*** 11312,11331 ****
  
  	* lib/findprog.c (find_in_path): Avoid "gcc -Wwrite-strings" warning.
  
- 2006-10-19  Paul Eggert  <eggert@cs.ucla.edu>
- 
- 	* lib/xstrtol.h: Include gettext.h.
- 	(_STRTOL_ERROR): Wrap English-language formats inside gettext.
- 	Problem reported by Eric Blake.
- 	* modules/xstrtol (Depends-on): Add gettext-h.
- 
- 2006-10-19  Paul Eggert  <eggert@cs.ucla.edu>  (tiny change)
- 
- 	* lib/strftime.c (advance): New macro.
- 	(add): Use it to avoid adding 0 to a FILE *.  FILE can be an
- 	incomplete type, so you can't add 0 to it.  Problem and patch
- 	reported by Eelco Dolstra for dietlibc.
- 
  2006-10-18  Jim Meyering  <jim@meyering.net>
  
  	* lib/readutmp.c (desirable_utmp_entry): Use "bool" as the
--- 11320,11325 ----
***************
*** 11357,11362 ****
--- 11351,11365 ----
  	* lib/gettext.h (gettext, ngettext, pgettext, npgettext): Define
  	differently if DEFAULT_TEXT_DOMAIN is set.
  
+ 2006-10-17  Eric Blake  <ebb9@byu.net>
+ 
+ 	* lib/xvasprintf.c (includes): Assume config.h.
+ 	* lib/xasprintf.c (includes): Likewise.
+ 
+ 2006-10-16  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* lib/c-strstr.c: Include c-strstr.h.
+ 
  2006-10-16  Bruno Haible  <bruno@clisp.org>
  
  	* lib/clean-temp.c: Include fwriteerror.h.
***************
*** 11371,11381 ****
  	* lib/sigprocmask.h: Include <sys/types.h>.
  	(sigset_t): Use the system's definition if present.
  
- 2006-10-17  Eric Blake  <ebb9@byu.net>
- 
- 	* lib/xvasprintf.c (includes): Assume config.h.
- 	* lib/xasprintf.c (includes): Likewise.
- 
  2006-10-16  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* lib/fsusage.c (PROPAGATE_ALL_ONES): Don't assume uintmax_t is
--- 11374,11379 ----
***************
*** 11870,11902 ****
  	(_PRI64_PREFIX, _PRIu64_PREFIX, _SCN64_PREFIX, _SCNu64_PREFIX): Handle
  	MSVC and mingw explicitly.
  
- 2006-10-11  Simon Josefsson  <jas@extundo.com>
- 	    Bruno Haible  <bruno@clisp.org>
- 
- 	Add support for multiple gnulib-tool invocations in the scope of a
- 	single configure.ac file.
- 	* gnulib-tool (func_emit_lib_Makefile_am): In the _LIBADD variable,
- 	use a private [LT]LIBOBJS variant. Define a _DEPENDENCIES variable
- 	with the same contents as the _LIBADD variable.
- 	(func_emit_initmacro_start, func_emit_initmacro_end,
- 	func_emit_initmacro_done): New functions.
- 	(func_import, func_create_testdir): Invoke them. Allow the identifiers
- 	gl_LIBOBJS and gl_LTLIBOBJS.
- 
- 2006-10-11  Bruno Haible  <bruno@clisp.org>
- 
- 	* gnulib-tool (GETTEXTPATH, AUTOHEADER, AUTOPOINT): New variables.
- 	(func_create_testdir): Don't create po/Makefile.am, don't invoke
- 	autoreconf. Instead, invoke autopoint explicitly but move back the
- 	*.m4 files from gnulib.
- 
- 2006-10-11  Bruno Haible  <bruno@clisp.org>
- 
- 	* gnulib-tool (func_usage): Make module names after --create-testdir
- 	optional.
- 	(func_create_testdir): If no module was specified, use nearly all
- 	modules.
- 
  2006-10-12  Jim Meyering  <jim@meyering.net>
  
  	Big performance improvement for fts-based tools that use FTS_NOSTAT.
--- 11868,11873 ----
***************
*** 11935,11940 ****
--- 11906,11938 ----
  	* m4/rename-dest-slash.m4 (gl_FUNC_RENAME_TRAILING_DEST_SLASH):
  	Fix misspelling in diagnostic.
  
+ 2006-10-11  Simon Josefsson  <jas@extundo.com>
+ 	    Bruno Haible  <bruno@clisp.org>
+ 
+ 	Add support for multiple gnulib-tool invocations in the scope of a
+ 	single configure.ac file.
+ 	* gnulib-tool (func_emit_lib_Makefile_am): In the _LIBADD variable,
+ 	use a private [LT]LIBOBJS variant. Define a _DEPENDENCIES variable
+ 	with the same contents as the _LIBADD variable.
+ 	(func_emit_initmacro_start, func_emit_initmacro_end,
+ 	func_emit_initmacro_done): New functions.
+ 	(func_import, func_create_testdir): Invoke them. Allow the identifiers
+ 	gl_LIBOBJS and gl_LTLIBOBJS.
+ 
+ 2006-10-11  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* gnulib-tool (GETTEXTPATH, AUTOHEADER, AUTOPOINT): New variables.
+ 	(func_create_testdir): Don't create po/Makefile.am, don't invoke
+ 	autoreconf. Instead, invoke autopoint explicitly but move back the
+ 	*.m4 files from gnulib.
+ 
+ 2006-10-11  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* gnulib-tool (func_usage): Make module names after --create-testdir
+ 	optional.
+ 	(func_create_testdir): If no module was specified, use nearly all
+ 	modules.
+ 
  2006-10-11  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* lib/mkdir-p.c (HAVE_FCHMOD): Define to false if not already
***************
*** 13593,13598 ****
--- 13591,13601 ----
  	* MODULES.html.sh (Compatibility checks for POSIX:2001 functions: Fix
  	HTML structure.
  
+ 2006-08-24  Bruno Haible  <bruno@clisp.org>
+ 
+ 	* MODULES.html.sh (Compatibility checks for POSIX:2001 functions): Fix
+ 	HTML structure.
+ 
  2006-08-23  Paul Eggert  <eggert@cs.ucla.edu>
  
  	* modules/openat (Depends-on): Add lchown.
***************
*** 18765,18770 ****
--- 18768,18775 ----
  	* modules/strchrnul (License): Likewise.
  	* modules/sysexits (License): Likewise.
  
+ 2005-10-08  Martin Lambers  <marlam@marlam.de>
+ 2005-10-08  Paul Eggert  <eggert@cs.ucla.edu>
  2005-10-08  Simon Josefsson  <jas@extundo.com>
  
  	* config/srclist.txt: Bug 1423 is closed, but 1439 remains.
***************
*** 34640,34646 ****
  	* m4/uintmax_t.m4: New file.
  	* m4/Makefile.am (EXTRA_DIST): Add inttypes_h.m4 and uintmax_t.m4.
  
! Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007
    Free Software Foundation, Inc.
  Copying and distribution of this file, with or without modification,
  are permitted provided the copyright notice and this notice are preserved.
--- 34645,34651 ----
  	* m4/uintmax_t.m4: New file.
  	* m4/Makefile.am (EXTRA_DIST): Add inttypes_h.m4 and uintmax_t.m4.
  
! Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006,Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007
    Free Software Foundation, Inc.
  Copying and distribution of this file, with or without modification,
  are permitted provided the copyright notice and this notice are preserved.

--Boundary-00=_O42CHCD/uTA+MUD--
