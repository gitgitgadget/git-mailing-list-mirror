From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: read global+system config for clone+init
Date: Sat, 14 Nov 2009 14:50:40 -0800
Message-ID: <20091114225040.GA5165@dcvr.yhbt.net>
References: <20091110130913.GR19475@poetic.cynic.net> <20091114223930.GA10176@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Curt Sampson <cjs@cynic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 23:50:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9RSD-0002sh-Hc
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 23:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZKNWuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 17:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbZKNWuf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 17:50:35 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47119 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbZKNWuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 17:50:35 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1796E1F5FC;
	Sat, 14 Nov 2009 22:50:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091114223930.GA10176@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132893>

Eric Wong <normalperson@yhbt.net> wrote:
> Hi Curt,
> 
> Thanks for the bug report, the following patch should fix
> the bug.  Also pullable from git://git.bogomips.org/git-svn

It took me a while (possibly due to low caffeine levels) to make a
failing (automated) test case, but I've also pushed this out as
well.

>From e2f8617b266e320fd58ab584cae2ebe9906daaac Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 14 Nov 2009 14:43:20 -0800
Subject: [PATCH] git svn: add authorsfile test case for ~/.gitconfig

The commit for:
    git svn: read global+system config for clone+init

Initially lacked a test case because the author was unable to
reproduce it under his test environment, this adds it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9130-git-svn-authors-file.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index f5abdb3..134411e 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -91,4 +91,27 @@ test_expect_success 'fetch continues after authors-file is fixed' '
 	)
 	'
 
+test_expect_success 'fresh clone with svn.authors-file in config' '
+	(
+		rm -r "$GIT_DIR" &&
+		test x = x"$(git config svn.authorsfile)" &&
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="$HOME"/.gitconfig &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		unset GIT_DIR &&
+		unset GIT_CONFIG &&
+		git config --global \
+		  svn.authorsfile "$HOME"/svn-authors &&
+		test x"$HOME"/svn-authors = x"$(git config svn.authorsfile)" &&
+		git svn clone "$svnrepo" gitconfig.clone &&
+		cd gitconfig.clone &&
+		nr_ex=$(git log | grep "^Author:.*example.com" | wc -l) &&
+		nr_rev=$(git rev-list HEAD | wc -l) &&
+		test $nr_rev -eq $nr_ex
+	)
+'
+
+test_debug 'GIT_DIR=gitconfig.clone/.git git log'
+
 test_done
-- 
Eric Wong
