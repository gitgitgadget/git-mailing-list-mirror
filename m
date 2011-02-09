From: Thomas Rast <trast@student.ethz.ch>
Subject: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 9 Feb 2011 15:38:46 +0100
Message-ID: <201102091538.46594.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 09 15:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnBC2-0007Dz-Nq
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 15:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab1BIOit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 09:38:49 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:2800 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174Ab1BIOis (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 09:38:48 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 15:38:46 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 15:38:46 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166423>

Hi *,

I have been running a nightly next&pu smoke tester each on RHEL5 and
OS X.  For quite some time (at least a month), t7006 gets stuck
randomly (i.e., not every night).  [This has been a bit of a problem
because it keeps a lot of processes stuck on the machine and eats into
my ulimit, but that's the case with any stuck process; I'll have to
think about a good solution to that.]

The relevant part of 'ps xwww' is

  65211   ??  SN     0:00.03 /bin/sh t7006-pager.sh
  65798   ??  SN     0:00.04 /usr/bin/perl /Users/trast/git-smoke/t/test-terminal.perl git --no-pager log
  65846   ??  ZN     0:00.00 (git)
  65847   ??  ZN     0:00.00 (perl5.10.0)

Everything runs from a cronjob, so it does not have a terminal.  If I
SIGTERM the first perl process, the script continues and I eventually
get the normal results (upload to smoke.nix.git.is and emailed
report).

The Cc list is a bit of a random guess based on who worked on this;
from the 'git --no-pager log' you can see that the test got stuck in
the 'no pager with --no-pager' test, but that was introduced 10 months
ago.  It may very well have been broken all the time, or also for
other commands.

So if you have any idea what the problem could be or what I should be
looking for, help would be much appreciated...


Some files that may be relevant:

Crontab entry:
0 5 * * * cd ~ && . .bashrc && ./do-the-smoke.sh

---- 8< ---- ~/do-the-smoke.sh ---- 8< ----
#!/bin/bash

cd ~/git-smoke
git fetch -q

doit () {
    branch="$1"
    git checkout origin/"$branch" || exit 1

    make -j12 || exit 1
    cd t
    make clean
    TEST_JOBS=6 nice make smoke
    TEST_JOBS=6 nice make smoke_report SMOKE_COMMENT="Darwin 10.5 $branch" SMOKE_TAGS="$branch, Darwin 10.5, NO_SVN_TESTS, NO_EXPAT"
}

( doit next )
( doit pu )
---- >8 ---- >8 ----

---- 8< ---- ~/git-smoke/config.mak ---- 8< ----
CFLAGS = -Wall -O3 -g
THREADED_DELTA_SEARCH = 1
NO_SVN_TESTS = 1
ASCIIDOC8 = 1
ASCIIDOC_NO_ROFF = 1
GNU_ROFF = 1
BLK_SHA1 = 1
prefix = /home/thomas/.local
NO_EXPAT = 1
NO_GETTEXT = 1
SMOKE_USERNAME = trast
SMOKE_PASSWORD = I'm not telling you :-)
SMOKE_COMMENT = RHEL5.5
---- >8 ---- >8 ----

(I just noticed that the above 'prefix' makes no sense because $HOME
is /Users/trast, but I'm not installing it anyway...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
