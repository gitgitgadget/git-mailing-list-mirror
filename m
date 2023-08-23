Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D5EE49A3
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 01:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjHWBaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjHWBa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 21:30:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92893E45
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 18:30:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B98FD2207F;
        Tue, 22 Aug 2023 21:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cxuXscLgdhGFwWINE3Ok5NjJAIPYYjdmUA8VeX
        6UMAU=; b=JEGFHOmoDxv9n6otAQJSxi4L9kDgiXEVE5sC5iJ9OEPZ1SyVMcUIUE
        6cLtTk2Aa9nirRL+XaWfW0yNRzN3PHJIYnsHL17gDHMJ6ZpyhQHNQhcB2rJwDy0H
        HyDGvZMhFgvsJiOiLuoXI0e75dkWphP4mWE2WjvueQ8dytMH0zLl0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B19642207E;
        Tue, 22 Aug 2023 21:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7A002207D;
        Tue, 22 Aug 2023 21:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Santiago <taylorsantiago@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config
 settings.
References: <20230817215325.2550998-1-taylorsantiago@google.com>
        <20230817215325.2550998-2-taylorsantiago@google.com>
        <20230821203051.GA1800481@coredump.intra.peff.net>
        <xmqqttsrn9l2.fsf@gitster.g>
Date:   Tue, 22 Aug 2023 18:30:21 -0700
In-Reply-To: <xmqqttsrn9l2.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        21 Aug 2023 18:34:49 -0700")
Message-ID: <xmqqpm3eh7f6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0FC0622-4154-11EE-A02F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> So I'm in favor of fixing them[1]. Doesn't receive-pack have the same
>> bug, though? And we'd probably want to have tests for both.
>
> Thanks, both.  The receive-pack side (changes to the code and
> additional test) should look like this squashable patch.
>
>
>
>  builtin/receive-pack.c    |  6 +++---
>  t/t5546-receive-limits.sh | 35 ++++++++++++++++++++++++++++++++---
>  2 files changed, 35 insertions(+), 6 deletions(-)

Yesterday I was a bit too busy (well it was a release day wasn't
it?) and did not bother writing the tests for fetch/transfer, but it
seems nobody took the bait to finish it so far, so here it is again.

This time, what I am sending is not a squashable patch, but the
whole thing as a single patch.

------- >8 ------------- >8 ------------- >8 -------
Subject: transfer.unpackLimit: fetch/receive.unpackLimit takes precedence

The transfer.unpackLimit configuration variable is documented to be
used only as a fallback value when the more operation-specific
fetch.unpackLimit and receive.unpackLimit variables are not set, but
the implementation had the precedence reversed.  Apparently this was
broken since the transfer.unpackLimit was introduced in e28714c5
(Consolidate {receive,fetch}.unpackLimit, 2007-01-24).

Often when documentation and code have diverged for so long, we
prefer to change the documentation instead, to avoid disrupting
users.  But doing so would make these weirdly unlike most other
"specific overrides general" config options. And the fact that the
bug has existed for so long without anyone noticing implies to me
that nobody really tries to mix and match them much.

Signed-off-by: Taylor Santiago <taylorsantiago@google.com>
[jc: rewrote the log message, added tests, covered receive-pack as well]
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c    |  6 +++---
 fetch-pack.c              |  6 +++---
 t/t5510-fetch.sh          | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5546-receive-limits.sh | 35 ++++++++++++++++++++++++++++++++---
 4 files changed, 84 insertions(+), 9 deletions(-)

diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 1a31a58367..03ac7b01d2 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
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
diff --git c/fetch-pack.c w/fetch-pack.c
index 0f71054fba..8b300545d5 100644
--- c/fetch-pack.c
+++ w/fetch-pack.c
@@ -1911,10 +1911,10 @@ static void fetch_pack_setup(void)
 	if (did_setup)
 		return;
 	fetch_pack_config();
-	if (0 <= transfer_unpack_limit)
-		unpack_limit = transfer_unpack_limit;
-	else if (0 <= fetch_unpack_limit)
+	if (0 <= fetch_unpack_limit)
 		unpack_limit = fetch_unpack_limit;
+	else if (0 <= transfer_unpack_limit)
+		unpack_limit = transfer_unpack_limit;
 	did_setup = 1;
 }
 
diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
index 4f289063ce..19c36b57f4 100755
--- c/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -1127,6 +1127,52 @@ do
 	'
 done
 
+test_expect_success 'prepare source branch' '
+	echo one >onebranch &&
+	git checkout --orphan onebranch &&
+	git rm --cached -r . &&
+	git add onebranch &&
+	git commit -m onebranch &&
+	git rev-list --objects onebranch -- >actual &&
+	# 3 objects should be created, at least ...
+	test 3 -le $(wc -l <actual)
+'
+
+validate_store_type () {
+	git -C dest count-objects -v >actual &&
+	case "$store_type" in
+	packed)
+		grep "^count: 0$" actual ;;
+	loose)
+		grep "^packs: 0$" actual ;;
+	esac || {
+		echo "store_type is $store_type"
+		cat actual
+		false
+	}
+}
+
+test_unpack_limit () {
+	store_type=$1
+
+	case "$store_type" in
+	packed) fetch_limit=1 transfer_limit=10000 ;;
+	loose) fetch_limit=10000 transfer_limit=1 ;;
+	esac
+
+	test_expect_success "fetch trumps transfer limit" '
+		rm -fr dest &&
+		git --bare init dest &&
+		git -C dest config fetch.unpacklimit $fetch_limit &&
+		git -C dest config transfer.unpacklimit $transfer_limit &&
+		git -C dest fetch .. onebranch &&
+		validate_store_type
+	'
+}
+
+test_unpack_limit packed
+test_unpack_limit loose
+
 setup_negotiation_tip () {
 	SERVER="$1"
 	URL="$2"
diff --git c/t/t5546-receive-limits.sh w/t/t5546-receive-limits.sh
index eed3c9d81a..9fc9ba552f 100755
--- c/t/t5546-receive-limits.sh
+++ w/t/t5546-receive-limits.sh
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
