Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82327207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbcIKKxN (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:52666 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755546AbcIKKxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MJjUO-1bhvvD39KW-001BRm; Sun, 11 Sep 2016 12:53:07
 +0200
Date:   Sun, 11 Sep 2016 12:53:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 05/25] sequencer: allow the sequencer to take custody of
 malloc()ed data
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sGkrpMMLWbkG5WXDTt/riSsCxpxBMPHtNM3iD3akJPedbeP8fan
 vTxumg6d64xZqNCx5IU9NQe90jlVBfXBHokFceewn5b6hVExrkepq1EmH0Brnwr5y1dW5aW
 +5TE4ZremHKqOws6wPjaT44lNFOG97TI5pP18jvLH61v2xdT0GcfN8T13h2o74RQw3LEe6A
 zePs+Wr9GcU+4KPqCUA0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+emOhrtyeqk=:lhABM1V0R47nRo3QqNlwk9
 ne3z3gjfAqognFTqNrYTq5b12uOYZmIvLYcTxa5kxg9YnmkL6C+wVSeuONcmrNtJBBewTrns0
 lmgkERE9VMhMfKqi9fdJWpsHvndJ8Qvi6xuEAM6NwawEXBW6gx5YCxCrPMSpZwBNg4vRwy6Xj
 e8g2VLqc2Re4NRfRcZBei97CMA+gsTo99/xvu+Gfl20Ec7YvDHGiyBNEd/SuvFQj7TCjUB8lz
 NBCE5V2eKW45sxxpykKMGDXmW+2henmgffyTFOB2j/Ohl6adzguP218ljneGXBXb1/nygsIIS
 Yw5jCgY7F3DJYxOl2jYrwo4Q6BGdwlTNDjbf0lIPwjqy4mYlasrWMVWkW3uCDJzKEa9fHkqlJ
 mflCTFFN25SdN9h1AyssCbgg4q2hadA7yC/USFnnixbcctbuvmtqt1Vod0EBFZRFS/V6UoBlH
 afxIxn+RVB/fXz8JlArxdQDQLFX4lTZ/ZyU4/uuHqwH6VBOdjLnVjdcyiILZdwyPKcJXyNJW9
 PHQcoBJo2n+SxIW6xW4TfUXifqnsz4/P/HON7uw+rfOoT8K4F3+v+S446WHWtL11dmPctO3EC
 FYNSAU1+VIu4DUx+a7/+/61oOcz7SIHhbu6U6ZKDZqwBQ502qIqrgbDms4XOV85zyL3t7tvjj
 8zHbLuIsBFW2fpHkBhpah8Y7iA65npw7yZMl18r94W8W0S/QiOT2ytvOJwjVatrtQP/r9zKd1
 9dcFlW2ucBL8R/7RCFVmYcCohgsdAcW959vTGUJdDHbTkmgGNMhBXYj/Dg9AMUZBRSqt+SjvC
 fsoibdk
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
certain memory to the sequencer. Example:

	const char *label =
		sequencer_entrust(opts, xstrfmt("From: %s", email));

The entrusted memory will remain valid until sequencer_remove_state() is
called, or the program exits, whichever comes first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 +++++++++++++
 sequencer.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 8d272fb..8d56a05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -114,9 +114,22 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+void *sequencer_entrust(struct replay_opts *opts, void *to_free)
+{
+	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
+	opts->owned[opts->owned_nr++] = to_free;
+
+	return to_free;
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
index dd4d33a..04892a9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,9 +43,19 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	/* malloc()ed data entrusted to the sequencer */
+	void **owned;
+	int owned_nr, owned_alloc;
 };
 #define REPLAY_OPTS_INIT { -1, -1 }
 
+/*
+ * Make it the duty of sequencer_remove_state() to release the memory;
+ * For ease of use, return the same pointer.
+ */
+void *sequencer_entrust(struct replay_opts *opts, void *to_free);
+
 int sequencer_pick_revisions(struct replay_opts *opts);
 
 extern const char sign_off_header[];
-- 
2.10.0.windows.1.10.g803177d


