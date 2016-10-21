Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433B120229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbcJUMZZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:63714 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755491AbcJUMZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:21 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MBWo2-1c6x4E41Y6-00AVxb; Fri, 21 Oct 2016 14:25:09
 +0200
Date:   Fri, 21 Oct 2016 14:25:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 14/27] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <33b991f51d58ca092b972259d80bf11bacfd843d.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3pPuT1LIvdYCppVyBH0wlyxzitIPxbBEMGATAtZSq9a8LhxL1di
 AS8jKN+7iVT9OMRDuKsRV9jsB7ngulpEQAenTOmZiQiejAvfyuuzSBVsHugLDyFRgeRz7lS
 n6J2GzgGbnox9b5nd3WAOVTmhc7w2idsUrCIPSwlulwPepRQQOUi0zjahlxN/KlkoBovI+P
 nXIWx4+fQy+8JFiGBjA9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L6faoM8IMGE=:HBBL7PNWEJbqrcZYdwg/hZ
 vSht+xjJ1cHaRXrGDKXKoR3NL/Zi4FXDxZMgTrCHajVvoLPhfyDfMDXm74aNDGXkk8mLANm/2
 DrjX5q/W6rIGtA9x7AiJj93tQl+1cRLWpQRW36CKR3WyRcaibC8/Sg/HYzSV7ajf2dvKZn1EF
 4m+1OFcrQOAia+ZImmp25LdXKCOwZ1LikS8hOBtOf16HEiyZgw+xDzbN4p+Vq2wMmBTnHvPRF
 nYkVOtgw/05i/O2YvGJECMT/pNesvAFi6ZDhfgG0siNz1j5Wzv5mS0BSsm9CDrn8ek+r3wIky
 3M4WT07dI0pYmjzwJx2tsJA3/P8omRuJU9UUmv1xP8NH7MDYRn/LvcRFIrN7H0erDQVyi5TOR
 m8INisjRECA/4RykTqNxSkbVBbyFLDCFi7acbDkr2vzYhngrD1wF8dcwAAaTaFoxnI41ahNdX
 q5ColSJckjgt9BWBcnD2WZyT8dt6195KHp1+s0kV+gzLg1xKhqnybwUaRm/zw8LgamBu2X6RD
 fi4HafwbOgJmikmuNcIUZeWTDSEfudSNCtyTCaP7LWmIbe4LpuIGqgkVkP+e2t9TBqvH5x/If
 yRguBEaKVUEcgOudnFTEnZzziTDcsoHk0MdTZZZpIuwQTlSjNm84uw9menqAzwe2hhWHzW2Pk
 G3DMcoEzbHRk1vWnyz/4SoBcpzHVCexCLmI64u5Ge3pJWgLBkzTZanei1HgU4gCKHsM5l7c3a
 duz5pfObDSCrNMXcqxQ2aacXgJrNMHIB1B3pUtF5K+5rXeYjXEgwzgWs/FRMVS7OmDo8CE38V
 a1RjjFF
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
 sequencer.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 6d5fe94..282c4d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,40 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	return 0;
 }
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e. with an
+ * end-of-line marker that needs to be stripped.
+ *
+ * Note that only the last end-of-line marker is stripped, consistent with the
+ * behavior of "$(cat path)" in a shell script.
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
2.10.1.583.g721a9e0


