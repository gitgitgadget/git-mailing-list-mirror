Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FFB20285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdH3R61 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from mout.web.de ([212.227.17.12]:59259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1dDETT2iag-00Zwe2 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:25 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 02/34] am: release strbuf on error return in hg_patch_to_mail()
Date:   Wed, 30 Aug 2017 19:58:05 +0200
Message-Id: <20170830175825.20905-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:TNWnLWtEqAflJgisHXgcm426mkwrHJehwiFQVtwkwqSBa3UYu5n
 RHzOSMRRd2ih0WcuARAVltbdmAgSHEwCiYCKOrjoH9FZY8ad1gjIkHFM98czJli5qiS5dnp
 PAXm5kobkKOitwFQND708krpZIEJJ+9Wswx4h0BzQVm30r2ZF9a9qRTiucS/hWryz3nQFwJ
 k9QyRTMqR/BZB8EBzHvIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TpPI5RfkVXw=:PJ79QOac+xWWnZk6OPmxpr
 4gnu476Vzwn9z0LG7Jueblb4ctC6yu4rHKeEG4/9pN6xQ67YoYHmkLFruSBGLSN7kEgeGUV20
 AS1u6YvYie2IbIXN1EK7kBnUD//s0A7PQsZf48GicOGFwHVJcupQGDDusBj7WHsnv8hEYx0BS
 gUv/5s81ow3A3sJZgX129SyHaBLxtsgNngWaQu1a4+aOB+GaXVvXMkgi7Ou1BLYNpkLTqc5pT
 qNmkVg6H3kQcW1fVT76F1kQo8BevI31dfgUlvVKpGYRhD4uNENArV6Z3HVhUxnstCqpIt0qaP
 GVag4mCeEfSJwGWSupnuPARS/V/GUuT13OBLp97luScps26a7tkLbilJBfxkxJmYVc61y48Eq
 33zQ+IaTPdaJTzCpzZFhnsuQziyIrug8kJmvF/RlkqlXjGEuyGBLLeQO319U3KXrI6nvPhGKU
 s4PIiA+FbXvKrI34ai34iZ5YtKvnQ06GZy0eop7eTlPQ9RZ1sRlTAIcaVQLhwM/+BoYQAqJSe
 DsaYArygjlxIAT8MhMRUkS1X5U97/nLGnFEAbLWOsbCDh0P17MzF96s64dVl0Glc3JIuVmJKr
 8C2EfNEQ1TJD9ifP+wgxyr4B32QwagHIhtdTr7IXFDPbI3cw4IEzkqQ9XB5ey1V1e37krjs9n
 PxxSBYs9Dx3RX77ZyCman6JjhpCiowowv/lU2zF0p+7jO+W2cJx9NLwXqmqThDmwfazbrqrWp
 x0GS+vVcGQll8E5rapqcME8FpxLO6AouTyDjyMlWoTGCczOMNG2VOX2W+TjPQB9dIrXCNvRVy
 kKTVaOEwa0eR9TLlA8M2vU7kLZT8A==
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

