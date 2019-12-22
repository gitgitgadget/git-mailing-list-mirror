Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B6AC2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA8206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="hRdiEIaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLVGs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:57 -0500
Received: from mr85p00im-hyfv06011301.me.com ([17.58.23.184]:52889 "EHLO
        mr85p00im-hyfv06011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbfLVGs4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576996926; bh=gYcGtWiyG1OlZs6qndsYUH6XyMm30CXCphAqn03aBE4=;
        h=From:To:Subject:Date:Message-Id:Content-Type;
        b=hRdiEIaWrS/woZdZxtNfain4NgPNPTi/4xE2qONRxMqDRibu7K3PxJCaZ4gC5yL1U
         zv3VHwkMdZsT3bUNo2dp9wMRIqBfdjnxAHl4uIbMp5LtTvsU8j1crM+FDB9bRQ+H6Z
         c8jxwlV/bMx2+zUVhcnr4Y2hVoQRS5+moHINhXzZjJWM2bHtU4EufbA2f5bwYYrfDV
         dSsR93ggUMS+xwv7+B64DHRxt/u53cFlNkY+5DO99ZqlIQMLGReA4e9BUa8rH+Fh6c
         B5R3HFDVehQMlKBdHLo2f7HPeRlrndR8pbWBG9jvNsNEMsWSs+/x72w5/muayOVRlv
         jGhuLEfYKhp1Q==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011301.me.com (Postfix) with ESMTPSA id 83486580C2B;
        Sun, 22 Dec 2019 06:42:05 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: NewHash alternatives and SHA benchmarks
Date:   Sun, 22 Dec 2019 19:41:33 +1300
Message-Id: <20191222064133.35276-1-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Folks,

I have become interested in git's NewHash migration and have been
investigating alternate hash algorithm support in git. It seems
that implementation of NewHash is still a way off, and it is still
possible to revise the choice of SHA256 for a better alternative.

Many of you may already be aware of Hash content Length extension
attacks [1]. While I am not aware of any git vulnerabilities based
on length extension; it seems to me that choosing a hash algorithm
that is not vulnerable to this attack could prevent a future exploit
based on some future protocol or other bug. git hashes should be final
in its usage, so length extension resistance is a good property.

SHA3 is not vulnerable to content length extension because it uses a
sponge construction internally, meaning state is diffused away, and
the state cannot be reconstructed from a hash value. Truncated SHA2
hashes such as SHA224 and SHA512/256 are also not vulnerable to
length extension, however, SHA224 only reduces the probability
of extension by 1/2^32 which, while not trivial, is a small reduction.

SHA512/256 or SHA3-256 seems to me to be most attractive for safety
against content length extension.

With this in mind, I decided to investigate performance properties of
the alternative SHA hash algorithms. Of particular interest to me is
SHA3-256 and SHA512/256 (SHA512 truncated to 256-bits) as they are both
the same size as SHA256 thus are good NewHash contenders.

I was quite surprised by the benchmark results with SHA512/256 1.5X
faster than SHA256. SHA512/256 seems a very good alternative to SHA256:

- SHA256 8 x 32-bit state (256-bits) and 64-byte block, 64 rounds
- SHA512 8 x 64-bit state (512-bits) and 128-byte block, 80 rounds

SHA512/256 has understandable good performance on 64-bits systems due
to having only slightly more iterations (80 instead of 64) while
processing 128 bytes per block instead of 64. In practice, this means
SHA512/256 is about 1.5X faster than SHA256 on 64-bit systems.

SHA3, while competitive, is still significantly slower than SHA512.
The AVX512 version of SHA3 is actually faster than SHA256. SHA256 is
not the best performing NewHash alternative by a long shot.

SHA Benchmarks on Intel Core i7-7980XE @ 4.6GHz
===============================================

(MiB/sec)\      ext      16     128    1024    4096   65536 1048576
     -----    -----   -----   -----   -----   -----   -----   -----
      sha1     avx2    37.5   239.6   817.0  1097.5  1231.2  1244.8
    sha224     avx2    30.8   170.5   439.3   524.3   560.2   564.4
    sha256     avx2    31.2   171.2   438.7   525.0   560.9   564.8
    sha512     avx2    27.1   167.2   561.5   747.1   835.7   842.8
sha512-224     avx2    26.8   164.7   558.8   747.9   836.5   845.1
sha512-256     avx2    26.6   163.9   557.9   751.4   835.0   843.0
  sha3-224     avx2    38.9   313.8   411.5   474.6   491.1   490.7
  sha3-256     avx2    39.7   317.3   414.5   445.3   464.9   464.3
  sha3-384     avx2    39.8   184.6   338.1   348.4   356.5   358.0
  sha3-512     avx2    40.0   185.0   228.4   245.9   248.0   249.0

(MiB/sec)\      ext      16     128    1024    4096   65536 1048576
     -----    -----   -----   -----   -----   -----   -----   -----
  sha3-224   avx512    24.3   192.6   506.5   674.3   736.8   740.9
  sha3-256   avx512    25.0   198.4   511.5   635.4   698.8   698.8
  sha3-384   avx512    24.8   152.3   429.6   503.9   535.7   540.2
  sha3-512   avx512    24.8   152.4   307.3   361.2   375.6   374.4

Recommendations
===============

After performing multiple benchmarks and thinking about this for
several weeks I have come to the conclusion that SHA512/256 is a
very good alternative to SHA256, both from the perspective of its
length extension resistance, and performance. It seems that NewHash
implementation is some way off so it is not too late to change.

- Consider SHA512/256 for NewHash

SHA algorithm patches
=====================

I will be sending a patch series which adds SHA Algorithms which
are in the sha-algorithms branch of my git tree.

- https://github.com/michaeljclark/git.git
- https://github.com/michaeljclark/git/tree/sha-algorithms/sha

This is a precursor to asking some questions about the proposed
implementation of multiple or compat hashs (N-hash or 2-hash?).
I am curious about the pack format and directory structure for
loose objects. It seems there needs to be a single hash chosen
for loose object filenames, and auxilliary hashes will need
hash to hash map to go from a compat hash to new hash.

I have been reading the code, and it seems like it is going to be
a challenge to change to support more than one hash concurrently.
My observation is the content addressable storage layer could do
with being a little more abstract, as there seems to be a lot of
code that seperately computes hashes by accessing the hash algorithms
directly versus going through an abstract content-addressable storage
layer, like the VFS in Linux.

In any case, I hope you find this benchmark data useful.

Regards,

Michael

[1] https://en.wikipedia.org/wiki/Length_extension_attack
