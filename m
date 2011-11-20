From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] revert: rearrange pick_revisions() for clarity
Date: Sun, 20 Nov 2011 03:50:10 -0600
Message-ID: <20111120095010.GD2278@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS42c-0006S1-RG
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab1KTJuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:50:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53533 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab1KTJuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:50:21 -0500
Received: by iage36 with SMTP id e36so5855684iag.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 01:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fnvN6oKf6jior+zT0oPOiUpk4jA8GQHllhpOpBtb85Y=;
        b=BwXvDfOK5tBCwudSB2/Ab13gLVRM4jSzs7MogFNZVewNMi1ytYMOQuqEzVoe+jdS9i
         XAfotBvWTGp3MMWsDPqQTtzhYVLiVUaa7bEM38czrDnRuXOfnkdqVZuDEIUYsZow+Is6
         vZQTWPSxVdt02FK7byM8k+MsztysVVLdechTw=
Received: by 10.42.147.72 with SMTP id m8mr9775700icv.56.1321782620764;
        Sun, 20 Nov 2011 01:50:20 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z10sm29639645ibv.9.2011.11.20.01.50.19
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Nov 2011 01:50:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185722>

Deal completely with "cherry-pick --quit" and --continue at the
beginning of pick_revisions(), leaving the rest of the function for
the more interesting "git cherry-pick <commits>" case.

No functional change intended.  The impact is just to unindent the
code a little.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This also paves the way to factoring out the REPLAY_CONTINUE case
into a separate function.

 builtin/revert.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b59dd68c..dd072ce6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -968,40 +968,40 @@ static int pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_REMOVE_STATE) {
 		remove_sequencer_state(1);
 		return 0;
-	} else if (opts->subcommand == REPLAY_CONTINUE) {
+	}
+	if (opts->subcommand == REPLAY_CONTINUE) {
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
-			goto error;
+			return error(_("No %s in progress"), action_name(opts));
 		read_populate_opts(&opts);
 		read_populate_todo(&todo_list, opts);
 
 		/* Verify that the conflict has been resolved */
 		if (!index_differs_from("HEAD", 0))
 			todo_list = todo_list->next;
-	} else {
-		/*
-		 * Start a new cherry-pick/ revert sequence; but
-		 * first, make sure that an existing one isn't in
-		 * progress
-		 */
+		return pick_commits(todo_list, opts);
+	}
+
+	/*
+	 * Start a new cherry-pick/ revert sequence; but
+	 * first, make sure that an existing one isn't in
+	 * progress
+	 */
 
-		walk_revs_populate_todo(&todo_list, opts);
-		if (create_seq_dir() < 0) {
-			error(_("A cherry-pick or revert is in progress."));
-			advise(_("Use --continue to continue the operation"));
-			advise(_("or --quit to forget about it"));
-			return -1;
-		}
-		if (get_sha1("HEAD", sha1)) {
-			if (opts->action == REVERT)
-				return error(_("Can't revert as initial commit"));
-			return error(_("Can't cherry-pick into empty head"));
-		}
-		save_head(sha1_to_hex(sha1));
-		save_opts(opts);
+	walk_revs_populate_todo(&todo_list, opts);
+	if (create_seq_dir() < 0) {
+		error(_("A cherry-pick or revert is in progress."));
+		advise(_("Use --continue to continue the operation"));
+		advise(_("or --quit to forget about it"));
+		return -1;
+	}
+	if (get_sha1("HEAD", sha1)) {
+		if (opts->action == REVERT)
+			return error(_("Can't revert as initial commit"));
+		return error(_("Can't cherry-pick into empty head"));
 	}
+	save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 	return pick_commits(todo_list, opts);
-error:
-	return error(_("No %s in progress"), action_name(opts));
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
-- 
1.7.8.rc3
