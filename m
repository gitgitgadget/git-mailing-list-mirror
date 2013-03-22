From: y@quest-ce.net
Subject: [PATCH] t7600: merge tag shoud create a merge commit
Date: Fri, 22 Mar 2013 11:57:30 +0100
Message-ID: <12567.1632391915$1363949912@news.gmane.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 11:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIzg6-00043G-2A
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 11:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544Ab3CVK6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 06:58:01 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:44540 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab3CVK6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 06:58:00 -0400
X-Greylist: delayed 2875 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2013 06:57:59 EDT
Received: from test.quest-ce.net (unknown [37.161.251.30])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 58BFE8226B;
	Fri, 22 Mar 2013 11:57:51 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2MAvkf8011965;
	Fri, 22 Mar 2013 11:57:48 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2MAvf0Q011964;
	Fri, 22 Mar 2013 11:57:41 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1363704914.6289.39.camel@test.quest-ce.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218790>

From: Yann Droneaud <ydroneaud@opteya.com>

This test ensures a merge commit is always created
when merging an annotated (signed) tag without --ff-only option.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---

Here's a proposition for a test tath check the creation of a merge commit
when merging a tag.

It's not in final shape: the line 

    EDITOR=false test_must_fail git merge signed

should failed, but doesn't: the commit merge is created with
the default message, just like --no-edit was given.

I'm making a mistake somewhere, since the EDITOR=false trick
works, it's even used in the next test, for --no-edit testing.

Regards.

 t/t7600-merge.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b524bdb..486f1bf 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -697,10 +697,30 @@ test_expect_success 'merge --no-ff --edit' '
 	test_cmp actual expected
 '
 
+test_expect_failure GPG 'merge tag should create a merge commit' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git tag -f -s -m "A newer commit" signed &&
+	git reset --hard c0 &&
+
+	git merge signed &&
+	git rev-parse signed^0 >expect &&
+	git rev-parse HEAD^0 >actual &&
+	! test_cmp actual expect &&
+
+	git reset --hard c0 &&
+	git commit --allow-empty -m "An other newer commit" &&
+	git tag -f -s -m "An other newer commit" signed &&
+	git reset --hard c0 &&
+
+	EDITOR=false test_must_fail git merge signed &&
+	verify_head "$c0"
+'
+
 test_expect_success GPG 'merge --ff-only tag' '
 	git reset --hard c0 &&
 	git commit --allow-empty -m "A newer commit" &&
-	git tag -s -m "A newer commit" signed &&
+	git tag -f -s -m "A newer commit" signed &&
 	git reset --hard c0 &&
 
 	git merge --ff-only signed &&
-- 
1.7.11.7
