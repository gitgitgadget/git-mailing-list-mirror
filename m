Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B9C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F15225A9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 05:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbhAXFOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 00:14:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54606 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbhAXFOX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 00:14:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FDAE11AAE0;
        Sun, 24 Jan 2021 00:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UoIxYN5BAKzqAEeWnoAG8H5yz1Q=; b=NODxpq
        9ggS4LoUIyVYM1tdB6bkmHFkcFDZzLdqXtLLWv9PmzXRgUyysYZP6NqvOPvty/Bc
        ROefImY1c22i46Ke7gfR9l+6oOFkJXbC3Rgx3qZDoT8H9vOAgAnxjXBYwvlVWp9l
        o80pmM1wHLZSXuRtQEglcrVTUb0w8uP9+8Ueo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/tyjTG5DIpOQmXDcoaZFtPx8KX8G5Jw
        YMyGiB350kj5D8wOZFxlAi0v87puamRHzOiH0oIWjTZ9L1KLcHbDo2kcatZjTndu
        9RD1b7IPe7dqdhAVrQ10JXZszly6JMmfhYq+Nbd1iQVgmlqu//kqWFezhkIrVGsp
        ZHb04uoud5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17E3211AADF;
        Sun, 24 Jan 2021 00:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 656B411AADE;
        Sun, 24 Jan 2021 00:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v3 2/7] bisect--helper: reimplement `bisect_replay`
 shell function in C
References: <20210123154056.48234-1-mirucam@gmail.com>
        <20210123154056.48234-3-mirucam@gmail.com>
        <xmqq35yr2nh0.fsf@gitster.c.googlers.com>
Date:   Sat, 23 Jan 2021 21:13:32 -0800
In-Reply-To: <xmqq35yr2nh0.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 23 Jan 2021 16:22:03 -0800")
Message-ID: <xmqqr1ma29z7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E83F0670-5E02-11EB-8414-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Miriam Rubio <mirucam@gmail.com> writes:
>
>> From: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> Reimplement the `bisect_replay` shell function in C and also add
>> `--bisect-replay` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh
>> ...
>> +static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
>> +{
>> +	const char *p = line->buf + strspn(line->buf, " \t");
>> +
>> +	if ((!skip_prefix(p, "git bisect", &p) &&
>> +	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
>> +		return 0;
>> +	p += strspn(p, " \t");
>> +
>> +	char *word_end = (char*)p + strcspn(p, " \t");
>> +	char *rev = word_end + strspn(word_end, " \t");
>
> Are these lines new in this round?
>
> These break builds with -Werror=declaration-after-statement.


The following fix-up is tentatively queued at the tip of the topic
in tonight's pushout.  There might be better way to do what this
function is doing (especially I am skeptical about the way the code
casts const away), so please don't blindly trust it, but at least it
should please the compiler.

(char*) should be spelled (char *), by the way.

Thanks.


diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3b0a6a7d0c..c673f87795 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -918,14 +918,15 @@ static enum bisect_error bisect_log(void)
 static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 {
 	const char *p = line->buf + strspn(line->buf, " \t");
+	char *word_end, *rev;
 
 	if ((!skip_prefix(p, "git bisect", &p) &&
 	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
 		return 0;
 	p += strspn(p, " \t");
 
-	char *word_end = (char*)p + strcspn(p, " \t");
-	char *rev = word_end + strspn(word_end, " \t");
+	word_end = (char*)p + strcspn(p, " \t");
+	rev = word_end + strspn(word_end, " \t");
 	*word_end = '\0'; /* NUL-terminate the word */
 
 	get_terms(terms);
-- 
2.30.0-492-gde1138eff7

