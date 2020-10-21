Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA17C56201
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1949722248
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9TXpeIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505348AbgJUUas (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:30:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58263 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505338AbgJUUar (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:30:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE02E103B3A;
        Wed, 21 Oct 2020 16:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tm3OcMV+GfmBKF2/CeO1xR8JXv0=; b=X9TXpe
        IrAE0c0lfGkR2If9L918xLtFfAsHoxOBI/I+6J0Y2kaACuBa7WYpXxkccTfpnZAI
        L/rzxypGgn7K3AZXH+WDyWDu312A7ptJD6md2WRsTbS/GC/Np7ex0fIOKMMumKpV
        iNeWxo1S87RSrmgBUAsiZFFSpAhcWeAFcMugQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O7c6DyNSMXo+UR8Gv/7Dz8Y0LOQoDl4r
        TdMc4K12T4B3r7QRMH0yP+/DUOK1Sd3elFdeuxJ+hdlQ1+kCGUlRhF7etaafmhDF
        kWj3qEqOuThI4tJDHKTje1cxPS4K1gBCeiosliJsAG++nCXH2Mn01yOwv/4Mbl0P
        8OaCNyu1yF4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6E25103B39;
        Wed, 21 Oct 2020 16:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F039C103B38;
        Wed, 21 Oct 2020 16:30:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/11] merge-one-file: rewrite in C
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-3-alban.gruin@gmail.com>
        <xmqqmu0z3tge.fsf@gitster.c.googlers.com>
        <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com>
Date:   Wed, 21 Oct 2020 13:30:41 -0700
In-Reply-To: <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com> (Alban Gruin's
        message of "Wed, 21 Oct 2020 21:47:39 +0200")
Message-ID: <xmqqeelr724u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A958C70-13DC-11EB-9558-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>>> +	int ret, i, dest;
>>> +	ssize_t written;
>>> +	mmbuffer_t result = {NULL, 0};
>>> +	mmfile_t mmfs[3];
>>> +	struct ll_merge_options merge_opts = {0};
>>> +	struct cache_entry *ce;
>>> +
>>> +	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
>>> +		return error(_("%s: Not merging symbolic link changes."), path);
>>> +	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
>>> +		return error(_("%s: Not merging conflicting submodule changes."), path);
>>> +
>>> +	read_mmblob(mmfs + 1, our_blob);
>>> +	read_mmblob(mmfs + 2, their_blob);
>>> +
>>> +	if (orig_blob) {
>>> +		printf(_("Auto-merging %s\n"), path);
>>> +		read_mmblob(mmfs + 0, orig_blob);
>>> +	} else {
>>> +		printf(_("Added %s in both, but differently.\n"), path);
>>> +		read_mmblob(mmfs + 0, &null_oid);
>>> +	}
>>> +
>>> +	merge_opts.xdl_opts = XDL_MERGE_ZEALOUS_ALNUM;
>>> +	ret = ll_merge(&result, path,
>>> +		       mmfs + 0, "orig",
>>> +		       mmfs + 1, "our",
>>> +		       mmfs + 2, "their",
>>> +		       istate, &merge_opts);
>> 
>> Is it correct to call into ll_merge() here?  The original used to
>> call "git merge-file" which called into xdl_merge().  Calling into
>> ll_merge() means the path is used to look up the attributes and use
>> the custom merge driver, which I am not offhand sure is what we want
>> to see at this low level (and if it turns out to be a good idea, we
>> definitely should explain the change of semantics in the proposed
>> log message for this commit).

I am still not sure if it is correct to call ll_merge() and not the
xdl_merge() from here.  We need to highlight this change in the log
message, if we were still going to do this.

Thanks.

