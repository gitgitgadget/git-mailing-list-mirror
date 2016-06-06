From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] cherry-pick: allow to pick to unborn branches
Date: Mon,  6 Jun 2016 15:23:54 +0200
Message-ID: <69f7973e353f52a62157ca59af5027c9617506a4.1465219182.git.git@drmicha.warpmail.net>
References: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
Cc: Fabrizio Cucci <fabrizio.cucci@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 15:24:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uVc-0002Bn-J3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbcFFNX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 09:23:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54466 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764AbcFFNX4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 09:23:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8DCD5215D1;
	Mon,  6 Jun 2016 09:23:55 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 06 Jun 2016 09:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ZH2OiH9xW586RERrFl3u8Ml5+WM
	=; b=Y8O2BFIwlOU8wpgTQ25QI7Z47oXWqKorTFbRXcZ/kL2xk+E4lmSAvh3aSO+
	GVIf5kq7wLF+eWWj/604/930hGxamRicFwautn6xNPyl4AlWJybY9Zd3Vbqx7v/a
	Pm2GEObZWnCRhoH6m/3MHrFIKmzZSSgutnkC1cpqa/gjnMB4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZH2O
	iH9xW586RERrFl3u8Ml5+WM=; b=Sjt8Bd8XWuabIywzR5Vq9oHFMNX6VMcqNObC
	KoK1kPyUAqTEBcEYmrVFI/USzvrMHlNA4hNS8QfodrkOEzkU2V6nZlR0FNohZ0lv
	OJBHPleVTK24xGpbnpKrlmC6dvuoZxUAeyltkBSRKR88+buBrsr48JbunXfc2H6m
	VieTuLw=
X-Sasl-enc: XPLS0Ooc/EJ3le0g2BGYGug3M1HVM6oQZjx1kegWv211 1465219435
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id E9FF2CCDA1;
	Mon,  6 Jun 2016 09:23:54 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.rc1.371.ge0ee742
In-Reply-To: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296506>

Currently, cherry-pick allows tp pick single commits to an empty HEAD
but not multiple commits.

Allow the multiple commit case, too.

Reported-by: Fabrizio Cucci <fabrizio.cucci@gmail.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 sequencer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4687ad4..c6362d6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -888,6 +888,10 @@ static int sequencer_rollback(struct replay_opts *opts)
 			git_path_head_file());
 		goto fail;
 	}
+	if (is_null_sha1(sha1)) {
+		error(_("cannot abort from a branch yet to be born"));
+		goto fail;
+	}
 	if (reset_for_rollback(sha1))
 		goto fail;
 	remove_sequencer_state();
@@ -1086,11 +1090,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	walk_revs_populate_todo(&todo_list, opts);
 	if (create_seq_dir() < 0)
 		return -1;
-	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REPLAY_REVERT)
-			return error(_("Can't revert as initial commit"));
-		return error(_("Can't cherry-pick into empty head"));
-	}
+	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
+		return error(_("Can't revert as initial commit"));
 	save_head(sha1_to_hex(sha1));
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
-- 
2.9.0.rc1.371.ge0ee742
