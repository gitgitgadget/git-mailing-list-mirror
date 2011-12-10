From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] revert: do not remove state until sequence is finished
Date: Sat, 10 Dec 2011 07:02:12 -0600
Message-ID: <20111210130212.GF22035@elie.hsd1.il.comcast.net>
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
X-From: git-owner@vger.kernel.org Sat Dec 10 14:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMZL-00056M-FV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab1LJNCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 08:02:19 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50767 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1LJNCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 08:02:18 -0500
Received: by ggnr5 with SMTP id r5so4186711ggn.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eXYReVQoSz8H70EoT4FVnozMUFpLCPh2R/qXQuORdeA=;
        b=mjMfTb3vHSiXMKscXAEcMlHIUo3Yq4UIznzMw9B8PBvPpQX/IV25g20TpyyS90o7nb
         lntzvzJ5FYn8fybLp4/fGKL8oeO4hRo7hJA0w4GFrqJDAYjrU8iEv+VPK8yhYZFzonRH
         LMM62MxGiM83yHNOmkZkF7tn8RbAGnDuaHmcY=
Received: by 10.182.162.35 with SMTP id xx3mr1376287obb.34.1323522137721;
        Sat, 10 Dec 2011 05:02:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b7sm11018233obp.5.2011.12.10.05.02.15
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 05:02:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186774>

As v1.7.8-rc0~141^2~4 (2011-08-04) explains, git cherry-pick removes
the sequencer state just before applying the final patch.  In the
single-pick case, that was a good thing, since --abort and --continue
work fine without access to such state and removing it provides a
signal that git should not complain about the need to clobber it ("a
cherry-pick or revert is already in progress") in sequences like the
following:

	git cherry-pick foo
	git read-tree -m -u HEAD; # forget that; let's try a different one
	git cherry-pick bar

After the recent patch "allow single-pick in the middle of cherry-pick
sequence" we don't need that hack any more.  In the new regime, a
traditional "git cherry-pick <commit>" command never looks at
.git/sequencer, so we do not need to cripple "git cherry-pick
<commit>..<commit>" for it any more.

So now you can run "git cherry-pick --abort" near the end of a
multi-pick sequence and it will abort the entire sequence, instead of
misbehaving and aborting just the final commit.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   12 +-----------
 t/t3510-cherry-pick-sequence.sh |    6 +++---
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index dcb69904..28deb85b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1018,18 +1018,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res) {
-			if (!cur->next)
-				/*
-				 * An error was encountered while
-				 * picking the last commit; the
-				 * sequencer state is useless now --
-				 * the user simply needs to resolve
-				 * the conflict and commit
-				 */
-				remove_sequencer_state(0);
+		if (res)
 			return res;
-		}
 	}
 
 	/*
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 98a27a23..851b147f 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -203,10 +203,10 @@ test_expect_success '--abort refuses to clobber unrelated change, harder case' '
 	test_cmp_rev initial HEAD
 '
 
-test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
+test_expect_success 'cherry-pick still writes sequencer state when one commit is left' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
-	test_path_is_missing .git/sequencer &&
+	test_path_is_dir .git/sequencer &&
 	echo "resolved" >foo &&
 	git add foo &&
 	git commit &&
@@ -227,7 +227,7 @@ test_expect_success 'cherry-pick cleans up sequencer state when one commit is le
 	test_cmp expect actual
 '
 
-test_expect_failure '--abort after last commit in sequence' '
+test_expect_success '--abort after last commit in sequence' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
 	git cherry-pick --abort &&
-- 
1.7.8.rc3
