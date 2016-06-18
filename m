Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145891F744
	for <e@80x24.org>; Sat, 18 Jun 2016 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbcFRKEP (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 06:04:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:49413 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcFRKEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 06:04:10 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MRGPP-1apHTd4423-00UZFC; Sat, 18 Jun 2016 12:04:07
 +0200
Date:	Sat, 18 Jun 2016 12:04:06 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] shortlog: support outputting to streams other than
 stdout
In-Reply-To: <cover.1466244194.git.johannes.schindelin@gmx.de>
Message-ID: <c9990c2ac84f43e76afc52e5cca5d8876715e004.1466244194.git.johannes.schindelin@gmx.de>
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rS8EHOo3b2J7W8rNJet/+qNskuYRaBnOoUK8CVMSXDa2Ay2x0q+
 10cZyyzPPDhzYvlEPoopQlBhO4wcdmYqaCo4HIFYVWLhx9ugIv0DzxrBcctj/YvL/riQ7uK
 /FA1RzVB6ma6g37gLZVIETsAq1T1Tg3OFDlf660t7iPvsYTg2QZO7cc3WCqKuGD7bYxBVCR
 eDzuSAH+lqUbCq4V+01Vg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:g8bgXy2/go0=:/kXiXQp0br0J/HcX2cYwWh
 hnj9gR0ToQgOYBIoVy4aQ4GiM/PBF0dWw6OYRWkoUF4adhgQUJxz+9Y62ObuHbcNVxxsN0hwn
 rBLpvMuMKpeVKcJlapR1SzsG6VXdh+wv5udbk1c+PNF6FcVVxxfmNTE2WTaiEVRwZSVTC7W9N
 OsFcsJbkdZFNXkTL6uOTNm7etf7myIHgdrb/SX+lcNld0xThyNEJr3ciCNuZaQ99V3wAALNFo
 ANmHOSBfjvIfhRlcV5jy7Z6Bfb3G60OxrEMeOgQULL44br8LW/dJFKCyC3NRUPOnhJdEUdcjH
 +yE7efeUQ4/xOFWcwPcBOVASjJ/zEkKm4TdSByn1hd+gsQ+Ke4YX03N3WJCACG+MYriUzg/1x
 kxe0XalPp4+XRNWgseHw2CS5i/yq0PAaAaJQExi3FSLcsXrB+I44h8Dm/rj9PFDQMuRRY2GKq
 lj99Uxc2achCuzag5XmcYVW69lNXv04bPJ25GfOkqbkHbybk4cBIABDNFhcW4DmcGE4T8ryt8
 xgpBHqbng+FX1vdEcnxn0MvEkXvvcb+I7LsCBxg0YZ58hUNM0ipx5WbQWe2hoRfBUpV4Cb8dl
 OlqHLI/BIJMWyf96XNkjB14VU07Bxea/B79jb8DSpRe1qLEOweoneDHHhzW+6fd6HyQ4P55XT
 6DzW88DMdbAJNsXQbCzQMifQHflogU3FXqo96dpwOnptaGtcNVbQVTuu4gz4TmUoefUpMYtEO
 IZFkogBYSmQFZ15tSY4EjujqN52ROapO9H0xMFS/RfW1aAPKcO63Rlv2uilvL11aAbz2VE3G5
 uBnJ6wW
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
index bfc082e..4c68ba7 100644
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
+			fputc('\n', log->file);
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
2.9.0.118.gce770ba.dirty


