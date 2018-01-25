Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF381F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbeAYA6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:58:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:56588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYA6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:58:21 -0500
Received: (qmail 19767 invoked by uid 109); 25 Jan 2018 00:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:58:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31639 invoked by uid 111); 25 Jan 2018 00:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:58:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:58:19 -0500
Date:   Wed, 24 Jan 2018 19:58:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] t/lib-git-daemon: add network-protocol helpers
Message-ID: <20180125005819.GE26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of our git-protocol tests rely on invoking the client
and having it make a request of a server. That gives a nice
real-world test of how the two behave together, but it
doesn't leave any room for testing how a server might react
to _other_ clients.

Let's add a few test helper functions which can be used to
manually conduct a git-protocol conversation with a remote
git-daemon:

  1. To connect to a remote git-daemon, we need something
     like "netcat". But not everybody will have netcat. And
     even if they do, the behavior with respect to
     half-duplex shutdowns is not portable (openbsd netcat
     has "-N", with others you must rely on "-q 1", which is
     racy).

     Here we provide a "fake_nc" that is capable of doing
     a client-side netcat, with sane half-duplex semantics.
     It relies on perl's IO::Socket::INET. That's been in
     the base distribution since 5.6.0, so it's probably
     available everywhere. But just to be on the safe side,
     we'll add a prereq.

  2. To help tests speak and read pktline, this patch adds
     packetize() and depacketize() functions.

I've put fake_nc() into lib-git-daemon.sh, since that's
really the only server where we'd need to use a network
socket.  Whereas the pktline helpers may be of more general
use, so I've added them to test-lib-functions.sh. Programs
like upload-pack speak pktline, but can talk directly over
stdio without a network socket.

Signed-off-by: Jeff King <peff@peff.net>
---
The sideband handling in depacketize() is not actually needed for this
series. But these are helpers I had written long ago for some
unpublished work, and they have come in handy a few times.

 t/lib-git-daemon.sh     | 25 ++++++++++++++++++++++++-
 t/test-lib-functions.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 19f3ffdbb1..de621c1243 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -32,7 +32,8 @@ LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
 
 GIT_DAEMON_PID=
 GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
-GIT_DAEMON_URL=git://127.0.0.1:$LIB_GIT_DAEMON_PORT
+GIT_DAEMON_HOST_PORT=127.0.0.1:$LIB_GIT_DAEMON_PORT
+GIT_DAEMON_URL=git://$GIT_DAEMON_HOST_PORT
 
 start_git_daemon() {
 	if test -n "$GIT_DAEMON_PID"
@@ -98,3 +99,25 @@ stop_git_daemon() {
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output
 }
+
+# A stripped-down version of a netcat client, that connects to a "host:port"
+# given in $1, sends its stdin followed by EOF, then dumps the response (until
+# EOF) to stdout.
+fake_nc() {
+	if ! test_declared_prereq FAKENC
+	then
+		echo >&4 "fake_nc: need to declare FAKENC prerequisite"
+		return 127
+	fi
+	perl -Mstrict -MIO::Socket::INET -e '
+		my $s = IO::Socket::INET->new(shift)
+			or die "unable to open socket: $!";
+		print $s <STDIN>;
+		$s->shutdown(1);
+		print <$s>;
+	' "$@"
+}
+
+test_lazy_prereq FAKENC '
+	perl -MIO::Socket::INET -e "exit 0"
+'
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..a679b02a1c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1020,3 +1020,37 @@ nongit () {
 		"$@"
 	)
 }
+
+# convert stdin to pktline representation; note that empty input becomes an
+# empty packet, not a flush packet (for that you can just print 0000 yourself).
+packetize() {
+	cat >packetize.tmp &&
+	len=$(wc -c <packetize.tmp) &&
+	printf '%04x%s' "$(($len + 4))" &&
+	cat packetize.tmp &&
+	rm -f packetize.tmp
+}
+
+# Parse the input as a series of pktlines, writing the result to stdout.
+# Sideband markers are removed automatically, and the output is routed to
+# stderr if appropriate.
+#
+# NUL bytes are converted to "\\0" for ease of parsing with text tools.
+depacketize () {
+	perl -e '
+		while (read(STDIN, $len, 4) == 4) {
+			if ($len eq "0000") {
+				print "FLUSH\n";
+			} else {
+				read(STDIN, $buf, hex($len) - 4);
+				$buf =~ s/\0/\\0/g;
+				if ($buf =~ s/^[\x2\x3]//) {
+					print STDERR $buf;
+				} else {
+					$buf =~ s/^\x1//;
+					print $buf;
+				}
+			}
+		}
+	'
+}
-- 
2.16.1.273.gfdaa03aa74

