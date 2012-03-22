From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] merge-recursive: don't detect renames from empty files
Date: Thu, 22 Mar 2012 14:53:49 -0400
Message-ID: <20120322185349.GC32727@sigill.intra.peff.net>
References: <20120322185246.GA27037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:54:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn99-0000HP-03
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195Ab2CVSxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:53:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56839
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759194Ab2CVSxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:53:51 -0400
Received: (qmail 3901 invoked by uid 107); 22 Mar 2012 18:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:54:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 14:53:49 -0400
Content-Disposition: inline
In-Reply-To: <20120322185246.GA27037@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193686>

Merge-recursive detects renames so that if one side modifies
"foo" and the other side moves it to "bar", the modification
is applied to "bar". However, our rename detection is based
on content analysis, it can be wrong (i.e., two files were
not intended as a rename, but just happen to have the same
or similar content).

This is quite rare if the files actually contain content,
since two unrelated files are unlikely to have exactly the
same content.  However, empty files present a problem, in
that there is nothing to analyze. An uninteresting
placeholder file with zero bytes may or may not be related
to a placeholder file with another name.

The result is that adding content to an empty file may cause
confusion if the other side of a merge removed it; your
content may end up in another random placeholder file that
was added.

Let's err on the side of caution and not consider empty
files as renames. This will cause a modify/delete conflict
on the merge, which will let the user sort it out
themselves.

We could do the same thing for general diff rename
detection. However, the stakes are much less high there, as
we are explicitly reporting the rename to the user. It's
only the automatic nature of merge-recursive that makes the
result confusing. So there's not as much need for caution
when just showing a diff.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c       |    2 +-
 t/t6022-merge-rename.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 318d32e..0255f50 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -502,7 +502,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
+		if (pair->status != 'R' || is_empty_blob_sha1(pair->one->sha1)) {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 9d8584e..1104249 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -884,4 +884,20 @@ test_expect_success 'no spurious "refusing to lose untracked" message' '
 	! grep "refusing to lose untracked file" errors.txt
 '
 
+test_expect_success 'do not follow renames for empty files' '
+	git checkout -f -b empty-base &&
+	>empty1 &&
+	git add empty1 &&
+	git commit -m base &&
+	echo content >empty1 &&
+	git add empty1 &&
+	git commit -m fill &&
+	git checkout -b empty-topic HEAD^ &&
+	git mv empty1 empty2 &&
+	git commit -m rename &&
+	test_must_fail git merge empty-base &&
+	>expect &&
+	test_cmp expect empty2
+'
+
 test_done
-- 
1.7.10.rc0.9.gdcbe9
