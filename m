Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F039D2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbcJKAVx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:53 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32828 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbcJKAVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:51 -0400
Received: by mail-pa0-f41.google.com with SMTP id vu5so3987370pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lnZu8CfnYVAfb76EFR9NUQG7gbiHKlhENyvxZV1I12g=;
        b=jT6ddylEnr+6laDAjlnEm44983ZVuEKzA7nZA6r5emnnzK2a3LbFVlnigX/dw2jZD6
         eZgiauRqBmfTBB8huwyS8lX1vcE0wBYqhqwsZv7zK/PcdeCcPMrNiopdz57EAxr7Us8I
         oJTVq/SSAH2o/SdKKfPgPANRCCl4FIB8nCMmXd1DZNHPO7lUTvDSkv5b0Kn6q7FM6GE4
         FgV+ZZV3SOvl9CkLb8lVBlEqgvn07a5UlaeyC7HGEt26TUDbKHWiship/FuVuQp6Qjtb
         TzuTMV9DhfkcFK7uVMt8Zw8KrX7XkbtQZlQ2lVbUJ8K2ZiJHl697MEFsdWhqkAxZuPls
         wFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lnZu8CfnYVAfb76EFR9NUQG7gbiHKlhENyvxZV1I12g=;
        b=JuRtbsP0HWMVq0aPTHXkW6TegWeddzz1bnT9fHxn5Q1c9bEewNRSyHoLHV/fLerEmd
         s4cfThK44lzVweDDljEtf1PCQOQnv7zdPyMNgwGEzJsTum1lBOndA4slOOavdeK/WVz5
         K7RX/pZ6Wrjhwr6vGXa7jRG8GXdrBQ2i6oN+LqUYkJkEpOuVC3wLK8fnAeVmHBhgpEKd
         r4xhZogsxgbgDiCzI8QLRFWq3c4t+q5TLsJv8hOMPnWhZqCdAUgdTn0/rW8fqf0nA+eV
         /CQsIcZcrG/FJxui45UZzIuCh3r/M52L4Pe4HYj4Hx0IlbYIceZN7kVJXF8oNthqKnK5
         98DA==
X-Gm-Message-State: AA6/9RkujyCGgKs5yuftwBZ9Gsp0PPMfSZ+NLjkss2lwMhj3DZnytYzAzxlwaszMD9uXAj1M
X-Received: by 10.66.141.197 with SMTP id rq5mr1680608pab.75.1476145309473;
        Mon, 10 Oct 2016 17:21:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id h87sm502003pfj.78.2016.10.10.17.21.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 15/28] attr: add counted string version of git_check_attr()
Date:   Mon, 10 Oct 2016 17:21:02 -0700
Message-Id: <20161011002115.23312-16-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty

