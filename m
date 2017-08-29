Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C7E20285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdH2IUq (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:20:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51553 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbdH2IUn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:43 -0400
X-AuditID: 12074411-f7dff70000007f0a-ae-59a523dafe44
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id AD.C9.32522.AD325A95; Tue, 29 Aug 2017 04:20:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcRs002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/10] Implement transactions for the packed ref store
Date:   Tue, 29 Aug 2017 10:20:24 +0200
Message-Id: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqHtLeWmkwcRbPBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxroLs9gLditWPD8xka2BsUG6i5GTQ0LAROJmaztj
        FyMXh5DADiaJG6uPMkM4J5kkvm5ZxQhSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        uxg5OIQF3CS2Xs4EqWERUJW427eLHcTmFTCX6O+9wA6xTV7i3IPbzBMYuRYwMqxilEvMKc3V
        zU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAkYwR2MM07KHWIU4GBU4uFdab0kUog1say4
        MvcQoyQHk5Iob4bC0kghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzB7EA53pTEyqrUonyYlDQH
        i5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IELxcwMoQEi1LTUyvSMnNKENJMHJwgw3mAhjuB
        1PAWFyTmFmemQ+RPMSpKifNOUARKCIAkMkrz4HphEf2KURzoFWFeX5B2HmAygOt+BTSYCWiw
        ouBCkMEliQgpqQbGiacv7k0RULGJPHn3rmZn1PEbSWH2U0PYgp5/iOM+YWipd6tYJrhu9+Ip
        7iF5rm+dGruyl0WynNs5R7b4qukbu/kXfJV7C4yiJB5ueGFkX8KXtsI0IKQ5/onkBonW0wuN
        xW4wfXNT3FyXfjhdksXw0UXZuRONmfoTQ9U4p/7dHcy9/PyrO9ZKLMUZiYZazEXFiQDsue3I
        wwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This should be the second-to-last patch series in the quest for
mmapped packed-refs.

Before this patch series, there is still more coupling than necessary
between `files_ref_store` and `packed_ref_store`:

* `files_ref_store` adds packed references (e.g., during `git clone`
  and `git pack-refs`) by inserting them into the `packed_ref_store`'s
  internal `ref_cache`, then calling `commit_packed_refs()`. But
  `files_ref_store` shouldn't even *know* that `packed_ref_store` uses
  a `ref_cache`, let alone muck about in it.

* `files_ref_store` deletes packed references by calling
  `repack_without_refs()`.

Instead, implement reference transactions and `delete_refs()` for
`packed_ref_store`, and change `files_ref_store` to use these standard
methods rather than internal `packed_ref_store` methods.

This patch series finishes up the encapsulation of `packed_ref_store`.
At the end of the series, the outside world only interacts with it via
the refs API plus a couple of locking-related functions. That will
make it easy for the next patch series to change the internal workings
of `packed_ref_store` without affecting `files_ref_store`.

Along the way, we fix some longstanding problems with reference
updates. Quoting from patch [08/10]:

    First, the old code didn't obtain the `packed-refs` lock until
    `files_transaction_finish()`. This means that a failure to acquire the
    `packed-refs` lock (e.g., due to contention with another process)
    wasn't detected until it was too late (problems like this are supposed
    to be detected in the "prepare" phase). The new code acquires the
    `packed-refs` lock in `files_transaction_prepare()`, the same stage of
    the processing when the loose reference locks are being acquired,
    removing another reason why the "prepare" phase might succeed and the
    "finish" phase might nevertheless fail.

    Second, the old code deleted the loose version of a reference before
    deleting any packed version of the same reference. This left a moment
    when another process might think that the packed version of the
    reference is current, which is incorrect. (Even worse, the packed
    version of the reference can be arbitrarily old, and might even point
    at an object that has since been garbage-collected.)

    Third, if a reference deletion fails to acquire the `packed-refs` lock
    altogether, then the old code might leave the repository in the
    incorrect state (possibly corrupt) described in the previous
    paragraph.

    Now we activate the new "packed-refs" file (sans any references that
    are being deleted) *before* deleting the corresponding loose
    references. But we hold the "packed-refs" lock until after the loose
    references have been finalized, thus preventing a simultaneous
    "pack-refs" process from packing the loose version of the reference in
    the time gap, which would otherwise defeat our attempt to delete it.

This patch series is also available as branch
`packed-ref-transactions` in my fork on GitHub [1]. A draft of the
patch series to change `packed_ref_store` to use mmap and get rid of
its `ref_cache` is available as branch `mmap-packed-refs` from the
same source.

Michael

[1] https://github.com/mhagger/git

Michael Haggerty (10):
  packed-backend: don't adjust the reference count on lock/unlock
  struct ref_transaction: add a place for backends to store data
  packed_ref_store: implement reference transactions
  packed_delete_refs(): implement method
  files_pack_refs(): use a reference transaction to write packed refs
  files_initial_transaction_commit(): use a transaction for packed refs
  t1404: demonstrate two problems with reference transactions
  files_ref_store: use a transaction to update packed refs
  packed-backend: rip out some now-unused code
  files_transaction_finish(): delete reflogs before references

 refs/files-backend.c         | 200 ++++++++++++++-----
 refs/packed-backend.c        | 457 +++++++++++++++++++++++++++++--------------
 refs/packed-backend.h        |  17 +-
 refs/refs-internal.h         |   1 +
 t/t1404-update-ref-errors.sh |  71 +++++++
 5 files changed, 534 insertions(+), 212 deletions(-)

-- 
2.14.1

