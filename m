Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E69C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiCBTEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbiCBTEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:04:36 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CC522C7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 11:03:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EF281803DA;
        Wed,  2 Mar 2022 14:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P23kNa6WR9YCSXRXDujois8CrvpjkoyyDIjFom
        wNrbE=; b=llNFNtFVehp+plVRoTlXDU2qeCSWE6iRJ5cYFM+lLNJo6inJlvWujJ
        W5zQN7aYUJ1ZowGBVhcSsJDrsiOd9MQJ7Hoyy7nAsnmrWyp/XZ3QY4wj56oJCSS0
        WaCcOHpt/KvyHpjD7s9pNhHtqif1Ky1ujXKzl6FsW++rkP1lsU4Rg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87FCD1803D9;
        Wed,  2 Mar 2022 14:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D9461803D8;
        Wed,  2 Mar 2022 14:03:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
        <06ef2e2c-7048-1101-870a-4774a2dcd988@github.com>
        <Yh+Sp5BxqxYhBv0M@nand.local>
Date:   Wed, 02 Mar 2022 11:03:42 -0800
In-Reply-To: <Yh+Sp5BxqxYhBv0M@nand.local> (Taylor Blau's message of "Wed, 2
        Mar 2022 10:52:07 -0500")
Message-ID: <xmqqsfs0kwhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A914264-9A5B-11EC-B03F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Mar 02, 2022 at 09:32:48AM -0500, Derrick Stolee wrote:
>> > Instead of a more complex modification to the ref transaction code,
>> > display a progress meter when running verbosely in order to convince the
>> > user that Git is doing work while renaming a remote.
>>
>> Thanks for this patch. It improves the user experience through
>> useful feedback.
>
> Admittedly, it feels like a little bit of a shortcut to avoid modifying
> the ref transaction code, but I think it's an OK short-term solution.
> Thanks for reviewing.
>
>> > @@ -682,7 +686,8 @@ static int mv(int argc, const char **argv)
>> >  		old_remote_context = STRBUF_INIT;
>> >  	struct string_list remote_branches = STRING_LIST_INIT_DUP;
>> >  	struct rename_info rename;
>> > -	int i, refspec_updated = 0;
>> > +	int i, j = 0, refspec_updated = 0;
>>
>> My only complaint is that 'j' is not informative enough here.
>>
>> 'j' as a loop iterator is good, but we aren't looping "on" j,
>> but instead tracking a progress_count across multiple loops.
>
> How about s/j/refs_renamed_nr ?

Meaning "number of renamed refs"?  start_progress() got the number
of remote branches to be renamed (i.e. rename.remote_branches->nr,
with symref adjustments), and approaching that ceiling from 0 by
counting the renamed ones so far makes sense.
