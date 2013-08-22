From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] add tests for indexing packs with delta cycles
Date: Thu, 22 Aug 2013 19:14:40 -0400
Message-ID: <20130822231440.GC17060@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCe5X-0000tK-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab3HVXOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:14:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:60022 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab3HVXOn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:14:43 -0400
Received: (qmail 23940 invoked by uid 102); 22 Aug 2013 23:14:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Aug 2013 18:14:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Aug 2013 19:14:40 -0400
Content-Disposition: inline
In-Reply-To: <20130822231215.GA16978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232789>

If we receive a broken or malicious pack from a remote, we
will feed it to index-pack. As index-pack processes the
objects as a stream, reconstructing and hashing each object
to get its name, it is not very susceptible to doing the
wrong with bad data (it simply notices that the data is
bogus and aborts).

However, one question raised on the list is whether it could
be susceptible to problems during the delta-resolution
phase. In particular, can a cycle in the packfile deltas
cause us to go into an infinite loop or cause any other
problem?

The answer is no.

We cannot have a cycle of delta-base offsets, because they
go only in one direction (the OFS_DELTA object mentions its
base by an offset towards the beginning of the file, and we
explicitly reject negative offsets).

We can have a cycle of REF_DELTA objects, which refer to
base objects by sha1 name. However, index-pack does not know
these sha1 names ahead of time; it has to reconstruct the
objects to get their names, and it cannot do so if there is
a delta cycle (in other words, it does not even realize
there is a cycle, but only that there are items that cannot
be resolved).

Even though we can reason out that index-pack should handle
this fine, let's add a few tests to make sure it behaves
correctly.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-pack.sh                | 22 +++++++++++++++++
 t/t5309-pack-delta-cycles.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100755 t/t5309-pack-delta-cycles.sh

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index 61c5d19..e028c40 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -55,6 +55,28 @@ pack_obj() {
 			printf '\062\170\234\143\267\3\0\0\116\0\106'
 			return
 			;;
+		01d7713666f4de822776c7622c10f1b07de280dc)
+			printf '\165\1\327\161\66\146\364\336\202\47\166' &&
+			printf '\307\142\54\20\361\260\175\342\200\334\170' &&
+			printf '\234\143\142\142\142\267\003\0\0\151\0\114'
+			return
+			;;
+		esac
+		;;
+
+	# blob containing "\7\0"
+	01d7713666f4de822776c7622c10f1b07de280dc)
+		case "$2" in
+		'')
+			printf '\062\170\234\143\147\0\0\0\20\0\10'
+			return
+			;;
+		e68fe8129b546b101aee9510c5328e7f21ca1d18)
+			printf '\165\346\217\350\22\233\124\153\20\32\356' &&
+			printf '\225\20\305\62\216\177\41\312\35\30\170\234' &&
+			printf '\143\142\142\142\147\0\0\0\53\0\16'
+			return
+			;;
 		esac
 		;;
 	esac
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
new file mode 100755
index 0000000..9b3f2c3
--- /dev/null
+++ b/t/t5309-pack-delta-cycles.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='test index-pack handling of delta cycles in packfiles'
+. ./test-lib.sh
+. ../lib-pack.sh
+
+# Two similar-ish objects that we have computed deltas between.
+A=01d7713666f4de822776c7622c10f1b07de280dc
+B=e68fe8129b546b101aee9510c5328e7f21ca1d18
+
+# double-check our hand-constucted packs
+test_expect_success 'index-pack works with a single delta (A->B)' '
+	clear_packs &&
+	{
+		pack_header 2 &&
+		pack_obj $A $B &&
+		pack_obj $B
+	} >ab.pack &&
+	pack_trailer ab.pack &&
+	git index-pack --stdin <ab.pack &&
+	git cat-file -t $A &&
+	git cat-file -t $B
+'
+
+test_expect_success 'index-pack works with a single delta (B->A)' '
+	clear_packs &&
+	{
+		pack_header 2 &&
+		pack_obj $A &&
+		pack_obj $B $A
+	} >ba.pack &&
+	pack_trailer ba.pack &&
+	git index-pack --stdin <ba.pack &&
+	git cat-file -t $A &&
+	git cat-file -t $B
+'
+
+test_expect_success 'index-pack detects missing base objects' '
+	clear_packs &&
+	{
+		pack_header 1 &&
+		pack_obj $A $B
+	} >missing.pack &&
+	pack_trailer missing.pack &&
+	test_must_fail git index-pack --fix-thin --stdin <missing.pack
+'
+
+test_expect_success 'index-pack detects REF_DELTA cycles' '
+	clear_packs &&
+	{
+		pack_header 2 &&
+		pack_obj $A $B &&
+		pack_obj $B $A
+	} >cycle.pack &&
+	pack_trailer cycle.pack &&
+	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
+'
+
+test_done
-- 
1.8.4.rc2.28.g6bb5f3f
