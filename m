Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEB0C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiGMWd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiGMWd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:33:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6112D37
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:33:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4236013D589;
        Wed, 13 Jul 2022 18:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kU6HuFFNQM0xcjG61LHZF6rqCGCKS6sPkd6OOg
        mz2FA=; b=F+pbrRAtFciDbsQwBfESrgj+ilfZLbrjCer7tb9qTWmPtwTnQFe2cy
        Apw7n8ExhELWBtPAJEt30uvmykVqjQtQciKOuENMA1PhOIEmuQqOttyuQMKzJ+gM
        1d/rSYjOyUJIhS+p2i3imrEvRTxI3+S7FC04uF3QFFlvSo8SQH+Dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39B6F13D588;
        Wed, 13 Jul 2022 18:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E42313D587;
        Wed, 13 Jul 2022 18:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
        <xmqq7d4gbu10.fsf@gitster.g> <Ys86MnwhembiXRxj@zacax395.localdomain>
        <xmqqr12oadbk.fsf@gitster.g> <Ys9Ftu3z6zedCsoX@zacax395.localdomain>
Date:   Wed, 13 Jul 2022 15:33:53 -0700
In-Reply-To: <Ys9Ftu3z6zedCsoX@zacax395.localdomain> (Fernando Ramos's message
        of "Thu, 14 Jul 2022 00:22:46 +0200")
Message-ID: <xmqqa69cabhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E09B1806-02FB-11ED-97E2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/07/13 02:54PM, Junio C Hamano wrote:
>> 
>> OK, because "1" fails to execute, the expected output Dscho had
>> (which is for the case without base) would become invalid when we
>> use "true".
>> 
>> Perhaps we should use "false" instead?  Or do we need to test both?
>> 
> I think testing both is not really needed as the unit test is just making sure
> that filenames with spaces are processed correctly.  Whatever comes before
> (which changes depending on the value of "base_present") doesn't really matter
> as long as there is something.

As the quoting glitch are distributed on both sides

	if $base_present
	then
		eval "$merge_tool_path" \
			-f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"
	else
		# If there is no BASE (example: a merge conflict in a new file
		# with the same name created in both braches which didn't exist
		# before), close all BASE windows using vim's "quit" command

		FINAL_CMD=$(echo "$FINAL_CMD" | \
			sed -e 's:2b:quit:g' -e 's:3b:2b:g' -e 's:4b:3b:g')

		eval "$merge_tool_path" \
			-f "$FINAL_CMD" "$LOCAL" "$REMOTE" "$MERGED"
	fi

I suspect you can fix only one, and carefully choose which side to
test, and leave the other side broken ;-)

In any case, to minimize disruption to Dscho's patch, I replaced the
"1" with "false" (which will make his patch pass the new test
without other stuff) and tweak its merge into 'seen' to adjust for
the "leftabove" topic.

Thanks.

