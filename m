Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD694C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9169A20738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mfQSFvTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHXUik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:38:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51624 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXUik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 16:38:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EDA977DA7;
        Mon, 24 Aug 2020 16:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J/ZKPbmj3AN7aI99jROMsEH+2EM=; b=mfQSFv
        TzVBW5ptFVYUXgTY4lRLJxGT+VVfzn534rgDLrQFbmEdHztXLbBn2LvJxDol8kse
        5wDQCRbhG99iky9rRWdHR22iDmhHe/Lz40VQ4Uk8tig44tiB9gHzKKByd6OB4kqT
        0jYuMGDTtMZPZ6QRO9i4VeQEu4KutDDisdWeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M8B+DoDSB7ZEhr5AxGjB790OH7BX4Z+7
        Xx/Zc0jFEdNng3hwb4+Pv/1Slo3nvnHuVqmhCJPHt1oRPFye0LXlVHx0XuMLMdJs
        tl3E93xjpBvherIjh3bOjEJ6Uyya0t9yc78qCTVb9QYXhPGD/58lF/8o6nQGnj/y
        FdBQjo0twOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8472F77DA6;
        Mon, 24 Aug 2020 16:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DE1377DA4;
        Mon, 24 Aug 2020 16:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Ori Bernstein <ori@eigenstate.org>, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
References: <20200823005236.10386-1-ori@eigenstate.org>
        <20200823031151.10985-1-ori@eigenstate.org>
        <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
        <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
        <ef92391d-09ef-4c27-e6dd-ec7b907174fa@web.de>
        <20200824201208.GA706849@coredump.intra.peff.net>
Date:   Mon, 24 Aug 2020 13:38:35 -0700
In-Reply-To: <20200824201208.GA706849@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Aug 2020 16:12:08 -0400")
Message-ID: <xmqq5z974w50.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8E47174-E649-11EA-A1E1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it may be worth making this a configurable value
> (core.maxDeltaDepth or something). Nobody would generally need to tweak
> it, but it would give an escape hatch for getting people out of a broken
> situation ("git -c core.maxDeltaDepth=50000 repack" or similar).

... meaning "the pack I have has overlong delta chains to read, and
I am running repack to cut these chains down to more manageable
level"?  Makes sense.

As it may be a bit tricky to figure out where we should read such a
configuration for those who are new to our codebase, here is an
illustration to give a starting point.  Docs and tests are probably
needed, too.

 cache.h       | 1 +
 config.c      | 5 +++++
 environment.c | 1 +
 packfile.c    | 6 ++++++
 4 files changed, 13 insertions(+)

diff --git a/cache.h b/cache.h
index 0290849c19..b59d43f0ec 100644
--- a/cache.h
+++ b/cache.h
@@ -919,6 +919,7 @@ extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
+extern int max_allowed_delta_depth;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern const char *apply_default_whitespace;
diff --git a/config.c b/config.c
index 2b79fe76ad..5f9114f847 100644
--- a/config.c
+++ b/config.c
@@ -1197,6 +1197,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.maxalloweddeltadepth")) {
+		max_allowed_delta_depth = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.logallrefupdates")) {
 		if (value && !strcasecmp(value, "always"))
 			log_all_ref_updates = LOG_REFS_ALWAYS;
diff --git a/environment.c b/environment.c
index 52e0c979ba..d3f9a10799 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
+int max_allowed_delta_depth = 10000;
 int is_bare_repository_cfg = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
diff --git a/packfile.c b/packfile.c
index 6ab5233613..2ea24a19dd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1715,6 +1715,12 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			break;
 		}
 
+		if (max_allowed_delta_depth < delta_stack_nr) {
+			error("overlong delta chain at offset %"PRIuMAX" from %s",
+			      (uintmax_t)curpos, p->pack_name);
+			goto out;
+		}
+
 		/* push object, proceed to base */
 		if (delta_stack_nr >= delta_stack_alloc
 		    && delta_stack == small_delta_stack) {





