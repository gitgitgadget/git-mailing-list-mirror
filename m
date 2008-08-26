From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/6] 'git svn info' fixes
Date: Tue, 26 Aug 2008 21:32:31 +0200
Message-ID: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4IS-0004X8-Nj
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759576AbYHZTcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759559AbYHZTci
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:38 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbYHZTch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:37 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:36 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:36 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
X-OriginalArrivalTime: 26 Aug 2008 19:32:36.0223 (UTC) FILETIME=[7E5AE8F0:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93805>

Actually, I only wanted to do 5/6 (git svn info: make info relative to
the current directory).  This seemed like a fairly simple change, see
the corresponding mail.

However, I also wanted to provide tests, and that's where the fun
started.  Turns out t9119-git-svn-info.sh is currently quite broken.
1-4 just fix the tests; a brief summary:

[1/6] git svn info: tests: let 'init' test run with SVN 1.5

  The tests do not report any problems with 1.5.

[2/6] git svn info: tests: do not use set -e

  No idea how 'set -e' ever got in there; it completely breaks the
  test script in case of an error.

[3/6] git svn info: tests: use test_cmp instead of git-diff

  git-diff does not correctly report the exit status (IIRC that is
  caused by the pager setup code?), which used to hide a lot of
  errors.

[4/6] git svn info: tests: fix ptouch argument order in setup

  Swapped arguments caused ptouch to fail and tests to break.

Yes, I'm just whoring commit karma here, so feel free to squash these
four into one if you like it better that way.

After these, 22 of 37 tests (all except --url, plus all unknown files)
fail. Most of them are caused by 'git svn info' not URL-encoding the
URL and Repository fields in the output, as SVN does.  6/6 fixes
this.

However, the unknown files tests still fail, simply because 'svn info'
itself fails on untracked files.  It would be great if someone who is
still running SVN 1.4 could check whether that has been a bug in
git-svn all along, or is actually a behaviour change on the part of
SVN.

Oh, and let's hope I did the splitting right this time :-)


 git-svn.perl            |   30 +++++++++++--
 t/t9119-git-svn-info.sh |  102 ++++++++++++++++++++++++++---------------------
 2 files changed, 82 insertions(+), 50 deletions(-)
