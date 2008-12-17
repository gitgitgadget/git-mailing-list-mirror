From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange untracked file behaviour
Date: Wed, 17 Dec 2008 06:09:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812170605300.14632@racer>
References: <20081216232452.GV5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 06:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCoh0-0000YR-LF
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 06:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbYLQFKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 00:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYLQFKL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 00:10:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:42057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbYLQFKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 00:10:10 -0500
Received: (qmail invoked by alias); 17 Dec 2008 05:10:08 -0000
Received: from pD9EB298D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.141]
  by mail.gmx.net (mp016) with SMTP; 17 Dec 2008 06:10:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aQ2s/T8Fa90u4IcPUhYPgVU+sWeZUvlpctOoOej
	wLoptjMgbxIb1W
X-X-Sender: gene099@racer
In-Reply-To: <20081216232452.GV5691@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103306>

Hi,

On Wed, 17 Dec 2008, Miklos Vajna wrote:

> Here is a copy of the udev repo I cloned some time ago:
> 
> http://frugalware.org/~vmiklos/files/udev.tar.bz2
> 
> I did not modify it, so I thought a simple 'git pull' can update it.
> 
> $ git pull
> Updating 661a0be..b6626d0
> error: Untracked working tree file 'test/sys/class/misc/rtc/dev' would
> be removed by merge.

I just spent three hours narrowing it down to this test case (but now I 
have to catch 3 hours of sleep):

-- snipsnap --
[PATCH] Miklos' testcase

Even if we would not handle symlink/directory conflicts gracefully (which 
we do, though), those conflicts should not affect unchanged files at all, 
especially not claiming that they are untracked.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1008-read-tree-sd.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 t/t1008-read-tree-sd.sh

diff --git a/t/t1008-read-tree-sd.sh b/t/t1008-read-tree-sd.sh
new file mode 100644
index 0000000..4d74430
--- /dev/null
+++ b/t/t1008-read-tree-sd.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Johannes E. Schindelin
+#
+
+test_description='symlink/directory conflict'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir -p alpha/beta/gamma &&
+	ln -s delta alpha/beta/gamma/epsilon &&
+	mkdir -p alpha/beta/theta &&
+	ln -s zeta alpha/beta/theta/eta &&
+	mkdir -p iota/kappa/lambda/ &&
+	: > iota/kappa/lambda/mu &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+
+	git rm -r alpha/beta/gamma &&
+	ln -s nu alpha/beta/gamma &&
+	git rm -r alpha/beta/theta &&
+	ln -s xi alpha/beta/theta &&
+	git add . &&
+	test_tick &&
+	git commit -m 2nd
+
+'
+
+test_expect_failure 'read-tree -u -m handles symlinks gracefully' '
+
+	git checkout -b side HEAD^ &&
+	git read-tree -u -m master
+
+'
+
+test_done
-- 
1.6.0.4.1189.g8876f
