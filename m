Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F125B3
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:12:45 -0800 (PST)
Received: (qmail 19408 invoked by uid 109); 12 Dec 2023 22:12:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 22:12:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20028 invoked by uid 111); 12 Dec 2023 22:12:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 17:12:44 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 17:12:43 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
Message-ID: <20231212221243.GA1656116@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

When processing a header like a "From" line, mailinfo uses
unquote_quoted_pair() to handle double-quotes and rfc822 parenthesized
comments. It takes a NUL-terminated string on input, and loops over the
"in" pointer until it sees the NUL. When it finds the start of an
interesting block, it delegates to helper functions which also increment
"in", and return the updated pointer.

But there's a bug here: the helpers find the NUL with a post-increment
in the loop condition, like:

   while ((c = *in++) != 0)

So when they do see a NUL (rather than the correct termination of the
quote or comment section), they return "in" as one _past_ the NUL
terminator. And thus the outer loop in unquote_quoted_pair() does not
realize we hit the NUL, and keeps reading past the end of the buffer.

We should instead make sure to return "in" positioned at the NUL, so
that the caller knows to stop their loop, too. A hacky way to do this is
to return "in - 1" after leaving the inner loop. But a slightly cleaner
solution is to avoid incrementing "in" until we are sure it contained a
non-NUL byte (i.e., doing it inside the loop body).

The two tests here show off the problem. Since we check the output,
they'll _usually_ report a failure in a normal build, but it depends on
what garbage bytes are found after the heap buffer. Building with
SANITIZE=address reliably notices the problem. The outcome (both the
exit code and the exact bytes) are just what Git happens to produce for
these cases today, and shouldn't be taken as an endorsement. It might be
reasonable to abort on an unterminated string, for example. The priority
for this patch is fixing the out-of-bounds memory access.

Reported-by: Carlos Andrés Ramírez Cataño <antaigroupltda@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was reported to the security list, but because it's just an
out-of-bounds read, we won't do a coordinated disclosure.

 mailinfo.c          |  8 ++++----
 t/t5100-mailinfo.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index a07d2da16d..737b9e5e13 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -58,12 +58,12 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
 
 static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 {
-	int c;
 	int take_next_literally = 0;
 
 	strbuf_addch(outbuf, '(');
 
-	while ((c = *in++) != 0) {
+	while (*in) {
+		int c = *in++;
 		if (take_next_literally == 1) {
 			take_next_literally = 0;
 		} else {
@@ -88,10 +88,10 @@ static const char *unquote_comment(struct strbuf *outbuf, const char *in)
 
 static const char *unquote_quoted_string(struct strbuf *outbuf, const char *in)
 {
-	int c;
 	int take_next_literally = 0;
 
-	while ((c = *in++) != 0) {
+	while (*in) {
+		int c = *in++;
 		if (take_next_literally == 1) {
 			take_next_literally = 0;
 		} else {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index db11cababd..654d8cf3ee 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -268,4 +268,26 @@ test_expect_success 'mailinfo warn CR in base64 encoded email' '
 	test_must_be_empty quoted-cr/0002.err
 '
 
+test_expect_success 'from line with unterminated quoted string' '
+	echo "From: bob \"unterminated string smith <bob@example.com>" >in &&
+	git mailinfo /dev/null /dev/null <in >actual &&
+	cat >expect <<-\EOF &&
+	Author: bob unterminated string smith
+	Email: bob@example.com
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'from line with unterminated comment' '
+	echo "From: bob (unterminated comment smith <bob@example.com>" >in &&
+	git mailinfo /dev/null /dev/null <in >actual &&
+	cat >expect <<-\EOF &&
+	Author: bob (unterminated comment smith
+	Email: bob@example.com
+
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.310.g85bf1f633d
