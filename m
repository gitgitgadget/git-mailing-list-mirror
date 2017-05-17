Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0546201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdEQMF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:05:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55891 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbdEQMF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:05:57 -0400
X-AuditID: 12074412-a4fff70000003a21-ae-591c3ca3016f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A9.97.14881.3AC3C195; Wed, 17 May 2017 08:05:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfp000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:05:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/23] Prepare to separate out a packed_ref_store
Date:   Wed, 17 May 2017 14:05:23 +0200
Message-Id: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqLvERibSYO45Jou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG7C/nGQuualY8uLCMrYHxpUIXIyeHhICJ
        xLauNexdjFwcQgI7mCTO/+5kgnBOMElMbHzKDFLFJqArsainmQnEFhFQk5jYdogFpIhZ4DGT
        xN9l3SwgCWEBR4meFZ/AbBYBVYml5yeygti8AuYSdw+eYoVYJy+xq+0i6wRGrgWMDKsY5RJz
        SnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQoJHaAfj+pNyhxgFOBiVeHgncElHCrEm
        lhVX5h5ilORgUhLl3f8AKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE96apTKQQb0piZVVqUT5M
        SpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IEryQwSoQEi1LTUyvSMnNKENJMHJwgw3mA
        hhuD1PAWFyTmFmemQ+RPMSpKifMesAZKCIAkMkrz4Hph0f2KURzoFWFeM5AqHmBigOt+BTSY
        CWhwM8hHvMUliQgpqQZGI9df54xaH8/idwr1WdSYuWpj9cafk604bXJXnKlasH/f9y7mVt3U
        yrPrMq50+TxmiLpbt9xz773lt06f1fm6bMerzUbJmloZ6V2rfr0K2iy99NV0i13Or0LmrV3d
        s+Kz4+kNEqsWWV50ZVeN+mO3KXtv06b9zJ//p1Ys2HD+fn01T5HM713sNUosxRmJhlrMRcWJ
        ABqi5avJAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the next leg on a journey towards reading
`packed-refs` using `mmap()`, the most interesting aspect of which is
that we will often be able to avoid having to read the whole
`packed-refs` file if we only need a subset of references.

The first leg of the journey was separating out the reference cache
into a separate module [1]. That branch is already merged to master.

This patch series prepares the ground for separating out a
`packed_ref_store`, but doesn't yet take that step. (As you can see,
it's a long enough patch series already!) It's kind of a grab bag of
cleanup patches plus work to decouple the packed-refs handling code
from the rest of `files_ref_store`. Some highlights:

* Patch 07/23 adds a log message parameter to `refs_delete_refs()` and
  `delete_refs()`, for consistency with other reference-changing
  operations. Even though `files_ref_store` is incapable of storing
  reflogs for deleted references, that is no reason that the API
  shouldn't admit the possibility for future backends.

* Patch 12/23 breaks `ref_transaction_commit()` into multiple
  functions:

  * `ref_transaction_prepare()`: do pre-checks, obtain locks, etc.; do
    everything possible to make sure that the reference update will be
    successful.

  * `ref_transaction_finish()`: actually commit a prepared
    transaction.

  * `ref_transaction_abort()`: abort a prepared transaction.

  This separation will be useful for supporting a "compound" reference
  store composed of multiple reference stores that work together
  (i.e., one for loose refs and one for packed refs).

* Patch 17/23 changes `get_packed_ref_cache()` to skip `lstat()`ing
  the packed-refs file (to check its freshness) if we already have it
  locked.

* Patch 19/23 fixes the error handling in `read_packed_refs()`: if
  `fopen()` fails due to `ENOENT`, then there are no packed refs. But
  if it fails for another reason, that is a problem that should be
  reported to the user.

* Patch 22/23 (by Peff) changes ref-filter to attempt to limit the
  reference traversal to a prefix, if there is a single
  `match_as_path` pattern that starts with non-glob characters. This
  limits the number of loose references that need to be read when
  processing a command like `git for-each-ref refs/heads/`.

* Patch 23/23 makes `cache_ref_iterator` smarter about avoiding
  "priming" directories of loose references that won't be needed,
  further reducing the number of loose references that need to be read
  in some cases of iterating over references.

These changes are also available as branch `packed-ref-store-prep` in
my GitHub fork [2]. If you'd like to see a preview of the rest of the
changes (which works but is not yet polished), checkout the
`mmap-packed-refs` branch from the same place.

Michael

[1] http://public-inbox.org/git/cover.1490026594.git.mhagger@alum.mit.edu/
    http://public-inbox.org/git/cover.1490966385.git.mhagger@alum.mit.edu/
    http://public-inbox.org/git/cover.1492323985.git.mhagger@alum.mit.edu/

[2] https://github.com/mhagger/git

Jeff King (1):
  ref-filter: limit traversal to prefix

Michael Haggerty (22):
  t3600: clean up permissions test properly
  refs.h: clarify docstring for the ref_transaction_update()-related fns
  ref_iterator_begin_fn(): fix docstring
  prefix_ref_iterator: don't trim too much
  refs_ref_iterator_begin(): don't check prefixes redundantly
  refs: use `size_t` indexes when iterating over ref transaction updates
  ref_store: take `logmsg` parameter when deleting references
  lockfile: add a new method, is_lock_file_locked()
  files-backend: move `lock` member to `files_ref_store`
  files_ref_store: put the packed files lock directly in this struct
  files_transaction_cleanup(): new helper function
  ref_transaction_commit(): break into multiple functions
  ref_update_reject_duplicates(): expose function to whole refs module
  ref_update_reject_duplicates(): use `size_t` rather than `int`
  ref_update_reject_duplicates(): add a sanity check
  should_pack_ref(): new function, extracted from `files_pack_refs()`
  get_packed_ref_cache(): assume "packed-refs" won't change while locked
  read_packed_refs(): do more of the work of reading packed refs
  read_packed_refs(): report unexpected fopen() failures
  refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
  create_ref_entry(): remove `check_name` option
  cache_ref_iterator_begin(): avoid priming unneeded directories

 builtin/fetch.c                |   2 +-
 builtin/remote.c               |   4 +-
 lockfile.h                     |   8 ++
 ref-filter.c                   |  62 ++++++++-
 refs.c                         |  83 ++++++++++--
 refs.h                         |  62 ++++++++-
 refs/files-backend.c           | 300 +++++++++++++++++++++++++----------------
 refs/iterator.c                |  14 +-
 refs/ref-cache.c               |  99 +++++++++++---
 refs/ref-cache.h               |   6 +-
 refs/refs-internal.h           |  56 ++++++--
 t/helper/test-ref-store.c      |   3 +-
 t/t1405-main-ref-store.sh      |   2 +-
 t/t1406-submodule-ref-store.sh |   2 +-
 t/t3600-rm.sh                  |   4 +-
 15 files changed, 538 insertions(+), 169 deletions(-)

-- 
2.11.0

