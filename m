From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Remove unnecessary ouput from t3600-rm.
Date: Mon, 29 May 2006 04:06:48 -0400
Message-ID: <20060529080648.GA6420@spearce.org>
References: <20060529071646.GC6061@spearce.org> <7v1wud9tq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 10:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkcmG-0002md-7H
	for gcvg-git@gmane.org; Mon, 29 May 2006 10:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWE2IGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 04:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWE2IGx
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 04:06:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:6039 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750761AbWE2IGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 04:06:52 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fkcm1-00072n-Ai; Mon, 29 May 2006 04:06:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F2A8420E445; Mon, 29 May 2006 04:06:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wud9tq0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20934>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Moved the output of the setup commits and the test-file rm check to
> > file descriptors 3 and 4 hiding their messages unless -v is given.
> > This makes the test suite look a little cleaner when the rm test-file
> > setup step fails (and was probably expected to fail).
> 
> I suspect those bare commands _should_ succeed so make them a
> separate test step and verify their success return while you are
> at it, and their output would not be shown normally, without
> your futzing with file descriptors.  Wouldn't that be a lot
> cleaner approach?

Yes.  :-)

--> -
Remove unnecessary output from t3600-rm.

Moved the setup commands into test_expect_success blocks so their
output is hidden unless -v is used.  This makes the test suite look
a little cleaner when the rm test-file setup step fails (and was
expected to fail for most cases).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t3600-rm.sh |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index acaa4d6..201d164 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,30 +8,34 @@ test_description='Test of the various op
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
-touch -- foo bar baz 'space embedded' -q
-git-add -- foo bar baz 'space embedded' -q
-git-commit -m "add normal files"
-test_tabs=y
-if touch -- 'tab	embedded' 'newline
-embedded'
-then
-git-add -- 'tab	embedded' 'newline
+test_expect_success \
+    'Initialize test directory' \
+    "touch -- foo bar baz 'space embedded' -q &&
+     git-add -- foo bar baz 'space embedded' -q &&
+     git-commit -m 'add normal files' &&
+     test_tabs=y &&
+     if touch -- 'tab	embedded' 'newline
 embedded'
-git-commit -m "add files with tabs and newlines"
-else
-    say 'Your filesystem does not allow tabs in filenames.'
-    test_tabs=n
-fi
+     then
+     git-add -- 'tab	embedded' 'newline
+embedded' &&
+     git-commit -m 'add files with tabs and newlines'
+     else
+         say 'Your filesystem does not allow tabs in filenames.'
+         test_tabs=n
+     fi"
 
 # Later we will try removing an unremovable path to make sure
 # git-rm barfs, but if the test is run as root that cannot be
 # arranged.
-: >test-file
-chmod a-w .
-rm -f test-file
-test -f test-file && test_failed_remove=y
-chmod 775 .
-rm -f test-file
+test_expect_success \
+    'Determine rm behavior' \
+    ': >test-file
+     chmod a-w .
+     rm -f test-file
+     test -f test-file && test_failed_remove=y
+     chmod 775 .
+     rm -f test-file'
 
 test_expect_success \
     'Pre-check that foo exists and is in index before git-rm foo' \
-- 
1.3.3.g45d8
