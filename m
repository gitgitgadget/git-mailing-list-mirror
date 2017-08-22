Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125D61F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdHVVq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:46:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752622AbdHVVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:46:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA3AEAA22C;
        Tue, 22 Aug 2017 17:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=m/2a
        8WPI5nV7gB2eHBjtgSO1FWw=; b=whe59fYxKfCYraDPVPmEB97mKbhv96QNqngf
        vvxXN9U+VAJ5cgmkSBjrPlGTp5yOGGNbnqkzmuqFPRVb9yPga3sBrawiVdY52S36
        roPKgz2GNKMbyCgzjDYad90d3mmAvL26zFKXmXoD9m8aVQgGdRt2im92sUCjso3U
        4OOU26g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        pd//kvmXwfGvD2vwOCVAiRXf68SScCQKjdYn8ERm/kqZgXhPvz/QM1diCSbKaLL2
        oUzVMq1OrMuXwIb5eABSKQpH50VZrs9txy93kb2y2S0z8l+ymHV3ecXf8kLhwBDB
        tGQpqUxPvAU7hvu6wbhaA9lm2Rc9L0mTmgA8lsYLy5Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B28E9AA22B;
        Tue, 22 Aug 2017 17:46:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D2CCAA22A;
        Tue, 22 Aug 2017 17:46:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Uwe Hausbrand <uwe.hausbrand@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 0/6] accept non-integer for "this many days" expiry specification
Date:   Tue, 22 Aug 2017 14:46:46 -0700
Message-Id: <20170822214652.31626-1-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170819203013.3053-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
X-Pobox-Relay-ID: 69A0822A-8783-11E7-AA88-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About a month ago, we wondered why

	[gc]
		rerereResolved = 5.days

does not work and if we want to do something better.  

This is an update to my first attempt.  It turns out that I needed
more patches to clean up the tests before I can write new tests for
this feature.

The implementation of the feature itself has not changed much,
except that it now lives in config.c for easier reuse by other
codepaths in the future.

Junio C Hamano (6):
  t4200: give us a clean slate after "rerere gc" tests
  t4200: make "rerere gc" test more robust
  t4200: gather "rerere gc" together
  t4200: parameterize "rerere gc" custom expiry test
  rerere: represent time duration in timestamp_t internally
  rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved

 Documentation/config.txt |  2 ++
 config.c                 | 22 +++++++++++++++++++
 config.h                 |  3 +++
 rerere.c                 | 26 +++++++++++-----------
 t/t4200-rerere.sh        | 57 +++++++++++++++++++++++++++++++++---------------
 5 files changed, 79 insertions(+), 31 deletions(-)


The interdiff between the original one and this version looks like
this.

 config.c          | 26 +++++++++++++++++++++++--
 config.h          |  6 +++---
 rerere.c          | 24 ++---------------------
 t/t4200-rerere.sh | 57 +++++++++++++++++++++++++++++++++++++------------------
 4 files changed, 68 insertions(+), 45 deletions(-)

diff --git a/config.c b/config.c
index ac9071c5cf..ffca15f594 100644
--- a/config.c
+++ b/config.c
@@ -769,7 +769,7 @@ static int parse_unit_factor(const char *end, uintmax_t *val)
 	return 0;
 }
 
-int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
+static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -799,7 +799,7 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	return 0;
 }
 
-int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -2066,6 +2066,28 @@ int git_config_get_expiry(const char *key, const char **output)
 	return ret;
 }
 
+int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestamp_t now)
+{
+	char *expiry_string;
+	intmax_t days;
+	timestamp_t when;
+
+	if (git_config_get_string(key, &expiry_string))
+		return 1; /* no such thing */
+
+	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
+		const int scale = 86400;
+		*expiry = now - days * scale;
+		return 0;
+	}
+
+	if (!parse_expiry_date(expiry_string, &when)) {
+		*expiry = when;
+		return 0;
+	}
+	return -1; /* thing exists but cannot be parsed */
+}
+
 int git_config_get_untracked_cache(void)
 {
 	int val = -1;
diff --git a/config.h b/config.h
index 039a9295de..34ddd3eb8d 100644
--- a/config.h
+++ b/config.h
@@ -205,6 +205,9 @@ extern int git_config_get_max_percent_split_change(void);
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
 
+/* parse either "this many days" integer, or "5.days.ago" approxidate */
+extern int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
+
 struct key_value_info {
 	const char *filename;
 	int linenr;
@@ -215,7 +218,4 @@ struct key_value_info {
 extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
 extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
-int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
-int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
-
 #endif /* CONFIG_H */
diff --git a/rerere.c b/rerere.c
index 8bbdfe8569..d77235645e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1176,26 +1176,6 @@ static void prune_one(struct rerere_id *id,
 		unlink_rr_item(id);
 }
 
-static void config_get_expiry(const char *key, timestamp_t *cutoff, timestamp_t now)
-{
-	char *expiry_string;
-	intmax_t days;
-	timestamp_t when;
-
-	if (git_config_get_string(key, &expiry_string))
-		return;
-
-	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
-		const int scale = 86400;
-		*cutoff = now - days * scale;
-		return;
-	}
-
-	if (!parse_expiry_date(expiry_string, &when)) {
-		*cutoff = when;
-	}
-}
-
 void rerere_gc(struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
@@ -1209,8 +1189,8 @@ void rerere_gc(struct string_list *rr)
 	if (setup_rerere(rr, 0) < 0)
 		return;
 
-	config_get_expiry("gc.rerereresolved", &cutoff_resolve, now);
-	config_get_expiry("gc.rerereunresolved", &cutoff_noresolve, now);
+	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
+	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, now);
 	git_config(git_default_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1a080e7823..d97d2bebc9 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -239,6 +239,43 @@ test_expect_success 'old records rest in peace' '
 	! test -f $rr2/preimage
 '
 
+rerere_gc_custom_expiry_test () {
+	five_days="$1" right_now="$2"
+	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
+		rm -fr .git/rr-cache &&
+		rr=.git/rr-cache/$_z40 &&
+		mkdir -p "$rr" &&
+		>"$rr/preimage" &&
+		>"$rr/postimage" &&
+
+		two_days_ago=$((-2*86400)) &&
+		test-chmtime =$two_days_ago "$rr/preimage" &&
+		test-chmtime =$two_days_ago "$rr/postimage" &&
+
+		find .git/rr-cache -type f | sort >original &&
+
+		git -c "gc.rerereresolved=$five_days" \
+		    -c "gc.rerereunresolved=$five_days" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		test_cmp original actual &&
+
+		git -c "gc.rerereresolved=$five_days" \
+		    -c "gc.rerereunresolved=$right_now" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		test_cmp original actual &&
+
+		git -c "gc.rerereresolved=$right_now" \
+		    -c "gc.rerereunresolved=$right_now" rerere gc &&
+		find .git/rr-cache -type f | sort >actual &&
+		>expect &&
+		test_cmp expect actual
+	'
+}
+
+rerere_gc_custom_expiry_test 5 0
+
+rerere_gc_custom_expiry_test 5.days.ago now
+
 test_expect_success 'setup: file2 added differently in two branches' '
 	git reset --hard &&
 
@@ -419,24 +456,6 @@ count_pre_post () {
 	test_line_count = "$2" actual
 }
 
-test_expect_success 'rerere gc' '
-	find .git/rr-cache -type f >original &&
-	xargs test-chmtime -172800 <original &&
-
-	git -c gc.rerereresolved=5 -c gc.rerereunresolved=5 rerere gc &&
-	find .git/rr-cache -type f >actual &&
-	test_cmp original actual &&
-
-	git -c gc.rerereresolved=5 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f >actual &&
-	test_cmp original actual &&
-
-	git -c gc.rerereresolved=0 -c gc.rerereunresolved=0 rerere gc &&
-	find .git/rr-cache -type f >actual &&
-	>expect &&
-	test_cmp expect actual
-'
-
 merge_conflict_resolve () {
 	git reset --hard &&
 	test_must_fail git merge six.1 &&
@@ -446,6 +465,8 @@ merge_conflict_resolve () {
 }
 
 test_expect_success 'multiple identical conflicts' '
+	rm -fr .git/rr-cache &&
+	mkdir .git/rr-cache &&
 	git reset --hard &&
 
 	test_seq 1 6 >early &&
