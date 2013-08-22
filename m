From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCHv2] git-diff: Clarify operation when not inside a repository.
Date: Thu, 22 Aug 2013 16:31:21 -0400
Message-ID: <201308222031.r7MKVL6O028293@freeze.ariadne.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com> <xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 22 22:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCbXW-0002MQ-4g
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 22:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3HVUbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 16:31:25 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:33765
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753084Ab3HVUbY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Aug 2013 16:31:24 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id Fvys1m04o0EZKEL5BwXPvm; Thu, 22 Aug 2013 20:31:23 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id FwXN1m0101KKtkw3MwXPZA; Thu, 22 Aug 2013 20:31:23 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7MKVMQI028294;
	Thu, 22 Aug 2013 16:31:22 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7MKVL6O028293;
	Thu, 22 Aug 2013 16:31:21 -0400
In-reply-to: <xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377203483;
	bh=22GzLODfl2p93wUA3MUsyGX3PMPeVpNPPjWMAwDZDZ8=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=Fngh9lvgX5T9Co6tgzh2sUXuNeiZgHdq+8nb1ObZpg1qLQ46hFCgL0qKxygPsH9Zd
	 B3u+bqyDQ3gtXRwoItKxbwR4VVU2qN9UPocqXQvF27TUq8WM0/Jg4TYq6/QrAhlI4Q
	 xExBA/TiJGZOidQswFTroBXEDKtPjleFCn55/VNusKucUXMQtXTADD1nhfVEgSXlci
	 kyKFAyMwDzOHCx2NOAkjRmftZswnv0Wz+SDEsZgaonE/VVkgpjxhVrDVTv64xVBGH6
	 5glUYCYA5tf6budANhtUcvZNc6FlqP/SrtaN8BoguRs7LHp4pwBDuqobIg9nESK5A+
	 s6t/5o4SwuVKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232773>

Clarify documentation for git-diff:  State that when not inside a
repository, --no-index is implied (and thus two arguments are
mandatory).

Clarify error message from diff-no-index to inform user that CWD is
not inside a repository and thus two arguments are mandatory.

Signed-off-by: Dale Worley <worley@ariadne.com>
---


The error message has been updated from [PATCH].  "git diff" outside a
repository now produces:

    Not a git repository
    To compare two paths outside a working tree:
    usage: git diff [--no-index] <path> <path>

This should inform the user of his error regardless of whether he
intended to perform a within-repository "git diff" or an
out-of-repository "git diff".

This message is closer to the message that other Git commands produce:

    fatal: Not a git repository (or any parent up to mount parent )
    Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

"git diff --no-index" produces the same message as before (since the
user is clearly invoking the non-repository behavior):

    usage: git diff --no-index <path> <path>

Regarding the change to git-diff.txt, perhaps "forced ... by executing
'git diff' outside of a working tree" is not the best wording, but it
should be clear to the reader that (1) it is possible to execute 'git
diff' outside of a working tree, and (2) when doing so, the behavior
will be as if '--no-index' was specified.

I've also added some comments for the new code.


 Documentation/git-diff.txt |    3 ++-
 diff-no-index.c            |   12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index e66fdf3..9734ec3 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -215,9 +215,19 @@ void diff_no_index(struct rev_info *revs,
 		     path_inside_repo(prefix, argv[i+1])))
 			return;
 	}
-	if (argc != i + 2)
+	if (argc != i + 2) {
+	        if (!no_index) {
+		        /* There was no --no-index and there were not two
+			 * paths.  It is possible that the user intended
+			 * to do an inside-repository operation. */
+		        fprintf(stderr, "Not a git repository\n");
+		        fprintf(stderr,
+				"To compare two paths outside a working tree:\n");
+		}
+		/* Give the usage message for non-repository usage and exit. */
 		usagef("git diff %s <path> <path>",
 		       no_index ? "--no-index" : "[--no-index]");
+	}
 
 	diff_setup(&revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
-- 
1.7.7.6
