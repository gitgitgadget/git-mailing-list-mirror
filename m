From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCH] git-diff: Clarify operation when not inside a repository.
Date: Wed, 21 Aug 2013 13:34:58 -0400
Message-ID: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 19:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCCJJ-00068J-84
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 19:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab3HURfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 13:35:03 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:39732
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100Ab3HURfC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Aug 2013 13:35:02 -0400
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id FUgq1m0010Fqzac55Vb0Ue; Wed, 21 Aug 2013 17:35:00 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id FVaz1m01V1KKtkw3UVb0mY; Wed, 21 Aug 2013 17:35:00 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.5/8.14.5) with ESMTP id r7LHYxEi008860;
	Wed, 21 Aug 2013 13:34:59 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.5/8.14.5/Submit) id r7LHYwNh008859;
	Wed, 21 Aug 2013 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377106500;
	bh=cLAmL6uRxmZrGHs7ta/s79Qi5/g/5br648kjysjwW1Y=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=mSdOOAX8zp97xjmEfYhcxIj3fT5eG+HV4DQb4FAbNWqbY5VsQ2Duhe15nk0HJV1B7
	 ouy68oS/ZQ/cduCqdmn2o5fa4ZF40dOok+xb7iHi57Q4m6s1iXHIkQeoH3ClNcF3SK
	 35DkgYFuGaMDEESne5lkHobtoU0bGIgCOvZrLGmdLQOQNe3v/KmAWa1bfnUWT5hNv2
	 nu59J9yVBXd6s3M2P1oWW1M+oxU76sRvBqKgQShCtBgpioxtKVWDVpLBui57QK6FzM
	 4/6eSeFmX2cbDlwN0+T2iYzbhT5k2SePg26Oh8lIbWOW3VUYMrhGalNhEANI8+FtiD
	 6f9IzWIYBr/kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232710>

Clarify documentation for git-diff:  State that when not inside a
repository, --no-index is implied (and thus two arguments are
mandatory).

Clarify error message from diff-no-index to inform user that CWD is
not inside a repository and thus two arguments are mandatory.

Signed-off-by: Dale Worley <worley@ariadne.com>
---


This clarification is to avoid a problem I ran into.  I executed 'git
diff' in the remote working tree of a repository, and not in the
repository directory itself.  Because of that, git-diff assumed
git-diff --no-index, and executed diff-no-index.  Since I hadn't
provided paths, diff-no-index produced an error message.
Unfortunately, the error message presupposes that the decision to
execute diff-no-index reflects the user's intention, thus leaving me
confused, as the error message is only:
    usage: git diff [--no-index] <path> <path>
and does not cover the case I intended.  This patch changes the
message to notify the user that he is getting --no-index semantics
because he is outside of a repository:
    Not within a git repository:
    usage: git diff [--no-index] <path> <path>
The additional line is suppressed if the user specified --no-index.

The documentation is expanded to state that execution outside of a
repository forces --no-index behavior.  Previously, the manual implied
this but did not state it, making it easy for the user to overlook
that it's possible to run git-diff outside of a repository.

Dale


 Documentation/git-diff.txt |    3 ++-
 diff-no-index.c            |    6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 78d6d50..9f74989 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -31,7 +31,8 @@ two blob objects, or changes between two files on disk.
 +
 If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
-directories. This behavior can be forced by --no-index.
+directories. This behavior can be forced by --no-index or by 
+executing 'git diff' outside of a working tree.
 
 'git diff' [--options] --cached [<commit>] [--] [<path>...]::
 
diff --git a/diff-no-index.c b/diff-no-index.c
index e66fdf3..98c5f76 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -215,9 +215,13 @@ void diff_no_index(struct rev_info *revs,
 		     path_inside_repo(prefix, argv[i+1])))
 			return;
 	}
-	if (argc != i + 2)
+	if (argc != i + 2) {
+	        if (!no_index) {
+		        fprintf(stderr, "Not within a git repository:\n");
+		}
 		usagef("git diff %s <path> <path>",
 		       no_index ? "--no-index" : "[--no-index]");
+	}
 
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
-- 
1.7.7.6
