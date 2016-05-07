From: John Keeping <john@keeping.me.uk>
Subject: Force-with-lease and new branches
Date: Sat, 7 May 2016 19:09:14 +0100
Message-ID: <20160507180914.GR14612@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 20:13:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az6fR-00063v-I9
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 20:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbcEGSJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 14:09:26 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:51912 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbcEGSJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2016 14:09:25 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id C905B2306B;
	Sat,  7 May 2016 19:09:23 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id BD8B733D4;
	Sat,  7 May 2016 19:09:23 +0100 (BST)
X-Quarantine-ID: <GmZL5TYGMKgG>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: 0.551
X-Spam-Level: 
X-Spam-Status: No, score=0.551 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, KAM_INFOUSMEBIZ=0.75,
	URIBL_BLOCKED=0.001] autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GmZL5TYGMKgG; Sat,  7 May 2016 19:09:16 +0100 (BST)
Received: from serenity.lan (unknown [10.2.0.10])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 7A61F3484;
	Sat,  7 May 2016 19:09:15 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293904>

I've noticed a slightly annoying behaviour of git-push's
--force-with-lease option around branch creation.

I'd like to be able to do:

	git push --force-with-lease origin refs/heads/jk/*

to push out a load of topic branches safely in case I've switched client
machines and forgotten to pull, but for newly-created branches this
fails with "stale-info", which seems to be intentional via the
expect_old_no_trackback field in struct ref.

However, if I use the explicit --force-with-lease syntax with the null
hash then the push does succeed.  I've added a couple of tests to t5533
which demonstrate this in a patch below - the first one fails but the
second passes.

It looks like this has been the case since the first version of what
would become --force-with-lease [1] and I can't find any discussion
around this particular behaviour in the three versions of that patch set
I found on Gmane [2], [3], [4].

So my questions are: what will break if we decide to treat "no remote
tracking branch" as "new branch" and is that a reasonable thing to do?


[1] http://article.gmane.org/gmane.comp.version-control.git/229992
[2] http://article.gmane.org/gmane.comp.version-control.git/229430
[3] http://article.gmane.org/gmane.comp.version-control.git/230142
[4] http://article.gmane.org/gmane.comp.version-control.git/231021


-- >8 --
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index c732012..ad9e06f 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -191,4 +191,28 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'new branch covered by force-with-lease' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git branch branch master &&
+		git push --force-with-lease=branch origin branch
+	) &&
+	git ls-remote dst refs/heads/branch >expect &&
+	git ls-remote src refs/heads/branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new branch with explicit force-with-lease' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git branch branch master &&
+		git push --force-with-lease=branch:0000000000000000000000000000000000000000 origin branch
+	) &&
+	git ls-remote dst refs/heads/branch >expect &&
+	git ls-remote src refs/heads/branch >actual &&
+	test_cmp expect actual
+'
+
 test_done
