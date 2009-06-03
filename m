From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] blame: Fix corner case when a directory becomes a file
Date: Wed, 03 Jun 2009 00:43:22 -0700
Message-ID: <7vr5y1bw4l.fsf@alter.siamese.dyndns.org>
References: <cover.1243969358.git.benwillard@gmail.com>
	<4a257d91.0407560a.04d2.ffffe775@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Willard <benwillard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 09:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBl8A-0003Lv-Vh
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 09:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZFCHnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 03:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbZFCHnV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 03:43:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42269 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZFCHnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 03:43:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603074321.MNCB18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jun 2009 03:43:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zKjN1b0054aMwMQ03KjN00; Wed, 03 Jun 2009 03:43:22 -0400
X-Authority-Analysis: v=1.0 c=1 a=DXlptMxM95YA:10 a=m5BZlfTxKaIA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=j5tnuKaqCcAQ6C3DAJMA:9
 a=9iaQ_sIBANyRi4v42jN8cot6jmEA:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <4a257d91.0407560a.04d2.ffffe775@mx.google.com> (Ben Willard's message of "Tue\, 2 Jun 2009 15\:29\:17 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120590>

Ben Willard <benwillard@gmail.com> writes:

> find_origin() assumes that there will be only one listing in
> diff_queued_diff, but this is not the case when a directory becomes a
> file in a single commit.  So, don't fail in this case.

Thanks.

Your problem analysis is almost correct but the solution is wrong.

By the way, I'd rather not see people waste a whole _new_ test script when
there are existing test scripts availble for the command.

-- >8 --
Subject: [PATCH] blame: correctly handle a path that used to be a directory

When trying to see if the same path exists in the parent, we ran
"diff-tree" with pathspec set to the path we are interested in with the
parent, and expect either to have exactly one resulting filepair (either
"changed from the parent", "created when there was none") or nothing (when
there is no change from the parent).

If the path used to be a directory, however, we will also see unbounded
number of entries that talk about the files that used to exist underneath
the directory in question.  Correctly pick only the entry that describes
the path we are interested in in such a case (namely, the creation of the
path as a regular file).

Noticed by Ben Willard.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c  |   26 ++++++++++++++++++--------
 t/t8003-blame.sh |   15 +++++++++++++++
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index cf74a92..0afdb16 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -362,18 +362,28 @@ static struct origin *find_origin(struct scoreboard *sb,
 			       "", &diff_opts);
 	diffcore_std(&diff_opts);
 
-	/* It is either one entry that says "modified", or "created",
-	 * or nothing.
-	 */
 	if (!diff_queued_diff.nr) {
 		/* The path is the same as parent */
 		porigin = get_origin(sb, parent, origin->path);
 		hashcpy(porigin->blob_sha1, origin->blob_sha1);
-	}
-	else if (diff_queued_diff.nr != 1)
-		die("internal error in blame::find_origin");
-	else {
-		struct diff_filepair *p = diff_queued_diff.queue[0];
+	} else {
+		/*
+		 * Since origin->path is a pathspec, if the parent
+		 * commit had it as a directory, we will see a whole
+		 * bunch of deletion of files in the directory that we
+		 * do not care about.
+		 */
+		int i;
+		struct diff_filepair *p = NULL;
+		for (i = 0; i < diff_queued_diff.nr; i++) {
+			const char *name;
+			p = diff_queued_diff.queue[i];
+			name = p->one->path ? p->one->path : p->two->path;
+			if (!strcmp(name, origin->path))
+				break;
+		}
+		if (!p)
+			die("internal error in blame::find_origin");
 		switch (p->status) {
 		default:
 			die("internal error in blame::find_origin (%c)",
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 966bb0a..13c25f1 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -129,4 +129,19 @@ test_expect_success 'blame wholesale copy and more' '
 
 '
 
+test_expect_success 'blame path that used to be a directory' '
+	mkdir path &&
+	echo A A A A A >path/file &&
+	echo B B B B B >path/elif &&
+	git add path &&
+	test_tick &&
+	git commit -m "path was a directory" &&
+	rm -fr path &&
+	echo A A A A A >path &&
+	git add path &&
+	test_tick &&
+	git commit -m "path is a regular file" &&
+	git blame HEAD^.. -- path
+'
+
 test_done
-- 
1.6.3.1.263.g85347
