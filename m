Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF5C433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiBHBFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiBGXuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:50:39 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C03AC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:50:39 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7040711BCA1;
        Mon,  7 Feb 2022 18:50:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4PKY02rv5laSuVT3Ry7zLCiZZH9dSJ45graCde
        gaTvg=; b=ACs3aP8pJIWWJy60wVVQgwbkh2crI/MXBBIYiGATKn7A+1mmMLhk3b
        5aFEQTKDKejTuNxH1K27U4IYgijmvODQkjanqc/2iZgbTUwXJq+RfOi3EcNDO6Jf
        WejK3CO6e6DN7PfL0wclsBkr6bXJOM7OZriLH6bPsltsDJvahMCEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65FD111BCA0;
        Mon,  7 Feb 2022 18:50:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8B1111BC9F;
        Mon,  7 Feb 2022 18:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Greg Hurrell <greg@hurrell.net>, git@vger.kernel.org,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-checkout doesn't seem to respect config from include.path
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
        <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
        <xmqq1r0jx1qm.fsf@gitster.g>
        <bb0532ca-f718-15d1-7328-fd0e062eae06@gmail.com>
Date:   Mon, 07 Feb 2022 15:50:36 -0800
In-Reply-To: <bb0532ca-f718-15d1-7328-fd0e062eae06@gmail.com> (Phillip Wood's
        message of "Mon, 7 Feb 2022 14:01:26 +0000")
Message-ID: <xmqqsfsufd83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFD46FA6-8870-11EC-BF8A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think that would be worthwhile, the warning is potentially confusing
> though if a bad value is followed by a good value then we will warn 
> about the bad value but use the good one.

I dunno.  That is exactly why the new message is crafted to convey:
"you have an entry with an unsupported value in your configuration
file, which you may want to inspect and possibly correct it; in the
meantime we've ignored that entry".  "ignored" is the key word.

If we say "we later found this good value so we'd use it", it may
become confusing, as we'd never issue such a notice for a
last-one-wins variable that do not use any unsupported values, but
we are not doing that, so I think there is no room for confusion.


>> Completely untested.  The first test that would be interesting to
>> run is how many tests this changes breaks to gauge how good test
>> coverage we have ;-)
>>   xdiff-interface.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git c/xdiff-interface.c w/xdiff-interface.c
>> index 2e3a5a2943..523b04960a 100644
>> --- c/xdiff-interface.c
>> +++ w/xdiff-interface.c
>> @@ -322,8 +322,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
>>   		 * git-completion.bash when you add new merge config
>>   		 */
>>   		else
>> -			die("unknown style '%s' given for '%s'",
>> -			    value, var);
>> +			warning("ignored unknown style '%s' given for '%s'",
>> +				value, var);
>>   		return 0;
>>   	}
>>   	return git_default_config(var, value, cb);
