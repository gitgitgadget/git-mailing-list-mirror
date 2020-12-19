Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09812C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BC223B8C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 05:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgLSFQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 00:16:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgLSFQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 00:16:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77905113DF3;
        Sat, 19 Dec 2020 00:16:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b4D5c0DDDx8z0wvMjw8YbQW0VgY=; b=phvD9X
        CQs1h//8UtR1TWeO5bKc6PPZ9WJJn5Ptbn4EDFQd24vMpj+HkL/Ys4pZM+2FB6X5
        5KDib1DOSLDse61gDxAqf0H98grRFS2NEkblk6ipOqxcL4fiBwhjacoD2C45Tr3X
        NaMtScjt6zoJZmtRxo4M1+SX8QmN11OMGx++k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QnlEQ/r8xUYU+yuUAOdYFj5V4TqY6fL6
        ZHcos0R9KA7Cf4o3D8I0K3LKFastB0OcX7ZKDkbluJm0dy8+uLCBPjY1flu8P6jK
        6w2m3hQxheM8biW2ixvwZNF1JWHTSskAB9HOZQXJmq/yIvIFo3U380xUqCS3vUL9
        spOc/jInVSw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 714E1113DF2;
        Sat, 19 Dec 2020 00:16:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5279113DF1;
        Sat, 19 Dec 2020 00:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
Date:   Fri, 18 Dec 2020 21:16:03 -0800
In-Reply-To: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        (Philippe Blain's message of "Fri, 18 Dec 2020 23:23:41 -0500")
Message-ID: <xmqqmtyaqsto.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B180E1A-41B9-11EB-8CF4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..29fecc340f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -43,7 +43,14 @@ show_tool_names () {
 
 	shown_any=
 	( cd "$MERGE_TOOLS_DIR" && ls ) | {
-		while read toolname
+		while read scriptname
+		do
+			setup_tool "$scriptname" 2>/dev/null
+			variants="$variants$(list_tool_variants)\n"

Ahh, that does look quite bogus as \n won't do anything useful
there.  And I do not think we _need_ to use LF there.

+		done
+		variants="$(echo "$variants" | sort | uniq)"

+
+		for toolname in $variants

Just replace \n with " " (whitespace) and do something like this,
perhaps?

			variants="$variantes$(list_tool_variants) "
		done
		variants=$(printf "%s\n" $variants | sort | uniq)

