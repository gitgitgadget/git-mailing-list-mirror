From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] revert: allow single-pick in the middle of cherry-pick
 sequence
Date: Sat, 10 Dec 2011 06:59:48 -0600
Message-ID: <20111210125948.GE22035@elie.hsd1.il.comcast.net>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 14:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMXS-0004WT-W1
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab1LJNAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 08:00:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41366 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab1LJM7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:59:54 -0500
Received: by iaeh11 with SMTP id h11so200296iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8M5wMSMmakHWGc2e7is5QtrXgnAqV9c8aeLtuToDd1g=;
        b=gei2LGzQPXmkY4KWVdTZMme03tqCWSuw2B/LiSBryrebAW3RBlkGWU8SD8TtLfacgO
         UrOlj3tIIrkmrn68f4PO72l740Ufm+uNEToN53DkfySQE+CU5AuVLSy6VPrrUZnvFohn
         4ZGO5o9wHE2t570S5V7RTB/xaCP/sjKI840AE=
Received: by 10.43.65.79 with SMTP id xl15mr5990022icb.6.1323521993365;
        Sat, 10 Dec 2011 04:59:53 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 36sm23322865ibc.6.2011.12.10.04.59.52
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:59:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186773>

When I messed up a difficult conflict in the middle of a cherry-pick
sequence, it can be useful to be able to 'git checkout HEAD . && git
cherry-pick that-one-commit' to restart the conflict resolution.

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Maybe this should come after patch 6/7, so the use case could use
"git reset --hard".

 builtin/revert.c                |   26 ++++++++++++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |   12 ++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 71570357..dcb69904 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1072,6 +1072,12 @@ static int sequencer_continue(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
+static int single_pick(struct commit *cmit, struct replay_opts *opts)
+{
+	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	return do_pick_commit(cmit, opts);
+}
+
 static int pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -1097,6 +1103,26 @@ static int pick_revisions(struct replay_opts *opts)
 		return sequencer_continue(opts);
 
 	/*
+	 * If we were called as "git cherry-pick <commit>", just
+	 * cherry-pick/revert it, set CHERRY_PICK_HEAD /
+	 * REVERT_HEAD, and don't touch the sequencer state.
+	 * This means it is possible to cherry-pick in the middle
+	 * of a cherry-pick sequence.
+	 */
+	if (opts->revs->cmdline.nr == 1 &&
+	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
+	    opts->revs->no_walk &&
+	    !opts->revs->cmdline.rev->flags) {
+		struct commit *cmit;
+		if (prepare_revision_walk(opts->revs))
+			die(_("revision walk setup failed"));
+		cmit = get_revision(opts->revs);
+		if (!cmit || get_revision(opts->revs))
+			die("BUG: expected exactly one commit from walk");
+		return single_pick(cmit, opts);
+	}
+
+	/*
 	 * Start a new cherry-pick/ revert sequence; but
 	 * first, make sure that an existing one isn't in
 	 * progress
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 56c95ec1..98a27a23 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -50,6 +50,18 @@ test_expect_success 'cherry-pick persists data on failure' '
 	test_path_is_file .git/sequencer/opts
 '
 
+test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_cmp_rev picked CHERRY_PICK_HEAD &&
+	# "oops, I forgot that these patches rely on the change from base"
+	git checkout HEAD foo &&
+	git cherry-pick base &&
+	git cherry-pick picked &&
+	git cherry-pick --continue &&
+	git diff --exit-code anotherpick
+'
+
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
-- 
1.7.8.rc3
