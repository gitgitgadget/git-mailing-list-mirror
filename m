Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8B71F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbcIUSMG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:12:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58738 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932340AbcIUSMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:12:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B83453EDD0;
        Wed, 21 Sep 2016 14:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QW34RetkbIod7cQOis0ZHgk9tMc=; b=UoInp2
        qI1YyvZin2KJaKzDAmmHTHfi2TytZNP8dHgpFzK1DzB5JpqyP27Uvb6JZHrDbyf9
        m1bRFW4LmrzBbngRELvfGoMjPWIyyS96qbcMX5XGEa4g9rN4lqFx7tEPf3FZAAdp
        L3hsG5hm5uFg+hrNzd3pzjibU7f7ANUB21kmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mCJurzyYLmVEpK2RXpP4wl3O9ZeSLkFL
        09fWWyF0PVOXQlfBeRGU7OCfNHWEKi9w9dEoSVvznO6ibnTYpneh8nzcH3nfrI44
        JIqI2BIdjPAdBXgF+CjItgAsDH+8imlgWxeJix0tmdp7kQkuCE1LTvsa+GNzYVGC
        tsZF893WePg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEF123EDCF;
        Wed, 21 Sep 2016 14:12:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 296873EDCD;
        Wed, 21 Sep 2016 14:12:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x test with POSIXPERM
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
        <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
        <20160920193444.GG8254@hank>
Date:   Wed, 21 Sep 2016 11:12:02 -0700
In-Reply-To: <20160920193444.GG8254@hank> (Thomas Gummerer's message of "Tue,
        20 Sep 2016 20:34:44 +0100")
Message-ID: <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E645D8BC-8026-11E6-B49D-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>>  I am surprised that add --chmod=+x changes only the index, but not
>>  the file on disk!?!
>
> I *think* --chmod is mainly thought of as a convenience for git users
> on a filesystem that doesn't have an executable flag.  So it was
> introduced this way as the permissions on the file system don't matter
> in that case.  A change of that behaviour may make sense for this
> though.

Perhaps we shouldn't even test this, then?  I can see future people
wanting to change this behaviour, while I can see argument for not
touching the working tree file, too.  It is essential for the main
purpose of the command (i.e. "I want to flip the executable bit for
the path in the index") to make sure that the bit in the index is
changed.  Comparing the index with the working tree using "status"
is probably not how you would want to do so.  A future breakage may
cause the indexed blob name to change by mistake, and status would
happily report difference but you would not notice its output is
saying "Hey, they are different between the index and the working
tree", while you are expecting ONLY the change in the executable bit.

How about doing

	git add foo4 &&
        git add --chmod=+x foo4 &&
	test_mode_in_index 100755 foo4

instead?

>
>>  t/t3700-add.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index 16ab2da..13e0dd2 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -361,7 +361,7 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
>>  	test_mode_in_index 100644 xfoo3
>>  '
>>  
>> -test_expect_success 'file status is changed after git add --chmod=+x' '
>> +test_expect_success POSIXPERM 'file status is changed after git add --chmod=+x' '
>>  	echo "AM foo4" >expected &&
>>  	echo foo >foo4 &&
>>  	git add foo4 &&
>> -- 
>> 2.10.0.85.gea34e30
>> 
