Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50B320209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422700AbdEXVlo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:44 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36396 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164150AbdEXVky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id m17so147394992pfg.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EwLGcql8lEibsMq/IH9zcI2vJMclM4W7nE7k+ftGbOk=;
        b=AiXFrrwZFFs5sarXIdBqtM0zLkvgpYyDGKy0uw6EhrPKq3sPJugAglru6Pu3rSdfNF
         JEv0EkBPDrriL/45uFf70n66Xz1hm+RYDaEtj5Z7071ai5N92eKl4MAkN31EV5J4iDx5
         MLrQyw5SFuW7v5eJUtOvC2K3VIjzJknsj9VRqigNs+wdaZJXbzJ1ZuNH+udYJjgEr90Y
         qON//dQ1upoW1NQHuQNn7JGO9YsK4VMnuidFCcLn3Z3LkyLywu/aQ1ZSPgwuHXmdW8KX
         WMK2LD2NvZBiFzjuNqj5zXwxlhSdzWLN+ucVzTMYxVbValaO0NqCmDGXWyGSt/4c+QDb
         hu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EwLGcql8lEibsMq/IH9zcI2vJMclM4W7nE7k+ftGbOk=;
        b=ffNxAdRHjxi3rw/3tZP0vQjqv8cJgb6mN56WMvGbSq4ZGvbAdgQYw52eW/2ihQWpVV
         5hSJCEE8Mqu6SJQT4Jdp3CeaVFSzJYJ/t2OIZggVI3k8JSp0ssyIyUpi1GIqGkl7aqKi
         2MxNENQpPvFEthvMFiLQB8BpKkxQPLpfQohhR1c6I+rgdQLkm+cHuQcuPT0mmmQ3YGf3
         RK2vt6HXn9FQ6XHOxec/OCgNiAzGOIp28TBx31EccPCicya8/LLFBS87tbj4tlToyBjl
         2B1zExFCF5oEhBLDf1afeKOSODkYc2hFZakELm/TZn8OgDEbxjrueLQLCLaebVgwdE4k
         O7Xg==
X-Gm-Message-State: AODbwcACRCv1EbhaFatoNdU4mFVQsdbsonVgAkIyh4nsVN0k+AvQ19vd
        JU0yYbh/ISIsWq1EdHlOag==
X-Received: by 10.98.57.80 with SMTP id g77mr41524092pfa.111.1495662048680;
        Wed, 24 May 2017 14:40:48 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id c63sm8784503pfd.8.2017.05.24.14.40.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 06/17] diff.c: convert builtin_diff to use emit_line_*
Date:   Wed, 24 May 2017 14:40:25 -0700
Message-Id: <20170524214036.29623-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
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

This covers builtin_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 8186289734..4fa976d43c 100644
--- a/diff.c
+++ b/diff.c
@@ -1289,8 +1289,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
-		strbuf_reset(ecbdata->header);
+		emit_line(o, NULL, NULL, 0, 0,
+			  ecbdata->header->buf, ecbdata->header->len);
+		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
 	}
 
@@ -2435,7 +2436,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2445,7 +2446,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2456,12 +2457,15 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+					emit_line(o, NULL, NULL, 0, 0,
+						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line(o, NULL, NULL, 0, 0,
+				  header.buf, header.len);
+			emit_line_fmt(o, NULL, NULL, 1,
+				      "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2470,16 +2474,19 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+				emit_line(o, NULL, NULL, 0, 0,
+					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		emit_line(o, NULL, NULL, 0, 0,
+			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
 		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line_fmt(o, NULL, NULL, 1,
+				      "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
@@ -2491,7 +2498,7 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
-- 
2.13.0.18.g7d86cc8ba0

