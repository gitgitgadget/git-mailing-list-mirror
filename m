Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C09720988
	for <e@80x24.org>; Wed, 19 Oct 2016 04:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbcJSEYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:24:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57902 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750977AbcJSEX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:23:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E7D149EAD;
        Wed, 19 Oct 2016 00:23:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=pgHG
        qEEya4ltZTjpDhBfXE5vQqA=; b=CpRivcAMTz6XLlkoYWOyThFR2Eu+ZF/dOMxA
        BbkL8y9S3F/pJakpSvPh1aO6y9fWC85I3vD7sqSQSaBsJyGHQRqcBAcO5vfuiq2o
        RWlr0xQwVycgMwJfZ7067n5CmT8hhrf6jxFxsYvrkTpjioYfMyJbDl2CCC6hhcxd
        U0S/Itk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=CnQtrx
        CIpeS7cCUHQe6jyURFuT6F8793Latq2ZYxQI1z4GnJ+q5jp+8luObrydVfxnV53c
        H0eeA4S71AtSAYtLdCsrlhKC1yoLyLLdOka/YKxwt1CN9n0HpB+KTjGwJaQHcedY
        /jydyFLPdONCXifWz9lMeDDxi/fT0t/duJg8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4503749EAC;
        Wed, 19 Oct 2016 00:23:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B12B249EAB;
        Wed, 19 Oct 2016 00:23:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] merge-base: expose get_merge_bases_many_0() a bit more
Date:   Tue, 18 Oct 2016 21:23:42 -0700
Message-Id: <20161019042345.29766-5-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: D9D11248-95B3-11E6-BA04-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git merge-base" names its internal workhorse helper function
"get_merge_bases_many_0()", which takes one "can we get away without
clearing the object->flags bits because we know we are the last
caller?" parameter.  Make the parameter into a flags word to make it
extensible and rename it to get_merge_bases_opt().  Use it to turn
get_merge_bases_many_dirty() wrapper into a C-preprocessor macro.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 19 ++++++-------------
 commit.h |  6 ++++--
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 59bd18e67c..92d23b1082 100644
--- a/commit.c
+++ b/commit.c
@@ -942,15 +942,15 @@ static void mark_redundant(struct commit **array, int cnt)
 	free(filled_index);
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
-						  int n,
-						  struct commit **twos,
-						  int cleanup)
+struct commit_list *get_merge_bases_opt(struct commit *one,
+					int n, struct commit **twos,
+					unsigned flags)
 {
 	struct commit_list *list;
 	struct commit **rslt;
 	struct commit_list *result;
 	int cnt, i;
+	int cleanup = !!(flags & MB_POSTCLEAN);
 
 	result = merge_bases_many(one, n, twos);
 
@@ -997,19 +997,12 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
-}
-
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos)
-{
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_opt(one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_opt(one, 1, &two, MB_POSTCLEAN);
 }
 
 /*
diff --git a/commit.h b/commit.h
index 32e1a113e5..557f2814b7 100644
--- a/commit.h
+++ b/commit.h
@@ -253,8 +253,10 @@ extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, int n, struct commit **twos);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-/* To be used only when object flags after this call no longer matter */
-extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
+#define MB_POSTCLEAN 01
+extern struct commit_list *get_merge_bases_opt(struct commit *one, int n, struct commit **twos, unsigned flags);
+
+#define get_merge_bases_many_dirty(one, n, twos) get_merge_bases_opt((one),(n),(twos),MB_POSTCLEAN)
 
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
-- 
2.10.1-631-gb2c64dcf30

