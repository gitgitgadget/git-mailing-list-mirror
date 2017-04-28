Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554EC207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938068AbdD1ODJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:55188 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938012AbdD1ODH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lcj9b-1dmY3Y0S51-00k5IK; Fri, 28
 Apr 2017 16:02:59 +0200
Date:   Fri, 28 Apr 2017 16:02:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 09/25] mailinfo & mailsplit: check for EOF while parsing
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <32a2d16902734c8794de61b5e86a0d2a6cf43fa3.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F2VPfoT+/UbChygCD96JYYrxaFqtqZUAJBiYZh5X7KAA2QHJbtc
 X4cBvGR8HGjEWN1jLMbGcJYMNccBnry773oxNxub3PNMDvSooJ/eJ68KkiIhpE66xIjQSO3
 F/TcO/Jm8kcMZvSxQxswHtIbSFAc4gjYDAzMfopOKZncgo3VuCAsKFuq4PNzMivq+gLOlp4
 0F+t8xoRx7L6bk2l6XCgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yAFmoQT8XRY=:eKgFI245D+H2sZZ/g4MmOn
 Hikr1nct5pju8W6P1u56iQib7RvEtEtJ/x9UF1yDFszcVUlwG7T463aMbVYtmhugFFcFKuwWl
 M0CpagBad5ikSG2qrnoidqOFrUw6pjBPjMUNygBhD3Z4teWNUZVSoNrakGeh334AXxyv3zM+I
 MtkWi5D+gtGFRpahWaHvS4SkHdesawYht+8xWXNcnl255vePQvfmpaxnKaa5uj1ImEyiH56fI
 kjsTGbN7AUIIZJAshvCdDEP6YjhRInGgMMtx3RFokVw8Nb5ria4UP9t5Dg8uu/ApTV3VB6mdI
 ekh2gaaznzzeRU1aqxMX58skNO7YNuQb8TeRjbpIcSYCn3Xi8xzso+vG2D4oRDW+dKvMKfQ6m
 817NTBJ2PWVGKp0H39Ss5L7mR1HVlbZGa670eROC+ZTdfW7MvcGX7uQqZSPP+pN0+Srf9gqKT
 Bi4HRfDwh0+7Vv2bF6knoS4+IMYXhD/cRV9xpVhITkrIrlAb4ekQ1FhEN/wZb533BoJ2EGEOU
 U3OLfCL29Y6lPZO11i2kkiC8VBXokqTRUmpbKlFo2hbBCKZ/ZnID0dLBRt/FDL+oOcnRNKbV/
 /iTAmEWIt6O5yI3geCZUFLakKas0sjhQevCdKD4a4dLlXPUrQxAkWotOv1CiFLs0I/2Wrvctm
 U9ztkplbG46dZbmNV3/icW8Lr9pKKghyPiyRjGzH8L+si9gM6U2XArrt7YQsXvYqn4udwim0B
 JZ3fQg5RLaTWpUEIoP/wrjBMcR+WU4Njt376718H8xrqB1NbZLUZPtHIUfk7U9hSBMqVMd3le
 sqCu/64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While POSIX states that it is okay to pass EOF to isspace() (and it seems
to be implied that EOF should *not* be treated as whitespace), and also to
pass EOF to ungetc() (which seems to be intended to fail without buffering
the character), it is much better to handle these cases explicitly. Not
only does it reduce head-scratching (and helps static analysis avoid
reporting false positives), it also lets us handle files containing
nothing but whitespace by erroring out.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mailsplit.c |  3 ++-
 mailinfo.c          | 15 +++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30681681c13..9b3efc8e987 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -233,7 +233,8 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	do {
 		peek = fgetc(f);
 	} while (isspace(peek));
-	ungetc(peek, f);
+	if (peek != EOF)
+		ungetc(peek, f);
 
 	if (strbuf_getwholeline(&buf, f, '\n')) {
 		/* empty stdin is OK */
diff --git a/mailinfo.c b/mailinfo.c
index 68037758f2f..a319911b510 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -882,7 +882,10 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 	for (;;) {
 		int peek;
 
-		peek = fgetc(in); ungetc(peek, in);
+		peek = fgetc(in);
+		if (peek == EOF)
+			break;
+		ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
 			break;
 		if (strbuf_getline_lf(&continuation, in))
@@ -1094,14 +1097,18 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
-	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
-	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
-
 	do {
 		peek = fgetc(mi->input);
+		if (peek == EOF) {
+			fclose(cmitmsg);
+			return error("empty patch: '%s'", patch);
+		}
 	} while (isspace(peek));
 	ungetc(peek, mi->input);
 
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
+
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
 		check_header(mi, &line, mi->p_hdr_data, 1);
-- 
2.12.2.windows.2.800.gede8f145e06


