From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] Trivial path optimization test
Date: Tue, 18 Jul 2006 00:34:32 +0200
Message-ID: <20060717223432.GA25522@steel.home>
References: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jul 18 00:35:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2bg8-0004Sq-KH
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 00:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGQWep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 18:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGQWep
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 18:34:45 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:29125 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751097AbWGQWeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jul 2006 18:34:44 -0400
Received: from fwd27.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1G2bff-0008Pj-06; Tue, 18 Jul 2006 00:34:35 +0200
Received: from tigra.home (X7Awq6ZYgeqAEJ5pq0E8xouECAioNbXBMiehDhcDMQMmvn5b0AfUcm@[84.160.93.96]) by fwd27.sul.t-online.de
	with esmtp id 1G2bfd-0KDMv20; Tue, 18 Jul 2006 00:34:33 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A5CF1277AF;
	Tue, 18 Jul 2006 00:34:32 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G2bfc-0006eJ-NH; Tue, 18 Jul 2006 00:34:32 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: X7Awq6ZYgeqAEJ5pq0E8xouECAioNbXBMiehDhcDMQMmvn5b0AfUcm
X-TOI-MSGID: 785809d4-e739-4265-862d-ea6d488c5f56
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23986>

Linus Torvalds, Fri, Jul 14, 2006 17:39:24 +0200:
> > > Btw, I'm actually surprised that my path simplification didn't filter out
> > > the "." and make it mean exactly the same as not giving a path at all. I
> > > thought I had done that earlier, but if you say "-- ." matters, then it
> > > obviously does..
> >
> > In this specific case where I have a whole bunch of commits which don't
> > actually change anything, it definitely does make a difference...
> 
> Yes, I'm looking at "get_pathspec()", and noting that it really isn't able
> to optimize away the ".".
> 
> It does turn it into an empty string (which is correct - git internally
> does _not_ ever understand the notion of "." as the current working
> directory), but it doesn't ever do the optimization of noticing that a
> pathspec that consists solely of an empty string is "equivalent" to an
> empty pathspec.
> 
> Which is exactly what you _want_ in this case, of course, but maybe we
> should add a test-case for that, so that we never do that trivial
> optimization by mistake.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

...
> Anybody want to write that as a test, verify it, and send Junio a patch?
>
>                Linus

So here it is.

 t/t6004-rev-list-path-optim.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
new file mode 100755
index 0000000..5182dbb
--- /dev/null
+++ b/t/t6004-rev-list-path-optim.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='git-rev-list trivial path optimization test'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+echo Hello > a &&
+git add a &&
+git commit -m "Initial commit" a
+'
+
+test_expect_success path-optimization '
+    commit=$(echo "Unchanged tree" | git-commit-tree "HEAD^{tree}" -p HEAD) &&
+    test $(git-rev-list $commit | wc -l) = 2 &&
+    test $(git-rev-list $commit -- . | wc -l) = 1
+'
+
+test_done
-- 
1.4.1.gb944
