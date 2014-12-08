From: Jeff King <peff@peff.net>
Subject: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 00:48:13 -0500
Message-ID: <20141208054812.GA30154@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 06:48:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxrBE-0006j1-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 06:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaLHFsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 00:48:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:49809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbaLHFsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 00:48:14 -0500
Received: (qmail 25842 invoked by uid 102); 8 Dec 2014 05:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 23:48:14 -0600
Received: (qmail 20419 invoked by uid 107); 8 Dec 2014 05:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Dec 2014 00:48:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Dec 2014 00:48:13 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260998>

When we detect an invalid tag-name header in a tag object,
like, "tag foo bar\n", we feed the pointer starting at "foo
bar" to a printf "%s" formatter. This shows the name, as we
want, but then it keeps printing the rest of the tag buffer,
rather than stopping at the end of the line.

Our tests did not notice because they look only for the
matching line, but the bug is that we print much more than
we wanted to. So we also adjust the test to be more exact.

Note that when fscking tags with "index-pack --strict", this
is even worse. index-pack does not add a trailing
NUL-terminator after the object, so we may actually read
past the buffer and print uninitialized memory. Running
t5302 with valgrind does notice the bug for that reason.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm generally nervous about adding too-specific stderr wording or
formatting to our tests, as I do not want them to be brittle. But I do
not actually think this is substantially different than what other fsck
tests do (i.e., they are already grepping for _half_ the wording
already, so if it changes, they are likely to break, too).

If we care, the test can check test_line_count or similar to make sure
there isn't extra data. But I think the way I have written it below is a
lot easier for a reader coming later to understand what is going on.

 fsck.c          | 3 ++-
 t/t1450-fsck.sh | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2fffa43..88c92e8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -423,7 +423,8 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0))
-		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %s", buffer);
+		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %.*s",
+			   (int)(eol - buffer), buffer);
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tagger ", &buffer))
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 019fddd..57ccce5 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -229,8 +229,12 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	git fsck --tags 2>out &&
-	grep "invalid .tag. name" out &&
-	grep "expected .tagger. line" out
+
+	cat >expect <<-EOF &&
+	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	EOF
+	test_cmp expect out
 '
 
 test_expect_success 'tag with bad tagger' '
-- 
2.2.0.390.gf60752d
