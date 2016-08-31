Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506FB1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbcHaIz4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:60168 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933876AbcHaIzw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LeALI-1bJzq435iO-00pwp8; Wed, 31 Aug 2016 10:55:48
 +0200
Date:   Wed, 31 Aug 2016 10:55:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/34] sequencer (rebase -i): record interrupted commits in
 rewritten, too
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <556caa4188ba74731c84947b26b91939eb0a98a7.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l6mTxiuu0zxuz22sImCmQQgF4Zb3ZxbKgOibyacM+C1GW6RtezN
 Adyd5J7/hsN77j8nrVeCcx7AOPfILOujafinqX3R5gsRsCvwUPbzOk1wCTh0ilRVn4lRX/J
 oim6L6Z6mjDL1ZZ14eBY5NCyx2AQCcqKUmMWFvNb4e6Toozxd0eh6Eg5vB8otoho72gljDl
 5N+MnmREkbah2ugzwUKhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EkSpL0t+v3E=:E59vb0j/x2lbqMNbEn+12W
 tb64TByxg8T1xGH97m1aVR9jG/ojoQaf5pd0b3h2FnHHucpbe0e+fTqx0ntuyddhknbvES83w
 E8JMUyc2aaoLvmT4N4GWTozAs14soAq3IsQVipswT9hHpDgnGsseqyE1PMfTu+gHCVO+6hNpW
 SlSP4YB6/rELCyqHi+SSCANpo0C43PW+hojoKQC4ZzZYBDaqRetjmFo/sKCR0ATYHraZW5M29
 ngPY/AXWGFpBOrFw1uTKTKuYRzeS+X7Sn8DIkr+QcVzmNmDAytwW0ghyr8IceAKy0hV2fsp/v
 fsZz2SYB6q0j00PYqViR4etKUDNmZobExGWA1FNPDookm4xT78YJdLyPY3FghGscju5uzprKz
 0uJn4U3X25OIPAJv2+xeqzSF+LpaETOBUH7sUm9QVyODSaJ8JijcoPKx7hSHbzQiRZttvitXX
 XKg+FVVpUIuQ6u1vQWqobEPH7GszyvrOfHMWY52T71Z1eWcE1dlC6h5+yt9WecRtOxuJqRNwS
 S/yAVhkZM5oHgQzpeLLsPDnfFEXdXlZVFwsvSTuqKMe7ULQK+KijFm782VmpPuWWOmObxqDCa
 US/KqBoqPGOgUbucAdcBsKUKFtDCxZr5Agc/77sQ5S+pfcHhyFVlBlSYfR7BeGvcxkdDDVPeP
 xnwurWUGGNhdXvTDHQPXuiPdg9KwWGCKEunARf5lHq+KI6oQLjT9Q3f5OlvHiJPMGPaaqpHOo
 s5jYy9cmVoZR12KiQa84v3zd1kK+rlyQUE+6xGDmxvwzt8tbrsdv3g64KX93WPcPXC92qiZU+
 3C2nY2y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When continuing after a `pick` command failed, we want that commit
to show up in the rewritten-list (and its notes to be rewritten), too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a5e18f3..a00d349 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2023,6 +2023,17 @@ int sequencer_continue(struct replay_opts *opts)
 			return error_dirty_index(opts);
 		todo_list.current++;
 	}
+	else if (file_exists(rebase_path_stopped_sha())) {
+		struct strbuf buf = STRBUF_INIT;
+		struct object_id oid;
+
+		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1)) {
+			if (!get_sha1_committish(buf.buf, oid.hash))
+				record_in_rewritten(&oid,
+						peek_command(&todo_list, 0));
+		}
+		strbuf_release(&buf);
+	}
 
 	res = pick_commits(&todo_list, opts);
 	todo_list_release(&todo_list);
-- 
2.10.0.rc2.102.g5c102ec


