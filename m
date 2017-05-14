Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2420E201B0
	for <e@80x24.org>; Sun, 14 May 2017 04:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbdENECK (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:02:10 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34220 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdENEBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:44 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so45918453pgn.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FH8JjO6R72tYsaSGdHQI/YHdDHfoNWvi7RYKTD2o1MQ=;
        b=R4e1jXVLbe1YARuQujuZ5yx/ToczOBqCpXRsO0jPreBM18zRuG7LVTeJFMSza8y+hJ
         Q/2iXdzD93jQ24uJhexGnrobokjGSK/BY/hziRP60iarMw8WdEIYhmy2WccUkwKRNWOM
         vdsCjmogmCshwS3x0X4NsCF6dmEdsAvX+LKGP+AvWhECSZR+bnQg8NrIPgK+zK1ZRGIW
         OXZVlDL2KkbdnHjajF26gfV9/fxL1Azfh8ocIrjRY/hhzI8IyTtai/EJK2PkTDrIjhVM
         vuwwe8rPT6Zlu2yIDs1N9NmpWbTb6cHRVYiJTeIKQvXW/O+zzy2IEo7cY7jk7e0/Fobt
         nrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FH8JjO6R72tYsaSGdHQI/YHdDHfoNWvi7RYKTD2o1MQ=;
        b=uI6V4uL+xlwCU/0cDch6CPEXHPMrgvVxJ0vUmYw+vTbRK61IfxOGEMEqZF3wvEatwC
         X3huHqk0HUobReObIJlF1VXi2eqfD6/z+mciMTRnXKcfKEe1f4JGPpA9OYt/WRYe8C97
         Kj0s3BS+9Lg89ZbYc70yScmHEOf4WwRe9fcz+cPtopfnepKuaBM4hQicIau6nD5HOjPK
         AWXgczzWK3SQCl0Gigejr4OdOI9R6JUODaiXUC71vEMjpp414hs7uTrU/VblEhBkRmls
         tosMLulxjWPZS5ODansh6i11o/otCLC3iVcDgAPa+7OGHK0pvMt0/p8ksgEUknnwbsR2
         214A==
X-Gm-Message-State: AODbwcCwpq35mZKRpawjqRAhZ1ZkFLKkOpKfrbOkfgMUvyUohSyeK68A
        2turlonk8dsxPQYW
X-Received: by 10.84.224.206 with SMTP id k14mr16240189pln.162.1494734498302;
        Sat, 13 May 2017 21:01:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id s83sm12739852pfa.128.2017.05.13.21.01.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/19] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Sat, 13 May 2017 21:01:07 -0700
Message-Id: <20170514040117.25865-10-sbeller@google.com>
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

This covers emit_rewrite_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 8e00010bf4..e4b46fee4f 100644
--- a/diff.c
+++ b/diff.c
@@ -708,17 +708,17 @@ static void remove_tempfile(void)
 	}
 }
 
-static void print_line_count(FILE *file, int count)
+static void add_line_count(struct strbuf *out, int count)
 {
 	switch (count) {
 	case 0:
-		fprintf(file, "0,0");
+		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		fprintf(file, "1");
+		strbuf_addstr(out, "1");
 		break;
 	default:
-		fprintf(file, "1,%d", count);
+		strbuf_addf(out, "1,%d", count);
 		break;
 	}
 }
@@ -772,7 +772,7 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -810,20 +810,23 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.lno_in_preimage = 1;
 	ecbdata.lno_in_postimage = 1;
 
+	emit_line_fmt(o, metainfo, reset, "--- %s%s\n", a_name.buf, name_a_tab);
+	emit_line_fmt(o, metainfo, reset, "+++ %s%s\n", b_name.buf, name_b_tab);
+
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
-		print_line_count(o->file, lc_a);
+		add_line_count(&out, lc_a);
 	else
-		fprintf(o->file, "?,?");
-	fprintf(o->file, " +");
-	print_line_count(o->file, lc_b);
-	fprintf(o->file, " @@%s\n", reset);
+		strbuf_addstr(&out, "?,?");
+	strbuf_addstr(&out, " +");
+	add_line_count(&out, lc_b);
+	strbuf_addstr(&out, " @@\n");
+	emit_line(o, fraginfo, reset, out.buf, out.len);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.13.0.18.g183880de0a

