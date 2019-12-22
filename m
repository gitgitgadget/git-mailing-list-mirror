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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26184C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0550206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="DL0IblaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfLVGs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:26 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36222 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfLVGs0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:26 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 01:48:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997303; bh=Lcp1a0jC7VwJ5F7mywi+KWRj+xYNj7fBMMN1R9qUpVk=;
        h=From:To:Subject:Date:Message-Id:Content-Type;
        b=DL0IblaETIV9sM0uPMgmFirLwX2WkDuWfG2WnurH8P/RUjFi/wuqxDetKsjp/ExIR
         JEJjkYG133RUVyhNXT7HxlJRSiWBxKsAnS4duCJlzUARUj6ZEaOF4OmnzWbIXxlfN3
         CYrg/gm3y69tL9pU8VAh76XswyESXeFzHnsFYjoSQzeGg0mYjr8aC3BprgQp0CIGKm
         pNnqmgt6qkIHYKJWIIZZnygSM8EysOrh0jqFJEQUZ8dgPmeZoPUMtpZ1cz8IKqW6Tw
         zTK765XxI8gQMS1o9Dia0zgdZ+pah+vra78T9pRQHNpTjQwp4Ps36sN+nKr6xKs/v2
         17ofcYJANzLOw==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 5783BD209F7;
        Sun, 22 Dec 2019 06:48:22 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 0/6] Additional SHA implementations
Date:   Sun, 22 Dec 2019 19:48:03 +1300
Message-Id: <20191222064809.35667-1-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Folks,

I have been investigating performance and security of alternative hash
algorithms in git, and while doing so, have added algorithm alternatives
to git to allow testing them out to see how they affect performance.

I have been thinking that it might not be ideal to add lots of algorithm
variants to git so as to reduce potential future incompatibility,
however, that is another discussion. The algorithms need to be added
to test out performance, and this patch series is for anyone interested
in testing out alternative algorithms. While it is necessary to have
mandatory hashes for compatibility, there are potential use-cases where
alternative hashes might be beneficial. There is also the possibility
of N-hash support when implementing compatObjectFormat as outlined in
Git hash function transition [1].

This patch series adds to the generic hash algorithm interface in git
with two new hash algorithms: SHA512 (including SHA512/224, SHA512/256)
and SHA3. The patch also adds SHA224 (truncated SHA256) and add internal
implementations for the two new hashes as well as library wrappers.
THe SHA512 block digest function is derived from the existing SHA256
implementation, modified for 64-bit, as well as the truncated forms.

- moves existing SHA code into sha/ directory
- adds new SHA512 implementation (based on existing SHA256 impl)
- adds new SHA3 implementation (based on NIST submission)
- adds gcrypt library interfaces (`make GCRYPT_SHA512=1 GCRYPT_SHA3=1`)
- adds OpenSSL EVP interfaces (`make OPENSSL_EVP=1`)
- adds test cipher commands to test-tool
- adds test vectors to t/t0015-hash.sh
- adds empty tree and blob hashes using pre-existing scheme

It seems that muliple hash function support would have more utility if
the additional computed hashes were the pure hash of the unpacked
object, instead of compressed and prefixed object data. In any case,
I can see several potential uses for the alternative hash algorithms.

Noticed that the current empty tree and empty blob have the length
prefixes ("blob 0\0" and "tree 0\0") which may or may not be required
with new hashes given that they have length extension resistance?

This series adds almost all known SHA variants so that folk who are
working on abstracting away support for new algos can easily try
alternatives. The algos added by this patch series are not exposed
to the user in any way, and require changes to .hash_algo in cache.h
to enable them, so they should not cause any compatibility issues,
rather just extend the in-tree API.

We could perhaps add options so they are not compiled by default.

This table shows the algorithm type codes after the series is applied:

| algorithm      | type-code | integer-code |
| -------------- | --------- | ------------ |
| "sha1"         | "sha1"    | 0x73686131   |
| "sha224"       | "s224"    | 0x73323234   |
| "sha256"       | "s256"    | 0x73323536   |
| "sha512"       | "s512"    | 0x73353132   |
| "sha512/224"   | "s226"    | 0x73323236   |
| "sha512/256"   | "s228"    | 0x73323238   |
| "sha3-224"     | "s388"    | 0x73323234   |
| "sha3-256"     | "s398"    | 0x73323536   |
| "sha3-384"     | "s3a8"    | 0x73336834   |
| "sha3-512"     | "s3b8"    | 0x73356132   |

I hope you find these patches useful.

Regards,

Michael

[1] https://github.com/git/git/blob/master/Documentation/technical/hash-function-transition.txt

Michael Clark (6):
  Move all SHA algorithm variants into sha/ directory
  Add an implementation of the SHA-512 hash algorithm
  Add an implementation of the SHA-3 hash algorithm
  Add an implementation of the SHA224 truncated hash algorithm
  Add OpenSSL EVP interface for SHA-3 and SHA-512 algorithms
  Add sha/README.md with table of SHA algorithm details

 Makefile                              |  46 +++-
 hash.h                                | 125 ++++++++++-
 sha/README.md                         |  23 ++
 {block-sha1 => sha/sha1}/sha1.c       |   2 +-
 {block-sha1 => sha/sha1}/sha1.h       |   0
 {sha1dc => sha/sha1dc}/.gitattributes |   0
 {sha1dc => sha/sha1dc}/LICENSE.txt    |   0
 {sha1dc => sha/sha1dc}/sha1.c         |   0
 {sha1dc => sha/sha1dc}/sha1.h         |   0
 {sha1dc => sha/sha1dc}/ubc_check.c    |   0
 {sha1dc => sha/sha1dc}/ubc_check.h    |   0
 sha1dc_git.c => sha/sha1dc_git.c      |   0
 sha1dc_git.h => sha/sha1dc_git.h      |   2 +-
 {ppc => sha/sha1ppc}/sha1.c           |   0
 {ppc => sha/sha1ppc}/sha1.h           |   0
 {ppc => sha/sha1ppc}/sha1ppc.S        |   0
 {sha256 => sha/sha256}/gcrypt.h       |  15 +-
 {sha256/block => sha/sha256}/sha256.c |  18 +-
 {sha256/block => sha/sha256}/sha256.h |   9 +
 sha/sha3/gcrypt.h                     |  53 +++++
 sha/sha3/sha3.c                       | 271 ++++++++++++++++++++++
 sha/sha3/sha3.h                       |  34 +++
 sha/sha512/gcrypt.h                   |  43 ++++
 sha/sha512/sha512.c                   | 206 +++++++++++++++++
 sha/sha512/sha512.h                   |  31 +++
 sha/sha_evp/sha_evp.c                 |  99 +++++++++
 sha/sha_evp/sha_evp.h                 |  51 +++++
 sha1-file.c                           | 309 ++++++++++++++++++++++++++
 t/helper/test-sha256.c                |   5 +
 t/helper/test-sha3.c                  |  22 ++
 t/helper/test-sha512.c                |  17 ++
 t/helper/test-tool.c                  |   8 +
 t/helper/test-tool.h                  |   8 +
 t/t0015-hash.sh                       | 214 ++++++++++++++++++
 34 files changed, 1592 insertions(+), 19 deletions(-)
 create mode 100644 sha/README.md
 rename {block-sha1 => sha/sha1}/sha1.c (99%)
 rename {block-sha1 => sha/sha1}/sha1.h (100%)
 rename {sha1dc => sha/sha1dc}/.gitattributes (100%)
 rename {sha1dc => sha/sha1dc}/LICENSE.txt (100%)
 rename {sha1dc => sha/sha1dc}/sha1.c (100%)
 rename {sha1dc => sha/sha1dc}/sha1.h (100%)
 rename {sha1dc => sha/sha1dc}/ubc_check.c (100%)
 rename {sha1dc => sha/sha1dc}/ubc_check.h (100%)
 rename sha1dc_git.c => sha/sha1dc_git.c (100%)
 rename sha1dc_git.h => sha/sha1dc_git.h (95%)
 rename {ppc => sha/sha1ppc}/sha1.c (100%)
 rename {ppc => sha/sha1ppc}/sha1.h (100%)
 rename {ppc => sha/sha1ppc}/sha1ppc.S (100%)
 rename {sha256 => sha/sha256}/gcrypt.h (58%)
 rename {sha256/block => sha/sha256}/sha256.c (93%)
 rename {sha256/block => sha/sha256}/sha256.h (67%)
 create mode 100644 sha/sha3/gcrypt.h
 create mode 100644 sha/sha3/sha3.c
 create mode 100644 sha/sha3/sha3.h
 create mode 100644 sha/sha512/gcrypt.h
 create mode 100644 sha/sha512/sha512.c
 create mode 100644 sha/sha512/sha512.h
 create mode 100644 sha/sha_evp/sha_evp.c
 create mode 100644 sha/sha_evp/sha_evp.h
 create mode 100644 t/helper/test-sha3.c
 create mode 100644 t/helper/test-sha512.c

-- 
2.20.1

