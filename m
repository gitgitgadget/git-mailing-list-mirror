Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60EA20372
	for <e@80x24.org>; Fri, 13 Oct 2017 05:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbdJMFMD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 01:12:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52836 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753294AbdJMFMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 01:12:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADDFBAABB8;
        Fri, 13 Oct 2017 01:12:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=aQnO
        VVdzBGXtAIPcXpwAdFeNHDc=; b=nc812WoqjkwNyD17fi8eLfBxp9/VeEdGvbz0
        Zn9eUBBMM1JREOrsT5WhmsGOpn8hKIB1L0Pt59VtmiS/JGzrlVNtyjt5zHoII6J/
        iXrRL0Drhp5eELNf+DQQZ5lMcq0W7tFrT6WL2PYm5RTr9XNHBI4tlh5ZDUxrsJZs
        uP7DjhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q9A23c
        Vp97JoYHz3/Ma+5T/wIh15HM/yV4itQti19tPaOYkYKC1OHhT/9DNrBB9Evxf4eT
        1RRMWOES1KhCCmCji/N9snVTZZyrXCmkLwQcrFQSzd/CxUeso7T/ajrfsBkWVdBR
        n+G/ck5vfvOzDy3jTtyNeOv9bW8mm0Qegvna4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5152AABB7;
        Fri, 13 Oct 2017 01:12:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E3ECAABA4;
        Fri, 13 Oct 2017 01:11:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] branch: forbid refs/heads/HEAD
Date:   Fri, 13 Oct 2017 14:11:32 +0900
Message-Id: <20171013051132.3973-4-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-rc1-158-gbd035ae683
In-Reply-To: <20171013051132.3973-1-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
X-Pobox-Relay-ID: FDCC2886-AFD4-11E7-AC2E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_check_branch_ref() is the central place where many codepaths
see if a proposed name is suitable for the name of a branch.  It was
designed to allow us to get stricter than the check_refname_format()
check used for refnames in general, and we already use it to reject
a branch whose name begins with a '-'.

Use it to also reject "HEAD" as a branch name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c             | 2 +-
 t/t1430-bad-ref-name.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376c..1b8c503095 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1332,7 +1332,7 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	if (name[0] == '-')
+	if (*name == '-' || !strcmp(name, "HEAD"))
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_refname_format(sb->buf, 0);
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index e88349c8a0..3ecb2eab0c 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -331,4 +331,12 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
+test_expect_success 'branch rejects HEAD as a branch name' '
+	test_must_fail git branch HEAD HEAD^
+'
+
+test_expect_success 'checkout -b rejects HEAD as a branch name' '
+	test_must_fail git checkout -B HEAD HEAD^
+'
+
 test_done
-- 
2.15.0-rc1-158-gbd035ae683

