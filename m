Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7561FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdJXPQt (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:16:49 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58378 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751805AbdJXPQk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 11:16:40 -0400
X-AuditID: 1207440d-853ff70000000f42-96-59ef5954a8ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.CE.03906.5595FE95; Tue, 24 Oct 2017 11:16:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBEA.dip0.t-ipconnect.de [87.188.203.234])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9OFGTox001980
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 24 Oct 2017 11:16:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] files_transaction_prepare(): fix handling of ref lock failure
Date:   Tue, 24 Oct 2017 17:16:25 +0200
Message-Id: <6214107e1232a7fe7ca4b7440733ff496f07e537.1508856679.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1508856679.git.mhagger@alum.mit.edu>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqBsW+T7SoPMBq0XXlW4mi4beK8wW
        t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugStj5j3fgrn6
        FZO7bzM2MN5V62Lk5JAQMJE42L6bpYuRi0NIYAeTRNvKb6wQzikmiW2vu5hBqtgEdCUW9TQz
        gdgiAmoSE9sOsYDYzAIpEh3PuxlBbGGBIImbM6eD1bMIqEr83HYCzOYViJLo/v2HGWKbvMS5
        B7eBbA4OTgELib/XNEHCQgLmEh8uL2aewMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        kV5uZoleakrpJkZIiPDuYPy/TuYQowAHoxIP7w3Ld5FCrIllxZW5hxglOZiURHn/vQcK8SXl
        p1RmJBZnxBeV5qQWH2KU4GBWEuFdYfI+Uog3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1
        tSC1CCYrw8GhJMHbHwHUKFiUmp5akZaZU4KQZuLgBBnOAzScJQxkeHFBYm5xZjpE/hSjPUfH
        zbt/mDg2gckN3x8AyWczXzcwC7Hk5eelSonz5oQDtQmAtGWU5sFNhsX/K0ZxoEeFeTVADuAB
        pg642a+A1jIBrZW1fwOytiQRISXVwKixueNBqG+3CFOduUjD7e70pJCLlkLaQkwKH2Y03chf
        yDe3jfujvLlDuOAJARN3W3aulZWyZh0dvdI1J99pTPwsNHGXhsrOm/xnA6ab8/hJLToQGrFi
        btnMyvlT/zpaNtj2vpNU85LfNC8hqEBpz17XxUFiSbpeEY9v9pi+fhxdoKgwR05QiaU4I9FQ
        i7moOBEARzLrs9oCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since dc39e09942 (files_ref_store: use a transaction to update packed
refs, 2017-09-08), failure to lock a reference has been handled
incorrectly by `files_transaction_prepare()`. If
`lock_ref_for_update()` fails in the lock-acquisition loop of that
function, it sets `ret` then breaks out of that loop. Prior to
dc39e09942, that was OK, because the only thing following the loop was
the cleanup code. But dc39e09942 added another blurb of code between
the loop and the cleanup. That blurb sometimes resets `ret` to zero,
making the cleanup code think that the locking was successful.

Specifically, whenever

* One or more reference deletions have been processed successfully in
  the lock-acquisition loop. (Processing the first such reference
  causes a packed-ref transaction to be initialized.)

* Then `lock_ref_for_update()` fails for a subsequent reference. Such
  a failure can happen for a number of reasons, such as the old SHA-1
  not being correct, lock contention, etc. This causes a `break` out
  of the lock-acquisition loop.

* The `packed-refs` lock is acquired successfully and
  `ref_transaction_prepare()` succeeds for the packed-ref transaction.
  This has the effect of resetting `ret` back to 0, and making the
  cleanup code think that lock acquisition was successful.

In that case, any reference updates that were processed prior to
breaking out of the loop would be carried out (loose and packed), but
the reference that couldn't be locked and any subsequent references
would silently be ignored.

This can easily cause data loss if, for example, the user was trying
to push a new name for an existing branch while deleting the old name.
After the push, the branch could be left unreachable, and could even
subsequently be garbage-collected.

This problem was noticed in the context of deleting one reference and
creating another in a single transaction, when the two references D/F
conflict with each other, like

    git update-ref --stdin <<EOF
    delete refs/foo
    create refs/foo/bar HEAD
    EOF

This triggers the above bug because the deletion is processed
successfully for `refs/foo`, then the D/F conflict causes
`lock_ref_for_update()` to fail when `refs/foo/bar` is processed. In
this case the transaction *should* fail, but instead it causes
`refs/foo` to be deleted without creating `refs/foo`. This could
easily result in data loss.

The fix is simple: instead of just breaking out of the loop, jump
directly to the cleanup code. This fixes some tests in t1404 that were
added in the previous commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c         |  2 +-
 t/t1404-update-ref-errors.sh | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 014dabb0bf..8cc1e07fdb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2570,7 +2570,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &affected_refnames, err);
 		if (ret)
-			break;
+			goto cleanup;
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 8b5e9a83c5..b7838967b8 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -276,11 +276,11 @@ test_expect_success 'D/F conflict prevents add short + delete long' '
 	df_test refs/df-as-dl --add-del foo foo/bar
 '
 
-test_expect_failure 'D/F conflict prevents delete long + add short' '
+test_expect_success 'D/F conflict prevents delete long + add short' '
 	df_test refs/df-dl-as --del-add foo/bar foo
 '
 
-test_expect_failure 'D/F conflict prevents delete short + add long' '
+test_expect_success 'D/F conflict prevents delete short + add long' '
 	df_test refs/df-ds-al --del-add foo foo/bar
 '
 
@@ -292,17 +292,17 @@ test_expect_success 'D/F conflict prevents add short + delete long packed' '
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
 '
 
-test_expect_failure 'D/F conflict prevents delete long packed + add short' '
+test_expect_success 'D/F conflict prevents delete long packed + add short' '
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
 '
 
-test_expect_failure 'D/F conflict prevents delete short packed + add long' '
+test_expect_success 'D/F conflict prevents delete short packed + add long' '
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
 '
 
 # Try some combinations involving symbolic refs...
 
-test_expect_failure 'D/F conflict prevents indirect add long + delete short' '
+test_expect_success 'D/F conflict prevents indirect add long + delete short' '
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
 '
 
@@ -314,11 +314,11 @@ test_expect_success 'D/F conflict prevents indirect add short + indirect delete
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
 '
 
-test_expect_failure 'D/F conflict prevents indirect delete long + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long + indirect add short' '
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
 '
 
-test_expect_failure 'D/F conflict prevents indirect add long + delete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + delete short packed' '
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
 '
 
@@ -330,7 +330,7 @@ test_expect_success 'D/F conflict prevents add long + indirect delete short pack
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
 '
 
-test_expect_failure 'D/F conflict prevents indirect delete long packed + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long packed + indirect add short' '
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
 '
 
-- 
2.14.1

