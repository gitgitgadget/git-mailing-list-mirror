Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE6E211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 07:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeK2Sxj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 13:53:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60174 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeK2Sxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 13:53:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17447106BD7;
        Thu, 29 Nov 2018 02:49:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jq1U1DxhrjIm0TqBSnv6+ivoJMk=; b=Q3soCq
        QPwPiJ9HPBuVn8+wPk78kUwvUX2tyBtsPmmuYIHXtbUecY5mHFsjRdnAlDf6AnvP
        vhBjszMwen4Ygd1p5VBaJZKBLcuQBcZZxCvIm32cQJ8XpIYWkAXmnu9xX2TT5e7G
        VKCUwv2JvK7V+9b1TLkmpRyt0/p3epaPGW/Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AWcR9Rlyhcw3auKO/EXiV3xOqbCwLdYx
        7IxQUv7gqgjUv26Qo8L7o70xVzF6bXSiZK5bIfVUf/Ky8InOkpmeNB7LWsAaKaIZ
        3tMa/5LjjeW4dPel0IhJ30aF5/QStcs0rxGlNntgW29+53GD88Jkw3UTMTAwgp7J
        yw+3A+a6zH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E2E8106BD5;
        Thu, 29 Nov 2018 02:49:10 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76DF8106BD4;
        Thu, 29 Nov 2018 02:49:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
References: <20181127045301.103807-1-masayasuzuki@google.com>
        <xmqqh8g3t7gm.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 29 Nov 2018 16:49:08 +0900
In-Reply-To: <xmqqh8g3t7gm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Nov 2018 14:28:25 +0900")
Message-ID: <xmqq1s74nx1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4147E08A-F3AB-11E8-8590-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/connect.c b/connect.c
>> index 24281b608..458906e60 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -306,8 +306,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>>  			die_initial_contact(1);
>>  		case PACKET_READ_NORMAL:
>>  			len = reader->pktlen;
>> -			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
>> -				die(_("remote error: %s"), arg);
>>  			break;
>>  		case PACKET_READ_FLUSH:
>>  			state = EXPECTING_DONE;

This breaks build by not removing the decl of arg while removing the
last user of that variable in the function.

 connect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/connect.c b/connect.c
index 458906e60d..4813f005ab 100644
--- a/connect.c
+++ b/connect.c
@@ -296,7 +296,6 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 	struct ref **orig_list = list;
 	int len = 0;
 	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
-	const char *arg;
 
 	*list = NULL;
 
-- 
2.20.0-rc1-10-g7068cbc4ab

