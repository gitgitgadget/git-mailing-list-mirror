Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E100C1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 18:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbdA3SOu (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 13:14:50 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34613 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdA3SOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 13:14:44 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so102953263pgg.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JZFPVVPhMPcPrMxpRyU36mVwN5vd/k0n6wTRfwumVdw=;
        b=n/4tnC+DM86oBNYPWkHDggijA3nTxhapaue1gm4cqpkU+b0JSSSpzD5Et+fPnN40vb
         2JoSR0deDtAVz5/ZjcWd6wr1nqaEJd2D4zWxixApHY7sRwIJbtpC0IR3hmW3VTPT9GYo
         nPeSUE83JMn7DNiXxGc5Cuoqql1gR37nFISybLsPT21yl4nKce7yDBN+Vw92rdpZSmwF
         oTxi29p4Wr2zO47d2rOcY1qdcDskMrXXubBAgSQvwxlDIlu9ytyGZpyPP0uxnuUQtJuM
         L5Fc5ce5xKFlkKwAncnaCy/eN5te78fCX36FhMaS/pHdbHYS66wgsuqJn+T1X/VkUqzr
         vhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JZFPVVPhMPcPrMxpRyU36mVwN5vd/k0n6wTRfwumVdw=;
        b=aToh//hiTPZ10YOAb2KRJZPFgW2HmpRNk+H3dc7rpwvUjN63eYrIsmvkivzLJg2eL0
         uqLrLDz6c5+lWxUWpSd3nexn0l2zPi/rS8H3kaLV7OigyKLnG8oUJmIq8bE2WbmZ0jFe
         KnQbbQtiDA2NEU5ICk1yIfI/WMzJDSzg1r7jNy0NwWOjj/8bFMRfUW2A9GVMD4hqZsT9
         GusDmi+dAF0YNIiHXNnjXIuggpPvKLer19s+9ptJiUl5w3fohCIKivXhfqJu8t5QH6px
         2SO5sXT8ObAs2/kszJqMZpuFMhbVdBYbJXUDPqLNhVRe4HWwqPdgvESTBrY0VW7gs234
         KKyg==
X-Gm-Message-State: AIkVDXI84xjCKEzXAKq+NOh5YTQ6d+75ccarnF30SVrnQMlzxm+4m0+GLqpGSFhscKBtd8sS
X-Received: by 10.84.241.207 with SMTP id t15mr33633866plm.136.1485799536212;
        Mon, 30 Jan 2017 10:05:36 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id f3sm34511816pga.34.2017.01.30.10.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 10:05:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 15/27] attr: (re)introduce git_check_attr() and struct attr_check
Date:   Mon, 30 Jan 2017 10:05:20 -0800
Message-Id: <20170130180520.46632-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-16-bmwill@google.com>
References: <20170128020207.179015-16-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

A common pattern to check N attributes for many paths is to

 (1) prepare an array A of N attr_check_item items;
 (2) call git_attr() to intern the N attribute names and fill A;
 (3) repeatedly call git_check_attrs() for path with N and A;

A look-up for these N attributes for a single path P scans the
entire attr_stack, starting from the .git/info/attributes file and
then .gitattributes file in the directory the path P is in, going
upwards to find .gitattributes file found in parent directories.

An earlier commit 06a604e6 (attr: avoid heavy work when we know the
specified attr is not defined, 2014-12-28) tried to optimize out
this scanning for one trivial special case: when the attribute being
sought is known not to exist, we do not have to scan for it.  While
this may be a cheap and effective heuristic, it would not work well
when N is (much) more than 1.

What we would want is a more customized way to skip irrelevant
entries in the attribute stack, and the definition of irrelevance
is tied to the set of attributes passed to git_check_attrs() call,
i.e. the set of attributes being sought.  The data necessary for
this optimization needs to live alongside the set of attributes, but
a simple array of git_attr_check_elem simply does not have any place
for that.

Introduce "struct attr_check" that contains N, the number of
attributes being sought, and A, the array that holds N
attr_check_item items, and a function git_check_attr() that
takes a path P and this structure as its parameters.  This structure
can later be extended to hold extra data necessary for optimization.

Also, to make it easier to write the first two steps in common
cases, introduce git_attr_check_initl() helper function, which takes
a NULL-terminated list of attribute names and initialize this
structure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---

This is the correct 15/27 patch that doesn't have the rebase mistake discovered
by Stefan.

 attr.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 attr.h | 17 +++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/attr.c b/attr.c
index 2f180d609..e3298516a 100644
--- a/attr.c
+++ b/attr.c
@@ -370,6 +370,75 @@ static void free_attr_elem(struct attr_stack *e)
 	free(e);
 }
 
+struct attr_check *attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct attr_check));
+}
+
+struct attr_check *attr_check_initl(const char *one, ...)
+{
+	struct attr_check *check;
+	int cnt;
+	va_list params;
+	const char *param;
+
+	va_start(params, one);
+	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
+		;
+	va_end(params);
+
+	check = attr_check_alloc();
+	check->nr = cnt;
+	check->alloc = cnt;
+	check->items = xcalloc(cnt, sizeof(struct attr_check_item));
+
+	check->items[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->nr; cnt++) {
+		const struct git_attr *attr;
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->nr, cnt);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->items[cnt].attr = attr;
+	}
+	va_end(params);
+	return check;
+}
+
+struct attr_check_item *attr_check_append(struct attr_check *check,
+					  const struct git_attr *attr)
+{
+	struct attr_check_item *item;
+
+	ALLOC_GROW(check->items, check->nr + 1, check->alloc);
+	item = &check->items[check->nr++];
+	item->attr = attr;
+	return item;
+}
+
+void attr_check_reset(struct attr_check *check)
+{
+	check->nr = 0;
+}
+
+void attr_check_clear(struct attr_check *check)
+{
+	free(check->items);
+	check->items = NULL;
+	check->alloc = 0;
+	check->nr = 0;
+}
+
+void attr_check_free(struct attr_check *check)
+{
+	attr_check_clear(check);
+	free(check);
+}
+
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -merge -text",
 	NULL,
@@ -865,6 +934,11 @@ int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
 	return 0;
 }
 
+int git_check_attr(const char *path, struct attr_check *check)
+{
+	return git_check_attrs(path, check->nr, check->items);
+}
+
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
 {
 	enum git_attr_direction old = direction;
diff --git a/attr.h b/attr.h
index efc7bb3b3..e611b139a 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,22 @@ struct attr_check_item {
 	const char *value;
 };
 
+struct attr_check {
+	int nr;
+	int alloc;
+	struct attr_check_item *items;
+};
+
+extern struct attr_check *attr_check_alloc(void);
+extern struct attr_check *attr_check_initl(const char *, ...);
+
+extern struct attr_check_item *attr_check_append(struct attr_check *check,
+						 const struct git_attr *attr);
+
+extern void attr_check_reset(struct attr_check *check);
+extern void attr_check_clear(struct attr_check *check);
+extern void attr_check_free(struct attr_check *check);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
@@ -37,6 +53,7 @@ struct attr_check_item {
 extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attrs(const char *path, int, struct attr_check_item *);
+extern int git_check_attr(const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
-- 
2.11.0.483.g087da7b7c-goog

