Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A15620986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965036AbcJVXdR (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:17 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37167 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964811AbcJVXdC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:02 -0400
Received: by mail-it0-f44.google.com with SMTP id m138so74587675itm.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcLL97dkY7g3OayRGHpguBbDiCylxl6DpkHTeB/DsdU=;
        b=MY6UD2hPIet5/iu6T4lvQJyZC4qtve7guSPl2pLPq4T9GUOl3zyPrrJr6759I5pChX
         Fh9cxuMpUdvinP7wO1tMsVQdfjzmvsw4Ha1CgxCA1TrB5A/ncMzXX5qP55EeClZwE9FP
         RNQQEt1fPX1n7chSDJ9YZhoOQccQQdfYJyT7UidM1cAuxz2hlZdAnRwpoQAX7DCibDfk
         1gCrasKikml588/x8JAQtWcmB90NpG9YjkF/YAYcYWeB1gKNDsAmBZJDErhIdFYylyBe
         kl9DL4QW1nil6j+FAJL0VGSbxBK+Hon8406F23HVBk2Mdj11zj1lzCqlF4i5B2LlZnPj
         qkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcLL97dkY7g3OayRGHpguBbDiCylxl6DpkHTeB/DsdU=;
        b=mqnPJxvvdYMV7q4ywqQ7+4FT8cy7ltcVVFFLel441ElKT/usp7mY8on9G+/bz/VBpy
         IIO+GAwQrf6geciE7LbHEmLK0QKF2d3e6//CkkAjTmSh9+VSNOZgIEPuk5sUB5KF1L+t
         hRuBJBhJBp7xIh1kJ0GbjJ3gPIg36qDaCOcnN2QQRO5shHhe31oBLeqpeJ/xG6xyyAKF
         IlL0Bn6Jj1mBRQxNYasv5BnbEnuukQurHiwSEb6XyMKPq3oXAa5wXqftS+ShUoBWpPqH
         kbN25WcGDCXcbAroFlJ53eVprv2FS5szRYdY0M73JvZF8g/DDZQHnkbOW1hOs0EtjKG4
         TTMw==
X-Gm-Message-State: ABUngvei6cWcMBTwFFrLY+4tjbEpMmNGFGbmtrHMUunqY8/ME+lGT2LcYVIzGP4YnloAAdTz
X-Received: by 10.36.26.3 with SMTP id 3mr8066800iti.46.1477179181070;
        Sat, 22 Oct 2016 16:33:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 65sm4565231iop.0.2016.10.22.16.33.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/36] attr: add counted string version of git_check_attr()
Date:   Sat, 22 Oct 2016 16:32:04 -0700
Message-Id: <20161022233225.8883-16-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Often a potential caller has <path, pathlen> pair that
represents the path it wants to ask attributes for; when
path[pathlen] is not NUL, the caller has to xmemdupz()
only to call git_check_attr().

Add git_check_attr_counted() that takes such a counted
string instead of "const char *path".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 23 ++++++++++++++---------
 attr.h |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index d427798..9bec243 100644
--- a/attr.c
+++ b/attr.c
@@ -734,20 +734,19 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
  * check_all_attr. If num is non-zero, only attributes in check[] are
  * collected. Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const char *path, int num,
+static void collect_some_attrs(const char *path, int pathlen, int num,
 			       struct git_attr_check_elem *check)
 
 {
 	struct attr_stack *stk;
-	int i, pathlen, rem, dirlen;
+	int i, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
 
-	for (cp = path; *cp; cp++) {
+	for (cp = path; cp < path + pathlen; cp++) {
 		if (*cp == '/' && cp[1])
 			last_slash = cp;
 	}
-	pathlen = cp - path;
 	if (last_slash) {
 		basename_offset = last_slash + 1 - path;
 		dirlen = last_slash - path;
@@ -778,12 +777,12 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-static int git_check_attrs(const char *path, int num,
+static int git_check_attrs(const char *path, int pathlen, int num,
 			   struct git_attr_check_elem *check)
 {
 	int i;
 
-	collect_some_attrs(path, num, check);
+	collect_some_attrs(path, pathlen, num, check);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
@@ -800,7 +799,7 @@ void git_all_attrs(const char *path, struct git_attr_check *check)
 	int i;
 
 	git_attr_check_clear(check);
-	collect_some_attrs(path, 0, NULL);
+	collect_some_attrs(path, strlen(path), 0, NULL);
 
 	for (i = 0; i < attr_nr; i++) {
 		const char *name = check_all_attr[i].attr->name;
@@ -825,10 +824,16 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 	use_index = istate;
 }
 
-int git_check_attr(const char *path, struct git_attr_check *check)
+int git_check_attr_counted(const char *path, int pathlen,
+			   struct git_attr_check *check)
 {
 	check->finalized = 1;
-	return git_check_attrs(path, check->check_nr, check->check);
+	return git_check_attrs(path, pathlen, check->check_nr, check->check);
+}
+
+int git_check_attr(const char *path, struct git_attr_check *check)
+{
+	return git_check_attr_counted(path, strlen(path), check);
 }
 
 struct git_attr_check *git_attr_check_initl(const char *one, ...)
diff --git a/attr.h b/attr.h
index 506db0c..c84f164 100644
--- a/attr.h
+++ b/attr.h
@@ -38,6 +38,7 @@ struct git_attr_check {
 
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
+extern int git_check_attr_counted(const char *, int, struct git_attr_check *);
 
 extern struct git_attr_check *git_attr_check_alloc(void);
 extern struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *, const struct git_attr *);
-- 
2.10.1.508.g6572022

