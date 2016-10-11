Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1272098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbcJKAWX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32896 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:06 -0400
Received: by mail-pa0-f41.google.com with SMTP id vu5so3991147pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c6cuAnZkN1NphRJ1X2oR0MvusLCa9dE1645/tnqfKgg=;
        b=Y9w9n+bA/OAoMaUQuNEoExaeGU+IwtLaV7K/pN3EAUzan/kkOy8J47aG/wI+b+WWGA
         D9JdLbImnXGbNTIExNL/TPE+H503hH+LREcZcGciVpQ/9/zUMbr/YBIfgWUs35fZMEts
         qqN06lhaez1mQtvkJgcsFkVnM4JdDwfXXqS/fQygwb8XFUvbDsVX1LfRN0rSnGNniDrI
         0HRxyuJ7despNGwCOavavOcCA+BE0iBZaMTBj/d3frq3+uliwRvdOyjUi5iwxJsGb0vW
         QDzVQFhvi2+saeNMEUjAeN9AvLnKNRKuYLFVSwmEyU+Cr95eBUTK+R5U8PmkGplU7lyu
         wJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c6cuAnZkN1NphRJ1X2oR0MvusLCa9dE1645/tnqfKgg=;
        b=f0aDws0zWZydKywkLk3GnY3/dNYZ/pRq4M2zmoH9uhh7I9lSXw0hNspVGumSqDGrFq
         kyzlInGLPCREWP++4bS8O/XYt8gARJO7Ypos2WiDlRdCumxKws8LClEqy9PNqpYxmAcv
         3wN+T+lkz44Pl/BZ3SLPahDYaLwXvtuFQZ0+YstbeHOhqW+vx6DKLgkD8nHKh5JF+Uln
         Y9Zq1YO4tSUhic1fSRYX6dKXyd/RWru9s2vN8uM7M9uVkksfIZvLkD0ZOfAHp08zA9EZ
         q7Nz+ARXL1/HJx4tr81TB9ZDjCNfuB4xf7VZ3qmRLRWXX1znlMU2BnoNykxHd04x1bl/
         2XhQ==
X-Gm-Message-State: AA6/9RnuRfwr1+KxkWZ7tJlSlCkjJ0Z3jXSmDwVdXKuo5yYbEkKpRmC69Rof05Ur7f+k/nbO
X-Received: by 10.66.219.201 with SMTP id pq9mr1768963pac.32.1476145325737;
        Mon, 10 Oct 2016 17:22:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id w65sm521059pfd.48.2016.10.10.17.22.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/28] attr.c: always pass check[] to collect_some_attrs()
Date:   Mon, 10 Oct 2016 17:21:11 -0700
Message-Id: <20161011002115.23312-25-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

This function used to be called with check=NULL to signal it to
collect all attributes in the global check_all_attr[] array.

Because the longer term plan is to allocate check_all_attr[] and
attr_stack data structures per git_attr_check instance (i.e. "check"
here) to make the attr subsystem thread-safe, it is unacceptable.

Pass "Are we grabbing all attributes defined in the system?" bit as
a separate argument and pass it from the callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/attr.c b/attr.c
index cb3b702..a08783a 100644
--- a/attr.c
+++ b/attr.c
@@ -756,11 +756,12 @@ static void empty_attr_check_elems(struct git_attr_check *check)
 
 /*
  * Collect attributes for path into the array pointed to by
- * check_all_attr.  If check is not NULL, only attributes in
- * check[] are collected. Otherwise all attributes are collected.
+ * check_all_attr.  If collect_all is zero, only attributes in
+ * check[] are collected.  Otherwise, check[] is cleared and
+ * any and all attributes that are visible are collected in it.
  */
 static void collect_some_attrs(const char *path, int pathlen,
-			       struct git_attr_check *check)
+			       struct git_attr_check *check, int collect_all)
 
 {
 	struct attr_stack *stk;
@@ -781,10 +782,11 @@ static void collect_some_attrs(const char *path, int pathlen,
 	}
 
 	prepare_attr_stack(path, dirlen);
+
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
-	if (check && !cannot_trust_maybe_real) {
+	if (!collect_all && !cannot_trust_maybe_real) {
 		struct git_attr_check_elem *celem = check->check;
 
 		rem = 0;
@@ -803,6 +805,17 @@ static void collect_some_attrs(const char *path, int pathlen,
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = fill(path, pathlen, basename_offset, stk, rem);
+
+	if (collect_all) {
+		empty_attr_check_elems(check);
+		for (i = 0; i < attr_nr; i++) {
+			const struct git_attr *attr = check_all_attr[i].attr;
+			const char *value = check_all_attr[i].value;
+			if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+				continue;
+			git_attr_check_append(check, attr)->value = value;
+		}
+	}
 }
 
 static int git_check_attrs(const char *path, int pathlen,
@@ -811,7 +824,7 @@ static int git_check_attrs(const char *path, int pathlen,
 	int i;
 	struct git_attr_check_elem *celem = check->check;
 
-	collect_some_attrs(path, pathlen, check);
+	collect_some_attrs(path, pathlen, check, 0);
 
 	for (i = 0; i < check->check_nr; i++) {
 		const char *value = check_all_attr[celem[i].attr->attr_nr].value;
@@ -825,19 +838,7 @@ static int git_check_attrs(const char *path, int pathlen,
 
 void git_all_attrs(const char *path, struct git_attr_check *check)
 {
-	int i;
-
-	git_attr_check_clear(check);
-	collect_some_attrs(path, strlen(path), NULL);
-
-	for (i = 0; i < attr_nr; i++) {
-		const char *name = check_all_attr[i].attr->name;
-		const char *value = check_all_attr[i].value;
-		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
-			continue;
-		git_attr_check_append(check, git_attr(name));
-		check->check[check->check_nr - 1].value = value;
-	}
+	collect_some_attrs(path, strlen(path), check, 1);
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
-- 
2.10.1.382.ga23ca1b.dirty

