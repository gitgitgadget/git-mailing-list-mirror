Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674252018C
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbcFVPCz (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:02:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:63124 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbcFVPCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:09 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MgoiC-1b2ccZ21p2-00M2Bs; Wed, 22 Jun 2016 17:01:51
 +0200
Date:	Wed, 22 Jun 2016 17:01:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 05/10] shortlog: support outputting to streams other than
 stdout
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <3cc264b716f84b764e2fc1eef6bb8d8d65bfed67.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:P3PusNfkiPhihJy3zN0cnIJZH1atNHH3no5LjDAULhjImkiwOH3
 KVddHx5RnzfLoCysoUlNFInpS+WtzbQZTunpSxErurvKRW7zPSsM/ttUnEzzrx0aqfeDbjg
 NID5N6nfQa/dNy3sRY8Y9GNmJx5VOfdphTSD/CAW6wmwmCloZmLjvaHtn17vHiTQb4G7CfI
 Yj/srZqupXZw7of+JQ5oA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:x36EDvSMwJQ=:nI0DQ5LemJ9vpqEK3i0ph9
 Fj3BMfJBdkvoom/CSGFnDnceItc5kzfjPZiY2gKjfuCCNZjGxt4dHGC5S9v+vfCOvCOheRoQs
 /ewoXYd6V22imutXYE5cn7INeOU61fKjB4DwLWFa8+KVSP9Eb4MfgZ3RAbVwpklm9sblS3Xk+
 5MeZVncrRaziSLWTdODwRWzScZF2AC0Nc9lM/oLgkzIgUmvR7Thq8Ujsr05IDPprEfY0qZH74
 KkGOkBiDR5MXG0MayXsN/v2OYSlUccLOxxiJMEzHMOMBk/NfXsVKEMH9Z98uWy+cBHtXEe2Lw
 yXjR4kO6J/hwTXttdSD2L1M5Xv2IswgR/4VNZOr3pWkKjkIbfytkmBvt4ld2VhOi7q8y5R/Bu
 jWAJ48xPluCHX36ATcbArERH/vTadF0vDNMp9y/4L0OprQEPuK3wj1C2ku8tXa75FHVV8pMd/
 WaqD3zFsdSzJSmE61PVWi2eEKw4FQqr7ESjiemW1c9htO9ukYXfY7IWrOxyAAqK+B5IT1NNJ7
 eeUuXfoB48ne3X+5Xr4UuTho70Azhy6gth9pccSAiA5hw70aKEDAcsu9IC7z5JYVM5pnmLiIb
 YIsBxIch3P4y3UBNKaWbpCazf+UWdFFO8mfBbsysfADKQ8lCMB64ni+uSZ04MOF8HBfUiRIuH
 o7EzVtatYdFj9zwWXk6T55a+LU4L+E7LMEsydA5yPXio8lWwGZGJoA1+1OBPM1GCnEcJn0Wkb
 jbGqFD5uzOY3lKieO42Bt93rLvP49x3dcILV3nUu9Jpgn5yzLZ8O99YOzSiOIX6hrI6vPQXg0
 AD4EZy/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This will be needed to avoid freopen() in `git format-patch`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/shortlog.c | 13 ++++++++-----
 shortlog.h         |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index bfc082e..39d74fe 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -229,6 +229,7 @@ void shortlog_init(struct shortlog *log)
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
+	log->file = stdout;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -310,22 +311,24 @@ void shortlog_output(struct shortlog *log)
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
 		if (log->summary) {
-			printf("%6d\t%s\n", (int)UTIL_TO_INT(item), item->string);
+			fprintf(log->file, "%6d\t%s\n",
+				(int)UTIL_TO_INT(item), item->string);
 		} else {
 			struct string_list *onelines = item->util;
-			printf("%s (%d):\n", item->string, onelines->nr);
+			fprintf(log->file, "%s (%d):\n",
+				item->string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].string;
 
 				if (log->wrap_lines) {
 					strbuf_reset(&sb);
 					add_wrapped_shortlog_msg(&sb, msg, log);
-					fwrite(sb.buf, sb.len, 1, stdout);
+					fwrite(sb.buf, sb.len, 1, log->file);
 				}
 				else
-					printf("      %s\n", msg);
+					fprintf(log->file, "      %s\n", msg);
 			}
-			putchar('\n');
+			putc('\n', log->file);
 			onelines->strdup_strings = 1;
 			string_list_clear(onelines, 0);
 			free(onelines);
diff --git a/shortlog.h b/shortlog.h
index de4f86f..5a326c6 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -17,6 +17,7 @@ struct shortlog {
 	char *common_repo_prefix;
 	int email;
 	struct string_list mailmap;
+	FILE *file;
 };
 
 void shortlog_init(struct shortlog *log);
-- 
2.9.0.118.g0e1a633


