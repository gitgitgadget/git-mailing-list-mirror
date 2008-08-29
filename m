From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/2] *** SUBJECT HERE ***
Date: Fri, 29 Aug 2008 15:42:47 +0200
Message-ID: <1220017369-32637-1-git-send-email-trast@student.ethz.ch>
References: <20080829081654.GA6680@yp-box.dyndns.org>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 15:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ4Gf-0001z5-N5
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 15:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbYH2Nmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 09:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYH2Nmy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 09:42:54 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37232 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbYH2Nmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 09:42:53 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:51 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 15:42:52 +0200
X-Mailer: git-send-email 1.6.0.1.98.g76a24
In-Reply-To: <20080829081654.GA6680@yp-box.dyndns.org>
X-OriginalArrivalTime: 29 Aug 2008 13:42:52.0195 (UTC) FILETIME=[22239730:01C909DD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong wrote.
> > So should we just change all "unknown foo" tests to verify that 'git
> > svn info' errors out too?
>
> Yes, I see no reason to differ from plain svn here.

This starts getting more complicated at every turn.  The included
mini-series (probably textually depends on the other 6 patches though)
"fixes" this.

HOWEVER: Subversion itself broke compatibility here.  In 1.4:

  $ svn info new; echo $?
  new:  (Not a versioned resource)

  0

Note the extra linebreak and successful exit.  Current git-svn
precisely matches this output.  In 1.5, it's different:

  $ svn info new; echo $?
  svn: 'new' is not under version control
  1

While it is of course up to you what you would like to do (and modulo
test_must_fail, 2/2 can still be used to fix the tests if you decide
to reject 1/2), I suggest changing to 1.5 behaviour.  exit(1) is the
sane thing to do in this case, and that is already breaking
bit-for-bit compatibility with SVN 1.4, so we might as well adopt the
new error message.  Of course this prevents us from comparing the
output literally in the tests, so I settled for a slightly weaker
check: failure status and mention of the filename.

Unfortunately this does raise the question whether the URL-encoding
issue treated in the other series is in fact a similar incompatibility
between 1.4 and 1.5, not a (minor but long-standing) bug in git-svn.

- Thomas


 git-svn.perl            |    4 +-
 t/t9119-git-svn-info.sh |   73 ++++++++++++++++-------------------------------
 2 files changed, 27 insertions(+), 50 deletions(-)
