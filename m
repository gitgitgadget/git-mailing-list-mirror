Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62C01F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdEBQCG (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:62221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbdEBQCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:03 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9OMc-1dDmuY2u5e-00Ch5j; Tue, 02
 May 2017 18:01:56 +0200
Date:   Tue, 2 May 2017 18:01:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 09/25] mailinfo & mailsplit: check for EOF while parsing
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <a27646674c0548c891433945f99891b1bfb5d8a4.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:02KjRXHlvtA9kszMq626rIyNX82gEasKJQh2Kvcy+tooPzuW47R
 76bpqVbqMiMzXz0VUERI10YE/XoaZXS1LgKnk0WiUcqh3Xhtmm7z9lWM60bpe4GPcfRnb3p
 p8x6gv99298Z7lpJqyxRgcVNcCcFQ5bbWdvRdckFG5sc/3xW6elwBMTOqRbElBvUVwJkgQY
 9onD0AFF2L3H88Uk+NlDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L7Eh8W/scRM=:nBpqt8TcwUA8lAH27PEkB/
 MYF0upoiQhF89RKj2SGNHKloJGYa+if0Z4bSNQI3WU3gWVWAkr8RpsBTd+5tH19ydGO2k98CS
 jtkZPV174J5SKVQbE6KXklILgM6oyqolNE23CM3lNpk/xe7tixlhHRDOcDK55W78facpW9wX1
 4zgiuJr80w9uyi7BYDKmAK4YeiCze6opGsLYpzMYfUdcGMD3SIVXiUIDpmkNstg34h9FesR6Q
 dZCESklKdKKo6xnaXKM1D7HxN2cmGMIqBC386WNJOPdbhsfpkc+y2S6ku68ZKEXwVIr+JhlL8
 CyeyG567bcFo0EJm1ElTlymUjESkvnrzaYqKU4N3I3ikApP3fePK1GpCBMEgaGyy3VJypl6Qs
 MdE16EtOhhHs+gwqTRyBuKw7xXDcD0TAfk3FCarfP+L5zHiqofQYyFDy+os/2zv/kxrl3JPO4
 y81oTP9md7cY2XbqPbKOPkp2WYEPe9fBB7pmjG6rjoHWEHc4MW+q3+SkpRHnKb5SK2LSKolI/
 RqEo7iQ17rZKthEgK8EVp4ThZGkMwS9f2TPEXwecPcw2yKVHRx2BHRHv5qzgsjkk6MxCGki8i
 +CGb8KIvWLqukhxuXwylDvZEFB6g7I+xOhF0IC36RgZF1sjCwa2My0Y/hFGIdjqeTD4b2Xv9g
 2HjyrPz3hJ/mo6eDjO16GQ2w4dSZ6PTEsCuzzPCffuv/dQoXbTLRZAcLLggTarU50e9WBWf44
 d9orUCd0ApxDzNVzKZuXNeHX7erAqcrxm25Zb/9BiA2tHXZvXJT4ZNxZFphG59AYylBluEDyD
 xcfRWtW
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
 builtin/mailsplit.c | 10 ++++++++++
 mailinfo.c          |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30681681c13..664400b8169 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -232,6 +232,16 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 
 	do {
 		peek = fgetc(f);
+		if (peek == EOF) {
+			if (f == stdin)
+				/* empty stdin is OK */
+				ret = skip;
+			else {
+				fclose(f);
+				error(_("empty mbox: '%s'"), file);
+			}
+			goto out;
+		}
 	} while (isspace(peek));
 	ungetc(peek, f);
 
diff --git a/mailinfo.c b/mailinfo.c
index 68037758f2f..f92cb9f729c 100644
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
@@ -1099,6 +1102,10 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	do {
 		peek = fgetc(mi->input);
+		if (peek == EOF) {
+			fclose(cmitmsg);
+			return error("empty patch: '%s'", patch);
+		}
 	} while (isspace(peek));
 	ungetc(peek, mi->input);
 
-- 
2.12.2.windows.2.800.gede8f145e06


