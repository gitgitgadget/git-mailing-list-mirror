From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [FYI] How I compile on IRIX 6.5 with the MIPSpro compiler and ksh
Date: Mon, 18 Aug 2008 17:55:10 -0500
Message-ID: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 00:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDeE-0008Ba-4X
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 00:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYHRWzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYHRWzN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 18:55:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53648 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbYHRWzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 18:55:12 -0400
Received: by mail.nrlssc.navy.mil id m7IMtAH8023789; Mon, 18 Aug 2008 17:55:10 -0500
X-OriginalArrivalTime: 18 Aug 2008 22:55:10.0146 (UTC) FILETIME=[775A6220:01C90185]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92748>


This email describes how I have successfully compiled git on IRIX6.5 with the
native MIPSpro compiler version 7.4.4m and successfully run nearly all of the
tests using the Korn shell.

A series of 7 patches will follow this email. The patches work around a couple
of flaws in the IRIX c99 compiler, and the not-quite-recent build environment.

A build script is provided at the end of this email.

The GIT_SKIP_TESTS environment variable was used to skip tests which still fail.
The tests which still fail do so because of an ancient iconv, with one exception:
the t5000 tests which fail are due to the installed gnu tar being too old.

Two lingering concerns:
  1) Building with -Ofast produced an executable which segfaulted and could not
     pass the tests.
  2) Building without THREADED_DELTA_SEARCH=1 produced an executable which
     segfaulted and could not pass the tests.

I have no debugger.

Otherwise, I've been using this executable somewhat and have not experienced any
problems. Maybe it will be useful to others.

 Makefile                      |   12 ++++++++++++
 git-compat-util.h             |   12 +++++++++++-
 t/lib-git-svn.sh              |    3 +++
 t/t1002-read-tree-m-u-2way.sh |   10 ++++++----
 t/t9301-fast-export.sh        |    1 -
 t/test-lib.sh                 |    2 +-
 templates/Makefile            |    2 +-
 unpack-trees.c                |    3 ++-
 8 files changed, 36 insertions(+), 9 deletions(-)

-brandon


#!/bin/sh

GIT_SKIP_TESTS='
   t3900.1[0-289] t3900.2[023]
   t3901.*
   t5000.1[0-24-689] t5000.2[01]
   t5100.[56] t5100.1[02]
   t9301.4
'

export GIT_SKIP_TESTS

# NO_C99_FORMAT is required since this c99 compiler does not understand %td,
# and probably not %zu.

exec gmake \
    CC=c99 \
    CFLAGS='-n32 -O2' \
    SHELL_PATH='/bin/ksh' \
    TAR=gtar \
    NO_C99_FORMAT=1 \
    NO_CURL=1 \
    NO_OPENSSL=1 \
    NO_TCLTK=1 \
    NO_PERL_MAKEMAKER=1 \
    THREADED_DELTA_SEARCH=1
