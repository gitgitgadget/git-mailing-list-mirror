Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8001F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbcHaTzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:55:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753645AbcHaTzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:55:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 872B837BA8;
        Wed, 31 Aug 2016 15:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+lT37E4dwMgj0nwluXmRXHciMj4=; b=Fw/6s2
        ZF/TX8Rj6K2hhM9cAYzRt+xeCxrYkW2fcKrRxhb1Ma3I3jOFORCQY+MRRJRa4pqb
        GUN0a4KZrWJRmE9W59BSp6M6RFcHqzmfctbP1w44O0BDrRE1pfN1533RQo4Du9F6
        8XVpOZHI2RScBei7mRjmDARWp/+4PvfYuAa5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hui8TwoogkLWOgnGT6HnSju1PwIfOh+H
        dAPx/RNT9aHJ6JlhPNHtuCtRZDdNAxVgtHCFhVPdYzoJWPScvLrn8caa5/JMgH3t
        somrxyIQuDni2mabA6jL/HAHDbDuVU9VlhqWlZcrNYR/YOag/2L54fLzAOUR0iqV
        bpdo5N9DV/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80FC537BA7;
        Wed, 31 Aug 2016 15:55:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19F1937BA6;
        Wed, 31 Aug 2016 15:55:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] squelch some "gcc -O3 -Wmaybe-uninitialized" warnings
References: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
Date:   Wed, 31 Aug 2016 12:55:01 -0700
In-Reply-To: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 Aug 2016 23:39:34 -0400")
Message-ID: <xmqqvaygzpbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF20478A-6FB4-11E6-99D6-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I happened to be compiling git with -O3 today, and noticed we generate
> some warnings about uninitialized variables (I actually compile with
> -Wall, but the only false positives I saw were these).
>
> Here are patches to squelch them.
>
>   [1/2]: error_errno: use constant return similar to error()
>   [2/2]: color_parse_mem: initialize "struct color" temporary

Interesting.  Here is for "gcc -Os" on top to appease gcc 4.8.4 that
I probably am NOT going to apply.  These are all false positives.

The ones on config.c is the most curious as these two "ret" needs a
false initialization, but the one that comes after them
git_config_ulong() that has the same code structure does not get any
warning, which made absolutely no sense to me.


 builtin/update-index.c | 2 +-
 config.c               | 4 ++--
 diff.c                 | 2 +-
 fast-import.c          | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b19..a202612 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -832,7 +832,7 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 				const struct option *opt, int unset)
 {
 	unsigned char sha1[20];
-	unsigned int mode;
+	unsigned int mode = 0;
 	const char *path;
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, sha1, &path)) {
diff --git a/config.c b/config.c
index 0dfed68..52133aa 100644
--- a/config.c
+++ b/config.c
@@ -685,7 +685,7 @@ static void die_bad_number(const char *name, const char *value)
 
 int git_config_int(const char *name, const char *value)
 {
-	int ret;
+	int ret = 0;
 	if (!git_parse_int(value, &ret))
 		die_bad_number(name, value);
 	return ret;
@@ -693,7 +693,7 @@ int git_config_int(const char *name, const char *value)
 
 int64_t git_config_int64(const char *name, const char *value)
 {
-	int64_t ret;
+	int64_t ret = 0;
 	if (!git_parse_int64(value, &ret))
 		die_bad_number(name, value);
 	return ret;
diff --git a/diff.c b/diff.c
index c7e2605..1098198 100644
--- a/diff.c
+++ b/diff.c
@@ -995,7 +995,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
-	int i, j;
+	int i, j = 0;
 	long alloc = 0;
 
 	out->size = 0;
diff --git a/fast-import.c b/fast-import.c
index bf53ac9..abc4519 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1377,6 +1377,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
 	unsigned char c;
 	uint16_t mode = 0;
 
+	*modep = 0;
 	while ((c = *str++) != ' ') {
 		if (c < '0' || c > '7')
 			return NULL;
