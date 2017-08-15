Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CD8208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdHOT0e (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:26:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56537 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752031AbdHOT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:26:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D83ACA734E;
        Tue, 15 Aug 2017 15:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xrqPkbR85ArIz9ON6mv98j3Mcjo=; b=b3tPRJ
        n3JnFV1FmT3dRnQjvLCDUA3EhsQzuRhJEoF8mwJe2N1QCXwokOATMlj/xBWvxfyO
        kKhxa4e+/DFWOTi9DLWCYtMs1J5neIVr28bmA5habBZPpib7TlMPAubbg1VNnyFY
        rlWhw3pqRzoevtuVRLO6P8wDf1HzfpwZnCxpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iFARhOM5mfSNm07Eo2xyJoZXkEFK+VrJ
        830eJeoMKRNi2ymHFp7m9PqG19oucxCxwpwqlf90c+Lgld0cZdRmKyTCnA0SEWF+
        SJ1pXEkUfUfYgDNVPTKIF7s3rJSia7PnGKxSbJ61QTwNGbsfrZ03vJJDwGOP29/Q
        N0Y9+c+IQ/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEE76A734D;
        Tue, 15 Aug 2017 15:26:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23AE6A7349;
        Tue, 15 Aug 2017 15:26:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
        <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com>
Date:   Tue, 15 Aug 2017 12:26:23 -0700
In-Reply-To: <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com> (Lars
        Schneider's message of "Tue, 15 Aug 2017 21:00:53 +0200")
Message-ID: <xmqq378sr5sw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0C0BEBC-81EF-11E7-AD7E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 15 Aug 2017, at 19:36, Christian Couder <christian.couder@gmail.com> wrote:
>> 
>> In handshake_capabilities() we use warning() when a capability
>> is not supported, so the exit code of the function is 0 and no
>> further error is shown. This is a problem because the warning
>> message doesn't tell us which subprocess cmd failed.
>> 
>> On the contrary if we cannot write a packet from this function,
>> we use error() and then subprocess_start() outputs:
>> 
>>    initialization for subprocess '<cmd>' failed
>> 
>> so we can know which subprocess cmd failed.
>> 
>> Let's improve the warning() message, so that we can know which
>> subprocess cmd failed.
>> 
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> sub-process.c | 13 ++++++++-----
>> 1 file changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/sub-process.c b/sub-process.c
>> index 6edb97c1c6..6b133f8dce 100644
>> --- a/sub-process.c
>> +++ b/sub-process.c
>> @@ -158,7 +158,8 @@ static int handshake_version(struct child_process *process,
>> 
>> static int handshake_capabilities(struct child_process *process,
>> 				  struct subprocess_capability *capabilities,
>> -				  unsigned int *supported_capabilities)
>> +				  unsigned int *supported_capabilities,
>> +				  const char *cmd)
>> {
>> 	int i;
>> 	char *line;
>> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct child_process *process,
>> 			if (supported_capabilities)
>> 				*supported_capabilities |= capabilities[i].flag;
>> 		} else {
>> -			warning("external filter requested unsupported filter capability '%s'",
>> -				p);
>> +			warning("subprocess '%s' requested unsupported capability '%s'",
>> +				cmd, p);
>
> Wouldn't it be possible to use "process->argv[0]"? 
> Shouldn't that be the same as "cmd"?

It is good to see many people are in agreement and in favor of
giving more information.  It is even better to see somebody noticing
a room for improvement ;-)

I also wonder if this should be left as a silent warning that the
caller cannot notice as in the corrent code.  Dying here might not
be desirable for some callers, but even if we don't die here, we may
want to give the caller a chance to react to the protocol error.
