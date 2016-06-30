Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6E21F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcF3JOk (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:14:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:38281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751383AbcF3JOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:14:38 -0400
Received: (qmail 31479 invoked by uid 102); 30 Jun 2016 09:07:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:07:59 -0400
Received: (qmail 6644 invoked by uid 107); 30 Jun 2016 09:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 05:08:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 05:07:54 -0400
Date:	Thu, 30 Jun 2016 05:07:54 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/5] t9300: factor out portable "head -c" replacement
Message-ID: <20160630090753.GA17463@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630090614.GA16725@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In shell scripts it is sometimes useful to be able to read
exactly N bytes from a pipe. Doing this portably turns out
to be surprisingly difficult.

We want a solution that:

  - is portable

  - never reads more than N bytes due to buffering (which
    would mean those bytes are not available to the next
    program to read from the same pipe)

  - handles partial reads by looping until N bytes or read
    (or we see EOF)

  - is resilient to stray signals giving us EINTR while
    trying to read (even though we don't send them, things
    like SIGWINCH could cause apparently-random failures)

Some possible solutions are:

  - "head -c" is not portable, and implementations may
    buffer (though GNU head does not)

  - "read -N" is a bash-ism, and thus not portable

  - "dd bs=$n count=1" does not handle partial reads. GNU dd
    has iflags=fullblock, but that is not portable

  - "dd bs=1 count=$n" fixes the partial read problem (all
    reads are 1-byte, so there can be no partial response).
    It does make a lot of write() calls, but for our tests
    that's unlikely to matter.  It's fairly portable. We
    already use it in our tests, and it's unlikely that
    implementations would screw up any of our criteria. The
    most unknown one would be signal handling.

  - perl can do a sysread() loop pretty easily. On my Linux
    system, at least, it seems to restart the read() call
    automatically. If that turns out not to be portable,
    though, it would be easy for us to handle it.

That makes the perl solution the least bad (because we
conveniently omitted "length of code" as a criterion).
It's also what t9300 is currently using, so we can just pull
the implementation from there.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9300-fast-import.sh  | 23 +++--------------------
 t/test-lib-functions.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 74d740d..2e0ba3e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,23 +7,6 @@ test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
-# Print $1 bytes from stdin to stdout.
-#
-# This could be written as "head -c $1", but IRIX "head" does not
-# support the -c option.
-head_c () {
-	perl -e '
-		my $len = $ARGV[1];
-		while ($len > 0) {
-			my $s;
-			my $nread = sysread(STDIN, $s, $len);
-			die "cannot read: $!" unless defined($nread);
-			print $s;
-			$len -= $nread;
-		}
-	' - "$1"
-}
-
 verify_packs () {
 	for p in .git/objects/pack/*.pack
 	do
@@ -2481,7 +2464,7 @@ test_expect_success PIPE 'R: copy using cat-file' '
 
 		read blob_id type size <&3 &&
 		echo "$blob_id $type $size" >response &&
-		head_c $size >blob <&3 &&
+		test_copy_bytes $size >blob <&3 &&
 		read newline <&3 &&
 
 		cat <<-EOF &&
@@ -2524,7 +2507,7 @@ test_expect_success PIPE 'R: print blob mid-commit' '
 		EOF
 
 		read blob_id type size <&3 &&
-		head_c $size >actual <&3 &&
+		test_copy_bytes $size >actual <&3 &&
 		read newline <&3 &&
 
 		echo
@@ -2559,7 +2542,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 		echo "cat-blob $to_get" &&
 
 		read blob_id type size <&3 &&
-		head_c $size >actual <&3 &&
+		test_copy_bytes $size >actual <&3 &&
 		read newline <&3 &&
 
 		echo deleteall
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 48884d5..90856d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -961,3 +961,17 @@ test_env () {
 		done
 	)
 }
+
+# Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
+test_copy_bytes () {
+	perl -e '
+		my $len = $ARGV[1];
+		while ($len > 0) {
+			my $s;
+			my $nread = sysread(STDIN, $s, $len);
+			die "cannot read: $!" unless defined($nread);
+			print $s;
+			$len -= $nread;
+		}
+	' - "$1"
+}
-- 
2.9.0.317.g65b4e7c

