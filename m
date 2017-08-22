Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2481C1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 22:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbdHVW3o (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:29:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56166 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752684AbdHVW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:29:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D7C9111C;
        Tue, 22 Aug 2017 18:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zGKUpzXvZ72ADihR5a5AWH3gXh8=; b=BNhHg0
        stbYTNH7hf1wwvl7Efio8rJ7hUqdYqzyUyfpnV3BhhkzIZz6XnrDv7qT6ZN0mIEb
        iwBZtG48rmafz8a6NlZ1oIZP8wnwiYc3jO0a0vFLN+lxDU8GEf5z0n/dRGi9JR+V
        hTbDJ70COrtdjFydLB+j1S3awB4y5Jt8KF3NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N1dGkop/54CeKv2c8wlWR/GbYT0MX7kN
        nkukUvhM4SUwCN/MYETvvagjiBfR/usq74C4oA4W6MDATDFLvrUoqX6gOTLntaky
        f3g8Q8MRwfI93LEv1f8E9kCe4ctsm7A+paYuJy//+h+AzUJYh0DT1VOm1aeL2HIW
        8DJe6aAvfMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 714559111A;
        Tue, 22 Aug 2017 18:29:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D221B91117;
        Tue, 22 Aug 2017 18:29:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 1/4] submodule--helper: introduce get_submodule_displaypath()
References: <20170821161515.23775-1-pc44800@gmail.com>
Date:   Tue, 22 Aug 2017 15:29:40 -0700
In-Reply-To: <20170821161515.23775-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Mon, 21 Aug 2017 21:45:12 +0530")
Message-ID: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6429195A-8789-11E7-BB7D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function get_submodule_displaypath() to replace the code
> occurring in submodule_init() for generating displaypath of the
> submodule with a call to it.

Looks like a quite straight-forward refactoring.

> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +	const char *super_prefix = get_super_prefix();
> +
> +	if (prefix && super_prefix) {
> +		BUG("cannot have prefix '%s' and superprefix '%s'",
> +		    prefix, super_prefix);
> +	} else if (prefix) {
> +		struct strbuf sb = STRBUF_INIT;
> +		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +		strbuf_release(&sb);
> +		return displaypath;

Use of xstrdup() would waste one extra allocation and copy, no?  In
other words, wouldn't this do the same thing?

	... {
		struct strbuf sb = STRBUF_INIT;

		relative_path(path, prefix, &sb);
	        return strbuf_detach(&sb, NULL);

> @@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 * Set active flag for the submodule being initialized
>  	 */
>  	if (!is_submodule_active(the_repository, path)) {
> -		strbuf_reset(&sb);
>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
>  		git_config_set_gently(sb.buf, "true");
>  	}

This is because sb will stay untouched with the use of the new
helper.  With the way this single strbuf is reused throughout this
function, I cannot help wondering if the prevailing pattern of
resetting and then using is a mistake.  If the strbuf is mostly used
as a scratchpad, wouldn't it make more sense to use it and then
clean up when you are done with it?

I.e. something along this line that shows only two uses...

 builtin/submodule--helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0ff9dd0b85..84ded4b2e9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -363,9 +363,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -373,7 +373,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -410,9 +409,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
+	strbuf_reset(&sb);
 
 	/* Copy "update" setting when it is not set yet */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
 	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {


