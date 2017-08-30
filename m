Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030BD208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbdH3RuR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:17 -0400
Received: from mout.web.de ([217.72.192.78]:51523 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhRh-1e3pA83yYn-00J5vQ for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 02/34] am: release strbuf on error return in hg_patch_to_mail()
Date:   Wed, 30 Aug 2017 19:49:33 +0200
Message-Id: <20170830175005.20756-3-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:kruqC3T814ePwmp7nCivZOHj3Fy//bfZJGwJzwoIzadMU6WcfId
 pcMrYrlUsmCgT8EixeMNYHy6cHkUr3baQEBjUzC3qCahv0BMVybHD8ULgmU4zVN2irHcKbE
 9KsPQKTZB0YVgiptMp5zQlfT9x0I0MXvXMTGEpNtj28jkADY8hd8w9CRwDPR0geB6pHrtkk
 NRGeOMlUmRoh9oHAw3mow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dcJpwKgBpWE=:TSnNHFFH0oie9oBPaA1Bmk
 rT50lkLn+t7GcNhpbB76lKeQjwp4vd5RJN1hnihdOFGST32fgpyW61VxBLtadttctyFZGHo0C
 zEseN3iIlQTXWodduvPoQktnXKwlqLk1NmD29WMHGZX8Lw8S+oBcVu+/od0PfW1B62JV5iDn6
 VW7s5kUcEfr8OF40rm0sBQ8IMAhCymI7dOYvNsCYsPOrhNgAoqeHQaFsiZzqPTTBGQr6dkBut
 sFzZwOflOIpFDkUakkJlk4gMepLkLol8QBD1KEGim2SwKwSCg4ttveuSHk25holV6sfUhFuWz
 KdD6D79ara3XCW6iUWnZ2CGL05z3b+8PdXWZp+ePRrjEev+T/YV0RXiFb1yOXDS3bEp/ShuIW
 ypbjz6RL8sek9tugfTFg5IpyPfSGGlQAxS22VAIQnYSpOGZdnpzaAEcy+ciT2hl+B+gEjbHFj
 /2KRTZqgHFHww6mhTRwzSF6C8XvcsM9h9B27NuD8k1lD6vnNCuOY8ZayfAerswJu3MoSjWuad
 PECKgyg8DImjh414OrWN4J2zdIHvxqR9Wb5DPVhedtVyiwNeCTJZuk83uUAGXim8T+5nnrb55
 WElsJuhNH+iPayf4jJiDvXsnQjaZSLBdNe5F3vbYbkTMFrGvnpLuPo6qq44mJpE5Xyg8d46ra
 FKkB0b0Jh5sJyU0+SNscIb04Fu+JSyNuSMSviuqX2HUiviYno/LOo0D/5bpmp783ciFIH6Xqw
 2+54XaJqNbRfx7q4Uz+6wqBgcJAmS28qhRRDlxx9iqstjNz8hSKmJDEBMUR1P+ZdLHsSNPw2R
 RFdWXyiV8eEqBv8NZ63Qnxq7WhP7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3c50b03faa..3d38b3fe9f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -881,75 +881,84 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
 static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 {
 	struct strbuf sb = STRBUF_INIT;
+	int rc = 0;
 
 	while (!strbuf_getline_lf(&sb, in)) {
 		const char *str;
 
 		if (skip_prefix(sb.buf, "# User ", &str))
 			fprintf(out, "From: %s\n", str);
 		else if (skip_prefix(sb.buf, "# Date ", &str)) {
 			timestamp_t timestamp;
 			long tz, tz2;
 			char *end;
 
 			errno = 0;
 			timestamp = parse_timestamp(str, &end, 10);
-			if (errno)
-				return error(_("invalid timestamp"));
+			if (errno) {
+				rc = error(_("invalid timestamp"));
+				goto exit;
+			}
 
-			if (!skip_prefix(end, " ", &str))
-				return error(_("invalid Date line"));
+			if (!skip_prefix(end, " ", &str)) {
+				rc = error(_("invalid Date line"));
+				goto exit;
+			}
 
 			errno = 0;
 			tz = strtol(str, &end, 10);
-			if (errno)
-				return error(_("invalid timezone offset"));
+			if (errno) {
+				rc = error(_("invalid timezone offset"));
+				goto exit;
+			}
 
-			if (*end)
-				return error(_("invalid Date line"));
+			if (*end) {
+				rc = error(_("invalid Date line"));
+				goto exit;
+			}
 
 			/*
 			 * mercurial's timezone is in seconds west of UTC,
 			 * however git's timezone is in hours + minutes east of
 			 * UTC. Convert it.
 			 */
 			tz2 = labs(tz) / 3600 * 100 + labs(tz) % 3600 / 60;
 			if (tz > 0)
 				tz2 = -tz2;
 
 			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
 		} else if (starts_with(sb.buf, "# ")) {
 			continue;
 		} else {
 			fprintf(out, "\n%s\n", sb.buf);
 			break;
 		}
 	}
 
 	strbuf_reset(&sb);
 	while (strbuf_fread(&sb, 8192, in) > 0) {
 		fwrite(sb.buf, 1, sb.len, out);
 		strbuf_reset(&sb);
 	}
-
+exit:
 	strbuf_release(&sb);
-	return 0;
+	return rc;
 }
 
 /**
  * Splits a list of files/directories into individual email patches. Each path
  * in `paths` must be a file/directory that is formatted according to
  * `patch_format`.
  *
  * Once split out, the individual email patches will be stored in the state
  * directory, with each patch's filename being its index, padded to state->prec
  * digits.
  *
  * state->cur will be set to the index of the first mail, and state->last will
  * be set to the index of the last mail.
  *
  * Set keep_cr to 0 to convert all lines ending with \r\n to end with \n, 1
  * to disable this behavior, -1 to use the default configured setting.
  *
  * Returns 0 on success, -1 on failure.
  */
-- 
2.14.1

