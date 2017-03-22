Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9365C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdCVWWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:22:12 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35312 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdCVWWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:22:09 -0400
Received: by mail-pg0-f48.google.com with SMTP id t143so47667467pgb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+TEfZG8fbuvo9Xn0KA+EXqzAdunDlNF4Otx0SeGx/4=;
        b=i98rJCLrKaCMkb0l0YcSsWjStNeZoIoNekI2MRGrsB/maDewDPjfD+DuRnHJFqq7Yr
         DC2QPHkRjxNYgqQRdSzm8e5eOe+o1W/esaT9XS8K9Wsci75+BlczxqCUxA9hw8BMYEOc
         OC7FgiEVH7H91TrXHyugToqDQeN2XzMx7NlVji5Zqhs/ks6JSO8jVfMrsZW5cF/GqX77
         GAPrXOfqVFIhfmJWUZrwlXTJOgtu/cgUxY3QgW72jbdxTlSEOS6mU1tpg2+/iDuTNWqr
         TDUS/YoA0069z0GXrGCLaLmeU4laz6E/17+AHO+oId3FCFB/IoPz42EiOxv0cf7JA4Mh
         9UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+TEfZG8fbuvo9Xn0KA+EXqzAdunDlNF4Otx0SeGx/4=;
        b=s5DGYHi5327v0xPJe3CjkdFUAzP18k30sPRw3xpy0Xqeg4KPwDUr0O2tZZR/ILsHoh
         +5CLQXk7ITzG7GhLPiH2JapfSVSstEZw5lBBUwQOyjF00IL8FdP7WJHpydrBW+jtLzi3
         TRI2drg2DH9vP1cB/tabJC5zkpwkwDrH279qmgiutGkFX+WU7uK/qo6Vs96fHXrKbsAO
         jAEufx9P2geQpalrydGKLpSkeFjZHesvANGjuDpy5qpTQ1NGUt/YKBMDVfOV7zTAJ0vz
         HmVhztWGnDAjGhuuDRn+v1GNCMmZOPAImTsFkpKRgXdFiGxuEdQFfg80uAKYK4EisZSv
         AoEw==
X-Gm-Message-State: AFeK/H0e1xobfDpVOS8hyJPEntHNHFOAC1OLGFobjTnGQHCGVbgCCCeksVn/G6pZpNUmx5Ed
X-Received: by 10.99.230.17 with SMTP id g17mr45985776pgh.84.1490221326926;
        Wed, 22 Mar 2017 15:22:06 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t67sm5813582pfd.76.2017.03.22.15.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:22:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [PATCH v2 1/2] send-pack: send push options correctly in stateless-rpc case
Date:   Wed, 22 Mar 2017 15:21:59 -0700
Message-Id: <20170322222200.103204-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
In-Reply-To: <20170322222200.103204-1-bmwill@google.com>
References: <20170322195102.165314-1-bmwill@google.com>
 <20170322222200.103204-1-bmwill@google.com>
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

