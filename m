From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [FYI] How I compile on SunOS 5.7 with the SUNWspro compiler and ksh
Date: Mon, 18 Aug 2008 18:39:40 -0500
Message-ID: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEL8-0003Kj-Ke
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbYHRXjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYHRXjn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:39:43 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46067 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbYHRXjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:39:42 -0400
Received: by mail.nrlssc.navy.mil id m7INdeET028780; Mon, 18 Aug 2008 18:39:41 -0500
X-OriginalArrivalTime: 18 Aug 2008 23:39:40.0403 (UTC) FILETIME=[AEF34430:01C9018B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92763>

This email describes how I have successfully compiled git on SunOS 5.7 with
the native SUNWspro compiler version 6 update 2 C 5.3 2001/05/15 and
successfully run nearly all of the tests using the Korn shell.

A series of 8 patches will follow this email. The patches work around a
few issues with this c89 compiler, and the ancient build environment.

A build script is provided at the end of this email.

The GIT_SKIP_TESTS environment variable was used to skip tests which still fail.
The tests which still fail do so because of an ancient iconv, with two exceptions:
1) the t5000 tests which fail are due to the installed gnu tar being too old, and
2) the t6030 tests which fail do so because of the recent change which calls
   trap with signal 0 inside of a function. The installed korn shell (mis-?)handles
   this calling sequence.

Otherwise, I've been using this executable somewhat and have not experienced any
problems. Maybe it will be useful to others.

 Makefile                       |   14 +++++++++++++-
 builtin-cat-file.c             |    2 +-
 builtin-reset.c                |    2 +-
 dir.c                          |   11 ++++++-----
 t/annotate-tests.sh            |    2 +-
 t/lib-git-svn.sh               |    3 +++
 t/t1002-read-tree-m-u-2way.sh  |   10 ++++++----
 t/t4118-apply-empty-context.sh |    2 +-
 t/t4200-rerere.sh              |    5 +++--
 t/t9301-fast-export.sh         |    1 -
 t/t9700/test.pl                |   12 ++++++------
 t/test-lib.sh                  |    2 +-
 12 files changed, 42 insertions(+), 24 deletions(-)

-brandon


#!/bin/sh

GIT_SKIP_TESTS='
   t3900.1[0-289] t3900.2[023]
   t3901.*
   t5000.1[0-24-689] t5000.2[01]
   t5100.[56] t5100.1[02]
   t6030.1[2-9] t6030.2[0-9]
   t9301.4
'

GIT_TEST_CMP='cmp -s'

PATH="/usr/xpg4/bin:$PATH"

export PATH GIT_TEST_CMP GIT_SKIP_TESTS

exec gmake \
    CC=/opt/SUNWspro/bin/cc \
    INSTALL=ginstall \
    TAR=gtar \
    CFLAGS='-fast' \
    NO_CURL=1 \
    NO_OPENSSL=1 \
    NO_TCLTK=1 \
    NO_PERL_MAKEMAKER=1 \
    THREADED_DELTA_SEARCH=1 \
    "$@"
