From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] fix parallel make problem
Date: Thu, 30 Aug 2007 10:27:48 +0300
Message-ID: <20070830072748.GF16312@mellanox.co.il>
References: <20070830063810.GD16312@mellanox.co.il> <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 09:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQeRc-000660-8W
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 09:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbXH3H15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 03:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbXH3H15
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 03:27:57 -0400
Received: from p02c11o141.mxlogic.net ([208.65.144.74]:34780 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbXH3H14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 03:27:56 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-5.1.0-1)
	with ESMTP id b7176d64.2600733616.166961.00-001.p02c11o141.mxlogic.net (envelope-from <mst@dev.mellanox.co.il>);
	Thu, 30 Aug 2007 01:27:55 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Aug 2007 10:30:40 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 30 Aug 2007 10:27:03 +0300
Content-Disposition: inline
In-Reply-To: <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Aug 2007 07:30:40.0627 (UTC) FILETIME=[AAB5FC30:01C7EAD7]
X-Spam: [F=0.0372558498; S=0.037(2007082901); SS=0.500]
X-MAIL-FROM: <mst@dev.mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57009>

There seems to be a bug in parallel build with GNU Make 3.81beta4
which ships with Ubuntu Dapper:
$touch revision.c
$make -j 4
fails with
	LINK test-chmtime
	gcc: test-chmtime.o: No such file or directory
	make: *** [test-chmtime] Error 1

Even though test-chmtime depends on test-chmtime.o
Work around this by building test-* executables directly
from the appropriate .c file.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---
> Quoting Junio C Hamano <gitster@pobox.com>:
> Subject: Re: parallel make problem with git
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >     LINK test-chmtime
> > gcc: test-chmtime.o: No such file or directory
> > make: *** [test-chmtime] Error 1
> > make: *** Waiting for unfinished jobs....
> >
> > Any ideas?
> 
> Some missing dependencies, apparently.

Looks more like bug in make, to me: test-chmtime.o should have been
built by implicit rule, but isn't.

> make --version
GNU Make 3.81beta4

The following patch helps by building the test directly from .c file:

diff --git a/Makefile b/Makefile
index 4eb4637..d6b38b5 100644
--- a/Makefile
+++ b/Makefile
@@ -969,8 +969,8 @@ test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
 
-test-%$X: test-%.o $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+test-%$X: test-%.c $(GITLIBS) GIT-CFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.c,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh

-- 
MST
