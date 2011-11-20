From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] revert: improve error message for cherry-pick during
 cherry-pick
Date: Sun, 20 Nov 2011 03:51:51 -0600
Message-ID: <20111120095151.GE2278@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:52:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS44H-0006tz-Qg
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab1KTJwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:52:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab1KTJwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:52:03 -0500
Received: by iage36 with SMTP id e36so5856939iag.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xLev5SItYJAcHeyEYv8qCGXgedgkSZBzNuFFX1e/DUs=;
        b=LcAjhdMsVw0cvzOR37D2Vx+G+cQQ8WJiGP5SAaJAvXNRZz9Qx0AVw612q6QieoUkAO
         Vpp45ZISKvCbgXiPsa1fRfndqMq3eXCG7wNdFeIGiCQLQU936K7I8c+mKnY5FfgSM4Hf
         JVFtYASyIa5xDjsrWiE80+8jeV0Ulnq0hmLCw=
Received: by 10.42.176.130 with SMTP id be2mr7822808icb.11.1321782722467;
        Sun, 20 Nov 2011 01:52:02 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dm1sm7934069igb.6.2011.11.20.01.52.01
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Nov 2011 01:52:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185723>

In the spirit of v1.6.3.3~3^2 (refuse to merge during a merge,
2009-07-01), "git cherry-pick" refuses to start a new cherry-pick when
in the middle of an existing conflicted cherry-pick in the following
sequence:

 1. git cherry-pick HEAD..origin
 2. resolve conflicts
 3. git cherry-pick HEAD..origin (instead of "git cherry-pick
    --continue", by mistake)

Good.  However, the error message on attempting step 3 is more
convoluted than necessary:

  $ git cherry-pick HEAD..origin
  error: .git/sequencer already exists.
  error: A cherry-pick or revert is in progress.
  hint: Use --continue to continue the operation
  hint: or --quit to forget about it
  fatal: cherry-pick failed

Clarify by removing the double redundant first "error:" message,
simplifying the advice, and using lower-case and no full stops to be
consistent with other commands that prefix their messages with
"error:", so it becomes

  error: a cherry-pick or revert is already in progress
  hint: try "git cherry-pick (--continue | --quit)"
  fatal: cherry-pick failed

The "fatal: cherry-pick failed" line seems unnecessary, too, but
that can be fixed some other day.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  There are more error messages, but
let's start with this one.

Thanks for reading.

 builtin/revert.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index dd072ce6..9db4c1e4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -843,8 +843,11 @@ static int create_seq_dir(void)
 {
 	const char *seq_dir = git_path(SEQ_DIR);
 
-	if (file_exists(seq_dir))
-		return error(_("%s already exists."), seq_dir);
+	if (file_exists(seq_dir)) {
+		error(_("a cherry-pick or revert is already in progress"));
+		advise(_("try \"git cherry-pick (--continue | --quit)\""));
+		return -1;
+	}
 	else if (mkdir(seq_dir, 0777) < 0)
 		die_errno(_("Could not create sequencer directory %s"), seq_dir);
 	return 0;
@@ -988,12 +991,8 @@ static int pick_revisions(struct replay_opts *opts)
 	 */
 
 	walk_revs_populate_todo(&todo_list, opts);
-	if (create_seq_dir() < 0) {
-		error(_("A cherry-pick or revert is in progress."));
-		advise(_("Use --continue to continue the operation"));
-		advise(_("or --quit to forget about it"));
+	if (create_seq_dir() < 0)
 		return -1;
-	}
 	if (get_sha1("HEAD", sha1)) {
 		if (opts->action == REVERT)
 			return error(_("Can't revert as initial commit"));
-- 
1.7.8.rc3
