From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 3/4] fetch --use-mirror: don't fetch with 'autotags' for actual fetch
Date: Wed, 25 Nov 2009 23:06:56 +1300
Message-ID: <1259143617-26580-4-git-send-email-sam@vilain.net>
References: <1259143617-26580-1-git-send-email-sam@vilain.net>
 <1259143617-26580-2-git-send-email-sam@vilain.net>
 <1259143617-26580-3-git-send-email-sam@vilain.net>
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDF3M-0006bC-0X
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556AbZKYKYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbZKYKYj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:24:39 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51587 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669AbZKYKYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:24:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 2AE6E21C46F; Wed, 25 Nov 2009 23:07:28 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 8777B21C39E;
	Wed, 25 Nov 2009 23:07:01 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NDEmH-0006vO-KZ; Wed, 25 Nov 2009 23:07:13 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1259143617-26580-3-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133627>

Unsetting 'autotags' at a late stage during the fetch process has the
useful behaviour of figuring out which refs to fetch where according to the
regular autotags rules, building a refspec (struct ref* linked list), and
then we turn them off for mirror fetch and no real tags are actually
changed, just the re-written ones under refs/mirrors/.  The final fetch
will re-set autotags again, and uncannily the exact behaviour we are after
springs up: we get all the tags for the refs that are now changing, even
though we got the data from a mirror.  All from one line of code.  Win!

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 builtin-fetch.c         |    1 +
 t/t5560-mirror-fetch.sh |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b3b8766..daa287a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -269,6 +269,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		find_non_local_tags(transport, &ref_map, &tail);
 	ref_remove_duplicates(ref_map);
 	if (strcmp(transport->url, transport->remote->url[0]) != 0) {
+		*autotags = 0;
 		return mirror_refmap(transport, ref_map);
 	}
 
diff --git a/t/t5560-mirror-fetch.sh b/t/t5560-mirror-fetch.sh
index 940dc0e..58d5f3c 100644
--- a/t/t5560-mirror-fetch.sh
+++ b/t/t5560-mirror-fetch.sh
@@ -11,11 +11,13 @@ test_expect_success setup '
 	echo >file master initial &&
 	git add file &&
 	git commit -a -m "Master initial" &&
+	git tag -m "SEEN" initial &&
 	git clone . master &&
 	git clone master mirror &&
 	cd master &&
 	echo >file master update &&
 	git commit -a -m "Master update" &&
+	git tag -m "SEEN" update &&
 	cd .. &&
 	mkdir clone &&
 	cd clone &&
@@ -35,12 +37,20 @@ test_expect_success 'fetch using mirror - explicit' '
 
 test_expect_success 'fetch using mirror - default' '
 	cd .. &&
+	cd mirror &&
+	git tag -m "badtag" badtag &&
+	cd .. &&
 	mkdir clone2 &&
 	cd clone2 &&
 	git init &&
 	git remote add origin ../master &&
 	git config remote.origin.mirror-url ../mirror
 	git fetch --use-mirror &&
-	git rev-parse refs/mirrors/origin/localhost/heads/master
+	git rev-parse refs/mirrors/origin/localhost/heads/master &&
+	git rev-parse refs/mirrors/origin/localhost/tags/initial &&
+	! git rev-parse refs/tags/badtag &&
+	git rev-parse refs/tags/initial &&
+	git rev-parse refs/tags/update
 '
+
 test_done
-- 
1.6.3.3
