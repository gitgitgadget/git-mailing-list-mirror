Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BE81F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdHSUaX (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:30:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51239 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751533AbdHSUaV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDB3DAB595;
        Sat, 19 Aug 2017 16:30:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Cieo
        BqhAoPEhXe4YKQTxZNc0GdY=; b=eBw/+l0CVZMyBX/MJDkKLCGnXvKi6UiHULcQ
        /Ky4q/mEhx7XQfnxmoim6urdlRx3xHRzatPMJkZ5u02TzvYEjwh9zYg1c71vuvgv
        ZeX4sbtNiuE2/0GGBqUFPTuycD1NpV7H0hSgrhLklegeaa/2pGhb4YdZbnEXVnUR
        qpWoSjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        GgGoHZg+CyAm9OWzq9qTHOjWt/RmPbLQ3ePHcI0ALESS6p6hncYFoKDpthnb+5Gs
        /XDEBCdvaNyzDfaTZoXmuu5bFQl3n5QUvOQMvvoG9HaVZ68T5UOKBpKlBYXe+mnv
        DZXgQ2Q+tkjplCtNmExgsk4Xp605Jl8xY89R4HgSPqw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D49EDAB594;
        Sat, 19 Aug 2017 16:30:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 460BDAB592;
        Sat, 19 Aug 2017 16:30:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Uwe Hausbrand <uwe.hausbrand@gmx.de>
Subject: [PATCH 2/2] rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved
Date:   Sat, 19 Aug 2017 13:30:13 -0700
Message-Id: <20170819203013.3053-3-gitster@pobox.com>
X-Mailer: git-send-email 2.14.1-405-g52c75fc716
In-Reply-To: <20170819203013.3053-1-gitster@pobox.com>
References: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
 <20170819203013.3053-1-gitster@pobox.com>
X-Pobox-Relay-ID: 37188428-851D-11E7-9B07-9D2B0D78B957-77302942!pb-smtp2.pobox.com
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

Tweak the config_get_expiry() helper introduced in the previous step
to use date.c::parse_expiry_date() to do so.

In the future, we may find other variables that only allow an
integer that specifies "this many days" (or other unit of time) and
allow them to also do the same, and at that point we probably would
want to move the helper to a place that is not specific to the
rerere machinery.  Perhaps config.c would be such a good neutral
place, as it will allow git_parse_signed() to go back to static to
the file.

But this will do for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  2 ++
 config.c                 |  4 ++--
 config.h                 |  3 +++
 rerere.c                 | 14 ++++++++++++--
 4 files changed, 19 insertions(+), 4 deletions(-)

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
index 231f9a750b..ac9071c5cf 100644
--- a/config.c
+++ b/config.c
@@ -769,7 +769,7 @@ static int parse_unit_factor(const char *end, uintmax_t *val)
 	return 0;
 }
 
-static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -799,7 +799,7 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	return 0;
 }
 
-static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
diff --git a/config.h b/config.h
index 0352da117b..039a9295de 100644
--- a/config.h
+++ b/config.h
@@ -215,4 +215,7 @@ struct key_value_info {
 extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
 extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
+int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
+int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
+
 #endif /* CONFIG_H */
diff --git a/rerere.c b/rerere.c
index f0b4bce881..8bbdfe8569 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1178,11 +1178,21 @@ static void prune_one(struct rerere_id *id,
 
 static void config_get_expiry(const char *key, timestamp_t *cutoff, timestamp_t now)
 {
-	int days;
+	char *expiry_string;
+	intmax_t days;
+	timestamp_t when;
 
-	if (!git_config_get_int(key, &days)) {
+	if (git_config_get_string(key, &expiry_string))
+		return;
+
+	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
 		const int scale = 86400;
 		*cutoff = now - days * scale;
+		return;
+	}
+
+	if (!parse_expiry_date(expiry_string, &when)) {
+		*cutoff = when;
 	}
 }
 
-- 
2.14.1-405-g52c75fc716

