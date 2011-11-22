From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] revert: rearrange pick_revisions() for clarity
Date: Tue, 22 Nov 2011 05:15:10 -0600
Message-ID: <20111122111510.GC7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:15:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoJt-0001hv-Ba
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab1KVLPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:15:15 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43802 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab1KVLPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:15:14 -0500
Received: by ghrr1 with SMTP id r1so33683ghr.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FdY/l4v6jipH0XnEL1MCvydOJbEOFYaY1EoGxXrJgjY=;
        b=A3u6daRN05kahu4gT5dn33+qudmR30DCbN+M1E6mxAAaNgqYMfnaNE4bb6pXNU0tpK
         btdEvldvUVaY/mhcqYGRihGgwPmdjfi8nzIhdYQMC+UQUMIHEgXRbEbPhrra8V2UfleS
         0feQZF7oBQXo1W/f7zhCuaZT7t+VDGLcuhan0=
Received: by 10.50.47.201 with SMTP id f9mr19923658ign.18.1321960513543;
        Tue, 22 Nov 2011 03:15:13 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dd36sm58714071ibb.7.2011.11.22.03.15.12
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:15:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185783>

Deal completely with "cherry-pick --quit" and --continue at the
beginning of pick_revisions(), leaving the rest of the function for
the more interesting "git cherry-pick <commits>" case.

No functional change intended.  The impact is just to unindent the
code a little.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e109fb11..2346cafb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -971,40 +971,40 @@ static int pick_revisions(struct replay_opts *opts)
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
