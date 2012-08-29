From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 3/3] cherry-pick/revert: respect order of revisions to pick
Date: Tue, 28 Aug 2012 23:15:56 -0700
Message-ID: <1346220956-25034-4-git-send-email-martinvonz@gmail.com>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 08:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bap-0006rt-S9
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab2H2GR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:17:26 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:64644 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab2H2GQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:16:57 -0400
Received: by mail-wi0-f202.google.com with SMTP id hr14so12027wib.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 23:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=M16LyTLBuASxm2QNg2qQqTmYDg9JvmquCu2xIHA2c2g=;
        b=U4zId/JwsnBXCyYHiEKYtmh3bkxooDK76+iu3zZfj8XE28Hoz22KQovA8l8YxogkRt
         OC/ZHrdhZjquCR/L81wT0zLffqHuZnLLvzgDE4X0qknlwxaYD5LpfEQbLeD75Zpb47sP
         UbcBkUbu3Sb/ttvAyrNq4Njhs/yVwuPGVkXPG/iaPIp59i0DD4iglDMGkYEF5ZVfzQDN
         VItHDavzC6YtLO8oGM0b9dzZOYk51xoOVm4W3HlvgCVhhwV9ztbeRHhja3MogmcITLJs
         VAIY6+ULqr6J7wb4yZNDxWmIOHm3eWkT7hLLv36De/+9Ip/X66MOX708crjRD422uvzj
         StIw==
Received: by 10.180.103.197 with SMTP id fy5mr112657wib.1.1346221017290;
        Tue, 28 Aug 2012 23:16:57 -0700 (PDT)
Received: by 10.180.103.197 with SMTP id fy5mr112646wib.1.1346221017238;
        Tue, 28 Aug 2012 23:16:57 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id hm1si1105051wib.3.2012.08.28.23.16.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 28 Aug 2012 23:16:57 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 999F920004E;
	Tue, 28 Aug 2012 23:16:56 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 08C89C2AB1; Tue, 28 Aug 2012 23:16:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmqCTyvMFjEQd6Xks2wbczf6QTYCVTLAdO71H/WlyfXx3vUqbFKJCwj8vquQdO7Q+TQsvdHJnchEcSrh3kCmoRT8uiri8d3+rZiWXHNEjKWSGGAiNtX+yZdcNeZiFLS8sstjdSy308mHzf4zfjTiuqqsQS7M+Yz0bIBBDy4Ozs3DwwXxsfwtrlyjzTeAV+k7F3hEu6u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204466>

When giving multiple individual revisions to cherry-pick or revert, as
in 'git cherry-pick A B' or 'git revert B A', one would expect them to
be picked/reverted in the order given on the command line. They are
instead ordered by their commit timestamp -- in chronological order
for "cherry-pick" and in reverse chronological order for
"revert". This matches the order in which one would usually give them
on the command line, making this bug somewhat hard to notice. Still,
it has been reported at least once before [1].

It seems like the chronological sorting happened by accident because
the revision walker has traditionally always sorted commits in reverse
chronological order when rev_info.no_walk was enabled. In the case of
'git revert B A' where B is newer than A, this sorting is a no-op. For
'git cherry-pick A B', the sorting would reverse the arguments, but
because the sequencer also flips the rev_info.reverse flag when
picking (as opposed to reverting), the end result is a chronological
order. The rev_info.reverse flag was probably flipped so that the
revision walker emits B before C in 'git cherry-pick A..C'; that it
happened to effectively undo the unexpected sorting done when not
walking, was probably a coincidence that allowed this bug to happen at
all.

Fix the bug by telling the revision walker not to sort the commits
when not walking. The only case we want to reverse the order is now
when cherry-picking and walking revisions (rev_info.no_walk = 0).

 [1] http://thread.gmane.org/gmane.comp.version-control.git/164794

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/revert.c                    | 2 +-
 sequencer.c                         | 4 +++-
 t/t3508-cherry-pick-many-commits.sh | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 42ce399..98ad641 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -193,7 +193,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		struct setup_revision_opt s_r_opt;
 		opts->revs = xmalloc(sizeof(*opts->revs));
 		init_revisions(opts->revs, NULL);
-		opts->revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
+		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
diff --git a/sequencer.c b/sequencer.c
index bf078f2..9f32104 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -543,7 +543,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 static void prepare_revs(struct replay_opts *opts)
 {
-	if (opts->action != REPLAY_REVERT)
+	// picking (but not reverting) ranges (but not individual revisions)
+	// should be done in reverse
+	if (opts->action == REPLAY_PICK && !opts->revs->no_walk)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index fff20c3..04b5ad4 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -44,7 +44,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 	check_head_differs_from fourth
 '
 
-test_expect_failure 'cherry-pick three one two works' '
+test_expect_success 'cherry-pick three one two works' '
 	git checkout -f first &&
 	test_commit one &&
 	test_commit two &&
-- 
1.7.11.1.104.ge7b44f1
