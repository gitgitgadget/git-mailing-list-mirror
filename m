Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD231FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755789AbcHWVfx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:35:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755386AbcHWVfw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B27A93677F;
        Tue, 23 Aug 2016 17:21:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r9+0b4ram72qI7gH80Pjp+2w09o=; b=AgJo1N
        6sgsuYeTEvZw3a0+3jy08put4J3N0Dxf6RfsZdPumKqvIIz4eG0rRD3n93epY1cB
        yl0rrgdmYkD1wyZMQe3FGjIQUmInpvd1+lOBR0PV47b680XdYJfc/5BFD+qn5p9k
        Xq982rdiDoMe3zLijTQsIgF4S7zvPnm7uNm3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ecsfOz6F1cdA1Xv3mgEOLAaXLBrFQ/sd
        GceQxAtOMiNKUoOI/ZLbWix6Ga7TxOkIi6/JHocUFwKnao9dtj0uEdUatJWsR90Z
        IY37FcsxUuqNhu8JCDQcjmJ0VawjOgEj2BytOhl1eX6VmMQvwnLCCJoZFUsLvB3K
        y4fDCJ6en5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A98863677E;
        Tue, 23 Aug 2016 17:21:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AD8C3677D;
        Tue, 23 Aug 2016 17:21:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] format-patch: show 0/1 and 1/1 for singleton patch with cover letter
References: <20160819234959.26308-1-jacob.e.keller@intel.com>
        <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 23 Aug 2016 14:21:11 -0700
In-Reply-To: <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 23 Aug 2016 09:33:39 -0700")
Message-ID: <xmqqinuruqpk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84D3E314-6977-11E6-9A4D-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This obviously changes the behaviour, but I do not think of a reason
> why this change is a bad idea.  

>> diff --git a/builtin/log.c b/builtin/log.c
>> index 92dc34dcb0cc..8e6100fb0c5b 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1676,7 +1676,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>  		/* nothing to do */
>>  		return 0;
>>  	total = nr;
>> -	if (!keep_subject && auto_number && total > 1)
>> +	if (!keep_subject && auto_number && (total > 1 || cover_letter))
>>  		numbered = 1;
>>  	if (numbered)
>>  		rev.total = total + start_number - 1;

Actually there is a very good reason why this patch is not good
(yet).  When the --cover option is not specified on the command
line, cover_letter is -1 (use configuration or turn it on only when
it is a multi-patch series) at this point.

I think you would have noticed it if you ran any format-patch tests.
t/t4021-format-patch-numbered.sh fails at the very beginning.

With the attached SQUASH, existing tests pass, which is a strong
sign that this new feature needs to be protected by a new test in
the t4021 script to make sure other people would not break it in the
future.

 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e50d361..b7bfeb9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1650,16 +1650,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		/* nothing to do */
 		return 0;
 	total = nr;
-	if (!keep_subject && auto_number && (total > 1 || cover_letter))
-		numbered = 1;
-	if (numbered)
-		rev.total = total + start_number - 1;
 	if (cover_letter == -1) {
 		if (config_cover_letter == COVER_AUTO)
 			cover_letter = (total > 1);
 		else
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
+	if (!keep_subject && auto_number && (total > 1 || cover_letter))
+		numbered = 1;
+	if (numbered)
+		rev.total = total + start_number - 1;
 
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
