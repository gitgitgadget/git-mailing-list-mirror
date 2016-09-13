Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDF9207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbcIMEqo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:44 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33779 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcIMEqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id g202so59757695pfb.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MfphG+dCwwyk72ToV9iWRjJj3rkx403+4drkSM8ShbM=;
        b=isLUiHJwsKutQBjQmhHGUA5EBPBT8+Ft6s/PwiTYXa1DBIEL/vK8oCC5gEf8462jUa
         P46secxwWkD1EyJC4vjd+MT3HBkYUJEfWEGcaKRo0gH+m3QQ+aBchr0EG5E6VY0jylEr
         gwPg2GKy+73iwKCaU5oUkjdWKu3jpUSnd8QtU+OrQdTAJswEKB8WPwhlfwwCEfRopr1z
         FRjzAMNdMwMjs5Apex5WbMeeT6J1wlYhKMZ/dF57V0STYu8iqHJykqVF/hj1/+rbO/kf
         gxTCjYWdwV6cBjk7nAqWP6KBaZmmeSov2KlnufFWQwUBp/svcDWoJO7ypVfE6+bHctEw
         DDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MfphG+dCwwyk72ToV9iWRjJj3rkx403+4drkSM8ShbM=;
        b=cRfkHbE6zTCHpQ/gZHGGK3izfr8Ypy4ael0sxlIKogCLGyPRN4Nw5jh22MLrfCM/qK
         3ncqF5QfySxjmScamnJGMHJMOT2oiG405MutNELHJ5V4jgON73L9KO07tPGx7ttSdjio
         lGs7TGnvoDH5EJX38ODNlrm0VA0CDrIg6nt9CM1/pVHsWk1v79IqSgSO1pVpEoBoiCEH
         OrlYJos0JeJavm3dkrg7/NGrUPuMxW8B7Xu9z6YBTUl+Kks8MtXInC3Fl89N1WgyTs1Y
         IMzL/i0930ytZgc0AOPl7gTa62zHLcMQwaNb9h36EyqdfhUZPlkQzg71iiA1SEAAcjkz
         529w==
X-Gm-Message-State: AE9vXwPnn8FlSbiwA5SRS8M3Bq+97IwYzS/wAylBM5trRGSMRpQzQ96OQVebaXKY9ymKHtPN
X-Received: by 10.98.210.202 with SMTP id c193mr16859486pfg.161.1473741997201;
        Mon, 12 Sep 2016 21:46:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id cp11sm27861837pac.28.2016.09.12.21.46.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 11/17] diff.c: convert emit_binary_diff_body to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:07 -0700
Message-Id: <20160913044613.1037-12-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers emit_binary_diff_body.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 1892c2b..ff1e829 100644
--- a/diff.c
+++ b/diff.c
@@ -2169,8 +2169,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2199,13 +2199,12 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		emit_line_fmt(o, 0, 0, "delta %lu\n", orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
-	}
-	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+	} else {
+		emit_line_fmt(o, 0, 0, "literal %lu\n", two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2214,8 +2213,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
+		int len;
 		int bytes = (52 < data_size) ? 52 : data_size;
-		char line[70];
+		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
 			line[0] = bytes + 'A' - 1;
@@ -2223,20 +2223,25 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
-		fprintf(file, "%s", prefix);
-		fputs(line, file);
-		fputc('\n', file);
+
+		len = strlen(line);
+		line[len++] = '\n';
+		line[len] = '\0';
+
+		emit_line(o, 0, 0, line, len);
 	}
-	fprintf(file, "%s\n", prefix);
+	emit_line(o, 0, 0, "\n", 1);
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two,
-			     const char *prefix)
+static void emit_binary_diff(struct diff_options *o,
+			     mmfile_t *one, mmfile_t *two)
 {
-	fprintf(file, "%sGIT binary patch\n", prefix);
-	emit_binary_diff_body(file, one, two, prefix);
-	emit_binary_diff_body(file, two, one, prefix);
+	const char *s = "GIT binary patch\n";
+	const int len = strlen(s);
+	emit_line(o, 0, 0, s, len);
+	emit_binary_diff_body(o, one, two);
+	emit_binary_diff_body(o, two, one);
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
@@ -2411,7 +2416,7 @@ static void builtin_diff(const char *name_a,
 			emit_line(o, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+			emit_binary_diff(o, &mf1, &mf2);
 		else
 			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
 				      lbl[0], lbl[1]);
-- 
2.10.0.21.g1da280f.dirty

