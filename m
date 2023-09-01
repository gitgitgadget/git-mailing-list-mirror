Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F3ECA0FE4
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbjIAO1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350012AbjIAO1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 10:27:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1FB10F9
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 07:27:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso1557962a12.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693578434; x=1694183234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLjQrjMtBXjPcC7JJmBjqPgEmMixJNKK4Ea6UZ4auNc=;
        b=JskuzCWid9GTF7RddXp5HzTvTqfA1cbVzqkSG0Q7T7hC9zhV8wGNWL5ZzH/LMZoMO9
         LS3QRA3/pxKi7hud1kxwHln2DHFLn9xwwTly5O6vwBfezyRzP3dnj9P48uiyRxIAI99v
         SFD366UAZ2tc/e3XxJ5+URQ4ncM1Hmhbn/IlCNc2S9JqXZ/PlAWoqgHG9NF4dTk5M5dS
         R3tIzGwm367q3FUWZuooY4O9x0psaxnJdnwGWC00lwYrEVSIA/Omuff7PF2flCBSwM0i
         bNzXVxoYwDPRuPgETOWAMs9YMvCOxSOUHxwBb5/6D5emFOHSmKwYZLMOBch3O3cM85bH
         Uxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578434; x=1694183234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLjQrjMtBXjPcC7JJmBjqPgEmMixJNKK4Ea6UZ4auNc=;
        b=dDN2J5CgK1BvnSsGncEJzFtGRdesC+UNGn8d4TaSeuSJU9s5pn9BZ3mO/fmxjFPytv
         tMT4e8WYF3P2MuBbku9QOnmr8VwglJmG04H8VT4JrVtdju0CWiYm1YV6YrayFaRzGaLd
         x2+ioluLVG+srgOK48D55oHwG5ss7kOzbQTn9uOmI45AnFXIwetfz2aj/iFvvJGI+psi
         Vj2zDRzBdVUFWFTp5mvGaP9btxYfvSPCYELW55RhfGGb26x9dTyuBQevbSe6/UV7rhFR
         3/4/7IcytYA2ckF8m4EDZSPOcbc6E2la6sLofBskLjAWoDlGLyIffhK2KB6bBqs7U8Xv
         V6EA==
X-Gm-Message-State: AOJu0Yy+fXJRBpbphAdSUtz+38IjZGoq05hf0f4HomADAf9iL/w8l+Iv
        ieUaFrw3xVD0XkSkA5qb1P7ActjkhThx6g==
X-Google-Smtp-Source: AGHT+IHMR2hlU5237iYEkKGs01H0iu9k3BpzkuRXNXXAdOnx80qYZ0SSoVe3Q+GIZXJAsF0mdlG15w==
X-Received: by 2002:a05:6a20:1447:b0:14d:f41c:435a with SMTP id a7-20020a056a20144700b0014df41c435amr3360091pzi.39.1693578434312;
        Fri, 01 Sep 2023 07:27:14 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.156.236])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b00688435a9915sm3010775pfe.189.2023.09.01.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:27:13 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] ref-filter: sort numerically when ":size" is used
Date:   Fri,  1 Sep 2023 19:54:54 +0530
Message-ID: <20230901142624.12063-1-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.51.g5dc72c0fbc.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atoms like "raw" and "contents" have a ":size" option which can be used
to know the size of the data. Since these atoms have the cmp_type
FIELD_STR, they are sorted alphabetically from 'a' to 'z' and '0' to
'9'. Meaning, even when the ":size" option is used and what we
ultimatlely have is numbers, we still sort alphabetically.

For example, consider the the following case in a repo

refname			contents:size		raw:size
=======			=============		========
refs/heads/branch1	1130			1210
refs/heads/master	300			410
refs/tags/v1.0		140			260

Sorting with "--format="%(refname) %(contents:size) --sort=contents:size"
would give

refs/heads/branch1 1130
refs/tags/v1.0.0 140
refs/heads/master 300

which is an alphabetic sort, while what one might really expect is

refs/tags/v1.0.0 140
refs/heads/master 300
refs/heads/branch1 1130

which is a numeric sort (that is, a "$ sort -n file" as opposed to a
"$ sort file", where "file" contains only the "contents:size" or
"raw:size" info, each of which is on a newline).

Same is the case with "--sort=raw:size".

So, sort numerically whenever the sort is done with "contents:size" or
"raw:size" and do it the normal alphabetic way when "contents" or "raw"
are used with some other option (they are FIELD_STR anyways).

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 ref-filter.c            | 20 +++++++++++++++-----
 t/t6300-for-each-ref.sh | 15 +++++++++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1bfaf20fbf..5d7bea5f23 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -932,7 +932,13 @@ struct atom_value {
 	ssize_t s_size;
 	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
 		       struct strbuf *err);
-	uintmax_t value; /* used for sorting when not FIELD_STR */
+
+	/*
+	 * Used for sorting when not FIELD_STR or when FIELD_STR but the
+	 * sort should be numeric and not alphabetic.
+	 */
+	uintmax_t value;
+
 	struct used_atom *atom;
 };
 
@@ -1857,7 +1863,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 				v->s = xmemdupz(buf, buf_size);
 				v->s_size = buf_size;
 			} else if (atom->u.raw_data.option == RAW_LENGTH) {
-				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
+				v->value = (uintmax_t)buf_size;
+				v->s = xstrfmt("%"PRIuMAX, v->value);
 			}
 			continue;
 		}
@@ -1883,8 +1890,10 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			v->s = strbuf_detach(&sb, NULL);
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
+		else if (atom->u.contents.option == C_LENGTH) {
+			v->value = (uintmax_t)strlen(subpos);
+			v->s = xstrfmt("%"PRIuMAX, v->value);
+		}
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
@@ -2265,6 +2274,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 		v->s_size = ATOM_SIZE_UNSPECIFIED;
 		v->handler = append_atom;
+		v->value = 0;
 		v->atom = atom;
 
 		if (*name == '*') {
@@ -2986,7 +2996,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 		cmp_detached_head = 1;
 	} else if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
-	} else if (cmp_type == FIELD_STR) {
+	} else if (cmp_type == FIELD_STR && !va->value && !vb->value) {
 		if (va->s_size < 0 && vb->s_size < 0) {
 			int (*cmp_fn)(const char *, const char *);
 			cmp_fn = s->sort_flags & REF_SORTING_ICASE
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index aa3c7c03c4..7b943fd34c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1017,16 +1017,16 @@ test_expect_success 'Verify sorts with raw' '
 test_expect_success 'Verify sorts with raw:size' '
 	cat >expected <<-EOF &&
 	refs/myblobs/blob8
-	refs/myblobs/first
 	refs/myblobs/blob7
-	refs/heads/main
 	refs/myblobs/blob4
 	refs/myblobs/blob1
 	refs/myblobs/blob2
 	refs/myblobs/blob3
 	refs/myblobs/blob5
 	refs/myblobs/blob6
+	refs/myblobs/first
 	refs/mytrees/first
+	refs/heads/main
 	EOF
 	git for-each-ref --format="%(refname)" --sort=raw:size \
 		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
@@ -1138,6 +1138,17 @@ test_expect_success 'for-each-ref --format compare with cat-file --batch' '
 	test_cmp expected actual
 '
 
+test_expect_success 'verify sorts with contents:size' '
+	cat >expect <<-\EOF &&
+	refs/heads/main
+	refs/heads/newtag
+	refs/heads/ambiguous
+	EOF
+	git for-each-ref --format="%(refname)" \
+		--sort=contents:size refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
 	do
-- 
2.42.0.51.g5dc72c0fbc.dirty

