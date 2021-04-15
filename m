Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4438DC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B9610FB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhDOWPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:15:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53633 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbhDOWPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 18:15:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4600812453B;
        Thu, 15 Apr 2021 18:15:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lp/Sar93ktQLAzACZAOJ/6qQSWc=; b=gNfw69
        0mgPBEbe3PPOMXbPOT/THViEOEaUl6m1+lEs6IH9FqlE7en+iQRXk8CxOs9jS5VY
        bsXOZsLM+iPjoisErqqo8Fjv/Bvv2njr0V17f7YW9QIagWVYHE2nOWULxDHF75rV
        rxXzBpZ4Yp6WmNFXFEgsIk2bDfYi8o82qDH5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EzruezhmUmGgsKfC6llvuglXYleTDa1G
        S1VgCvqxw30mcJipQIAa/37IH1gBL8OEZc9sOenlsbI7M8Fc17NxCDKjm0Y3VMIy
        7qUiHieCxKHFj4KyKeYP5W2eI6btCSrBBxREMv6DY9LJhy4GZLNMFTfKIuDEEepO
        hkT8sOLGSg4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E79612453A;
        Thu, 15 Apr 2021 18:15:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82478124538;
        Thu, 15 Apr 2021 18:15:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bruno Albuquerque <bga@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] object-info: support for retrieving object info
References: <20210415212017.1407303-1-bga@google.com>
Date:   Thu, 15 Apr 2021 15:15:09 -0700
In-Reply-To: <20210415212017.1407303-1-bga@google.com> (Bruno Albuquerque's
        message of "Thu, 15 Apr 2021 14:20:17 -0700")
Message-ID: <xmqqmttznqj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BA262FE-9E38-11EB-8CF5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bruno Albuquerque <bga@google.com> writes:

> +int cap_object_info(struct repository *r, struct strvec *keys,
> +		    struct packet_reader *request)
> +{
> +	struct packet_writer writer;
> +	packet_writer_init(&writer, 1);

This triggers -Wdeclaration-after-statement below.  Move it down.

> +	int parsed_header;
> +	struct requested_info info;
> +

Puzzling blank line here.  There does not seem to be a good reason
why 'parsed_header' bit plus 'info' pair together closely than to
the other 'oid_str_list' variable, so it does not make much sense as
a grouping aid.

> +	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
> +

Here, just before "parsed_header = 0;" after the blank line that
separates the decls and the statements, is a good place to say
"packet_writer_init()".  Also it may make more sense to give initial
value to parsed_header where it is declared.

> +	parsed_header = 0;
> +	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
> +		if (!strcmp("size", request->line)) {
> +			info.size = 1;
> +			continue;

And upon further inspection, nobody seems to use parsed_header at
all.  Let's lose it.

Perhaps this minimum fix-up squashed in?

Next time, perhaps try "make DEVELOPER=YesPlease test" to catch
possible problems like these early?

Thanks.


 protocol-caps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git c/protocol-caps.c w/protocol-caps.c
index c15e397756..922bfeb905 100644
--- c/protocol-caps.c
+++ w/protocol-caps.c
@@ -78,13 +78,10 @@ int cap_object_info(struct repository *r, struct strvec *keys,
 		    struct packet_reader *request)
 {
 	struct packet_writer writer;
-	packet_writer_init(&writer, 1);
-	int parsed_header;
 	struct requested_info info;
-
 	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
 
-	parsed_header = 0;
+	packet_writer_init(&writer, 1);
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		if (!strcmp("size", request->line)) {
 			info.size = 1;

