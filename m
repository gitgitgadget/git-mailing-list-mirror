From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH/RFC v2 3/4] fetch-pack: test cases for the new --stdin option
Date: Tue, 27 Mar 2012 08:27:11 +0200
Message-ID: <4F715DBF.6030909@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPrk-00029c-Tq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 08:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091Ab2C0G0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 02:26:44 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:41819 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757068Ab2C0G0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 02:26:43 -0400
Received: (qmail invoked by alias); 27 Mar 2012 06:26:41 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.160.201]
  by mail.gmx.net (mp004) with SMTP; 27 Mar 2012 08:26:41 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX1+KQiYVtJaKSkFfDORHeYsdzrG2OuHd5dAppYwvSL
	y0aWeVdcNFF3hg
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F715CF7.5070903@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194022>

These test cases focus only on testing the parsing of refs on stdin,
without bothering with the rest of the fetch-pack machinery. We pass in
the refs using different combinations of command line and stdin and then
we watch fetch-pack's stdout to see whether it prints all the refs we
specified and in the same order as we specified them.

For the --stateless-rpc tests we cannot easily execute fetch-pack to the
end because that would require simulating the remote protocol. We settle
for only checking 2 cases:

1) Whether fetch-pack correctly fails to parse the refs if they are not
terminated by a flush packet

2) Whether fetch-pack finishes parsing the refs without error when they
are correctly terminated by a flush packet

The fetch-pack invocation fails in both cases due to the missing remote
side of the protocol, but it fails in different ways which allows us to
determine how the refs parsing ended by inspecting the different error
messages.
---
 t/t5500-fetch-pack.sh |  100 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9bf69e9a0f..f4de7d07c1 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -248,4 +248,104 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
 
+
+cat >stdin.exp <<EOF
+refs/heads/C
+refs/heads/A
+refs/heads/D
+refs/tags/C
+refs/heads/B
+refs/tags/A
+refs/heads/E
+refs/tags/B
+refs/tags/E
+refs/tags/D
+EOF
+
+test_expect_success 'setup tests for --stdin' '
+	for head in C D E F; do
+		add $head
+	done &&
+	for head in A B C D E F; do
+		git tag $head $head
+	done
+'
+
+test_expect_success 'fetch refs from cmdline, make sure it still works OK' '
+	cd client &&
+	git fetch-pack --no-progress .. $(cat ../stdin.exp) |
+	cut -d " " -f 2 > ../stdin.act &&
+	cd .. &&
+	test_cmp stdin.exp stdin.act
+'
+
+test_expect_success 'fetch refs from stdin' '
+	cd client &&
+	cat ../stdin.exp |
+	git fetch-pack --stdin --no-progress .. |
+	cut -d " " -f 2 > ../stdin.act &&
+	cd .. &&
+	test_cmp stdin.exp stdin.act
+'
+
+test_expect_success 'fetch mixed refs from cmdline and stdin in right order' '
+	cd client &&
+	tail -n +5 ../stdin.exp |
+	git fetch-pack --stdin --no-progress .. $(head -n 4 ../stdin.exp) |
+	cut -d " " -f 2 > ../stdin.act &&
+	cd .. &&
+	test_cmp stdin.exp stdin.act
+'
+
+
+# remove final newline and insert random spaces, NULs, and empty lines
+head -c -1 stdin.exp | sed -e '
+	1i
+	2s/^\|$/   /g
+	4s/^/    /
+	6s/$/    /
+	8s/$/\n     /
+	9s/$/Ztrailing garbage/
+	9s/^\|$/    /g
+' | tr "Z" "\000" > stdin.spaces
+
+test_expect_success 'ignore leading/trailing spaces, empty lines and NULs' '
+	cd client &&
+	cat ../stdin.spaces |
+	git fetch-pack --stdin --no-progress .. |
+	cut -d " " -f 2 > ../stdin.act &&
+	cd .. &&
+	test_cmp stdin.exp stdin.act
+'
+
+
+packet_write() { printf "%04x%s\n" $((${#1} + 5)) "$1"; }
+packet_flush() { printf "0000"; }
+
+cat stdin.exp | while read ref; do
+	packet_write $ref
+done | tee stdin.pkt.bad |
+(packet_flush; packet_write garbage) > stdin.pkt.good
+
+echo "fatal: protocol error: expected sha/ref, got 'garbage'" > stdin.pkt.good.exp
+echo "fatal: The remote end hung up unexpectedly" > stdin.pkt.bad.exp
+
+test_expect_success 'refs on stdin in packetized format' '
+	cd client &&
+	cat ../stdin.pkt.good |
+	test_must_fail git fetch-pack --stdin --stateless-rpc .. \
+	2> ../stdin.pkt.good.act &&
+	cd .. &&
+	test_cmp stdin.pkt.good.exp stdin.pkt.good.act
+'
+
+test_expect_success 'fail if flush packet is missing' '
+	cd client &&
+	cat ../stdin.pkt.bad |
+	test_must_fail git fetch-pack --stdin --stateless-rpc .. \
+	2> ../stdin.pkt.bad.act &&
+	cd .. &&
+	test_cmp stdin.pkt.bad.exp stdin.pkt.bad.act
+'
+
 test_done
-- 
1.7.9.5.4.g4f508
