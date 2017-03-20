Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B9820958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755264AbdCTQdk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:33:40 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55611 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753245AbdCTQdi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:38 -0400
X-AuditID: 12074411-4d7ff700000005a9-b9-58d0045ef58b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 49.A9.01449.E5400D85; Mon, 20 Mar 2017 12:33:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9A010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/20] Separate `ref_cache` into a separate module
Date:   Mon, 20 Mar 2017 17:33:05 +0100
Message-Id: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqJvAciHCYN0HdouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6Mrxd2shZ8Uaz4tHQyUwPjfukuRk4OCQETiT2b37KB2EICO5gkJq6Q
        6mLkArJPMUm0fnvHApJgE9CVWNTTzARiiwioSUxsO8QCUsQs8IhR4ur8u+xdjBwcwgJOEhu+
        iIDUsAioSpyeNAmsnlfAXGJLTwMjxDJ5iV1tF1knMHItYGRYxSiXmFOaq5ubmJlTnJqsW5yc
        mJeXWqRrqpebWaKXmlK6iRESHII7GGeclDvEKMDBqMTDy3D9fIQQa2JZcWXuIUZJDiYlUd6n
        t4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHirXgLleFMSK6tSi/JhUtIcLErivHxL1P2EBNIT
        S1KzU1MLUotgsjIcHEoSvFf+ATUKFqWmp1akZeaUIKSZODhBhvMADVf/AzK8uCAxtzgzHSJ/
        ilGX41fPsTdMQix5+XmpUuK8F34DFQmAFGWU5sHNgUX1K0ZxoLeEeWt/AVXxABMC3KRXQEuY
        gJYsu3EGZElJIkJKqoFx+l693VOF2257TVNde0vyykxt0RZZT/52GYHcQz4McQf6dTK/Ca1s
        W//m3L3Ak9uY7asqNsne/82l3jUvQE/fc6v31bbWf4uE96+971Id/inl2OrOR00GbfNuLU+6
        HnRGxtHvplP6xJmy8pMkZ65Xu2tw8GnNvWez+ScyPX3rc9hZ/g+vm6eeEktxRqKhFnNRcSIA
        RxOMJcUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had a window of opportunity last week to hack intensely on Git, with
the following goals:

* Separate `ref_cache` out of `files_ref_cache`.

* Separate a new `packed_ref_cache` class out of `files_ref_cache`.
  Change the latter to use an instance of the former for all of its
  interactions with the `packed-refs` file.

* Mmap `packed-refs` files rather than reading-and-parsing.

* Use the mmapped version of the `packed-refs` file as the "cache"
  rather than using a separate `ref_cache`.

* (And the main goal): Avoid reading and parsing the *whole
  `packed-refs` file* (as we do now) every time any part of it is
  needed. Instead, use binary search to find the reference and/or
  range of references that we want, and parse the info out of the
  mmapped image on the fly.

I've completed a draft of an epic 48-patch series implementing all of
the above points on my GitHub fork [1] as branch
`wip/mmap-packed-refs`. It dramatically speeds up performance and
reduces memory usage for some tasks in repositories with very many
packed references.

But the later parts of that series aren't completely polished yet, and
such a large patch series would be indigestible anyway, so here I
submit the first part...

This patch series extracts a `ref_cache` module out of
`files_ref_cache`, and goes some way to disentangling those two
modules, which until now were overly intimate with each other:

* Remove `verify_refname_available()` from the refs VTABLE, instead
  implementing it in a generic way that uses only the usual refs API
  to talk to the `ref_store`.

* Split `ref_cache`-related code into a new module,
  `refs/ref-cache.{c,h}`. Encapsulate the data structure in a new
  class, `struct ref_cache`.

* Change the lazy-filling mechanism of `ref_cache` to call back to its
  backing `ref_store` via a callback function rather than calling
  `read_loose_refs()` directly.

* Move the special handling of `refs/bisect/` from `ref_cache` to
  `files_ref_store`.

* Make `cache_ref_iterator_begin()` smarter, and change external users
  to iterate via this interface instead of using
  `do_for_each_entry_in_dir()`.

Even after this patch series, the modules are still too intimate for
my taste, but I think this is a big step forward, and it is enough to
allow the other changes that I've been working on.

These patches depend on Duy's nd/files-backend-git-dir branch, v6 [2].
They are also available from my GitHub fork [1] as branch
`separate-ref-cache`.

Happily, this patch series actually removes a few more lines than it
adds, mostly thanks to the simpler `verify_refname_available()`
implementation.

Michael

[1] https://github.com/mhagger/git
[2] http://public-inbox.org/git/20170318020337.22767-1-pclouds@gmail.com/

Michael Haggerty (20):
  get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
  refs_read_raw_ref(): new function
  refs_ref_iterator_begin(): new function
  refs_verify_refname_available(): implement once for all backends
  refs_verify_refname_available(): use function in more places
  Rename `add_ref()` to `add_ref_entry()`
  Rename `find_ref()` to `find_ref_entry()`
  Rename `remove_entry()` to `remove_entry_from_dir()`
  refs: split `ref_cache` code into separate files
  ref-cache: introduce a new type, ref_cache
  refs: record the ref_store in ref_cache, not ref_dir
  ref-cache: use a callback function to fill the cache
  refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
  do_for_each_entry_in_dir(): eliminate `offset` argument
  get_loose_ref_dir(): function renamed from get_loose_refs()
  get_loose_ref_cache(): new function
  cache_ref_iterator_begin(): make function smarter
  commit_packed_refs(): use reference iteration
  files_pack_refs(): use reference iteration
  do_for_each_entry_in_dir(): delete function

 Makefile             |    1 +
 refs.c               |  111 ++++-
 refs.h               |    2 +-
 refs/files-backend.c | 1229 +++++++-------------------------------------------
 refs/ref-cache.c     |  523 +++++++++++++++++++++
 refs/ref-cache.h     |  267 +++++++++++
 refs/refs-internal.h |   22 +-
 7 files changed, 1066 insertions(+), 1089 deletions(-)
 create mode 100644 refs/ref-cache.c
 create mode 100644 refs/ref-cache.h

-- 
2.11.0

