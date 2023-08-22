Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11866EE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 01:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjHVBe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 21:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHVBez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 21:34:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B48187
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 18:34:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2947E1BD2B7;
        Mon, 21 Aug 2023 21:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f8Nkhl0FoT5b6re8wbUMvl5hyQokP20VB1J/l7
        7M3J0=; b=V2vW2Z/ojOAXvAlOHZBJAj6YkxIMKXDV8MOJaRu/sUqC3XgGdEgSXI
        UIG6n/1tDbzs6hmq6pFy139Vmj62h3lLToCnph6lXDBv6A0I4TF52EktVqaZeN1e
        jaQRN9WpWoVrZLJ8EWQZSmxTdfehwiyEulPH2EGggi97f0xpHJ5/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 211831BD2B6;
        Mon, 21 Aug 2023 21:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 837B41BD2B5;
        Mon, 21 Aug 2023 21:34:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Santiago <taylorsantiago@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config
 settings.
References: <20230817215325.2550998-1-taylorsantiago@google.com>
        <20230817215325.2550998-2-taylorsantiago@google.com>
        <20230821203051.GA1800481@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 18:34:49 -0700
In-Reply-To: <20230821203051.GA1800481@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 16:30:51 -0400")
Message-ID: <xmqqttsrn9l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 161B1E30-408C-11EE-8507-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I'm in favor of fixing them[1]. Doesn't receive-pack have the same
> bug, though? And we'd probably want to have tests for both.

Thanks, both.  The receive-pack side (changes to the code and
additional test) should look like this squashable patch.



 builtin/receive-pack.c    |  6 +++---
 t/t5546-receive-limits.sh | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a31a58367..03ac7b01d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2524,10 +2524,10 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if (cert_nonce_seed)
 		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
-	if (0 <= transfer_unpack_limit)
-		unpack_limit = transfer_unpack_limit;
-	else if (0 <= receive_unpack_limit)
+	if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
+	else if (0 <= transfer_unpack_limit)
+		unpack_limit = transfer_unpack_limit;
 
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index eed3c9d81a..9fc9ba552f 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -9,10 +9,26 @@ TEST_PASSES_SANITIZE_LEAK=true
 # When the limit is 1, `git receive-pack` will call `git index-pack`.
 # When the limit is 10000, `git receive-pack` will call `git unpack-objects`.
 
+validate_store_type () {
+	git -C dest count-objects -v >actual &&
+	case "$store_type" in
+	index)
+		grep "^count: 0$" actual ;;
+	unpack)
+		grep "^packs: 0$" actual ;;
+	esac || {
+		echo "store_type is $store_type"
+		cat actual
+		false;
+	}
+}
+
 test_pack_input_limit () {
-	case "$1" in
-	index) unpack_limit=1 ;;
-	unpack) unpack_limit=10000 ;;
+	store_type=$1
+
+	case "$store_type" in
+	index) unpack_limit=1 other_limit=10000 ;;
+	unpack) unpack_limit=10000 other_limit=1 ;;
 	esac
 
 	test_expect_success 'prepare destination repository' '
@@ -43,6 +59,19 @@ test_pack_input_limit () {
 		git --git-dir=dest config receive.maxInputSize 0 &&
 		git push dest HEAD
 	'
+
+	test_expect_success 'prepare destination repository (once more)' '
+		rm -fr dest &&
+		git --bare init dest
+	'
+
+	test_expect_success 'receive trumps transfer' '
+		git --git-dir=dest config receive.unpacklimit "$unpack_limit" &&
+		git --git-dir=dest config transfer.unpacklimit "$other_limit" &&
+		git push dest HEAD &&
+		validate_store_type
+	'
+
 }
 
 test_expect_success "create known-size (1024 bytes) commit" '
-- 
2.42.0

