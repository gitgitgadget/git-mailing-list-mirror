Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8241920899
	for <e@80x24.org>; Thu, 17 Aug 2017 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbdHQPNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 11:13:00 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58508 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752885AbdHQPM6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Aug 2017 11:12:58 -0400
X-AuditID: 1207440d-a1fff70000000c0c-f5-5995b2793db1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.0A.03084.972B5995; Thu, 17 Aug 2017 11:12:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5FB.dip0.t-ipconnect.de [87.188.197.251])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7HFCsGR029703
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 17 Aug 2017 11:12:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     s@kazlauskas.me, Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] files-backend: cheapen refname_available check when locking refs
Date:   Thu, 17 Aug 2017 17:12:50 +0200
Message-Id: <4e81f1ecf190082d3415d96650014841cd4c5b19.1502982012.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
References: <20170709112932.njac5m6jmgmjywoz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYndR1K3cNDXSYO5pIYuuK91MFg29V5gt
        bq+Yz2zxo6WH2WLzof/sDqwef99/YPJoeLSOyeNZ7x5Gj4uXlD0+b5ILYI3isklJzcksSy3S
        t0vgyli4uIWt4JdsxeFj39gaGHdLdDFyckgImEgcb/zD1MXIxSEksINJ4uD2m8wQzikmidPP
        7rCAVLEJ6Eos6mlmArFFBNQkJrYdAoszC5RKPJh3nBnEFhYIlOj++ggsziKgKrHzxlWwOK9A
        lMSMhdvZILbJS+xqu8gKYnMKuEisfXkbrF5IwFnifv8zNoh6QYmTM58AxTmA5qtLrJ8nBLFK
        XqJ562zmCYz8s5BUzUKomoWkagEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU
        0k2MkDDm3cH4f53MIUYBDkYlHl6BZVMjhVgTy4orcw8xSnIwKYny/p41JVKILyk/pTIjsTgj
        vqg0J7X4EKMEB7OSCK/CRqBy3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwH
        h5IELy8wXoUEi1LTUyvSMnNKENJMHJwgw3mAhp8GG15ckJhbnJkOkT/FqMvxasL/b0xCLHn5
        ealS4rySIEUCIEUZpXlwc2Dp5xWjONBbwrxPQKp4gKkLbtIroCVMQEuutE8CWVKSiJCSamAU
        iH33tHKSrP79ANe0iIa8+NADi09NOS1U5cSp86Hk1p+jPMLPOjx7X/w8Mr1ywsdNghFvsy6s
        tFY12vDsQviFNbZWNi92Him59TU4s1ztkESls5jTxmrGv3M3JTE5f5BN/XaZk7f76aqikwlf
        mIs6tkx+4raAY/mBa/c5+oXX/T5YOtV3ivwWJZbijERDLeai4kQA0R4NkhoDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When locking references in preparation for updating them, we need to
check that none of the newly added references D/F conflict with
existing references (e.g., we don't allow `refs/foo` to be added if
`refs/foo/bar` already exists, or vice versa).

Prior to 524a9fdb51 (refs_verify_refname_available(): use function in
more places, 2017-04-16), conflicts with existing loose references
were checked by looking directly in the filesystem, and then conflicts
with existing packed references were checked by running
`verify_refname_available_dir()` against the packed-refs cache.

But that commit changed the final check to call
`refs_verify_refname_available()` against the *whole* files ref-store,
including both loose and packed references, with the following
comment:

> This means that those callsites now check for conflicts with all
> references rather than just packed refs, but the performance cost
> shouldn't be significant (and will be regained later).

That comment turned out to be too sanguine. User s@kazlauskas.me
reported that fetches involving a very large number of references in
neighboring directories were slowed down by that change.

The problem is that when fetching, each reference is updated
individually, within its own reference transaction. This is done
because some reference updates might succeed even though others fail.
But every time a reference update transaction is finished,
`clear_loose_ref_cache()` is called. So when it is time to update the
next reference, part of the loose ref cache has to be repopulated for
the `refs_verify_refname_available()` call. If the references are all
in neighboring directories, then the cost of repopulating the
reference cache increases with the number of references, resulting in
O(N²) effort.

The comment above also claims that the performance cost "will be
regained later". The idea was that once the packed-refs were finished
being split out into a separate ref-store, we could limit the
`refs_verify_refname_available()` call to the packed references again.
That is what we do now.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch applies on top of branch mh/packed-ref-store. It can also
be obtained from my fork [1] as branch "faster-refname-available-check".

I was testing this using the reporter's recipe (but fetching from a
local clone), and found the following surprising timing numbers:

b05855b5bc (before the slowdown): 22.7 s
524a9fdb51 (immediately after the slowdown): 13 minutes
4e81f1ecf1 (after this fix): 14.5 s

The fact that the fetch is now significantly *faster* than before the
slowdown seems not to have anything to do with the reference code.

 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e9b95592b6..f2a420c611 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -631,11 +631,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
 
 		/*
 		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing ref that conflicts
-		 * with refname:
+		 * make sure there is no existing packed ref that
+		 * conflicts with refname:
 		 */
 		if (refs_verify_refname_available(
-				    &refs->base, refname,
+				    refs->packed_ref_store, refname,
 				    extras, skip, err))
 			goto error_return;
 	}
@@ -938,7 +938,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    refs_verify_refname_available(&refs->base, refname,
+	    refs_verify_refname_available(refs->packed_ref_store, refname,
 					  extras, skip, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
-- 
2.11.0

