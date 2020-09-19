Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C589C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 14:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D237E21741
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 14:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="HfO+gFdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgISOsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 10:48:33 -0400
Received: from out0-130.mail.aliyun.com ([140.205.0.130]:38687 "EHLO
        out0-130.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgISOsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 10:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1600526909; h=From:To:Subject:Date:Message-Id:MIME-Version;
        bh=HCIeUf8zrfyoaEU5HuQIL1YRY1dfDxLqNCB6MXx1sX8=;
        b=HfO+gFddkOPU/rJd6QgsoPAmn0cJZKgecXsGjdig3clWVU1kLJm49ce8Ktj4uN0Y+WNfvQ6pAUc/FOyDB3QlWsg+3x5+QSmyI3t9fcI0vrzvr3EY8GU8IjfqrlEtjQnern81KambFydljpNs5x93stXfx3DJEh3eqk91x8muLJE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e02c03302;MF=hanxin.hx@alibaba-inc.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---.IZH-rgV_1600526901;
Received: from localhost.localdomain(mailfrom:hanxin.hx@alibaba-inc.com fp:SMTPD_---.IZH-rgV_1600526901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Sep 2020 22:48:27 +0800
From:   "Han Xin" <hanxin.hx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     "Han Xin" <hanxin.hx@alibaba-inc.com>,
        "=?UTF-8?B?6JKL6ZGrKOefpeW/pyk=?=" <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3] send-pack: run GPG after atomic push checking
Date:   Sat, 19 Sep 2020 22:47:50 +0800
Message-Id: <20200919144750.95812-1-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <xmqqft7eljkz.fsf@gitster.c.googlers.com>
References: <xmqqft7eljkz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The refs update commands can be sent to the server side in two different
ways: GPG-signed or unsigned.  We should run these two operations in the
same "Finally, tell the other end!" code block, but they are seperated
by the "Clear the status for each ref" code block.  This will result in
a slight performance loss, because the failed atomic push will still
perform unnecessary preparations for shallow advertise and GPG-signed
commands buffers, and user may have to be bothered by the (possible) GPG
passphrase input when there is nothing to sign.

Add a new test case to t5534 to ensure GPG will not be called when the
GPG-signed atomic push fails.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 send-pack.c            | 58 ++++++++++++++++++++++--------------------
 t/t5534-push-signed.sh | 23 +++++++++++++++++
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d671ab5d05..f227b7315e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -244,7 +244,12 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
 		return CHECK_REF_UPTODATE;
+
 	default:
+	case REF_STATUS_EXPECTING_REPORT:
+		/* already passed checks on the local side */
+	case REF_STATUS_OK:
+		/* of course this is OK */
 		return 0;
 	}
 }
@@ -447,13 +452,6 @@ int send_pack(struct send_pack_args *args,
 		if (ref->deletion && !allow_deleting_refs)
 			ref->status = REF_STATUS_REJECT_NODELETE;
 
-	if (!args->dry_run)
-		advertise_shallow_grafts_buf(&req_buf);
-
-	if (!args->dry_run && push_cert_nonce)
-		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf, push_cert_nonce);
-
 	/*
 	 * Clear the status for each ref and see if we need to send
 	 * the pack data.
@@ -489,31 +487,35 @@ int send_pack(struct send_pack_args *args,
 			ref->status = REF_STATUS_EXPECTING_REPORT;
 	}
 
+	if (!args->dry_run)
+		advertise_shallow_grafts_buf(&req_buf);
+
 	/*
 	 * Finally, tell the other end!
 	 */
-	for (ref = remote_refs; ref; ref = ref->next) {
-		char *old_hex, *new_hex;
-
-		if (args->dry_run || push_cert_nonce)
-			continue;
-
-		if (check_to_send_update(ref, args) < 0)
-			continue;
-
-		old_hex = oid_to_hex(&ref->old_oid);
-		new_hex = oid_to_hex(&ref->new_oid);
-		if (!cmds_sent) {
-			packet_buf_write(&req_buf,
-					 "%s %s %s%c%s",
-					 old_hex, new_hex, ref->name, 0,
-					 cap_buf.buf);
-			cmds_sent = 1;
-		} else {
-			packet_buf_write(&req_buf, "%s %s %s",
-					 old_hex, new_hex, ref->name);
+	if (!args->dry_run && push_cert_nonce)
+		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
+					       cap_buf.buf, push_cert_nonce);
+	else if (!args->dry_run)
+		for (ref = remote_refs; ref; ref = ref->next) {
+			char *old_hex, *new_hex;
+
+			if (check_to_send_update(ref, args) < 0)
+				continue;
+
+			old_hex = oid_to_hex(&ref->old_oid);
+			new_hex = oid_to_hex(&ref->new_oid);
+			if (!cmds_sent) {
+				packet_buf_write(&req_buf,
+						 "%s %s %s%c%s",
+						 old_hex, new_hex, ref->name, 0,
+						 cap_buf.buf);
+				cmds_sent = 1;
+			} else {
+				packet_buf_write(&req_buf, "%s %s %s",
+						 old_hex, new_hex, ref->name);
+			}
 		}
-	}
 
 	if (use_push_options) {
 		struct string_list_item *item;
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 030331f1c5..7e928aff66 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -273,4 +273,27 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'failed atomic push does not execute GPG' '
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script gpg <<-EOF &&
+	# should check atomic push locally before running GPG.
+	exit 1
+	EOF
+	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push \
+			--signed --atomic --porcelain \
+			dst noop ff noff >out 2>&1 &&
+
+	test_i18ngrep ! "gpg failed to sign" out &&
+	sed -n -e "/^To dst/,$ p" out >actual &&
+	cat >expect <<-EOF &&
+	To dst
+	=	refs/heads/noop:refs/heads/noop	[up to date]
+	!	refs/heads/ff:refs/heads/ff	[rejected] (atomic push failed)
+	!	refs/heads/noff:refs/heads/noff	[rejected] (non-fast-forward)
+	Done
+	EOF
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
2.28.0

