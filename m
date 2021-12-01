Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2368C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbhLAAcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:32:32 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:57497 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhLAAcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:32:32 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id sDUkmByoui2JdsDUkmSxRz; Wed, 01 Dec 2021 00:29:10 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=f5U2+96M c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=RAVPTI3A8MLRkWd0RqsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 0/3] Fix LLP64 `(size_t)1` compatibility VS C4334 warnings
Date:   Wed,  1 Dec 2021 00:28:59 +0000
Message-Id: <20211201002902.1042-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEaCEXODdAkI0kcc5LNC2z/QWVLDuuX2vKgCILN0bpd0MtlMpmt1ePqWrWG+NjNbNCln/+xCfGJJ3Xcb6Yh2QYSN4a0MH/oJDai/j7Ghf/+H2tClhHU0
 PeZOc8LIiwzxI+0udrIZQwNLknA56N8On/mJ+B4WRKyMrMZcAKc5YfCm92OsQcNAkpNPJAD0JFLlY9YtCSt7RDFsNE/JkHWEupkiCdWoqelJ6Ru3UQVs0rKT
 hBAsLWD5DjPJ5cb+z+NsmgGurACLl3h6f9zG+0lwM5asGQMfB+tfF0+dk2HwksJ96pIl0ssAytwey5/mfvIkwF6oWQo4b45BJUJZTDhcNPOM9W32AQGPs5Ys
 j9DMMfer
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since V1 (gitster/po/size-t-for-vs)
https://lore.kernel.org/git/20211126113614.709-1-philipoakley@iee.email/

Former patch 1/4 was dropped as it was already in Junio's tree.

Patch 1/3 corrects my spelling mistake.

Patch 2/3 has added extra spacing around the << operator as suggested by
Stollee[1].

Patch 3/3 removes the superceded commit message comment regarding
backporting the patch onto maint.

The Visual Studio MSVC compilation reports a number of C4334 "was 64-bit
shift intended" size mismatch warnings. In most of these cases a size_t
is ANDed (masked) with a bit shift of 1, or 1U. On LLP64 systems the unity
value is 32 bits, while size_t is 64 bits. 

The fix is to upcast the unity value to size_t.   

The first [dropped] patch had been reported [2] by René Scharfe as an extra patch
to the rs/mergesort series.

These fixes clear all the current C4334 warnings.

[1] https://lore.kernel.org/git/?q=%3Cf721bc99-6d79-e2f2-7810-dd77b777161f%40gmail.com%3E
[2] https://lore.kernel.org/git/7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email/

Philip Oakley (3):
  repack.c: LLP64 compatibility, upcast unity for left shift
  diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
  object-file.c: LLP64 compatibility, upcast unity for left shift

 builtin/repack.c | 2 +-
 diffcore-delta.c | 6 +++---
 object-file.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  c00e082ed8 < -:  ---------- mergesort.c: LLP64 compatibility, upcast unity for left shift
2:  85506c7e77 ! 1:  13d9b3fd6d repack.c: LLP64 compatibility, upcast unity for left shift
    @@ Commit message
         repack.c: LLP64 compatibility, upcast unity for left shift
     
         Visual Studio reports C4334 "was 64-bit shift intended" warning
    -    because of size miss-match.
    +    because of size mismatch.
     
         Promote unity to the matching type to fit with the `&` operator.
     
3:  2072852f61 ! 2:  b6c7ad9177 diffcore-delta.c: LLP64 compatibility, upcast unity for left shift
    @@ diffcore-delta.c: static struct spanhash_top *hash_chars(struct repository *r,
      	i = INITIAL_HASH_SIZE;
      	hash = xmalloc(st_add(sizeof(*hash),
     -			      st_mult(sizeof(struct spanhash), 1<<i)));
    -+			      st_mult(sizeof(struct spanhash), (size_t)1<<i)));
    ++			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
      	hash->alloc_log2 = i;
      	hash->free = INITIAL_FREE(i);
     -	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
4:  3b8f33fb28 ! 3:  0fa0d0a8c6 object-file.c: LLP64 compatibility, upcast unity for left shift
    @@ Commit message
     
         Signed-off-by: Philip Oakley <philipoakley@iee.email>
     
    -    ---
    -
    -    This cannot be applied to the maint-2.32 branch as the earlier René Scharfe
    -    patch had been, because the original sha1-file.c, to which the backport
    -    would apply, has been renamed in e5afd4449d (object-file.c: rename
    -    from sha1-file.c, 2020-12-31) which was merged in 8b327f1784
    -    (Merge branch 'ma/sha1-is-a-hash', 2021-01-15)
    -
      ## object-file.c ##
     @@ object-file.c: struct oidtree *odb_loose_cache(struct object_directory *odb,
      	struct strbuf buf = STRBUF_INIT;
-- 
2.34.0.rc1.windows.1.4.ga126985b17

