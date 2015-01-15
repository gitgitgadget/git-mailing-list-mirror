From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] commit/status: show the index-worktree with -v -v
Date: Thu, 15 Jan 2015 17:08:03 +0100
Message-ID: <038e08973a5872ea13a0ea76bf2a0443fe3c3b50.1421337740.git.git@drmicha.warpmail.net>
References: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 17:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBmy3-0007Rg-HL
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 17:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbbAOQIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 11:08:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44423 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbbAOQIJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 11:08:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 75E48203FF
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 11:08:05 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 15 Jan 2015 11:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=LxC9q6tHVVyOIq
	3ww7UDGfHWmug=; b=PbivQY2Sa8O7WayPSpgAvvm34RfrjbveikDTw0sY4Ux9c8
	hL80/KbJP5grTPyhcj8rGBLUJG4Qw3OmbKib1Z73Hvb6x9W985QMkrY0laG2kEsR
	Yejo6NQHo8ScqxJyLq5RYeexcXIo7WkFv/C3IWvCYdLf9J5sweBoK0nT28oY8=
X-Sasl-enc: zg9E4vOmWPICo2p/aNl+mjvGNufERU24mgN+ZvN8mhE7 1421338084
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D36B7C00013;
	Thu, 15 Jan 2015 11:08:04 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc0.202.g6f441c7
In-Reply-To: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262484>

git commit and git status in long format show the diff between HEAD
and the index when given -v. This allows previewing a commit to be made.

They also list tracked files with unstaged changes, but without a diff.

Introduce '-v -v' which shows the diff between the index and the
worktree in addition to HEAD index diff. This allows to review unstaged
changes which might be missing from the commit.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Also, the git status man page does not mention -v at all, and the doc
for git status (long format) and the status parts of the git commit
man page should really be the same.

In any case, this may have helped the OP with his amend oversight.

 Documentation/git-commit.txt | 4 ++++
 wt-status.c                  | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1e74b75..f14d2ec 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -284,6 +284,10 @@ configuration variable documented in linkgit:git-config[1].
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
 	lines prefixed with '#'.
++
+If specified twice, show in addition the unified diff between
+what would be committed and the worktree files, i.e. the unstaged
+changes to tracked files.
 
 -q::
 --quiet::
diff --git a/wt-status.c b/wt-status.c
index b54eac5..75674c2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -874,6 +874,14 @@ static void wt_status_print_verbose(struct wt_status *s)
 		wt_status_add_cut_line(s->fp);
 	}
 	run_diff_index(&rev, 1);
+	if (s->verbose > 1) {
+		setup_work_tree();
+		if (read_cache_preload(&rev.diffopt.pathspec) < 0)
+			perror("read_cache_preload");
+		rev.diffopt.a_prefix = 0; /* allow run_diff_files */
+		rev.diffopt.b_prefix = 0; /* to reset the prefixes */
+		run_diff_files(&rev, 0);
+	}
 }
 
 static void wt_status_print_tracking(struct wt_status *s)
-- 
2.3.0.rc0.202.g6f441c7
