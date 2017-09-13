Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8501420286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdIMRQY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59495 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751054AbdIMRQX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:23 -0400
X-AuditID: 12074412-1fdff7000000748d-68-59b967e63869
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 00.27.29837.6E769B95; Wed, 13 Sep 2017 13:16:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiO001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/20] Read `packed-refs` using mmap()
Date:   Wed, 13 Sep 2017 19:15:54 +0200
Message-Id: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1H2WvjPS4N8FKYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoErY+POr6wFm9UqPv3ext7AuEi2i5GTQ0LAROLbvHMs
        XYxcHEICO5gkbt/dzA7hnGSSOHj+MSNIFZuArsSinmYmEFtEQE1iYtshsA5mgadMEjtP3mUF
        SQgLmEks3LAWrIhFQFXi6/lOsGZeAXOJ55N62CDWyUuce3CbGSIuKHFy5hOgQRxAg9Ql1s8T
        AgkzA5U0b53NPIGRdxaSqlkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZ
        opeaUrqJERK+QjsY15+UO8QowMGoxMP7wHJnpBBrYllxZe4hRkkOJiVR3r26QCG+pPyUyozE
        4oz4otKc1OJDjBIczEoivEFRQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZ
        GQ4OJQnev2lAjYJFqempFWmZOSUIaSYOTpDhPEDDZ4DU8BYXJOYWZ6ZD5E8x6nJ03Lz7h0mI
        JS8/L1VKnPdvKlCRAEhRRmke3BxY2nnFKA70ljDvMZBRPMCUBTfpFdASJqAlZ07vAFlSkoiQ
        kmpgNFf97bynMEL3YhL7nzLdFRfiPU6E8y5b2C0U8tydSUTlSMjOslqDZVsyH3E6xs162X/3
        flmZm9Wfonf9a7+dyze48VNwbfGrzTsFvHkvTjBUvj7B6TqHz4zKfy8sQ8SjmibdXJDosmRi
        a30FW8yeuzLhwrqhwd4vW57//9nEM8PdeFUar2CvEktxRqKhFnNRcSIA3D9eYxYDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, any time we wanted to read even a single reference from
the `packed-refs` file, we parsed the whole file and stored it in an
elaborate structure in memory called a `ref_cache`. Subsequent
reference lookups or iterations over some or all of the references
could be done by reading from the `ref_cache`.

But for large `packed-refs` files, the time needed to parse the file,
and the memory needed to cache its contents, can be quite significant.
This is partly because building the cache costs lots of little memory
allocations. (And lest you think that most Git commands can be
executed by reading at most a couple of loose references, remember
that almost any command that reads objects has to look for replace
references (unless they are turned off in the config), and *that*
necessarily entails reading packed references.)

Following lots of work to extract the `packed_ref_store` into a
separate module and decouple it from the `files_ref_store`, it is now
possible to fundamentally change how the `packed-refs` file is read.

* `mmap()` the whole file rather than `read()`ing it.

* Instead of parsing the complete file at once into a `ref_cache`,
  parse the references out of the file contents on demand.

* Use a binary search to find, very quickly, the reference or group of
  references that needs to be read. Parse *only* those references out
  of the file contents, without creating in-memory data structures at
  all.

In rare cases this change might force parts of the `packed-refs` file
to be read multiple times, but that cost is far outweighed by the fact
that usually most of the `packed-refs` file doesn't have to be read
*at all*.

Note that the binary search optimization requires the `packed-refs`
file to be sorted by reference name. We have always written them
sorted, but just in case there are clients that don't, we assume the
file is unsorted unless its header lists a `sorted` trait. From now
on, we write the file with that trait. If the file is not sorted, it
is sorted on the fly in memory.

For a repository with only a couple thousand references and a warm
disk cache, this change doesn't make a very significant difference.
But for repositories with very large numbers of references, the
difference start to be significant:

A repository with 54k references (warm cache):

                                  git 2.13.1         this branch
git for-each-ref                      464 ms              452 ms
git for-each-ref (no output)           66 ms               47 ms
git for-each-ref (0.6% of refs)        47 ms                9 ms
git for-each-ref (0.6%, no output)     41 ms                2 ms
git rev-parse                          32 ms                2 ms

A repository (admittedly insane, but a real-life example) with 60M
references (warm cache):

                                  git 2.13.1         this branch
git for-each-ref (no output)        84000 ms            61000 ms
git rev-parse                       40000 ms                2 ms

This branch applies on top of mh/packed-ref-transactions. It can also
be obtained from my git fork [1] as branch `mmap-packed-refs`.

Michael

[1] https://github.com/mhagger/git

Jeff King (1):
  prefix_ref_iterator: break when we leave the prefix

Michael Haggerty (19):
  ref_iterator: keep track of whether the iterator output is ordered
  packed_ref_cache: add a backlink to the associated `packed_ref_store`
  die_unterminated_line(), die_invalid_line(): new functions
  read_packed_refs(): use mmap to read the `packed-refs` file
  read_packed_refs(): only check for a header at the top of the file
  read_packed_refs(): make parsing of the header line more robust
  read_packed_refs(): read references with minimal copying
  packed_ref_cache: remember the file-wide peeling state
  mmapped_ref_iterator: add iterator over a packed-refs file
  mmapped_ref_iterator_advance(): no peeled value for broken refs
  packed_ref_cache: keep the `packed-refs` file open and mmapped
  read_packed_refs(): ensure that references are ordered when read
  packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
  packed_read_raw_ref(): read the reference from the mmapped buffer
  ref_store: implement `refs_peel_ref()` generically
  packed_ref_store: get rid of the `ref_cache` entirely
  ref_cache: remove support for storing peeled values
  mmapped_ref_iterator: inline into `packed_ref_iterator`
  packed-backend.c: rename a bunch of things and update comments

 refs.c                |  22 +-
 refs/files-backend.c  |  54 +--
 refs/iterator.c       |  47 ++-
 refs/packed-backend.c | 896 +++++++++++++++++++++++++++++++++++++-------------
 refs/ref-cache.c      |  44 +--
 refs/ref-cache.h      |  35 +-
 refs/refs-internal.h  |  26 +-
 7 files changed, 761 insertions(+), 363 deletions(-)

-- 
2.14.1

