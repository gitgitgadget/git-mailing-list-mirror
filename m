From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 14 Apr 2007 13:10:03 -0700
Message-ID: <20070414201003.GA28389@muzzle>
References: <m2647zh2zc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 22:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcoZx-00029b-6H
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 22:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXDNUKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbXDNUKG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 16:10:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53318 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXDNUKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 16:10:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E04227DC09A;
	Sat, 14 Apr 2007 13:10:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2647zh2zc.fsf@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44469>

Seth Falcon <sethfalcon@gmail.com> wrote:
> A few weeks ago I reported a symlink related error with git-svn and
> I've now had a chance to track down a few more details.  The trigger
> seems to be if a file is removed from svn and then later added as a
> symlink.  The error I get is:
> 
>   error: git-checkout-index: unable to create symlink foo.txt (Invalid argument)
> 
> This is from the call to symlink(new, path) in entry.c and it seems
> that new is ''.

I can't reproduce it on Linux with ext3.  I translated your recipe into
a test script in the patch below.  Anybody familiar with OSX and/or HFS
know if there's a workaround or fix for this?

From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 14 Apr 2007 13:03:24 -0700
Subject: [PATCH] git-svn: add test to handle conversion from file to symlink

This does not trigger any failures on my Linux machine with ext3,
but it may fail on OSX and/or HFS.

This test is based on a bug report by Seth Falcon:
  http://permalink.gmane.org/gmane.comp.version-control.git/44445

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9112-git-svn-file-to-symlink.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t9112-git-svn-file-to-symlink.sh

diff --git a/t/t9112-git-svn-file-to-symlink.sh b/t/t9112-git-svn-file-to-symlink.sh
new file mode 100755
index 0000000..f94310f
--- /dev/null
+++ b/t/t9112-git-svn-file-to-symlink.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# Copyright (c) 2007 Eric Wong
+test_description='git-svn file to symlink'
+. ./lib-git-svn.sh
+
+test_expect_success 'create file in svn repository' "
+	svn co '$svnrepo' svn &&
+	cd svn &&
+		echo 123 > foo.txt &&
+		svn add foo.txt &&
+		svn commit -m 'add a file'
+		cd ..
+	"
+
+test_expect_success 'clone with git-svn' "pwd && git svn clone '$svnrepo' git"
+
+test_expect_success 'remove and add file as symlink in svn' "
+	cd svn &&
+		echo 123 > bar.txt &&
+		svn add bar.txt &&
+		svn commit -m 'add bar' &&
+		svn rm foo.txt &&
+		svn commit -m 'remove foo' &&
+		ln -s bar.txt foo.txt &&
+		svn add foo.txt &&
+		svn ci -m 'add foo as symlink'
+		cd ..
+	"
+
+test_expect_success 'rebase in git-svn' "
+	cd git &&
+		git svn rebase
+		cd ..
+	"
+
+test_done
-- 
Eric Wong
