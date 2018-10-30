Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DD91F453
	for <e@80x24.org>; Tue, 30 Oct 2018 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeJaIpe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 04:45:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726366AbeJaIpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 04:45:33 -0400
Received: (qmail 29112 invoked by uid 109); 30 Oct 2018 23:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Oct 2018 23:23:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5429 invoked by uid 111); 30 Oct 2018 23:22:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Oct 2018 19:22:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2018 19:23:12 -0400
Date:   Tue, 30 Oct 2018 19:23:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 2/3] check_stream_sha1(): handle input underflow
Message-ID: <20181030232312.GB32038@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181030231232.GA6141@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit fixes an infinite loop when fscking large
truncated loose objects.

The check_stream_sha1() function takes an mmap'd loose
object buffer and streams 4k of output at a time, checking
its sha1. The loop quits when we've output enough bytes (we
know the size from the object header), or when zlib tells us
anything except Z_OK or Z_BUF_ERROR.

The latter is expected because zlib may run out of room in
our 4k buffer, and that is how it tells us to process the
output and loop again.

But Z_BUF_ERROR also covers another case: one in which zlib
cannot make forward progress because it needs more _input_.
This should never happen in this loop, because though we're
streaming the output, we have the entire deflated input
available in the mmap'd buffer. But since we don't check
this case, we'll just loop infinitely if we do see a
truncated object, thinking that zlib is asking for more
output space.

It's tempting to fix this by checking stream->avail_in as
part of the loop condition (and quitting if all of our bytes
have been consumed). But that assumes that once zlib has
consumed the input, there is nothing left to do.  That's not
necessarily the case: it may have read our input into its
internal state, but still have bytes to output.

Instead, let's continue on Z_BUF_ERROR only when we see the
case we're expecting: the previous round filled our output
buffer completely. If it didn't (and we still saw
Z_BUF_ERROR), we know something is wrong and should break
out of the loop.

The bug comes from commit f6371f9210 (sha1_file: add
read_loose_object() function, 2017-01-13), which
reimplemented some of the existing loose object functions.
So it's worth checking if this bug was inherited from any of
those. The answers seems to be no. The two obvious
candidates are both OK:

  1. unpack_sha1_rest(); this doesn't need to loop on
     Z_BUF_ERROR at all, since it allocates the expected
     output buffer in advance (which we can't do since we're
     explicitly streaming here)

  2. check_object_signature(); the streaming path relies on
     the istream interface, which uses read_istream_loose()
     for this case. That function uses a similar "is our
     output buffer full" check with Z_BUF_ERROR (which is
     where I stole it from for this patch!)

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c     |  3 ++-
 t/t1450-fsck.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..2daf7d9935 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2199,7 +2199,8 @@ static int check_stream_sha1(git_zstream *stream,
 	 * see the comment in unpack_sha1_rest for details.
 	 */
 	while (total_read <= size &&
-	       (status == Z_OK || status == Z_BUF_ERROR)) {
+	       (status == Z_OK ||
+		(status == Z_BUF_ERROR && !stream->avail_out))) {
 		stream->next_out = buf;
 		stream->avail_out = sizeof(buf);
 		if (size - total_read < stream->avail_out)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3421f12e8a..b5677d26a4 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -683,6 +683,25 @@ test_expect_success 'fsck detects trailing loose garbage (large blob)' '
 	test_i18ngrep "garbage.*$blob" out
 '
 
+test_expect_success 'fsck detects truncated loose object' '
+	# make it big enough that we know we will truncate in the data
+	# portion, not the header
+	test-tool genrandom truncate 4096 >file &&
+	blob=$(git hash-object -w file) &&
+	file=$(sha1_file $blob) &&
+	test_when_finished "remove_object $blob" &&
+	test_copy_bytes 1024 <"$file" >tmp &&
+	rm "$file" &&
+	mv -f tmp "$file" &&
+
+	# check both regular and streaming code paths
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep corrupt.*$blob out &&
+
+	test_must_fail git -c core.bigfilethreshold=128 fsck 2>out &&
+	test_i18ngrep corrupt.*$blob out
+'
+
 # for each of type, we have one version which is referenced by another object
 # (and so while unreachable, not dangling), and another variant which really is
 # dangling.
-- 
2.19.1.1235.g6b27db57c2

