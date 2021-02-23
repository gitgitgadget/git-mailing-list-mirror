Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E2C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047C864E7A
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBWWve (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:51:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64314 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhBWWrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 17:47:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B062B96BD3;
        Tue, 23 Feb 2021 17:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vUjrz523ocE+2OD7UVdDg9P29JU=; b=A93WJI
        AZOn/ribchOjC8xkcyzvreVppPCTUdo9qYdwkC0shIBaV7L3n2yoeOl8l24jq8gt
        /e413TSaHr6sODqACTlaZXx32oHWJEEcO9+xMxtr1xVXlJ18KnDRj8li0Y/gS/mW
        RXthf9RbQF8uzvL8umX5Hn+Gfy8HuupBG+uSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSFGlrAtqIwQvZmdni9tXoV8NS4Z/D4T
        AC66vDvLKB6y8xkCRn5koflgR9aIBTbcoU/4tMiZmJPYtoz9CPX30BKXpFibkzNs
        ap3QRB6VeG9ZjxSwSAZl1Y5cwVRxKA41wU1zTDwnoyM5orFgnlQwGdIgZZFHPgjR
        LZtoJVCIlSU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A78CA96BD2;
        Tue, 23 Feb 2021 17:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3156F96BCF;
        Tue, 23 Feb 2021 17:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tilman Vogel <tilman.vogel@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What does `git push origin --delete ""` do?
References: <CAAbQbbCAqbJhU05WSWD6HmHpAxLqs0LbFzQmKHNaDUg2kHkZBQ@mail.gmail.com>
Date:   Tue, 23 Feb 2021 14:46:51 -0800
In-Reply-To: <CAAbQbbCAqbJhU05WSWD6HmHpAxLqs0LbFzQmKHNaDUg2kHkZBQ@mail.gmail.com>
        (Tilman Vogel's message of "Tue, 23 Feb 2021 22:50:09 +0100")
Message-ID: <xmqqa6ru1jxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0573F6CC-7629-11EB-941B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tilman Vogel <tilman.vogel@web.de> writes:

> Because of an empty line in the input file, my script
>
> cat remove.txt | sed 's/origin\///' | xargs -d '\n' git push origin --delete
>
> executed (among other deletions) an implicit `git push origin --delete
> ""`. I wonder, what that one is supposed to do.

It is supposed to error out, but incorrectly and silently turns
itself into a "matching push".

This should fix it, I think (not even compiled tested).

 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/push.c w/builtin/push.c
index 03adb58602..194967ed79 100644
--- c/builtin/push.c
+++ w/builtin/push.c
@@ -115,7 +115,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 			else
 				refspec_appendf(&rs, "refs/tags/%s", ref);
 		} else if (deleterefs) {
-			if (strchr(ref, ':'))
+			if (strchr(ref, ':') || !*ref)
 				die(_("--delete only accepts plain target ref names"));
 			refspec_appendf(&rs, ":%s", ref);
 		} else if (!strchr(ref, ':')) {
