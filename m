From: Jeff King <peff@peff.net>
Subject: [PATCH] split_ident: parse timestamp from end of line
Date: Mon, 14 Oct 2013 16:27:34 -0400
Message-ID: <20131014202734.GA7007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 14 22:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVojy-0004yp-NG
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 22:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866Ab3JNU1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 16:27:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:49267 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932862Ab3JNU1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 16:27:37 -0400
Received: (qmail 14813 invoked by uid 102); 14 Oct 2013 20:27:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 15:27:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 16:27:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236118>

Split_ident currently parses left to right. Given this
input:

  Your Name <email@example.com> 123456789 -0500\n

We assume the name starts the line and runs until the first
"<".  That starts the email address, which runs until the
first ">".  Everything after that is assumed to be the
timestamp.

This works fine in the normal case, but is easily broken by
corrupted ident lines that contain an extra ">". Some
examples seen in the wild are:

  1. Name <email>-<> 123456789 -0500\n

  2. Name <email> <Name<email>> 123456789 -0500\n

  3. Name1 <email1>, Name2 <email2> 123456789 -0500\n

Currently each of these produces some email address (which
is not necessarily the one the user intended) and end up
with a NULL date (which is generally interpreted as the
epoch by "git log" and friends).

But in each case we could get the correct timestamp simply
by parsing from the right-hand side, looking backwards for
the final ">", and then reading the timestamp from there.

In general, it's a losing battle to try to automatically
guess what the user meant with their broken crud. But this
particular workaround is probably worth doing.  One, it's
dirt simple, and can't impact non-broken cases. Two, it
doesn't catch a single breakage we've seen, but rather a
large class of errors (i.e., any breakage inside the email
angle brackets may affect the email, but won't spill over
into the timestamp parsing). And three, the timestamp is
arguably more valuable to get right, because it can affect
correctness (e.g., in --until cutoffs).

This patch implements the right-to-left scheme described
above. We adjust the tests in t4212, which generate a commit
with such a broken ident, and now gets the timestamp right.
We also add a test that fsck continues to detect the
breakage.

For reference, here are pointers to the breakages seen (as
numbered above):

[1] http://article.gmane.org/gmane.comp.version-control.git/221441

[2] http://article.gmane.org/gmane.comp.version-control.git/222362

[3] http://perl5.git.perl.org/perl.git/commit/13b79730adea97e660de84bbe67f9d7cbe344302

Signed-off-by: Jeff King <peff@peff.net>
---
You could take this concept further and try to do something clever with
the email when we notice the extra ">". But I think that is where this
crosses from "easily and simply covers a class of errors" into "losing
proposition trying to tweak heuristics around various breakages".

The only thing that gives me pause here is that parsing from the right
would close the door to ever adding any new information on the end of an
ident line. I'd be surprised if that door wasn't already closed by the
existing parsers, but I feel like the topic might have come up sometime
in the past year or two (but I can't seem to find anything in the
archive).

 ident.c                | 14 +++++++++++++-
 t/t4212-log-corrupt.sh |  9 +++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index 1c123e6..1a4b3ad 100644
--- a/ident.c
+++ b/ident.c
@@ -233,7 +233,19 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	if (!split->mail_end)
 		return status;
 
-	for (cp = split->mail_end + 1; cp < line + len && isspace(*cp); cp++)
+	/*
+	 * Look from the end-of-line to find the trailing ">" of the mail
+	 * address, even though we should already know it as split->mail_end.
+	 * This can help in cases of broken idents with an extra ">" somewhere
+	 * in the email address.  Note that we are assuming the timestamp will
+	 * never have a ">" in it.
+	 *
+	 * Note also that this memchr can never return NULL, as we would
+	 * always find at least the split->mail_end closing bracket.
+	 */
+	cp = memrchr(split->mail_end, '>', len - (split->mail_end - line));
+
+	for (cp = cp + 1; cp < line + len && isspace(*cp); cp++)
 		;
 	if (line + len <= cp)
 		goto person_only;
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index ec5099b..93c7c36 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -13,11 +13,16 @@ test_expect_success 'git log with broken author email' '
 	git update-ref refs/heads/broken_email $(cat broken_email.hash)
 '
 
+test_expect_success 'fsck notices broken commit' '
+	git fsck 2>actual &&
+	test_i18ngrep invalid.author actual
+'
+
 test_expect_success 'git log with broken author email' '
 	{
 		echo commit $(cat broken_email.hash)
 		echo "Author: A U Thor <author@example.com>"
-		echo "Date:   Thu Jan 1 00:00:00 1970 +0000"
+		echo "Date:   Thu Apr 7 15:13:13 2005 -0700"
 		echo
 		echo "    foo"
 	} >expect.out &&
@@ -30,7 +35,7 @@ test_expect_success 'git log --format with broken author email' '
 '
 
 test_expect_success 'git log --format with broken author email' '
-	echo "A U Thor+author@example.com+" >expect.out &&
+	echo "A U Thor+author@example.com+Thu Apr 7 15:13:13 2005 -0700" >expect.out &&
 	: >expect.err &&
 
 	git log --format="%an+%ae+%ad" broken_email >actual.out 2>actual.err &&
-- 
1.8.4.1.4.gf327177
