From: roberto.tyley@gmail.com
Subject: [PATCH v2] Tolerate zlib deflation with window size < 32Kb
Date: Sun,  7 Aug 2011 19:46:13 +0100
Message-ID: <1312742773-26373-1-git-send-email-roberto.tyley@gmail.com>
References: <7vhb5x5cgo.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Roberto Tyley <roberto.tyley@guardian.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 20:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq8NE-0007Ri-LY
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 20:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab1HGSql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 14:46:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50922 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab1HGSqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 14:46:40 -0400
Received: by wyg24 with SMTP id 24so370621wyg.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rin0KXY0FqQMeGNJWSqYl5Tz+3Lss36rwgHZd8TWcd8=;
        b=qS2NilZlu0UgvQRubMX/ii5y84/6iTm5Nj8Eiy39xWiynT82avjFvlD7vuoVsrmKhO
         bLsqN0dpBWjV9yMbxHnjXQjPk0TGUjwh8/c7AcO85hoPdbTyfxJ28PJoGl05D6L4U/Ow
         qdS8HtXIuRCCw8G7lpP2diQc+GqGfLeVTccQE=
Received: by 10.217.7.10 with SMTP id z10mr2324122wes.95.1312742798528;
        Sun, 07 Aug 2011 11:46:38 -0700 (PDT)
Received: from localhost.localdomain ([81.31.102.176])
        by mx.google.com with ESMTPS id fe4sm3921574wbb.11.2011.08.07.11.46.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 11:46:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vhb5x5cgo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178923>

From: Roberto Tyley <roberto.tyley@guardian.co.uk>

Git currently reports loose objects as 'corrupt' if they've been
deflated using a window size less than 32Kb, because the
experimental_loose_object() function doesn't recognise the header
byte as a zlib header. This patch makes the function tolerant of
all valid window sizes (15-bit to 8-bit) - but doesn't sacrifice
it's accuracy in distingushing the standard loose-object format
from the experimental (now abandoned) format.

On memory constrained systems zlib may use a much smaller window
size - working on Agit, I found that Android uses a 4KB window;
giving a header byte of 0x48, not 0x78. Consequently all loose
objects generated appear 'corrupt', which is why Agit is a read-only
Git client at this time - I don't want my client to generate Git
repos that other clients treat as broken :(

This patch makes Git tolerant of different deflate settings - it
might appear that it changes experimental_loose_object() to the point
where it could incorrectly identify the experimental format as the
standard one, but the two criteria (bitmask & checksum) can only
give a false result for an experimental object where both of the
following are true:

1) object size is exactly 8 bytes when uncompressed (bitmask)
2) [single-byte in-pack git type&size header] * 256
   + [1st byte of the following zlib header] % 31 = 0 (checksum)

As it happens, for all possible combinations of valid object type
(1-4) and window bits (0-7), the only time when the checksum will be
divisible by 31 is for 0x1838 - ie object type *1*, a Commit - which,
due the fields all Commit objects must contain, could never be as
small as 8 bytes in size.

Given this, the combination of the two criteria (bitmask & checksum)
always correctly determines the buffer format, and is more tolerant
than the previous version.

The alternative to this patch is simply removing support for the
experimental format, which I am also totally cool with.

References:

Android uses a 4KB window for deflation:
http://android.git.kernel.org/?p=platform/libcore.git;a=blob;f=luni/src/main/native/java_util_zip_Deflater.cpp;h=c0b2feff196e63a7b85d97cf9ae5bb2583409c28;hb=refs/heads/gingerbread#l53

Code snippet searching for false positives with the zlib checksum:
https://gist.github.com/1118177

Signed-off-by: Roberto Tyley <roberto.tyley@guardian.co.uk>
---

This updated patch contains the corrected 0x8F bitmask, and also
provides tests to ensure that the experimental & standard format
headers are still correctly identified and parsed.

As Git doesn't generate the old experimental format anymore, the
tests include a set of loose objects in that format created using
Git v1.4.3, as well as two objects generated on the Android platform
using a reduced-size window buffer for deflation.


 sha1_file.c                                        |   32 ++++++++--
 t/t1013-loose-object-format.sh                     |   66 ++++++++++++++++++++
 .../14/9cedb5c46929d18e0f118e9fa31927487af3b6      |  Bin 0 -> 117 bytes
 .../16/56f9233d999f61ef23ef390b9c71d75399f435      |  Bin 0 -> 17 bytes
 .../1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd      |  Bin 0 -> 18 bytes
 .../25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99      |  Bin 0 -> 19 bytes
 .../2e/65efe2a145dda7ee51d1741299f848e5bf752e      |  Bin 0 -> 10 bytes
 .../6b/aee0540ea990d9761a3eb9ab183003a71c3696      |  Bin 0 -> 181 bytes
 .../70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd      |  Bin 0 -> 26 bytes
 .../76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb      |  Bin 0 -> 155 bytes
 .../78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09      |  Bin 0 -> 139 bytes
 .../7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8      |  Bin 0 -> 54 bytes
 .../85/df50785d62d3b05ab03d9cbf7e4a0b49449730      |  Bin 0 -> 13 bytes
 .../8d/4e360d6c70fbd72411991c02a09c442cf7a9fa      |  Bin 0 -> 156 bytes
 .../95/b1625de3ba8b2214d1e0d0591138aea733f64f      |  Bin 0 -> 252 bytes
 .../9a/e9e86b7bd6cb1472d9373702d8249973da0832      |  Bin 0 -> 11 bytes
 .../bd/15045f6ce8ff75747562173640456a394412c8      |  Bin 0 -> 34 bytes
 .../e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391      |  Bin 0 -> 9 bytes
 .../f8/16d5255855ac160652ee5253b06cd8ee14165a      |  Bin 0 -> 116 bytes
 19 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100755 t/t1013-loose-object-format.sh
 create mode 100644 t/t1013/objects/14/9cedb5c46929d18e0f118e9fa31927487af3b6
 create mode 100644 t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d75399f435
 create mode 100644 t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd
 create mode 100644 t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
 create mode 100644 t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5bf752e
 create mode 100644 t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a71c3696
 create mode 100644 t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd
 create mode 100644 t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb
 create mode 100644 t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09
 create mode 100644 t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8
 create mode 100644 t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49449730
 create mode 100644 t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442cf7a9fa
 create mode 100644 t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea733f64f
 create mode 100644 t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973da0832
 create mode 100644 t/t1013/objects/bd/15045f6ce8ff75747562173640456a394412c8
 create mode 100644 t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
 create mode 100644 t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a

diff --git a/sha1_file.c b/sha1_file.c
index d5616dc..44444ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1217,14 +1217,34 @@ static int experimental_loose_object(unsigned char *map)
 	unsigned int word;
 
 	/*
-	 * Is it a zlib-compressed buffer? If so, the first byte
-	 * must be 0x78 (15-bit window size, deflated), and the
-	 * first 16-bit word is evenly divisible by 31. If so,
-	 * we are looking at the official format, not the experimental
-	 * one.
+	 * We must determine if the buffer contains the standard
+	 * zlib-deflated stream or the experimental format based
+	 * on the in-pack object format. Compare the header byte
+	 * for each format:
+	 *
+	 * RFC1950 zlib w/ deflate : 0www1000 : 0 <= www <= 7
+	 * Experimental pack-based : Stttssss : ttt = 1,2,3,4
+	 *
+	 * If bit 7 is clear and bits 0-3 equal 8, the buffer MUST be
+	 * in standard loose-object format, UNLESS it is a Git-pack
+	 * format object *exactly* 8 bytes in size when inflated.
+	 *
+	 * However, RFC1950 also specifies that the 1st 16-bit word
+	 * must be divisible by 31 - this checksum tells us our buffer
+	 * is in the standard format, giving a false positive only if
+	 * the 1st word of the Git-pack format object happens to be
+	 * divisible by 31, ie:
+	 *      ((byte0 * 256) + byte1) % 31 = 0
+	 *   =>        0ttt10000www1000 % 31 = 0
+	 *
+	 * As it happens, this case can only arise for www=3 & ttt=1
+	 * - ie, a Commit object, which would have to be 8 bytes in
+	 * size. As no Commit can be that small, we find that the
+	 * combination of these two criteria (bitmask & checksum)
+	 * can always correctly determine the buffer format.
 	 */
 	word = (map[0] << 8) + map[1];
-	if (map[0] == 0x78 && !(word % 31))
+	if ((map[0] & 0x8F) == 0x08 && !(word % 31))
 		return 0;
 	else
 		return 1;
diff --git a/t/t1013-loose-object-format.sh b/t/t1013-loose-object-format.sh
new file mode 100755
index 0000000..b5ac46d
--- /dev/null
+++ b/t/t1013-loose-object-format.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Roberto Tyley
+#
+
+test_description='Correctly identify and parse loose object headers
+
+There are two file formats for loose objects - the original standard
+format, and the experimental format introduced with Git v1.4.3, later
+deprecated with v1.5.3. Although Git no longer writes the
+experimental format, objects in both formats must be read, with the
+format for a given file being determined by the header.
+
+Detecting file format based on header is not entirely trivial, not
+least because the first byte of a zlib-deflated stream will vary
+depending on how much memory was allocated for the deflation window
+buffer when the object was written out (for example 4KB on Android,
+rather that 32KB on a normal PC).
+
+The loose objects used as test vectors have been generated with the
+following Git versions:
+
+standard format: Git v1.7.4.1
+experimental format: Git v1.4.3 (legacyheaders=false)
+standard format, deflated with 4KB window size: Agit/JGit on Android
+'
+
+. ./test-lib.sh
+
+assert_blob_equals() {
+	echo -n $2 > expected &&
+	git cat-file -p $1 > actual &&
+	test_cmp expected actual
+}
+
+test_expect_success setup '
+	cp -R ../t1013/objects .git/
+	git --version
+'
+
+test_expect_success 'read standard-format loose objects' '
+	git cat-file tag 8d4e360d6c70fbd72411991c02a09c442cf7a9fa &&
+	git cat-file commit 6baee0540ea990d9761a3eb9ab183003a71c3696 &&
+	git ls-tree 7a37b887a73791d12d26c0d3e39568a8fb0fa6e8 &&
+	assert_blob_equals "257cc5642cb1a054f08cc83f2d943e56fd3ebe99" "foo\n"
+'
+
+test_expect_success 'read experimental-format loose objects' '
+	git cat-file tag 76e7fa9941f4d5f97f64fea65a2cba436bc79cbb &&
+	git cat-file commit 7875c6237d3fcdd0ac2f0decc7d3fa6a50b66c09 &&
+	git ls-tree 95b1625de3ba8b2214d1e0d0591138aea733f64f &&
+	assert_blob_equals "2e65efe2a145dda7ee51d1741299f848e5bf752e" "a" &&
+	assert_blob_equals "9ae9e86b7bd6cb1472d9373702d8249973da0832" "ab" &&
+	assert_blob_equals "85df50785d62d3b05ab03d9cbf7e4a0b49449730" "abcd" &&
+	assert_blob_equals "1656f9233d999f61ef23ef390b9c71d75399f435" "abcdefgh" &&
+	assert_blob_equals "1e72a6b2c4a577ab0338860fa9fe87f761fc9bbd" "abcdefghi" &&
+	assert_blob_equals "70e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd" "abcdefghijklmnop" &&
+	assert_blob_equals "bd15045f6ce8ff75747562173640456a394412c8" "abcdefghijklmnopqrstuvwx"
+'
+
+test_expect_success 'read standard-format objects deflated with smaller window buffer' '
+	git cat-file tag f816d5255855ac160652ee5253b06cd8ee14165a &&
+	git cat-file tag 149cedb5c46929d18e0f118e9fa31927487af3b6
+'
+
+test_done
diff --git a/t/t1013/objects/14/9cedb5c46929d18e0f118e9fa31927487af3b6 b/t/t1013/objects/14/9cedb5c46929d18e0f118e9fa31927487af3b6
new file mode 100644
index 0000000000000000000000000000000000000000..472fd1458e03e47136416bce60d6e7c893a468ab
GIT binary patch
literal 117
zcmV-*0E+)ei51K-4#F@DKvCwL!aJ&DH^jjbLR`g3tWwmHs(9h{l<n&c-*p0_eCp+8
z)q#teVY;BH2sX(~8m)*Hx<<sPnQCO=;NQ)l_H~^-`0>zp+xy&xqlfV?lkEVv$I`1V
X&;Ic{P^6Jl5+pbyA%^e+FOeitJb^w>

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d75399f435 b/t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d75399f435
new file mode 100644
index 0000000000000000000000000000000000000000..c379d74ae2b40faae9c31cb7478bc7f42a6fb13c
GIT binary patch
literal 17
YcmcDhnB(o^<>%?^eV&1VkAYbg05K>8VgLXD

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd b/t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd
new file mode 100644
index 0000000000000000000000000000000000000000..93706305bcff060547181ee4b7d3a8583b691181
GIT binary patch
literal 18
ZcmcDlnB(o^<>%?^ef|UsgJ2(X9{@cS1}Ojl

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99 b/t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
new file mode 100644
index 0000000000000000000000000000000000000000..bdcf704c9e663f3a11b3146b1b455bc2581b4761
GIT binary patch
literal 19
acmb<m^geacKgb}_<MjFGObnu-%uWDJxd#LQ

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5bf752e b/t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5bf752e
new file mode 100644
index 0000000000000000000000000000000000000000..ad62c43e418c11254cede4dc94982ac6a30dbe9c
GIT binary patch
literal 10
RcmXr4nB&dDz>vg{1ON`X0$Bh6

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a71c3696 b/t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a71c3696
new file mode 100644
index 0000000000000000000000000000000000000000..3d2f0337dbb64c092b4a7e9bd324a66986cfe01a
GIT binary patch
literal 181
zcmV;m080OO0i}>jY6CG41+&&EdLIz_c+?s&#*jt!#uw=6?r{d&BO_}9zP*3BL6-Fv
zMe(?t&r^etx{p>>0V(2;GZIGZz4#y@v6HB=?^32b4sN8R*<7gV+yFCnoI*s2Ba1lV
zFgj7@=Rk=%H>8K4H?*{$QejsHt*yZRcG4TH>l<x*;`Xpmm5FA{#V*GU_~=6l7@~(y
j=bbbBs%`pTkNNr&2`txXKEU_mgI{mauB<nAL=six5bRpF

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd b/t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd
new file mode 100644
index 0000000000000000000000000000000000000000..b3f71a6ee5802b36b4576c5ebf111f30ef2017a4
GIT binary patch
literal 26
icmdnMSTV=j$IH*t*Zcg5GpEj-JbPN7fx*mytrGyBA`4~!

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb b/t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb
new file mode 100644
index 0000000000000000000000000000000000000000..af4e9a7b0c035fc7c26355b85f250f3ff7d3afa1
GIT binary patch
literal 155
zcmV;M0A&Bd3wWF*%s~!<Fc3h|eNQoaV^dlvm>A>Ez2O4GbZDxSl3I-1-k{6>7C#LS
zrUGr(He|JFof*kFg``L2m}m#I*r>r;QYTTig@ICxp@@PW__J^hk>`TbaZEYl&pl_j
zr-5@x&~FoOaL)gfWzVZ$F}r}Xq$Jnp1u9c%tLsj8a8Q*}LiGE^!TJibhg&G{u4FBZ
J_yWO9IpM14O;`W`

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09 b/t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09
new file mode 100644
index 0000000000000000000000000000000000000000..3dd28be5c61840c23486bc654213c493c5387d75
GIT binary patch
literal 139
zcmV;60CfM64S1ZT%u5QwFc1LHeNHiZA!PEi1rc|y+=v&LG*cUF4TP!E+lzPvmv8f=
zF+(2`MjJA_L|w8LeMUCfgdWj##I$#AjDA$K%2XR%YvLvqZrjWo9NLdszC7JmYPrx;
t4^^*^BcMYYt&hRN&Y&@BsLN7B_}@oeC^Ni^OmHp&FVtQ;^#LMbK`4x{Jre)`

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8 b/t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8
new file mode 100644
index 0000000000000000000000000000000000000000..2b97b264c33f78fe6c8230b5bbeacd6409d9f963
GIT binary patch
literal 54
zcmV-60LlM&0V^p=O;s>9XD~D{Ff%bx2yqP#(RK6mab-}gIhvxgaY4w3o)h-EQ|!Y2
M+U=VO05jJR92g)Lz5oCK

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49449730 b/t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49449730
new file mode 100644
index 0000000000000000000000000000000000000000..6dff746876aab1acb9b42c557cdda69164d68398
GIT binary patch
literal 13
UcmXr1nB(o^<;Tdte1owY030|2-~a#s

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442cf7a9fa b/t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442cf7a9fa
new file mode 100644
index 0000000000000000000000000000000000000000..cb41e92d076c191245389bedfc0184ff78511c03
GIT binary patch
literal 156
zcmV;N0Av4n0VRw<3c@fD06pgwdly5tsfhs*Z{DRJ*tBb?+D6i?(BE72I0G|63DCPu
zj(2VaTqI_*uMJZOrVHL7S&o4s9;`8zJhs*ar(}6Cw0RhMQL;WJp|PXV?QXdY^mB;|
zTyx|i8JgwE3mnTIwS4iM<~8VP)NR)D;{<52a+SALfUQAelxip??qHt!F~Ox5c%$~Z
K)~G%MG&zg-a!8y2

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea733f64f b/t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea733f64f
new file mode 100644
index 0000000000000000000000000000000000000000..7ac46b4f703aa00cd96c42971a237e3da5bbb5ca
GIT binary patch
literal 252
zcmV<Y00aN25_p_5G%zqTF;Pg(OwTCME2$`95DWXMY&&y);(O)ymfUj+uLsZkVrmFc
zl$Kvw1Xj~}KcFHu>GFoC4YqUk*LiV!x=c5Ks>#dDO9iWuD_XYc$kOuF%oc6@EC02B
zPy91`FH}uFREb{d`$r31?=F8Ac(Fui<`0jj`%CqpN{TZpN>Wqvz{(1qt+4Gqt@fw;
z!1)3_-Fw^Co|5<rRaR1-npaY(3wPLFQI`0e7ynC3N|VIR99*+3U4%}+mF9z$%zF7E
zyZYK`k)oUC=1ezKW)|P#FoG(nN-ct@c{caa>`fQ1IeT|&t}Bnaap*};@I(N)b$dQ6
C6@X{}

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973da0832 b/t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973da0832
new file mode 100644
index 0000000000000000000000000000000000000000..9d8316d4e598e32ef17b3918cf00276c8c1bffba
GIT binary patch
literal 11
ScmXr2nB(ok#K5S=a0CDn4+6^o

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/bd/15045f6ce8ff75747562173640456a394412c8 b/t/t1013/objects/bd/15045f6ce8ff75747562173640456a394412c8
new file mode 100644
index 0000000000000000000000000000000000000000..eebf23956e3b8ac736fa04e682b4214ac75c716a
GIT binary patch
literal 34
qcmdnNSTV=j$IH*t*Zcg5GpEj-JbPMSLq|(bQ&)RE14GpTE?oczGYz%?

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 b/t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
new file mode 100644
index 0000000000000000000000000000000000000000..134cf1937963c733d7affa6919f9835db864188a
GIT binary patch
literal 9
OcmXr0n8VBf1dIR)&;dyR

literal 0
HcmV?d00001

diff --git a/t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a b/t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a
new file mode 100644
index 0000000000000000000000000000000000000000..26b75aec56f8f178a9f001be3b630a4e48ceb6b9
GIT binary patch
literal 116
zcmV-)0E_=fi51Mj4uUWYfML&jirx)LyJa0F#`r3w9f$!(uovH6xc&JKzsm$f<<f?C
zRfp1-tQ=FZG^!bj#u2Tmo**n42WG`v@ZVNJ+q%vk{CLR6_BLC0bVsL5bqBaVm!`73
W+SeaIi6Uq0dxk3#VhDeEz9mhO%Qr3n

literal 0
HcmV?d00001

-- 
1.7.4.1
