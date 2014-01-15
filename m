From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] interpret_branch_name: avoid @{upstream} past colon
Date: Wed, 15 Jan 2014 03:37:23 -0500
Message-ID: <20140115083723.GD19132@sigill.intra.peff.net>
References: <20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:37:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Lyb-0002qV-EO
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbaAOIh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:37:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:60922 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbaAOIhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:37:24 -0500
Received: (qmail 9506 invoked by uid 102); 15 Jan 2014 08:37:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:37:25 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:37:23 -0500
Content-Disposition: inline
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240441>

get_sha1() cannot currently parse a valid object name like
"HEAD:@{upstream}" (assuming that such an oddly named file
exists in the HEAD commit). It takes two passes to parse the
string:

  1. It first considers the whole thing as a ref, which
     results in looking for the upstream of "HEAD:".

  2. It finds the colon, parses "HEAD" as a tree-ish, and then
     finds the path "@{upstream}" in the tree.

For a path that looks like a normal reflog (e.g.,
"HEAD:@{yesterday}"), the first pass is a no-op. We try to
dwim_ref("HEAD:"), that returns zero refs, and we proceed
with colon-parsing.

For "HEAD:@{upstream}", though, the first pass ends up in
interpret_upstream_mark, which tries to find the branch
"HEAD:". When it sees that the branch does not exist, it
actually dies rather than returning an error to the caller.
As a result, we never make it to the second pass.

One obvious way of fixing this would be to teach
interpret_upstream_mark to simply report "no, this isn't an
upstream" in such a case. However, that would make the
error-reporting for legitimate upstream cases significantly
worse. Something like "bogus@{upstream}" would simply report
"unknown revision: bogus@{upstream}", while the current code
diagnoses a wide variety of possible misconfigurations (no
such branch, branch exists but does not have upstream, etc).

However, we can take advantage of the fact that a branch
name cannot contain a colon. Therefore even if we find an
upstream mark, any prefix with a colon must mean that
the upstream mark we found is actually a pathname, and
should be disregarded completely. This patch implements that
logic.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this would actually be cleaner if get_sha1() simply did the
colon-parsing first, and omitted the first pass completely. Then
sub-functions would not have to care about arbitrary junk that can come
in paths; they would always be parsing just the revision-specifier.

However, given the way this code has developed over the years and its
general fragility, I would be entirely unsurprised if there is some case
that relies on the current scheme. So I went with the simple fix here,
which should be much less likely to have any fallout. And I could not
come up with an example that is actually broken under the current code
(we just do some suboptimal things, like looking for "foo:bar" as a ref
in the filesystem, even though it is syntactically bogus).

 sha1_name.c                   |  3 +++
 t/t1507-rev-parse-upstream.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 6d5038d..b253a88 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1093,6 +1093,9 @@ static int interpret_upstream_mark(const char *name, int namelen,
 	if (!len)
 		return -1;
 
+	if (memchr(name, ':', at))
+		return -1;
+
 	set_shortened_ref(buf, get_upstream_branch(name, at));
 	return len + at;
 }
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 2a19e79..cace1ca 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -210,4 +210,20 @@ test_expect_success 'log -g other@{u}@{now}' '
 	test_cmp expect actual
 '
 
+test_expect_success '@{reflog}-parsing does not look beyond colon' '
+	echo content >@{yesterday} &&
+	git add @{yesterday} &&
+	git commit -m "funny reflog file" &&
+	git hash-object @{yesterday} >expect &&
+	git rev-parse HEAD:@{yesterday} >actual
+'
+
+test_expect_success '@{upstream}-parsing does not look beyond colon' '
+	echo content >@{upstream} &&
+	git add @{upstream} &&
+	git commit -m "funny upstream file" &&
+	git hash-object @{upstream} >expect &&
+	git rev-parse HEAD:@{upstream} >actual
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
