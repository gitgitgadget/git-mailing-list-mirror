Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3A11FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 19:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbcLGTlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 14:41:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752524AbcLGTlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 14:41:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34817550DE;
        Wed,  7 Dec 2016 14:41:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=e0kp
        ujxSvhiX4q2cPg2CUHxozJE=; b=J08RxKrFtQ+bnWnNjnZkMq9z2Ki/FKtqRzJX
        vOai43Ai78IYwpMH7hnyWiprkq+JYIf0NSR3EgqvleZVxiCrSWR+HAp1DPrNvVog
        B3p/OZyxjBlQH0m0MRwgYW7bwzkdkuHOLCOHLByCHOdKiqM8sg9lWZ6b8Iu598ua
        1CDZPtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        MZEX7JeNDvRTK739GBwAC41AovNaV/X9gsG68gkrI9MAO1GI4wqLVoJMaKGBUb0f
        c3ufg4mVetjGz6fVuHkJ2BpVfBU1OuFRPvaa7eEkApVnFSVkDyVMvLsS71NNy7n+
        3eAJ9WuYZNmm2wZZcQiTdTB2/6Ny0d5IQVCwiVbhvD8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DDA1550DC;
        Wed,  7 Dec 2016 14:41:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7F46550DB;
        Wed,  7 Dec 2016 14:41:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
Date:   Wed,  7 Dec 2016 11:41:03 -0800
Message-Id: <20161207194105.25780-2-gitster@pobox.com>
X-Mailer: git-send-email 2.11.0-274-g0631465056
In-Reply-To: <20161207194105.25780-1-gitster@pobox.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
 <20161207194105.25780-1-gitster@pobox.com>
X-Pobox-Relay-ID: 19A9B604-BCB5-11E6-AAE7-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The require_clean_work_tree() function calls hold_locked_index()
with die_on_error=0 to signal that it is OK if it fails to obtain
the lock, but unconditionally calls update_index_if_able(), which
will try to write into fd=-1.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a2e9d332d8..a715e71906 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2258,11 +2258,12 @@ int has_uncommitted_changes(int ignore_submodules)
 int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
 {
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
-	int err = 0;
+	int err = 0, fd;
 
-	hold_locked_index(lock_file, 0);
+	fd = hold_locked_index(lock_file, 0);
 	refresh_cache(REFRESH_QUIET);
-	update_index_if_able(&the_index, lock_file);
+	if (0 <= fd)
+		update_index_if_able(&the_index, lock_file);
 	rollback_lock_file(lock_file);
 
 	if (has_unstaged_changes(ignore_submodules)) {
-- 
2.11.0-274-g0631465056

