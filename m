From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Mon, 10 Aug 2009 01:32:34 -0700
Message-ID: <20090810083234.GA8698@dcvr.yhbt.net>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com> <1249350039-7338-2-git-send-email-adambrewster@gmail.com> <20090806212841.GA13437@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 10:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQJA-0008IF-PJ
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZHJIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZHJIcf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:32:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36199 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbZHJIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:32:35 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 869351F585;
	Mon, 10 Aug 2009 08:32:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090806212841.GA13437@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125406>

Eric Wong <normalperson@yhbt.net> wrote:
> Adam Brewster <adambrewster@gmail.com> wrote:
> > It was probably intended for the test to fail unless all of the
> > commands succeed.
> 
> I think you've uncovered some major breakage in this test that never got
> noticed until now.  I'll try to take a harder look tonight or this
> weekend.
> 
> Fortunately, this functionality is rarely needed these days :)
> Thanks for the heads up!

Actually, the test should look like this, I'll push it out
along with the other one in a few.

>From 4ebe6e92c3b62d5192b6cc8158fde701bf2c0dcb Mon Sep 17 00:00:00 2001
From: Adam Brewster <adambrewster@gmail.com>
Date: Mon, 3 Aug 2009 21:40:37 -0400
Subject: [PATCH] svn: Add && to t9107-git-svn-migrate.sh

It was probably intended for the test to fail unless all of the
commands succeed.

[ew: fixed tests to actually work]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9107-git-svn-migrate.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 3a9e077..c0098d9 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -56,7 +56,15 @@ test_expect_success 'initialize a multi-repository repo' '
 	git config --add svn-remote.svn.fetch "branches/b:refs/remotes/b" &&
 	for i in tags/0.1 tags/0.2 tags/0.3; do
 		git config --add svn-remote.svn.fetch \
-		                 $i:refs/remotes/$i || exit 1; done
+		                 $i:refs/remotes/$i || exit 1; done &&
+	git config --get-all svn-remote.svn.fetch > fetch.out &&
+	grep "^trunk:refs/remotes/trunk$" fetch.out &&
+	grep "^branches/a:refs/remotes/a$" fetch.out &&
+	grep "^branches/b:refs/remotes/b$" fetch.out &&
+	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
+	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
+	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
+	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
 
 # refs should all be different, but the trees should all be the same:
@@ -86,14 +94,14 @@ test_expect_success 'migrate --minimize on old inited layout' '
 		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
 	done &&
 	git svn migrate --minimize &&
-	test -z "`git config -l |grep -v "^svn-remote\.git-svn\."`" &&
+	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
 	git config --get-all svn-remote.svn.fetch > fetch.out &&
 	grep "^trunk:refs/remotes/trunk$" fetch.out &&
 	grep "^branches/a:refs/remotes/a$" fetch.out &&
 	grep "^branches/b:refs/remotes/b$" fetch.out &&
 	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
 	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
-	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out
+	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
 	grep "^:refs/${remotes_git_svn}" fetch.out
 	'
 
-- 
Eric Wong
