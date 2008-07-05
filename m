From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] Fix t7601-merge-pull-config.sh on AIX
Date: Sat,  5 Jul 2008 16:23:58 +0200
Message-ID: <1215267838-19402-1-git-send-email-vmiklos@frugalware.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 16:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF8gu-0007v7-Mj
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 16:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYGEOXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYGEOXr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 10:23:47 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52967 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYGEOXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 10:23:47 -0400
Received: from vmobile.example.net (dsl5401C7D7.pool.t-online.hu [84.1.199.215])
	by yugo.frugalware.org (Postfix) with ESMTP id 4AF871DDC5B;
	Sat,  5 Jul 2008 16:23:44 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1FD9A1A9CEF; Sat,  5 Jul 2008 16:23:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87447>

The test failed on AIX (and likely other OS, such as apparently OSX)
where wc -l outputs whitespace.

Also, avoid unnecessary eval in conflict_count().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Jul 04, 2008 at 06:49:03PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> In any case, this feels like an unnecessary use of eval.  The call
> site
> you have look like this:
>
>       conflict_count resolve_count
>
> but it is more natural if you are programming in shell to call it
> like:
>
>       resolve_count=$(count_conflicts)

Changed.

> If you are going to do numerical comparison in later versions, you can
> just drop the dq around parameters of test:
>
>       test $count_three = $count_two

Changed.

Mike, could you please confirm that this solves your problem as well?

 t/t7601-merge-pull-config.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 32585f8..95b4d71 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -70,10 +70,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
 
 conflict_count()
 {
-	eval $1=`{
+	{
 		git diff-files --name-only
 		git ls-files --unmerged
-	} | wc -l`
+	} | wc -l
 }
 
 # c4 - c5
@@ -115,15 +115,15 @@ test_expect_success 'merge picks up the best result' '
 	git config pull.twohead "recursive resolve" &&
 	git reset --hard c5 &&
 	git merge -s resolve c6
-	conflict_count resolve_count &&
+	resolve_count=$(conflict_count) &&
 	git reset --hard c5 &&
 	git merge -s recursive c6
-	conflict_count recursive_count &&
+	recursive_count=$(conflict_count) &&
 	git reset --hard c5 &&
 	git merge c6
-	conflict_count auto_count &&
-	test "$auto_count" = "$recursive_count" &&
-	test "$auto_count" != "$resolve_count"
+	auto_count=$(conflict_count) &&
+	test $auto_count = $recursive_count &&
+	test $auto_count != $resolve_count
 '
 
 test_done
-- 
1.5.6.1.322.ge904b.dirty
