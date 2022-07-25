Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FAC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 22:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiGYWNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGYWNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 18:13:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53C24BE6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:13:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e65a848daso98056297b3.20
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=ULKhpNZPMkLzXLJ56/KpLYFcmugEP7cskS/eNd0QQMg=;
        b=It9jr2R8bNaFNB56hSqkYlsW2Jk6/EX9KLrprxLquRHu1P47Ac6IWrtTRgxgcSOhHL
         DRH/r4zFabxxaTj1fcD9k+GuBOs1+NrrTZmbD1U8wFdZNNKEsNumGq4U8NFmk9DpBuig
         Azj2lTPw1hu3FAXtsv/BgJU6i7VQHPqqznLiHD6QwXWLAKEi6THCDrE90BQ23JziLc+8
         DeLTCbwsvA1ksHkWV/X0oufPxi5TkNFN2lopggZy98gxt8/0cDZr1eaWGnbtfEp1JmlI
         cRbCZJ+ISh/RKPBgtOCfNROd/5NVTtRljihtiEOgtZ7aBdm2JA0LkDFQR/oUxtlLZgh4
         IjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=ULKhpNZPMkLzXLJ56/KpLYFcmugEP7cskS/eNd0QQMg=;
        b=Soisl82WUAIcGvqz/Uu+2Eoaett1O+H+JZGOQ+2TgL+tkEiYme5qalVRovNi2ZLK0B
         /eZSUDJBZ52u/4c+Y0ZOz+Ub60l4aRTzqKMfxelrrv/GfdeeN6RZK1pfmDi6X5CwckKw
         0KQwf0QeL4vJ8Msu63IVs5ZhTFZrloSmnNLfP1sSk7oIWNLKHjsUM+iKIkckASiRTghi
         FzJUbpCfEzLZYgHCSD9F3wRQfDhtByDw7F68SJmPa/1O+olhgs/T69YGlSjN0pAynKv7
         6lAYmZjl5/f5AO9Jj4x37lDrFiN04EliUxkW1wLNihRlTgC9Ljl9QBIIXEfP7M5Ea2CS
         uOvg==
X-Gm-Message-State: AJIora9UuUacTE/ytDqXof3LjmKU04pyPvgUSp+1zJi8URZkaxr/PNPX
        LcJ93fAL/6oD/ZaqiniJyD5o1dVOewjN/huy/OLbOVWYeQ7CdJqCZBAr5qRpMRbVlIXHN+WQt1c
        z/xsvEBNTyipbkESYqVDgdpNLhRF+/z+z3nUR75ND5HcsZhxoSgNCXnADAZHJutg=
X-Google-Smtp-Source: AGRyM1uyyWyWqffMZidd7vEogvbLFEyXnbXlIIJCSdWOqpY3ZEGvIo1lQGoAaPOY0KMHCNUSR2HI2OKptTV/4g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:8deb:5580:a49a:d605])
 (user=steadmon job=sendgmr) by 2002:a05:6902:282:b0:66e:26b0:8f16 with SMTP
 id v2-20020a056902028200b0066e26b08f16mr10912706ybh.469.1658787215393; Mon,
 25 Jul 2022 15:13:35 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:13:32 -0700
Message-Id: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] fetch-pack: add tracing for negotiation rounds
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
the entire negotiation process. However, we'd like additional data, such
as timing for each round of negotiation or the number of "haves" in each
round. Additionally, "independent negotiation" (AKA push negotiation)
has no tracing at all. Having this data would allow us to compare the
performance of the various negotation implementations, and to debug
unexpectedly slow fetch & push sessions.

Fix this by adding per-round trace2 regions for all negotiation
implementations (V0+V1, V2, and independent negotiation), as well as an
overall region for independent negotiation. Add trace2 data logging for
the number of haves and "in vain" objects for each round, and for the
total number of rounds once negotiation completes.  Finally, add a few
checks into various tests to verify that the number of rounds is logged
as expected.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fetch-pack.c                       | 62 +++++++++++++++++++++++++++++-
 t/t5500-fetch-pack.sh              |  4 +-
 t/t5516-fetch-push.sh              | 10 ++++-
 t/t5601-clone.sh                   |  6 ++-
 t/t5703-upload-pack-ref-in-want.sh |  6 ++-
 5 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..01a451e456 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -299,6 +299,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 {
 	int fetching;
 	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
+	int negotiation_round = 0, haves = 0;
 	const struct object_id *oid;
 	unsigned in_vain = 0;
 	int got_continue = 0;
@@ -441,9 +442,19 @@ static int find_common(struct fetch_negotiator *negotiator,
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
+		haves++;
 		if (flush_at <= ++count) {
 			int ack;
 
+			negotiation_round++;
+			trace2_region_enter_printf("negotiation_v0_v1", "round",
+						   the_repository, "round-%d",
+						   negotiation_round);
+			trace2_data_intmax("negotiation_v0_v1", the_repository,
+					   "haves_added", haves);
+			trace2_data_intmax("negotiation_v0_v1", the_repository,
+					   "in_vain", in_vain);
+			haves = 0;
 			packet_buf_flush(&req_buf);
 			send_request(args, fd[1], &req_buf);
 			strbuf_setlen(&req_buf, state_len);
@@ -465,6 +476,9 @@ static int find_common(struct fetch_negotiator *negotiator,
 						      ack, oid_to_hex(result_oid));
 				switch (ack) {
 				case ACK:
+					trace2_region_leave_printf("negotiation_v0_v1", "round",
+								   the_repository, "round-%d",
+								   negotiation_round);
 					flushes = 0;
 					multi_ack = 0;
 					retval = 0;
@@ -490,6 +504,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 						const char *hex = oid_to_hex(result_oid);
 						packet_buf_write(&req_buf, "have %s\n", hex);
 						state_len = req_buf.len;
+						haves++;
 						/*
 						 * Reset in_vain because an ack
 						 * for this commit has not been
@@ -510,14 +525,26 @@ static int find_common(struct fetch_negotiator *negotiator,
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
 				print_verbose(args, _("giving up"));
+				trace2_region_leave_printf("negotiation_v0_v1", "round",
+							   the_repository, "round-%d",
+							   negotiation_round);
 				break; /* give up */
 			}
-			if (got_ready)
+			if (got_ready) {
+				trace2_region_leave_printf("negotiation_v0_v1", "round",
+							   the_repository, "round-%d",
+							   negotiation_round);
 				break;
+			}
+			trace2_region_leave_printf("negotiation_v0_v1", "round",
+						   the_repository, "round-%d",
+						   negotiation_round);
 		}
 	}
 done:
 	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
+	trace2_data_intmax("negotiation_v0_v1", the_repository, "total_rounds",
+			   negotiation_round);
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
@@ -1361,6 +1388,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 
 	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
 	*in_vain += haves_added;
+	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
+	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
 	if (!haves_added || (seen_ack && *in_vain >= MAX_IN_VAIN)) {
 		/* Send Done */
 		packet_buf_write(&req_buf, "done\n");
@@ -1603,6 +1632,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct oidset common = OIDSET_INIT;
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
+	int negotiation_round = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
@@ -1659,6 +1689,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						    "negotiation_v2",
 						    the_repository);
 			}
+			negotiation_round++;
+			trace2_region_enter_printf("negotiation_v2", "round",
+						   the_repository, "round-%d",
+						   negotiation_round);
 			if (send_fetch_request(negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
@@ -1686,12 +1720,20 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			} else {
 				do_check_stateless_delimiter(args->stateless_rpc, &reader);
 				state = FETCH_SEND_REQUEST;
+				trace2_region_leave_printf("negotiation_v2", "round",
+							   the_repository, "round-%d",
+							   negotiation_round);
 			}
 			break;
 		case FETCH_GET_PACK:
+			trace2_region_leave_printf("negotiation_v2", "round",
+						   the_repository, "round-%d",
+						   negotiation_round);
 			trace2_region_leave("fetch-pack",
 					    "negotiation_v2",
 					    the_repository);
+			trace2_data_intmax("negotiation_v2", the_repository,
+					   "total_rounds", negotiation_round);
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
 				receive_shallow_info(args, &reader, shallows, si);
@@ -2071,6 +2113,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 	int in_vain = 0;
 	int seen_ack = 0;
 	int last_iteration = 0;
+	int negotiation_round = 0;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
 
 	fetch_negotiator_init(the_repository, &negotiator);
@@ -2084,11 +2127,17 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 			   add_to_object_array,
 			   &nt_object_array);
 
+	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
 	while (!last_iteration) {
 		int haves_added;
 		struct object_id common_oid;
 		int received_ready = 0;
 
+		negotiation_round++;
+
+		trace2_region_enter_printf("negotiate_using_fetch", "round",
+					   the_repository, "round-%d",
+					   negotiation_round);
 		strbuf_reset(&req_buf);
 		write_fetch_command_and_capabilities(&req_buf, server_options);
 
@@ -2099,6 +2148,11 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
 			last_iteration = 1;
 
+		trace2_data_intmax("negotiate_using_fetch", the_repository,
+				   "haves_added", haves_added);
+		trace2_data_intmax("negotiate_using_fetch", the_repository,
+				   "in_vain", in_vain);
+
 		/* Send request */
 		packet_buf_flush(&req_buf);
 		if (write_in_full(fd[1], req_buf.buf, req_buf.len) < 0)
@@ -2131,7 +2185,13 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 						 REACH_SCRATCH, 0,
 						 min_generation))
 			last_iteration = 1;
+		trace2_region_leave_printf("negotiation", "round",
+					   the_repository, "round-%d",
+					   negotiation_round);
 	}
+	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
+	trace2_data_intmax("negotiate_using_fetch", the_repository,
+			   "total_rounds", negotiation_round);
 	clear_common_flag(acked_commits);
 	strbuf_release(&req_buf);
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ee6d2dde9f..d18f2823d8 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -407,6 +407,7 @@ test_expect_success 'in_vain not triggered before first ACK' '
 '
 
 test_expect_success 'in_vain resetted upon ACK' '
+	test_when_finished rm -f log trace2 &&
 	rm -rf myserver myclient &&
 	git init myserver &&
 
@@ -432,7 +433,8 @@ test_expect_success 'in_vain resetted upon ACK' '
 	# first. The 256th commit is common between the client and the server,
 	# and should reset in_vain. This allows negotiation to continue until
 	# the client reports that first_anotherbranch_commit is common.
-	git -C myclient fetch --progress origin main 2>log &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2" git -C myclient fetch --progress origin main 2>log &&
+	grep \"key\":\"total_rounds\",\"value\":\"6\" trace2 &&
 	test_i18ngrep "Total 3 " log
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ca0f8c144..f64cefa29a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -198,7 +198,10 @@ test_expect_success 'push with negotiation' '
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
 	test_when_finished "rm event" &&
-	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
+	GIT_TRACE2_EVENT="$(pwd)/event" \
+		git -c protocol.version=2 -c push.negotiate=1 \
+		push testrepo refs/heads/main:refs/remotes/origin/main &&
+	grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
 	grep_wrote 2 event # 1 commit, 1 tree
 '
 
@@ -222,7 +225,10 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
 	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
 	test_commit -C testrepo unrelated_commit &&
 	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
-	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	GIT_TRACE2_EVENT="$(pwd)/event"  git -c submodule.recurse=true \
+		-c protocol.version=2 -c push.negotiate=1 \
+		push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	grep \"key\":\"total_rounds\",\"value\":\"1\" event &&
 	! grep "Fetching submodule" err
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index cf3be0584f..2e57de9c12 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -743,7 +743,11 @@ test_expect_success 'batch missing blob request during checkout' '
 
 	# Ensure that there is only one negotiation by checking that there is
 	# only "done" line sent. ("done" marks the end of negotiation.)
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client checkout HEAD^ &&
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
+		git -C client -c trace2.eventNesting=5 checkout HEAD^ &&
+	grep \"key\":\"total_rounds\",\"value\":\"1\" trace2_event >trace_lines &&
+	test_line_count = 1 trace_lines &&
 	grep "fetch> done" trace >done_lines &&
 	test_line_count = 1 done_lines
 '
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 9d6cd7d986..df74f80061 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -229,14 +229,16 @@ test_expect_success 'setup repos for fetching with ref-in-want tests' '
 '
 
 test_expect_success 'fetching with exact OID' '
-	test_when_finished "rm -f log" &&
+	test_when_finished "rm -f log trace2" &&
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
 	oid=$(git -C "$REPO" rev-parse d) &&
-	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
+	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE2_EVENT="$(pwd)/trace2" \
+		git -C local fetch origin \
 		"$oid":refs/heads/actual &&
 
+	grep \"key\":\"total_rounds\",\"value\":\"2\" trace2 &&
 	git -C "$REPO" rev-parse "d" >expected &&
 	git -C local rev-parse refs/heads/actual >actual &&
 	test_cmp expected actual &&

base-commit: 4e2a4d1dd44367d7783f33b169698f2930ff13c0
-- 
2.37.1.359.gd136c6c3e2-goog

