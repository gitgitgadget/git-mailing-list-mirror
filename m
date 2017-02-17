Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1965201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 03:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbdBQD65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 22:58:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932089AbdBQD64 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 22:58:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEB296A020;
        Thu, 16 Feb 2017 22:58:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=uTle
        +rF1dVjJBWl2mGsmdBNIygc=; b=YEN/HaW2DclxNGy3w0wKtnxL9LUQjxsi1bYe
        y8rnyfLAwwmuWaxqSevgo++4CcL915qzk83rdgQKDJnmRYvzV59FFx21kUVTAwhA
        mw0TJKJ93hh8mOfpzr8muCtUxTpjpmYwxL1lmc2n4Kkogn17eHE+b9Z31N+5xwef
        EbkmMTc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4EEA6A01F;
        Thu, 16 Feb 2017 22:58:54 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2632B6A019;
        Thu, 16 Feb 2017 22:58:53 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 2/3] update-ref: pass reflog message argument to delete_refs
Date:   Thu, 16 Feb 2017 22:57:59 -0500
Message-Id: <20170217035800.13214-3-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170217035800.13214-1-kyle@kyleam.com>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 664200DC-F4C5-11E6-8A87-A7617B1B28F4-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=uTle+rF1dVjJBWl2mGsmdBNIygc=;
 b=PGPs/cCB2u+88vYaqoNshA7C8rXS9H5aSZozYxrljYhF4VZpdm/vnlnuEhT3wH2bntbIIcg9FH5dplZzVXYnDGI3BSCCpsmovsjwJgGF2PLpGAa9srAxfz64/vf63ed9vU3Ag5ILEbo1MN3X5SvdAGnuHzXsdH9ZuwF8umTatZk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that delete_refs() accepts a reflog message, pass the
user-provided message to delete_refs() rather than silently dropping
it.  The doesn't matter for the deleted ref's log because the log is
deleted along with the ref, but this entry will show up in HEAD's
reflog when deleting a checked out branch.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
I'm not sure if the test here (or in the next patch) is worth including.

 builtin/update-ref.c  | 2 +-
 t/t1400-update-ref.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a41f9adf1..f642acc22 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -435,7 +435,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 */
 		return delete_ref(refname,
 				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
-				  flags, NULL);
+				  flags, msg);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags | create_reflog_flag,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b0ffc0b57..65918d984 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -85,6 +85,15 @@ test_expect_success "delete $m (by HEAD)" '
 '
 rm -f .git/$m
 
+test_expect_success "deleting current branch adds message to HEAD's log" '
+	git update-ref $m $A &&
+	git symbolic-ref HEAD $m &&
+	git update-ref -mdelmsg -d $m &&
+	! test -f .git/$m &&
+	grep "delmsg$" .git/logs/HEAD >/dev/null
+'
+rm -f .git/$m
+
 test_expect_success 'update-ref does not create reflogs by default' '
 	test_when_finished "git update-ref -d $outside" &&
 	git update-ref $outside $A &&
-- 
2.11.1

