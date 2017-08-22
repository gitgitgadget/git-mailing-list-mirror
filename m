Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B291F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbdHVVrP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:47:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50884 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752890AbdHVVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:47:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE376AA245;
        Tue, 22 Aug 2017 17:47:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=azew
        RL2L/nMQzIQHOSD5CjpRlcs=; b=mb967AzhysdLuMlqQUlOpgTMIJrpi4haIICP
        9o0l8IlEA+tQH0uXm5PoutI4npYlWPqj0o9CXCWgloz1sbhVv40QR3EOfohpXEQl
        ++FwVvQXNl7U41x1dT96zlZrTIy4/2kYmKLZjqMxYTrRknOZa0feD7dSqHAT4ra2
        Tk0zPHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        wQuvGyXS0W7GhQ1DP7WMXDqw9wc0ezsgYyPp6NtoX6mvPaokAUhtTqMOVlfekPVu
        59GCavdgdvfCoFzSH8c9qpICaacUx3N+udfIYf8howZc91H6DejqOWiKHrUbZ3Kd
        G3gzsei70YH4UGGnlrL1EeTyYitHm05XucXtpANkI8w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4364AA244;
        Tue, 22 Aug 2017 17:47:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15781AA241;
        Tue, 22 Aug 2017 17:47:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 6/6] rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved
Date:   Tue, 22 Aug 2017 14:46:52 -0700
Message-Id: <20170822214652.31626-7-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-427-g5711bb0564
In-Reply-To: <20170822214652.31626-1-gitster@pobox.com>
References: <20170819203013.3053-1-gitster@pobox.com>
 <20170822214652.31626-1-gitster@pobox.com>
X-Pobox-Relay-ID: 6F9B10BE-8783-11E7-A39E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two configuration variables are described in the documentation
to take an expiry period expressed in the number of days:

    gc.rerereResolved::
	    Records of conflicted merge you resolved earlier are
	    kept for this many days when 'git rerere gc' is run.
	    The default is 60 days.

    gc.rerereUnresolved::
	    Records of conflicted merge you have not resolved are
	    kept for this many days when 'git rerere gc' is run.
	    The default is 15 days.

There is no strong reason not to allow a more general "approxidate"
expiry specification, e.g. "5.days.ago", or "never".

Rename the config_get_expiry() helper introduced in the previous
step to git_config_get_expiry_in_days() and move it to a more
generic place, config.c, and use date.c::parse_expiry_date() to do
so.  Give it an ability to allow the caller to tell among three
cases (i.e. there is no "gc.rerereResolved" config, there is and it
is correctly parsed into the *expiry variable, and there was an
error in parsing the given value).  The current caller can work
correctly without using the return value, though.

In the future, we may find other variables that only allow an
integer that specifies "this many days" or other unit of time, and
when it happens we may need to drop "_days" suffix from the name of
the function and instead pass the "scale" value as another parameter.

But this will do for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  2 ++
 config.c                 | 22 ++++++++++++++++++++++
 config.h                 |  3 +++
 rerere.c                 | 14 ++------------
 t/t4200-rerere.sh        |  2 ++
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab6..ac95f5f954 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1553,11 +1553,13 @@ gc.<pattern>.reflogExpireUnreachable::
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
 	The default is 60 days.  See linkgit:git-rerere[1].
 
 gc.rerereUnresolved::
 	Records of conflicted merge you have not resolved are
 	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
 gitcvs.commitMsgAnnotation::
diff --git a/config.c b/config.c
index 231f9a750b..ffca15f594 100644
--- a/config.c
+++ b/config.c
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
index 0352da117b..34ddd3eb8d 100644
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
diff --git a/rerere.c b/rerere.c
index f0b4bce881..d77235645e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1176,16 +1176,6 @@ static void prune_one(struct rerere_id *id,
 		unlink_rr_item(id);
 }
 
-static void config_get_expiry(const char *key, timestamp_t *cutoff, timestamp_t now)
-{
-	int days;
-
-	if (!git_config_get_int(key, &days)) {
-		const int scale = 86400;
-		*cutoff = now - days * scale;
-	}
-}
-
 void rerere_gc(struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
@@ -1199,8 +1189,8 @@ void rerere_gc(struct string_list *rr)
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
index 8d437534f2..d97d2bebc9 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -274,6 +274,8 @@ rerere_gc_custom_expiry_test () {
 
 rerere_gc_custom_expiry_test 5 0
 
+rerere_gc_custom_expiry_test 5.days.ago now
+
 test_expect_success 'setup: file2 added differently in two branches' '
 	git reset --hard &&
 
-- 
2.14.1-427-g5711bb0564

