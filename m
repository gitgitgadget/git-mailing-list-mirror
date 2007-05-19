From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: avoid crashing svnserve when creating new directories
Date: Sat, 19 May 2007 03:58:00 -0700
Message-ID: <20070519105800.GA22230@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr> <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com> <vpqtzuf46k9.fsf@bauges.imag.fr> <20070519061422.GA17528@muzzle> <20070519095837.GA387@muzzle> <vpqtzu9m7za.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat May 19 12:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpMdd-0005eo-Oe
	for gcvg-git@gmane.org; Sat, 19 May 2007 12:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbXESK6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXESK6E
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 06:58:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59187 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391AbXESK6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 06:58:02 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 64F317DC0A4;
	Sat, 19 May 2007 03:58:00 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 19 May 2007 03:58:00 -0700
Content-Disposition: inline
In-Reply-To: <vpqtzu9m7za.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47737>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >  	foreach (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$bat) {
> > +		next if $_ eq '';
> >  		$self->close_directory($bat->{$_}, $p);
> >  	}
> > +	$self->close_directory($bat->{''}, $p);
> 
> Works for me. Thanks a lot!
> 
> BTW, I didn't have time to write my script as a real testcase for
> git-svn, but it should probably be added to the testsuite.

I have a modified version of the test I posted earlier based on your
test.  However, I'm not comfortable binding to any port (even without
ssh) on a users machine or potentially leaving a daemon running if the
test is interrupted.

>From bfbd67e31e952489098c2a10df259fbf1e7863fb Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 13 May 2007 17:38:21 -0700
Subject: [PATCH] git-svn: test for creating new directories over svn://

As reported by Matthieu Moy, this is causing svnserve to
terminate connections (because it segfaults) segfault.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9112-git-svn-dcommit-new-file.sh |   37 +++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100755 t/t9112-git-svn-dcommit-new-file.sh

diff --git a/t/t9112-git-svn-dcommit-new-file.sh b/t/t9112-git-svn-dcommit-new-file.sh
new file mode 100755
index 0000000..b186fce
--- /dev/null
+++ b/t/t9112-git-svn-dcommit-new-file.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+test_description='git-svn dcommit new files over svn:// test'
+
+. ./lib-git-svn.sh
+
+# standard svnserve runs on 3690, so lets not conflict with that
+SVNSERVE_PORT=${SVNSERVE_PORT-'3691'}
+
+start_svnserve () {
+	svnserve --listen-port $SVNSERVE_PORT \
+	         --root $rawsvnrepo \
+	         --listen-once \
+	         --listen-host 127.0.0.1 &
+}
+
+test_expect_success 'start tracking an empty repo' "
+	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
+	echo anon-access = write >> $rawsvnrepo/conf/svnserve.conf &&
+	start_svnserve &&
+	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
+	git svn fetch
+	"
+
+test_expect_success 'create files in new directory with dcommit' "
+	mkdir git-new-dir &&
+	echo hello > git-new-dir/world &&
+	git update-index --add git-new-dir/world &&
+	git commit -m hello &&
+	start_svnserve &&
+	git svn dcommit
+	"
+
+test_done
-- 
Eric Wong
