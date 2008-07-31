From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 03:36:09 -0400
Message-ID: <20080731073609.GA8049@sigill.intra.peff.net>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk> <20080731055024.GA17652@sigill.intra.peff.net> <7vwsj23896.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSim-0006uh-An
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYGaHgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYGaHgL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:36:11 -0400
Received: from peff.net ([208.65.91.99]:2405 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbYGaHgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:36:11 -0400
Received: (qmail 21819 invoked by uid 111); 31 Jul 2008 07:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 03:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 03:36:09 -0400
Content-Disposition: inline
In-Reply-To: <7vwsj23896.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90907>

On Wed, Jul 30, 2008 at 10:58:13PM -0700, Junio C Hamano wrote:

> >>  			"# Please enter the commit message for your changes.\n"
> >> +			"# To abort the commit, use an empty commit message.\n"
> >>  			"# (Comment lines starting with '#' will ");
> >
> > I still prefer a shortened version of these three lines, as I mentioned
> > earlier.
> 
> I tend to agree; please make it so ;-)

Hmm, I didn't realize you had already applied the original patch. Here
is my previous patch, rebased on top of the current master.

I like this wording, but there is perhaps some disagreement. I will let
you apply, tweak, or ignore as you desire. :)

Note that this still has the error message change that Anders put in a
later patch, but is not in master. Should that be a separate patch (I
really didn't anticipate this much discussion for such a simple change,
but I think there is a rule of thumb about patch size and bike
sheds...)?

-- >8 --
Compact commit template message

We recently let the user know explicitly that an empty
commit message will abort the commit. However, this adds yet
another line to the template; let's rephrase and re-wrap so
that this fits back on two lines.

This patch also makes the "fatal: empty commit message?"
warning a bit less scary, since this is now a "feature"
instead of an error. However, we retain the non-zero exit
status to indicate to callers that nothing was committed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c  |   19 ++++++++++++-------
 t/t7502-commit.sh |   11 +++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f7c053a..b783e6e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -554,14 +554,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 
 		fprintf(fp,
 			"\n"
-			"# Please enter the commit message for your changes.\n"
-			"# To abort the commit, use an empty commit message.\n"
-			"# (Comment lines starting with '#' will ");
+			"# Please enter the commit message for your changes.");
 		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(fp, "not be included)\n");
+			fprintf(fp,
+				" Lines starting\n"
+				"# with '#' will be ignored, and an empty"
+				" message aborts the commit.\n");
 		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp, "be kept.\n"
-				"# You can remove them yourself if you want to)\n");
+			fprintf(fp,
+				" Lines starting\n"
+				"# with '#' will be kept; you may remove them"
+				" yourself if you want to.\n"
+				"# An empty message aborts the commit.\n");
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
 
@@ -1004,7 +1008,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("no commit message?  aborting commit.");
+		fprintf(stderr, "Aborting commit due to empty commit message.\n");
+		exit(1);
 	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index f111263..3eb9fae 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -141,16 +141,15 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 
 echo "sample
 
-# Please enter the commit message for your changes.
-# To abort the commit, use an empty commit message.
-# (Comment lines starting with '#' will not be included)" >expect
+# Please enter the commit message for your changes. Lines starting
+# with '#' will be ignored, and an empty message aborts the commit." >expect
 
 test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
-	head -n 5 .git/COMMIT_EDITMSG >actual &&
+	head -n 4 .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 
 '
@@ -163,7 +162,7 @@ test_expect_success 'author different from committer' '
 
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 8 .git/COMMIT_EDITMSG >actual &&
+	head -n 7 .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
@@ -182,7 +181,7 @@ test_expect_success 'committer is automatic' '
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
-	head -n 9 .git/COMMIT_EDITMSG |	\
+	head -n 8 .git/COMMIT_EDITMSG |	\
 	sed "s/^# Committer: .*/# Committer:/" >actual &&
 	test_cmp expect actual
 '
-- 
1.6.0.rc1.169.g34ee
