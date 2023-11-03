Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C821C6A8
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B221CA
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 09:20:21 -0700 (PDT)
Received: (qmail 20580 invoked by uid 109); 3 Nov 2023 16:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Nov 2023 16:20:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25101 invoked by uid 111); 3 Nov 2023 16:20:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Nov 2023 12:20:21 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Nov 2023 12:20:19 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: [PATCH] t: avoid perl's pack/unpack "Q" specifier
Message-ID: <20231103162019.GB1470570@coredump.intra.peff.net>
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
 <007101da0e65$13e3c170$3bab4450$@nexbridge.com>
 <20231103155220.GA1470570@coredump.intra.peff.net>
 <007c01da0e6f$014e2c30$03ea8490$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <007c01da0e6f$014e2c30$03ea8490$@nexbridge.com>

On Fri, Nov 03, 2023 at 12:01:22PM -0400, rsbecker@nexbridge.com wrote:

> Explains a lot. We are only able to build git in 32-bit mode because
> of OS dependencies (only available in 32-bit). I did not know that
> 64-bit was now required for git. We will get there, but it will
> probably take years.

It's not required for Git. And even on 32-bit systems there is usually
some compiler support for 64-bit types via "uint64_t", etc. And likewise
perl can probably be built for 64-bit types even on a 32-bit system (the
tests do pass on our Linux 32-bit build), but your perl simply wasn't.

I think we can accommodate it, though. Did you try the snippet I showed?

If it behaves as I think it does, then this patch should hopefully fix
things for you:

-- >8 --
Subject: [PATCH] t: avoid perl's pack/unpack "Q" specifier

The perl script introduced by 86b008ee61 (t: add library for munging
chunk-format files, 2023-10-09) uses pack("Q") and unpack("Q") to read
and write 64-bit values ("quadwords" in perl parlance) from the on-disk
chunk files. However, some builds of perl may not support 64-bit
integers at all, and throw an exception here. While some 32-bit
platforms may still support 64-bit integers in perl (such as our linux32
CI environment), others reportedly don't (the NonStop 32-bit builds).

We can work around this by treating the 64-bit values as two 32-bit
values. We can't ever combine them into a single 64-bit value, but in
practice this is OK. These are representing file offsets, and our files
are much smaller than 4GB. So the upper half of the 64-bit value will
always be 0.

We can just introduce a few helper functions which perform the
translation and double-check our assumptions.

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Jeff King <peff@peff.net>
---
If this does work, it should go on top of jk/chunk-bounds.

 t/lib-chunk/corrupt-chunk-file.pl | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/t/lib-chunk/corrupt-chunk-file.pl b/t/lib-chunk/corrupt-chunk-file.pl
index cd6d386fef..b024bbdcb5 100644
--- a/t/lib-chunk/corrupt-chunk-file.pl
+++ b/t/lib-chunk/corrupt-chunk-file.pl
@@ -21,14 +21,38 @@ sub copy {
 	return $buf;
 }
 
+# Some platforms' perl builds don't support 64-bit integers, and hence do not
+# allow packing/unpacking quadwords with "Q". The chunk format uses 64-bit file
+# offsets to support files of any size, but in practice our test suite will
+# only use small files. So we can fake it by asking for two 32-bit values and
+# discarding the first (most significant) one, which is equivalent as long as
+# it's just zero.
+sub unpack_quad {
+	my $bytes = shift;
+	my ($n1, $n2) = unpack("NN", $bytes);
+	die "quad value exceeds 32 bits" if $n1;
+	return $n2;
+};
+sub pack_quad {
+	my $n = shift;
+	my $ret = pack("NN", 0, $n);
+	# double check that our original $n did not exceed the 32-bit limit.
+	# This is presumably impossible on a 32-bit system (which would have
+	# truncated much earlier), but would still alert us on a 64-bit build
+	# of a new test that would fail on a 32-bit build (though we'd
+	# presumably see the die() from unpack_quad() in such a case).
+	die "quad round-trip failed" if unpack_quad($ret) != $n;
+	return $ret;
+}
+
 # read until we find table-of-contents entry for chunk;
 # note that we cheat a bit by assuming 4-byte alignment and
 # that no ToC entry will accidentally look like a header.
 #
 # If we don't find the entry, copy() will hit EOF and exit
 # (which should cause the caller to fail the test).
 while (copy(4) ne $chunk) { }
-my $offset = unpack("Q>", copy(8));
+my $offset = unpack_quad(copy(8));
 
 # In clear mode, our length will change. So figure out
 # the length by comparing to the offset of the next chunk, and
@@ -38,11 +62,11 @@ sub copy {
 	my $id;
 	do {
 		$id = copy(4);
-		my $next = unpack("Q>", get(8));
+		my $next = unpack_quad(get(8));
 		if (!defined $len) {
 			$len = $next - $offset;
 		}
-		print pack("Q>", $next - $len + length($bytes));
+		print pack_quad($next - $len + length($bytes));
 	} while (unpack("N", $id));
 }
 
-- 
2.42.0.1037.g1c5f731f9d

