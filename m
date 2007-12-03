From: Jeff King <peff@peff.net>
Subject: Re: make test failure with latest master
Date: Sun, 2 Dec 2007 20:59:54 -0500
Message-ID: <20071203015954.GB8322@coredump.intra.peff.net>
References: <4752A53E.4030000@gmail.com> <20071202163426.GA29781@coredump.intra.peff.net> <47533D75.1090002@gmail.com> <Pine.LNX.4.64.0712022340250.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:00:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz0bc-0004Al-K8
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbXLCB76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 20:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXLCB76
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 20:59:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbXLCB75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 20:59:57 -0500
Received: (qmail 25242 invoked by uid 111); 3 Dec 2007 01:59:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 20:59:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 20:59:54 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712022340250.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66842>

On Sun, Dec 02, 2007 at 11:41:10PM +0000, Johannes Schindelin wrote:

> > Attached is the output of
> > 
> > 	./t9600-cvsimport.sh --verbose >/tmp/9600_out.txt 2>&1
> > 
> 
> Unfortunately you attached the interesting part, so I cannot quote it 
> here.  Seems that your cvsps does not understand the "-A" option.  So it 
> looks like it is too old.

Yes, the changelog indicates that -A was added in 2.1, and he is running
2.0rc1.

We can do something like this, though it feels a bit hack-ish and will
need updated for new cvsps versions (a less lazy or more clever shell
coder than me could do a nice >= version comparator).

-- >8 --
t9600: require cvsps 2.1 to perform tests

git-cvsimport won't run at all with less than cvsps 2.1, because it
lacks the -A flag. But there's no point in preventing people who have an
old cvsps from running the full testsuite.

Signed-off-by: Jeff King <peff@peff.net>
---

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 08f0f2a..c646111 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,13 +3,29 @@
 test_description='git-cvsimport basic tests'
 . ./test-lib.sh
 
-if ! ( type cvs && type cvsps ) >/dev/null 2>&1
+if ! type cvs >/dev/null 2>&1
 then
-	test_expect_success 'skipping cvsimport tests, cvs/cvsps not found' ''
+	test_expect_success 'skipping cvsimport tests, cvs not found' ''
 	test_done
 	exit
 fi
 
+cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
+case "$cvsps_version" in
+2.1)
+	;;
+'')
+	test_expect_success 'skipping cvsimport tests, cvsps not found' ''
+	test_done
+	exit
+	;;
+*)
+	test_expect_success 'skipping cvsimport tests, cvsps too old' ''
+	test_done
+	exit
+	;;
+esac
+
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
 # for clean cvsps cache
