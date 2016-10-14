Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10281F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbcJNNTJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:59433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755885AbcJNNS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:28 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LcBBl-1ceJIH0SLV-00jadS; Fri, 14 Oct 2016 15:18:20
 +0200
Date:   Fri, 14 Oct 2016 15:18:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 14/25] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <dbfd332f77b9077b03454fd7dc079fefb8d0c284.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nHq34GAaiTdOel85KYLpkN168D7hDQFcmwT7MX5aoC8TnoA7IT3
 wS4ts0HPSQtjhOa3FJkebQ3IRqriSc4w6w3gru+L+rYNH0Ryd1+IxTxXOFmb0lhdVWu1myn
 cA6HsCHmIoLi/ZivkmMJupF2hZSaKD7Qgxa0kU7n4oGJzcqk9CMRJvtUMvbhn1q+8QF16kd
 1qaH4GapNLYqsV3du28oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x9LC/cX9yoA=:SXSxS/TTBx7iEgwXlOzLdD
 irq+opffTj61YMQeenIMd1Izay+EOeCnCl3ferekLdk4B+8ubI13SY/2vkgg9sA9ynrYwR8qi
 p8bXKIDXFXs48wAKbrbBAB68Swt0o8vsYVtfZ8NaBh60DGAlIfnxWH5WvKpZnBLKhxrs+GaSx
 3nouFdu90dYH3wmfP8KWRID7MVl0otr1HDbHQk3eRf8Sv2NJBkNx54aujyQqCtpX/ukhtBg3b
 /53KxaLw4QKJGJoSeVKOAg5MtYl1/4S8wG09J3PEQCS/lTwx2b9WiWhNvIbEAS956A5eSfqg0
 OWPB53vZSVgDsRJVu66bgCl5Yx01La4jpY0JuZxA6r4boRSNA2O4nEN50M0ASWffT1MX/oMWU
 cJzZ6DWiBHcNRIwPNd1d8LQUCfWZmdnF7TRCM0SK3L1WZGIN8m03dfcg8iDeXbeF1zW/UKfgL
 tp80uYq48/xjCY6abKUanaKtl3H3FhGcRdhqK//Y23H28KlBkwZkeH/PU+Cqy2ohcY05/eyGN
 /mM8KiE//Sw/6I0ntE7gBN28+dbHO4nD8oIgszF3KJwdBI7+gMNCvDEpJ5eE3xG9EK8zFz/Ou
 82GhsjLqFr07+sPE87RE5E6riiXuVlXx2If5hnItYG8IYAzczLyZYd9WsETKwzRtmuW6ly/pq
 IKZZRRCPTLJ8pOGCQCklMzlLMMuF9EdDFXoXi2qXZg9awpCdT1cGr0XJTpD/NbpXbheOiNiEA
 XickwSm0EmXOmyEMJ0uQga2RcplKlPvot3cn49qopI1sRaMV8Cp00pBSEIwLWPokBfouGTGmz
 hU8YcUf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are slowly teaching the sequencer to perform the hard work for
the interactive rebase, we need to read files that were written by
shell scripts.

These files typically contain a single line and are invariably ended
by a line feed (and possibly a carriage return before that). Let's use
a helper to read such files and to remove the line ending.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 99c39fb..de6b95f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,37 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	return 0;
 }
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e.
+ * with an end-of-line marker that needs to be stripped.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+static int read_oneliner(struct strbuf *buf,
+	const char *path, int skip_if_empty)
+{
+	int orig_len = buf->len;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (strbuf_read_file(buf, path, 0) < 0) {
+		warning_errno(_("could not read '%s'"), path);
+		return 0;
+	}
+
+	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
+		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
+			--buf->len;
+		buf->buf[buf->len] = '\0';
+	}
+
+	if (skip_if_empty && buf->len == orig_len)
+		return 0;
+
+	return 1;
+}
+
 static struct tree *empty_tree(void)
 {
 	return lookup_tree(EMPTY_TREE_SHA1_BIN);
-- 
2.10.1.513.g00ef6dd


