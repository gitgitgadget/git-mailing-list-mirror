From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 09:26:53 -0400
Message-ID: <20150630132653.GA25742@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 15:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vZ0-0003hM-F3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbbF3N06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 09:26:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:53671 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752612AbbF3N05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:26:57 -0400
Received: (qmail 23946 invoked by uid 102); 30 Jun 2015 13:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 08:26:56 -0500
Received: (qmail 14204 invoked by uid 107); 30 Jun 2015 13:27:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 09:27:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 09:26:53 -0400
Content-Disposition: inline
In-Reply-To: <20150629222247.GA31607@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273061>

On Mon, Jun 29, 2015 at 06:22:47PM -0400, Eric Sunshine wrote:

> Clients of strbuf rightly expect the buffer to grow as needed in
> order to complete the requested operation. It is, therefore, both
> weird and expectation-breaking for strbuf_addftime() to lack this
> behavior. Worse, it doesn't even signal when the format has failed
> due to insufficient buffer space.
> 
> How about taking this approach (or something similar), instead, which
> grows the strbuf as needed?

Here's a patch, on top of jk/date-mode-format (I think it would also be
fine to just squash into the tip commit; the explanation in the commit
message is sufficiently mirrored in the code comment).

-- >8 --
Subject: [PATCH] strbuf: make strbuf_addftime more robust

The return value of strftime is poorly designed; when it
returns 0, the caller cannot tell if the buffer was not
large enough, or if the output was actually 0 bytes. In the
original implementation of strbuf_addftime, we simply punted
and guessed that our 128-byte hint would be large enough.

We can do better, though, if we're willing to treat strftime
like less of a black box. We can munge the incoming format
to make sure that it never produces 0-length output, and
then "fix" the resulting output.  That lets us reliably grow
the buffer based on strftime's return value.

Clever-idea-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c                | 38 +++++++++++++++++++++-----------------
 t/t6300-for-each-ref.sh | 10 ++++++++++
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a7ba028..e5e7370 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -712,29 +712,33 @@ char *xstrfmt(const char *fmt, ...)
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 {
+	size_t hint = 128;
 	size_t len;
 
-	/*
-	 * strftime reports "0" if it could not fit the result in the buffer.
-	 * Unfortunately, it also reports "0" if the requested time string
-	 * takes 0 bytes. So if we were to probe and grow, we have to choose
-	 * some arbitrary cap beyond which we guess that the format probably
-	 * just results in a 0-length output. Since we have to choose some
-	 * reasonable cap anyway, and since it is not that big, we may
-	 * as well just grow to their in the first place.
-	 */
-	strbuf_grow(sb, 128);
+	if (!*fmt)
+		return;
+
+	strbuf_grow(sb, hint);
 	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
 
 	if (!len) {
 		/*
-		 * Either we failed, or the format actually produces a 0-length
-		 * output. There's not much we can do, so we leave it blank.
-		 * However, the output array is left in an undefined state, so
-		 * we must re-assert our NUL terminator.
+		 * strftime reports "0" if it could not fit the result in the buffer.
+		 * Unfortunately, it also reports "0" if the requested time string
+		 * takes 0 bytes. So our strategy is to munge the format so that the
+		 * output contains at least one character, and then drop the extra
+		 * character before returning.
 		 */
-		sb->buf[sb->len] = '\0';
-	} else {
-		sb->len += len;
+		struct strbuf munged_fmt = STRBUF_INIT;
+		strbuf_addf(&munged_fmt, "%s ", fmt);
+		while (!len) {
+			hint *= 2;
+			strbuf_grow(sb, hint);
+			len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
+				       munged_fmt.buf, tm);
+		}
+		strbuf_release(&munged_fmt);
+		len--; /* drop munged space */
 	}
+	strbuf_setlen(sb, sb->len + len);
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c7f368c..7c9bec7 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -235,6 +235,16 @@ test_expect_success 'Check format of strftime date fields' '
 	test_cmp expected actual
 '
 
+test_expect_success 'exercise strftime with odd fields' '
+	echo >expected &&
+	git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
+	test_cmp expected actual &&
+	long="long format -- $_z40$_z40$_z40$_z40$_z40$_z40$_z40" &&
+	echo $long >expected &&
+	git for-each-ref --format="%(authordate:format:$long)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 refs/heads/master
 refs/remotes/origin/master
-- 
2.5.0.rc0.336.g8460790
