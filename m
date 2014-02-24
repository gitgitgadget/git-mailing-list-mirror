From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] t4212: test bogus timestamps with git-log
Date: Mon, 24 Feb 2014 02:36:22 -0500
Message-ID: <20140224073622.GA9969@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 08:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHq5V-0004RY-3W
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbaBXHgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:36:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:55855 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750899AbaBXHgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:36:24 -0500
Received: (qmail 14285 invoked by uid 102); 24 Feb 2014 07:36:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 01:36:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 02:36:22 -0500
Content-Disposition: inline
In-Reply-To: <20140224073348.GA20221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242566>

When t4212 was originally added by 9dbe7c3d (pretty: handle
broken commit headers gracefully, 2013-04-17), it tested our
handling of commits with broken ident lines in which the
timestamps could not be parsed. It does so using a bogus line
like "Name <email>-<> 1234 -0000", because that simulates an
error that was seen in the wild.

Later, 03818a4 (split_ident: parse timestamp from end of
line, 2013-10-14) made our parser smart enough to actually
find the timestamp on such a line, and t4212 was adjusted to
match. While it's nice that we handle this real-world case,
this meant that we were not actually testing the
bogus-timestamp case anymore.

This patch adds a test with a totally incomprehensible
timestamp to make sure we are testing the code path.

Note that the behavior is slightly different between regular log
output and "--format=%ad". In the former case, we produce a
sentinel value and in the latter, we produce an empty
string. While at first this seems unnecessarily
inconsistent, it matches the original behavior given by
9dbe7c3d.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4212-log-corrupt.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 93c7c36..83de981 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -44,4 +44,25 @@ test_expect_success 'git log --format with broken author email' '
 	test_cmp expect.err actual.err
 '
 
+munge_author_date () {
+	git cat-file commit "$1" >commit.orig &&
+	sed "s/^\(author .*>\) [0-9]*/\1 $2/" <commit.orig >commit.munge &&
+	git hash-object -w -t commit commit.munge
+}
+
+test_expect_success 'unparsable dates produce sentinel value' '
+	commit=$(munge_author_date HEAD totally_bogus) &&
+	echo "Date:   Thu Jan 1 00:00:00 1970 +0000" >expect &&
+	git log -1 $commit >actual.full &&
+	grep Date <actual.full >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unparsable dates produce sentinel value (%ad)' '
+	commit=$(munge_author_date HEAD totally_bogus) &&
+	echo >expect &&
+	git log -1 --format=%ad $commit >actual
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2.500.g8060133
