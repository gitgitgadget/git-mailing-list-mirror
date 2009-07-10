From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 0/5] How I compile on IRIX 6.5 with the MIPSpro compiler and ksh
Date: Fri, 10 Jul 2009 12:10:42 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdM-0004dM-Kh
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZGJRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbZGJRLe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:11:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57120 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZGJRLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:33 -0400
Received: by mail.nrlssc.navy.mil id n6AHBVIC022071; Fri, 10 Jul 2009 12:11:31 -0500
X-OriginalArrivalTime: 10 Jul 2009 17:11:31.0052 (UTC) FILETIME=[7814D2C0:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123065>

From: Brandon Casey <drafnel@gmail.com>

This email describes how I have successfully compiled git on IRIX6.5 with the
native MIPSpro compiler version 7.4.4m and successfully run nearly all of the
tests using the Korn shell.

A config.mak file is provided at the end of this email.

The GIT_SKIP_TESTS environment variable was used to skip tests which still
fail.  The number of tests which must be skipped has been greatly reduced.
When I sent this email last year, 23 individual tests were skipped plus all
of t3901.  With current master, only 13 tests must be skipped.  The remaining
tests which fail are due to the installed iconv lacking support for the
tested languages.

Two lingering concerns:
  1) Building with -Ofast produces an executable which segfaults and can not
     pass the tests.
  2) Building with mmap support produces an executable which segfaults on
     t1400-update-ref when it calls

         'git rev-parse --verify "master@{May 25 2005}"'

     Previously, this fault was avoided when THREADED_DELTA_SEARCH was set,
     but there is a warning during compilation when THREADED_DELTA_SEARCH is
     enabled that suggests Variable Length Arrays should not be used when
     threads are used.  So it is left unset, and now NO_MMAP is set.

     From my notes:
     I tracked the mmap issue down to the mmap in refs.c:read_ref_at().  The
     mmap succeeds, and the loop is executed properly until rec is rewound
     into the first line (reflog entry) of the file. I don't know why it
     fails, the code looks correct. I can't reproduce it with a similarly
     structured stand-alone test program.  For the mentioned test that fails
     above, if the rev-parse argument is changed to something that does not
     reference the first entry in the log file, then it will succeed
     e.g. "master@{3}".

I have no debugger.

Otherwise, I've been using this executable somewhat and have not experienced
any problems.  Maybe it will be useful to others.

Are there actually any IRIX users out there?

These patches are all submitted For-Your-Information only.  Junio, feel free
to apply any of them or none, and to add my Signed-off-by.

-brandon


Brandon Casey (5):
  unpack-trees.c: work around run-time array initialization flaw on
    IRIX 6.5
  git-compat-util.h: adjust for SGI IRIX 6.5
  Makefile: add NEEDS_LIBGEN to optionally add -lgen to compile
    arguments
  Makefile: add section for SGI IRIX 6.5
  test-lib.sh: work around ksh's trap shortcomings

 Makefile          |   18 ++++++++++++++++++
 configure.ac      |    6 ++++++
 git-compat-util.h |    3 ++-
 t/lib-git-svn.sh  |   15 ++++++++++-----
 t/test-lib.sh     |    3 ++-
 unpack-trees.c    |    2 +-
 6 files changed, 39 insertions(+), 8 deletions(-)


--->8--- config.mak --->8---

GIT_SKIP_TESTS := \
   t3900.1[129] t3900.2[0234] \
   t5100.5 t5100.1[06] \
   t8005.[234]
export GIT_SKIP_TESTS

SHELL_PATH = /bin/ksh
TAR = gtar
CC = c99
CFLAGS = -n32 -O2
NO_C99_FORMAT = 1
NO_CURL = 1
NO_OPENSSL = 1
NO_TCLTK = 1
