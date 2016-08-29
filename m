Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A701F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756660AbcH2IEj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:64413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756425AbcH2IEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LmK3e-1b4Om30TfW-00ZyQe; Mon, 29 Aug 2016 10:04:33
 +0200
Date:   Mon, 29 Aug 2016 10:04:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QZhPWieS0g7vqF6fo48t0xUivvjNMIKwdlakaZzfseuJ7suqt9b
 Z6RInnqYzhQdbYmXXMYJzpwPrHLVyCXuLgQrO+JF1HeE74TTlPr3RV1Sl+Kd3CFJ/4GvDH1
 xNMcjud77/+ea03zqQ766OZcm2pEGPnxv9y3um+xW+ie/8VE5atg8L939mfavXcZczezliU
 1ezIRuG+LRtEpnpQnLMPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qEFOWWmYqCA=:inmKpHagse/VajjIRrVY+K
 AQjQG1GpOxyjbAo+PjViK8kwW+2vX3Br255MA88OYcUw7EKRzJB7eW18CzMi+BHk3Vw6andyp
 O91ExZsPSdLSzflCDE61SrQU0FB0gCwjfEG7+Bdlsz5y3PAeSyA34XMbuqjUQkH1bPPRLaAN9
 T5nO00AzXSvVt1WgIVa7XJ4Y3vzAuWpuWQRveekuWzl/WhdpsQgZ5uDpuR7Ku+Wj5TjJX05Ch
 DtuDS9L3nR+DvLiOBdEqjsaFQGeFvO3ogA/PINihbPrGZ14+v58ZpAJE49sW17BdHNpMApW7v
 LBGlZ8ms+OS4EUOEVDE1l/05oGpRC++ByAehN/16mQ1lQEPOlkRDjBhaer39BJEsowlmCfWN1
 eNWjO4SvEGqAXuhS7Ugoj4DALsmFmxaEMPtyhFCwacXvh9QmdaKn89Tu4zrpb/Kxo1pptvzX6
 cmKMk8JYzFA4k9c693UHV8zkocJRtpAPZbElNqAyVXEw/aFFzutoZACKtnn/4KtkpoJUK6Wxo
 fEG5PGy9WIlx2Jc7d/gGYNROtb9L3Gj89BT6OCYhT51nwqtTY0zdBHj14aFMnmuHlJfAeVgMi
 MY+7hCOWZVBm62eIqMNCHMWmK6xQi/O44blTrkcqdW0l/AujE0VvCnAUaXRHjUFWj6wwXkCVo
 eoUxcbwbPGtKMg3ZM1Uie4QIw8aONYTuR/o1ozuC2jO5isyY0YYQlpbHjflYUiTYEYfPWuAMj
 4XmTbYMF55WPUrd7azazrCKzfcNsdX+wc/mEBpV5DnhDEI4XFNKx7KHp5i3KMe5nJ+3Lt81xS
 gra27ft
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
like a one-shot command when it reads its configuration: memory is
allocated and released only when the command exits.

This is kind of okay for git-cherry-pick, which *is* a one-shot
command. All the work to make the sequencer its work horse was
done to allow using the functionality as a library function, though,
including proper clean-up after use.

This patch introduces an API to pass the responsibility of releasing
certain memory to the sequencer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 +++++++++++++
 sequencer.h |  8 +++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c4b223b..b5be0f9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -114,9 +114,22 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
+{
+	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
+	opts->owned[opts->owned_nr++] = set_me_free_after_use;
+
+	return set_me_free_after_use;
+}
+
 static void remove_sequencer_state(const struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < opts->owned_nr; i++)
+		free(opts->owned[i]);
+	free(opts->owned);
 
 	strbuf_addf(&dir, "%s", get_dir(opts));
 	remove_dir_recursively(&dir, 0);
diff --git a/sequencer.h b/sequencer.h
index c955594..20b708a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,8 +43,14 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	/* malloc()ed data entrusted to the sequencer */
+	void **owned;
+	int owned_nr, owned_alloc;
 };
-#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
+#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0 }
+
+void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use);
 
 int sequencer_pick_revisions(struct replay_opts *opts);
 
-- 
2.10.0.rc1.114.g2bd6b38


