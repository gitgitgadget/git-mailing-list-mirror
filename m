From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] revert: give --continue handling its own function
Date: Sat, 10 Dec 2011 06:47:36 -0600
Message-ID: <20111210124736.GB22035@elie.hsd1.il.comcast.net>
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
X-From: git-owner@vger.kernel.org Sat Dec 10 13:47:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMLB-0000xD-Vl
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab1LJMrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 07:47:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41771 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1LJMrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:47:40 -0500
Received: by iaeh11 with SMTP id h11so188386iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pUC3so1x3DmqxT7xH1R2+jF35RRxXiW6cdS8TQepdf4=;
        b=AB0dK2H22jFR8TaGgxLw2ywCkWOiHMzD/G1NNaBAIfsNI9B26ZI1+LIsH95JTSNzSM
         trqUed1s8dsjo5Xn7dBu7d1cy7btBgI9A+qcynhVeEFiQqYwx9kvadubZ1MM9ucMAf7n
         BDAZrXxO4BST2Qd2MHY0qyqFujdPdwyvUcb54=
Received: by 10.50.163.97 with SMTP id yh1mr7405103igb.37.1323521260384;
        Sat, 10 Dec 2011 04:47:40 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id py9sm13025251igc.2.2011.12.10.04.47.39
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:47:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186767>

This makes pick_revisions() a little shorter and easier to read
straight through.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1ea525c1..9f6c85c1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1038,6 +1038,21 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
+static int sequencer_continue(struct replay_opts *opts)
+{
+	struct commit_list *todo_list = NULL;
+
+	if (!file_exists(git_path(SEQ_TODO_FILE)))
+		return error(_("No %s in progress"), action_name(opts));
+	read_populate_opts(&opts);
+	read_populate_todo(&todo_list, opts);
+
+	/* Verify that the conflict has been resolved */
+	if (!index_differs_from("HEAD", 0))
+		todo_list = todo_list->next;
+	return pick_commits(todo_list, opts);
+}
+
 static int pick_revisions(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -1056,17 +1071,8 @@ static int pick_revisions(struct replay_opts *opts)
 	}
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
-	if (opts->subcommand == REPLAY_CONTINUE) {
-		if (!file_exists(git_path(SEQ_TODO_FILE)))
-			return error(_("No %s in progress"), action_name(opts));
-		read_populate_opts(&opts);
-		read_populate_todo(&todo_list, opts);
-
-		/* Verify that the conflict has been resolved */
-		if (!index_differs_from("HEAD", 0))
-			todo_list = todo_list->next;
-		return pick_commits(todo_list, opts);
-	}
+	if (opts->subcommand == REPLAY_CONTINUE)
+		return sequencer_continue(opts);
 
 	/*
 	 * Start a new cherry-pick/ revert sequence; but
-- 
1.7.8.rc3
