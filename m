Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D5C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 06:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC372225C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 06:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgJ0Gww (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 02:52:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:38226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgJ0Gww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 02:52:52 -0400
Received: (qmail 14139 invoked by uid 109); 27 Oct 2020 06:52:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 06:52:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14935 invoked by uid 111); 27 Oct 2020 06:52:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 02:52:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 02:52:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sideband: diagnose more incoming packet anomalies
Message-ID: <20201027065250.GB3005508@coredump.intra.peff.net>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
 <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 04:09:13PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v2:
> 
>  * Dropped patch 3/3 because it was only intended to be defensive
>    programming, but turned out to be too hard without layering violations.

It is a bit tricky, but here's a working replacement.

-- >8 --
Subject: [PATCH] sideband: diagnose more sideband anomalies

In demultiplex_sideband(), there are two oddities when we check an
incoming packet:

  - if it has zero length, then we assume it's a flush packet. This
    means we fail to notice the difference between a real flush and a
    true zero-length packet that's missing its sideband designator. It's
    not a huge problem in practice because we'd never send a zero-length
    data packet (even our keepalives are otherwise-empty sideband-1
    packets).

    But it would be nice to detect and report the error, since it's
    likely to cause other confusion (we think the other side flushed,
    but they do not).

  - we try to detect packets missing their designator by checking for
    "if (len < 1)". But this will never trigger for "len == 0"; we've
    already detected that and left the function before then.

    It _could_ detect a negative "len" parameter. But in that case, the
    error message is wrong. The issue is not "no sideband" but rather
    "eof while reading the packet". However, this can't actually be
    triggered in practice, because neither of the two callers uses
    pkt_read's GENTLE_ON_EOF flag. Which means they'd die with "the
    remote end hung up unexpectedly" before we even get here.

    So this truly is dead code.

We can improve these cases by passing in a pkt-line status to the
demultiplexer, and by having recv_sideband() use GENTLE_ON_EOF. This
gives us two improvements:

  - we can now reliably detect flush packets, and will report a normal
    packet missing its sideband designator as an error

  - we'll report an eof with a more detailed "protocol error: eof while
    reading sideband packet", rather than the generic "the remote end
    hung up unexpectedly"

  - when we see an eof, we'll flush the sideband scratch buffer, which
    may provide some hints from the remote about why they hung up
    (though note we already flush on newlines, so it's likely that most
    such messages already made it through)

In some sense this patch goes against fbd76cd450 (sideband: reverse its
dependency on pkt-line, 2019-01-16), which caused the sideband code not
to depend on the pkt-line code. But that commit was really just trying
to deal with the circular header dependency. The two modules are
conceptually interlinked, and it was just trying to keep things
compiling. And indeed, there's a sticking point in this patch: because
pkt-line.h includes sideband.h, we can't add the reverse include we need
for the sideband code to have an "enum packet_read_status" parameter.
Nor can we forward declare it, because you can't forward declare an enum
in C. However, C does guarantee that enums fit in an int, so we can just
use that type.

One alternative would be for the callers to check themselves that they
got something sane from the pkt-line code. But besides duplicating
logic, this gets quite tricky. Any error condition requires flushing the
sideband #2 scratch buffer, which only demultiplex_sideband() knows how
to do.

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c             | 14 ++++++++------
 sideband.c             | 29 ++++++++++++++++++++++-------
 sideband.h             |  6 +++++-
 t/t0070-fundamental.sh | 12 ++++++++++++
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 657a702927..d633005ef7 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -461,9 +461,11 @@ int recv_sideband(const char *me, int in_stream, int out)
 	enum sideband_type sideband_type;
 
 	while (1) {
-		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
-				  0);
-		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
+		int status = packet_read_with_status(in_stream, NULL, NULL,
+						     buf, LARGE_PACKET_MAX,
+						     &len,
+						     PACKET_READ_GENTLE_ON_EOF);
+		if (!demultiplex_sideband(me, status, buf, len, 0, &scratch,
 					  &sideband_type))
 			continue;
 		switch (sideband_type) {
@@ -520,9 +522,9 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 							 reader->options);
 		if (!reader->use_sideband)
 			break;
-		if (demultiplex_sideband(reader->me, reader->buffer,
-					 reader->pktlen, 1, &scratch,
-					 &sideband_type))
+		if (demultiplex_sideband(reader->me, reader->status,
+					 reader->buffer, reader->pktlen, 1,
+					 &scratch, &sideband_type))
 			break;
 	}
 
diff --git a/sideband.c b/sideband.c
index a5405b9aaa..a0d3fb9652 100644
--- a/sideband.c
+++ b/sideband.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "sideband.h"
 #include "help.h"
+#include "pkt-line.h"
 
 struct keyword_entry {
 	/*
@@ -114,7 +115,8 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
-int demultiplex_sideband(const char *me, char *buf, int len,
+int demultiplex_sideband(const char *me, int status,
+			 char *buf, int len,
 			 int die_on_error,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type)
@@ -130,17 +132,30 @@ int demultiplex_sideband(const char *me, char *buf, int len,
 			suffix = DUMB_SUFFIX;
 	}
 
-	if (len == 0) {
-		*sideband_type = SIDEBAND_FLUSH;
-		goto cleanup;
-	}
-	if (len < 1) {
+	if (status == PACKET_READ_EOF) {
 		strbuf_addf(scratch,
-			    "%s%s: protocol error: no band designator",
+			    "%s%s: protocol error: eof while reading sideband packet",
 			    scratch->len ? "\n" : "", me);
 		*sideband_type = SIDEBAND_PROTOCOL_ERROR;
 		goto cleanup;
 	}
+
+	if (len < 0)
+		BUG("negative length on non-eof packet read");
+
+	if (len == 0) {
+		if (status == PACKET_READ_NORMAL) {
+			strbuf_addf(scratch,
+				    "%s%s: protocol error: missing sideband designator",
+				    scratch->len ? "\n" : "", me);
+			*sideband_type = SIDEBAND_PROTOCOL_ERROR;
+		} else {
+			/* covers flush, delim, etc */
+			*sideband_type = SIDEBAND_FLUSH;
+		}
+		goto cleanup;
+	}
+
 	band = buf[0] & 0xff;
 	buf[len] = '\0';
 	len--;
diff --git a/sideband.h b/sideband.h
index 227740a58e..5a25331be5 100644
--- a/sideband.h
+++ b/sideband.h
@@ -18,8 +18,12 @@ enum sideband_type {
  *
  * scratch must be a struct strbuf allocated by the caller. It is used to store
  * progress messages split across multiple packets.
+ *
+ * The "status" parameter is a pkt-line response as returned by
+ * packet_read_with_status() (e.g., PACKET_READ_NORMAL).
  */
-int demultiplex_sideband(const char *me, char *buf, int len,
+int demultiplex_sideband(const char *me, int status,
+			 char *buf, int len,
 			 int die_on_error,
 			 struct strbuf *scratch,
 			 enum sideband_type *sideband_type);
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 357201640a..936030a5ef 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -40,4 +40,16 @@ test_expect_success 'incomplete sideband messages are reassembled' '
 	grep "Hello, world" err
 '
 
+test_expect_success 'eof on sideband message is reported' '
+	printf 1234 >input &&
+	test-tool pkt-line receive-sideband <input 2>err &&
+	test_i18ngrep "eof while reading" err
+'
+
+test_expect_success 'missing sideband designator is reported' '
+	printf 0004 >input &&
+	test-tool pkt-line receive-sideband <input 2>err &&
+	test_i18ngrep "missing sideband" err
+'
+
 test_done
-- 
2.29.1.634.g9e41dc1bf2

