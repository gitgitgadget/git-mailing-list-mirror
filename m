Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581BC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 22:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiGGW6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGW6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 18:58:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F1CE03
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 15:58:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A19F1474D0;
        Thu,  7 Jul 2022 18:58:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+GZPItCo0MzDqa5pYdqUTZV1rH5cKVz+YD9NpQ
        0cHJc=; b=pLORQG0gI4r/diwja4gtmoEJKC2iphkow3hbj5nRgHfmIlWVr+is2a
        QIeC4Tqtg8MOXJTsAb0EJZR90mNYfHZy+AAFJW/7tydi4+GRTNJq1mZMenlZkx+I
        jT1Xdea+zjLGN0FYLZxefJLtNbUaytmUsIZkW2t6l0MLAfK46YI3w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E0DB1474CE;
        Thu,  7 Jul 2022 18:58:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7FE41474CC;
        Thu,  7 Jul 2022 18:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk, avarab@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH v2 0/4] Add support for mailmap in cat-file
In-Reply-To: <xmqqsfncy3w1.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        07 Jul 2022 15:06:06 -0700")
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <xmqqsfncy3w1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 07 Jul 2022 15:58:29 -0700
Message-ID: <xmqqmtdky1gq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51F452BE-FE48-11EC-BCA9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> Changes in v2:
>> - The commit_rewrite_person() has been improved by restricting it to
>>   traverse only the header part of the object buffers.
>> - The callers of commit_rewrite_person() now don't require to call it
>>   multiple times for different headers. They can pass an array of
>>   headers and commit_rewrite_person() replaces idents only on those
>>   headers.
>> - commit_rewrite_person() has been renamed to a suitable name which
>>   expresses its functionality clearly.
>> - More tests have been added to test the --[no-]-use-mailmap option for
>>   the tag objects.
>> - Redundant operations from the tests have been removed.
>
> I agree with the general direction and the implementation strategy.
> I've noticed a few decl-after-statement and also at least one public
> helper function that does not need to be public.  Are you building
> with "make DEVELOPER=YesPlease"?  It enables -pedantic and -Werror,
> -Wdeclaration-after-statement, among other options (see the
> config.mak.dev file for the complete list) to help you catch these
> locally before sendign your patches to the list.

Here is what I prepared on top of your series to make them compile
while queuing them on a topic branch.

 builtin/cat-file.c | 7 +++++--
 revision.c         | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6dc750a367..4ca024a018 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -40,11 +40,14 @@ static const char *force_path;
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 static int use_mailmap;
 
-char *replace_idents_using_mailmap(char *object_buf, size_t *size)
+static char *replace_idents_using_mailmap(char *, size_t *);
+
+static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
 {
 	struct strbuf sb = STRBUF_INIT;
-	strbuf_attach(&sb, object_buf, *size, *size + 1);
 	const char *headers[] = { "author ", "committer ", "tagger ", NULL };
+
+	strbuf_attach(&sb, object_buf, *size, *size + 1);
 	apply_mailmap_to_header(&sb, headers, &mailmap);
 	*size = sb.len;
 	return strbuf_detach(&sb, NULL);
diff --git a/revision.c b/revision.c
index b561d6b5b5..767c6225df 100644
--- a/revision.c
+++ b/revision.c
@@ -3787,10 +3787,10 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		strbuf_addstr(&buf, message);
 
 	if (opt->grep_filter.header_list && opt->mailmap) {
+		const char *commit_headers[] = { "author ", "committer ", NULL };
+
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-
-		const char *commit_headers[] = { "author ", "committer ", NULL };
 		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
 	}
 
-- 
2.37.0-211-gafcdf5f063

