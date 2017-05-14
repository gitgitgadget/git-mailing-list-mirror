Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BD120188
	for <e@80x24.org>; Sun, 14 May 2017 04:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdENECD (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:02:03 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32924 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdENEBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:48 -0400
Received: by mail-pg0-f48.google.com with SMTP id u187so45855121pgb.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RjyQM+g7DZZqmS5KbouUd7Jjq8RM8etIxCWERXBKjrI=;
        b=SOrM+f37PowRzTEwki3EfRe34B22D5Sft/9u9Cgluim7ydUzQBB2j0jld+2VVcH6tH
         dMGhqwzBmgU056wx3Y0LizxzvfBD2aEMJOz+oqVPj5h5PjcyEd3rAbbiWEU665QHAvQG
         7vQwGtEXGqCsvGaNxtiaPLgqBnwZvgKU7iD0Z55qdVCcpjPMABzeK9LYjIfWeegt5iFW
         G8vPcYcCecMSzRlhkdfPnWGwnR38iscrj25o2KdLKmCS67JPFWxvJeJNIHKpQF3X16Px
         Z2LtajyE3lp4U6+OI3og1iF8yc3jF6mn++eYeS2pJ3KCxE6G2yr+KKvkbVzmTzaWb52N
         qsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RjyQM+g7DZZqmS5KbouUd7Jjq8RM8etIxCWERXBKjrI=;
        b=OkY5HnYFdybREHihsx77XrK57Vikpovroe9N4FzYTOkXgOiOiv1ccV1yvxvapZD8v3
         w10Gbh6E36XZhHMb7xcH7fzWqhKnhuAWk+CZk+PeB/aeWH6XK8OKVkyoBMVSznazqD7U
         gFxoTYhZGGQujTnazNcx/2kcICAfjE4MQ5i24IZSkl+xCcSpy/veBdtp2vCp/MfGRb5F
         eG30gbTXw1OeTX4ffvbwAtGvEHx8MhGJEm3Cah9Hzw6v6GqCN9rSa3JpeOsib3U+3Q+u
         JPn/Eb8H3cRlnFKA4sB9GNiKlpurWvdDK53wmQZBqkzd0nIXoKbbpasO+vVJNw8x2NnS
         UPqg==
X-Gm-Message-State: AODbwcC6zVsALapqp+x5EiH91jNYWRwVHhFAEOoiO3vTzVkDkRmn9Lgh
        6Qu11deaACBQ+5vN
X-Received: by 10.98.130.201 with SMTP id w192mr12455338pfd.34.1494734502457;
        Sat, 13 May 2017 21:01:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id y63sm14463757pfa.107.2017.05.13.21.01.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/19] diff.c: convert emit_binary_diff_body to use emit_line_*
Date:   Sat, 13 May 2017 21:01:10 -0700
Message-Id: <20170514040117.25865-13-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
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
index 45ec311828..ffdb728810 100644
--- a/diff.c
+++ b/diff.c
@@ -2233,8 +2233,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2263,13 +2263,12 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		emit_line_fmt(o, NULL, NULL, "delta %lu\n", orig_size);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
-	}
-	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+	} else {
+		emit_line_fmt(o, NULL, NULL, "literal %lu\n", two->size);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2278,8 +2277,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
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
@@ -2287,20 +2287,25 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
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
+		emit_line(o, NULL, NULL, line, len);
 	}
-	fprintf(file, "%s\n", prefix);
+	emit_line(o, NULL, NULL, "\n", 1);
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
+	emit_line(o, NULL, NULL, s, len);
+	emit_binary_diff_body(o, one, two);
+	emit_binary_diff_body(o, two, one);
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
@@ -2489,7 +2494,7 @@ static void builtin_diff(const char *name_a,
 				  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+			emit_binary_diff(o, &mf1, &mf2);
 		else
 			emit_line_fmt(o, NULL, NULL,
 				      "Binary files %s and %s differ\n",
-- 
2.13.0.18.g183880de0a

