From: Jeff King <peff@peff.net>
Subject: [PATCH] revision.c: propagate tag names from pending array
Date: Thu, 17 Dec 2015 01:47:07 -0500
Message-ID: <20151217064706.GA3531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Raymundo <gypark@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 07:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9SLh-00005u-NH
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 07:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbbLQGrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 01:47:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:43437 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751910AbbLQGrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 01:47:10 -0500
Received: (qmail 3958 invoked by uid 102); 17 Dec 2015 06:47:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 00:47:10 -0600
Received: (qmail 9042 invoked by uid 107); 17 Dec 2015 06:47:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 01:47:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 01:47:07 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282632>

When we unwrap a tag to find its commit for a traversal, we
do not propagate the "name" field of the tag in the pending
array (i.e., the ref name the user gave us in the first
place) to the commit (instead, we use an empty string). This
means that "git log --source" will never show the tag-name
for commits we reach through it.

This was broken in 2073949 (traverse_commit_list: support
pending blobs/trees with paths, 2014-10-15). That commit
tried to be careful and avoid propagating the path
information for a tag (which would be nonsensical) to trees
and blobs. But it should not have cut off the "name" field,
which should carry forward to children.

Note that this does mean that the "name" field will carry
forward to blobs and trees, too. Whereas prior to 2073949,
we always gave them an empty string. This is the right thing
to do, but in practice no callers probably use it (since now
we have an explicit separate "path" field, which was the
point of 2073949).

We add tests here not only for the broken case, but also a
basic sanity test of "log --source" in general, which did
not have any coverage in the test suite.

Reported-by: Raymundo <gypark@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was reported several weeks ago, but I needed to take the time to
convince myself this wasn't regressing any cases. I'm pretty sure it's
the right thing to do.

The regression is in v2.2.0, so this is not urgent to make it into v2.7
before release, but it is definitely maint-worthy.

 revision.c     |  3 +--
 t/t4202-log.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 9404a05..0a282f5 100644
--- a/revision.c
+++ b/revision.c
@@ -294,9 +294,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 		/*
 		 * We'll handle the tagged object by looping or dropping
 		 * through to the non-tag handlers below. Do not
-		 * propagate data from the tag's pending entry.
+		 * propagate path data from the tag's pending entry.
 		 */
-		name = "";
 		path = NULL;
 		mode = 0;
 	}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6ede069..a0f80af 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -908,4 +908,33 @@ test_expect_success 'log diagnoses bogus HEAD' '
 	test_i18ngrep broken stderr
 '
 
+test_expect_success 'set up --source tests' '
+	git checkout --orphan source-a &&
+	test_commit one &&
+	test_commit two &&
+	git checkout -b source-b HEAD^ &&
+	test_commit three
+'
+
+test_expect_success 'log --source paints branch names' '
+	cat >expect <<-\EOF &&
+	09e12a9	source-b three
+	8e393e1	source-a two
+	1ac6c77	source-b one
+	EOF
+	git log --oneline --source source-a source-b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --source paints tag names' '
+	git tag -m tagged source-tag &&
+	cat >expect <<-\EOF &&
+	09e12a9	source-tag three
+	8e393e1	source-a two
+	1ac6c77	source-tag one
+	EOF
+	git log --oneline --source source-tag source-a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.rc1.339.gca82f22
