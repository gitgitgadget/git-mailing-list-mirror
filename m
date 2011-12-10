From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] revert: stop creating and removing sequencer-old
 directory
Date: Sat, 10 Dec 2011 07:06:12 -0600
Message-ID: <20111210130612.GH22035@elie.hsd1.il.comcast.net>
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
X-From: git-owner@vger.kernel.org Sat Dec 10 14:06:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMdC-0006Ds-Km
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab1LJNGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 08:06:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64098 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1LJNGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 08:06:17 -0500
Received: by iaeh11 with SMTP id h11so207237iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w0kINmMhwry1ER4yjYDMJBoCUGnaApWBjoAhhJO+AIo=;
        b=G2dOg/3VwciUbsMoG1R6hTPRmgg6qMA8ThrjdEZJ9RjIIurdG7QQKWFOnoVfGf2K33
         WhZ+YHrzukb8mKcOOQzaT6BsMp8HA4UE6fv17rEwtW70nu+W6bY0DJrMqSzYzepnYg/o
         ZuUyxqOni8iaNCLlk5LTzBSKcVFiYcph+jIY0=
Received: by 10.50.51.234 with SMTP id n10mr7652687igo.10.1323522376780;
        Sat, 10 Dec 2011 05:06:16 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z22sm23409678ibg.5.2011.12.10.05.06.15
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 05:06:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186776>

Now that "git reset" no longer implicitly removes .git/sequencer that
the operator may or may not have wanted to keep, the logic to write a
backup copy of .git/sequencer and remove it when stale is not needed
any more.  Simplify the sequencer API and repository layout by
dropping it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end.  I hope the patches provided some amusement, and
advice towards making them more useful would be welcome.

Good night,
Jonathan

 builtin/revert.c |    6 +++---
 sequencer.c      |   10 ++--------
 sequencer.h      |   12 ++----------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 28deb85b..444df413 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -944,7 +944,7 @@ static int sequencer_rollback(struct replay_opts *opts)
 	}
 	if (reset_for_rollback(sha1))
 		goto fail;
-	remove_sequencer_state(1);
+	remove_sequencer_state();
 	strbuf_release(&buf);
 	return 0;
 fail:
@@ -1026,7 +1026,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state(1);
+	remove_sequencer_state();
 	return 0;
 }
 
@@ -1084,7 +1084,7 @@ static int pick_revisions(struct replay_opts *opts)
 	 * one that is being continued
 	 */
 	if (opts->subcommand == REPLAY_REMOVE_STATE) {
-		remove_sequencer_state(1);
+		remove_sequencer_state();
 		return 0;
 	}
 	if (opts->subcommand == REPLAY_ROLLBACK)
diff --git a/sequencer.c b/sequencer.c
index bc2c046a..d1f28a69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3,17 +3,11 @@
 #include "strbuf.h"
 #include "dir.h"
 
-void remove_sequencer_state(int aggressive)
+void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
-	struct strbuf seq_old_dir = STRBUF_INIT;
 
 	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
-	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
-	remove_dir_recursively(&seq_old_dir, 0);
-	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
-	if (aggressive)
-		remove_dir_recursively(&seq_old_dir, 0);
+	remove_dir_recursively(&seq_dir, 0);
 	strbuf_release(&seq_dir);
-	strbuf_release(&seq_old_dir);
 }
diff --git a/sequencer.h b/sequencer.h
index f435fdb4..2d4528f2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -2,19 +2,11 @@
 #define SEQUENCER_H
 
 #define SEQ_DIR		"sequencer"
-#define SEQ_OLD_DIR	"sequencer-old"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
-/*
- * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
- * any errors.  Intended to be used by 'git reset'.
- *
- * With the aggressive flag, it additionally removes SEQ_OLD_DIR,
- * ignoring any errors.  Inteded to be used by the sequencer's
- * '--quit' subcommand.
- */
-void remove_sequencer_state(int aggressive);
+/* Removes SEQ_DIR. */
+extern void remove_sequencer_state(void);
 
 #endif
-- 
1.7.8.rc3
