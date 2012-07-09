From: Chris Webb <chris@arachsys.com>
Subject: Using git commit --amend on a commit with an empty message
Date: Mon, 9 Jul 2012 15:24:38 +0100
Message-ID: <20120709142437.GQ13885@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 16:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoEtJ-0007LP-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 16:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab2GIOYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 10:24:40 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:49652 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab2GIOYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 10:24:40 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SoEtC-0008Ui-Kp
	for git@vger.kernel.org; Mon, 09 Jul 2012 15:24:39 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201204>

Github gists can be cloned as normal git repositories, but the commits made
through the web interface appear with an empty commit message. Running
git commit --amend against them exposes a slightly odd behaviour of git,
which I can also demonstrate as follows:

  $ git init foo && cd foo
  $ touch one && git add one
  $ git commit -m '' --allow-empty-message
  [master (root-commit) 535cb36] 
   0 files changed
   create mode 100644 one

When I try to correct this commit message in an editor, it refuses to
proceed, objecting to the existing empty commit message:

  $ git commit --amend
  fatal: commit has empty message

Shouldn't this drop me into the editor and fail only if the resulting
message on exit is empty? (For comparison, git commit --amend -m 'oops' will
work fine; it's apparently only the edit case which doesn't.)

In fact, we even fail to start the editor if --allow-empty-message is
explicitly provided:

  $ git commit --amend --allow-empty-message
  fatal: commit has empty message

Assuming this isn't intentional for some reason I don't understand, I think
this is the correct tiny fix? make test succeeds fine both before and after.

-- >8 --
Subject: [PATCH] Allow edit of empty message with commit --amend

If git commit --amend is used on a commit with an empty message, it fails
unless -m is given, whether or not --allow-empty-message is specified.

Instead, allow it to proceed to the editor with an empty commit message.
Unless --allow-empty-message is in force, it will still abort later if an
empty message is saved from the editor. (That check was already present
and necessary to prevent a non-empty commit message being edited to an
empty one.)

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/commit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f43eaaf..6515da2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -640,7 +640,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
-		if (!buffer || buffer[2] == '\0')
+		if (!use_editor && (!buffer || buffer[2] == '\0'))
 			die(_("commit has empty message"));
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
-- 
1.7.10
