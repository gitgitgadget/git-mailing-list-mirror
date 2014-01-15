From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] interpret_branch_name: always respect "namelen" parameter
Date: Wed, 15 Jan 2014 03:31:57 -0500
Message-ID: <20140115083157.GC19132@sigill.intra.peff.net>
References: <20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:32:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3LtL-0001YT-3A
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaAOIcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:32:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:60917 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751024AbaAOIb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:31:58 -0500
Received: (qmail 9272 invoked by uid 102); 15 Jan 2014 08:31:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:31:59 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:31:57 -0500
Content-Disposition: inline
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240440>

interpret_branch_name gets passed a "name" buffer to parse,
along with a "namelen" parameter representing its length. If
"namelen" is zero, we fallback to the NUL-terminated
string-length of "name".

However, it does not necessarily follow that if we have
gotten a non-zero "namelen", it is the NUL-terminated
string-length of "name". E.g., when get_sha1() is parsing
"foo:bar", we will be asked to operate only on the first
three characters.

Yet in interpret_branch_name and its helpers, we use string
functions like strchr() to operate on "name", looking past
the length we were given.  This can result in us mis-parsing
object names.  We should instead be limiting our search to
"namelen" bytes.

There are three distinct types of object names this patch
addresses:

  - The intrepret_empty_at helper uses strchr to find the
    next @-expression after our potential empty-at.  In an
    expression like "@:foo@bar", it erroneously thinks that
    the second "@" is relevant, even if we were asked only
    to look at the first character. This case is easy to
    trigger (and we test it in this patch).

  - When finding the initial @-mark for @{upstream}, we use
    strchr.  This means we might treat "foo:@{upstream}" as
    the upstream for "foo:", even though we were asked only
    to look at "foo". We cannot test this one in practice,
    because it is masked by another bug (which is fixed in
    the next patch).

  - The interpret_nth_prior_checkout helper did not receive
    the name length at all. This turns out not to be a
    problem in practice, though, because its parsing is so
    limited: it always starts from the far-left of the
    string, and will not tolerate a colon (which is
    currently the only way to get a smaller-than-strlen
    "namelen"). However, it's still worth fixing to make the
    code more obviously correct, and to future-proof us
    against callers with more exotic buffers.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c                | 17 ++++++++++-------
 t/t1508-at-combinations.sh | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 958aa2e..6d5038d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -430,7 +430,7 @@ static inline int upstream_mark(const char *string, int len)
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
-static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
+static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
@@ -492,7 +492,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(str, &buf) > 0) {
+		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
 			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
 			strbuf_release(&buf);
 			if (detached)
@@ -929,7 +929,8 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
-static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
+static int interpret_nth_prior_checkout(const char *name, int namelen,
+					struct strbuf *buf)
 {
 	long nth;
 	int retval;
@@ -937,9 +938,11 @@ static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 	const char *brace;
 	char *num_end;
 
+	if (namelen < 4)
+		return -1;
 	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
 		return -1;
-	brace = strchr(name, '}');
+	brace = memchr(name, '}', namelen);
 	if (!brace)
 		return -1;
 	nth = strtol(name + 3, &num_end, 10);
@@ -1012,7 +1015,7 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 		return -1;
 
 	/* make sure it's a single @, or @@{.*}, not @foo */
-	next = strchr(name + len + 1, '@');
+	next = memchr(name + len + 1, '@', namelen - len - 1);
 	if (next && next[1] != '{')
 		return -1;
 	if (!next)
@@ -1118,7 +1121,7 @@ static int interpret_upstream_mark(const char *name, int namelen,
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *at;
-	int len = interpret_nth_prior_checkout(name, buf);
+	int len = interpret_nth_prior_checkout(name, namelen, buf);
 
 	if (!namelen)
 		namelen = strlen(name);
@@ -1132,7 +1135,7 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 			return reinterpret(name, namelen, len, buf);
 	}
 
-	at = strchr(name, '@');
+	at = memchr(name, '@', namelen);
 	if (!at)
 		return -1;
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index ceb8449..078e119 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -9,8 +9,11 @@ check() {
 		if test '$2' = 'commit'
 		then
 			git log -1 --format=%s '$1' >actual
-		else
+		elif test '$2' = 'ref'
+		then
 			git rev-parse --symbolic-full-name '$1' >actual
+		else
+			git cat-file -p '$1' >actual
 		fi &&
 		test_cmp expect actual
 	"
@@ -82,4 +85,14 @@ check HEAD ref refs/heads/old-branch
 check "HEAD@{1}" commit new-two
 check "@{1}" commit old-one
 
+test_expect_success 'create path with @' '
+	echo content >normal &&
+	echo content >fun@ny &&
+	git add normal fun@ny &&
+	git commit -m "funny path"
+'
+
+check "@:normal" blob content
+check "@:fun@ny" blob content
+
 test_done
-- 
1.8.5.2.500.g8060133
