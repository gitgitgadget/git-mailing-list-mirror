Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1996720323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935584AbdCVTvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:51:32 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35811 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934884AbdCVTvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:51:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id 20so48115912pfk.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+TEfZG8fbuvo9Xn0KA+EXqzAdunDlNF4Otx0SeGx/4=;
        b=TaHrEXK62hBkaESMN8NwZx3BAXdTSqPwFP8P1Y6+C3BOevDyPpeEo0ClrjjLWGqxob
         2C3ZDrMgzpv/hIW+TfZUiZ8fURJ8Bn1kfl84cUSbS6WLjdne5huCbpEryqZ4fbQkebS6
         7NOuSHMzD39yeKPFeELlrCUJpHtXlDIUNl8TjmQxKJykFlo8VHnw1kLaAwu74Fj9IH8Z
         grL2Fj0cC8xaW0v2zNIkib6L7FQemUhBkYu9IOgu2l/WhOsCKCRsdhA7mxCnk6IpooX3
         Xy733kj85QdIsSShEoGsoE+V1/5x7hnna2SUid+sRI38gN+K2LAe3UGYnjx4/3bEQMfY
         twlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+TEfZG8fbuvo9Xn0KA+EXqzAdunDlNF4Otx0SeGx/4=;
        b=nr4DgWcke3HyHz3QnN1FYMZJuSh/K3Yx94eKCloagPbrbMIRXyOTDKFBMbEujWTa+h
         uIKzinKu9J6Pt7dlEMKOULUHwfnGH74nhiLYp60nCCEG8WbPWGdAzOEGmx5eVcYmp3lP
         lJC8UJp5i0LF9gZzcdv6iispJkT8K0nasJfYHHkRiyif/87kNGH6GwE5S2yzlZ7ZNxaB
         cbOBGmUlK0rtxUj7W/Bh3C7mNE50QJzouXP+2rnzB0o/cx460cOH6+hdvYzfB2HVuf8z
         +r4D2tFpFyqbQ9tWOYC55GXzMBg6l3LBg42iRVcdltnHr0+RWqYCby+SarBSBpfnlO2V
         CQfA==
X-Gm-Message-State: AFeK/H2x8M1HXIMcet07ZD+SbXGMQqBubblR+HsiqcE9d3UF+YHEKTjQNSAzafbl5UIjNITk
X-Received: by 10.98.112.134 with SMTP id l128mr19212900pfc.110.1490212272001;
        Wed, 22 Mar 2017 12:51:12 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id h14sm5577315pgn.41.2017.03.22.12.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 12:51:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/2] send-pack: send push options correctly in stateless-rpc case
Date:   Wed, 22 Mar 2017 12:51:01 -0700
Message-Id: <20170322195102.165314-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
In-Reply-To: <20170322195102.165314-1-bmwill@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git send-pack --stateless-rpc" puts each request in a sequence of pkt-lines
followed by a flush-pkt. The push option code forgot about this and sends push
options and their terminating delimiter as ordinary pkt-lines that get their
length header stripped off by remote-curl before being sent to the server.

The result is multiple malformed requests, which the server rejects.

Fortunately send-pack --stateless-rpc already is aware of this "pkt-line within
pkt-line" framing for the update commands that precede push options. Handle
push options the same way.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 send-pack.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d2d2a49a0..66e652f7e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -532,6 +532,14 @@ int send_pack(struct send_pack_args *args,
 		}
 	}
 
+	if (use_push_options) {
+		struct string_list_item *item;
+
+		packet_buf_flush(&req_buf);
+		for_each_string_list_item(item, args->push_options)
+			packet_buf_write(&req_buf, "%s", item->string);
+	}
+
 	if (args->stateless_rpc) {
 		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
 			packet_buf_flush(&req_buf);
@@ -544,18 +552,6 @@ int send_pack(struct send_pack_args *args,
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
 
-	if (use_push_options) {
-		struct string_list_item *item;
-		struct strbuf sb = STRBUF_INIT;
-
-		for_each_string_list_item(item, args->push_options)
-			packet_buf_write(&sb, "%s", item->string);
-
-		write_or_die(out, sb.buf, sb.len);
-		packet_flush(out);
-		strbuf_release(&sb);
-	}
-
 	if (use_sideband && cmds_sent) {
 		memset(&demux, 0, sizeof(demux));
 		demux.proc = sideband_demux;
-- 
2.12.1.500.gab5fba24ee-goog

