Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE8C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 02:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C62067D
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 02:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RNjJZyfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHBCUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 22:20:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64598 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBCUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 22:20:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B51FE032B;
        Sat,  1 Aug 2020 22:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/4zCTIizDUkgtzBmjnSk+Y362rA=; b=RNjJZy
        fuJNmRZAZCSsKUF/dAcX/5VU1ogONJ1oW6Nlo19pzyvtxW84afGV342Y4JVdLWBt
        3jPGOnzlYJKmlJCZ6jE1H84gQ/FNylQIR3Mr3QBYeXzSgSV3Hg2gUQ1ZDzqLyR4O
        CV6vC0zbq9nfmzKdorP29FG2YAOcWVQhNLmt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2jxbo27fL92dnvpny4xITFq6iOPiWjP
        xPWupmBaR/59V52U1mAQs6GHpRa2Mu9BF2Z+3cfspZ02FZ1JlDTntgHN2Pm5DQTb
        W7+JT3B1VGwPijFdq3aPEd+7mNpwceo/Nq0CUO34YLMb1Sho/r20SHYYpa9FMPdM
        oioA+15P0kA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 137EFE032A;
        Sat,  1 Aug 2020 22:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E4EBE0329;
        Sat,  1 Aug 2020 22:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 2/6] stash: remove the second index in stash_working_tree()
References: <20200630151558.20975-1-alban.gruin@gmail.com>
        <20200731165140.29197-1-alban.gruin@gmail.com>
        <20200731165140.29197-3-alban.gruin@gmail.com>
        <xmqqy2mz35i6.fsf@gitster.c.googlers.com>
Date:   Sat, 01 Aug 2020 19:20:18 -0700
In-Reply-To: <xmqqy2mz35i6.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 31 Jul 2020 11:26:41 -0700")
Message-ID: <xmqqime123h9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6A143D8-D466-11EA-A59C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -1091,8 +1088,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>>  	argv_array_pushl(&cp_upd_index.args, "update-index",
>>  			 "--ignore-skip-worktree-entries",
>>  			 "-z", "--add", "--remove", "--stdin", NULL);
>> -	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
>> -			 stash_index_path.buf);
>>  
>>  	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
>>  			 NULL, 0, NULL, 0)) {
>
> And then the new code now lets "update-index" work directly on the
> main index (which does make an observable difference to the outside
> world, but we are not letting any hook to look at this intermediate
> state, so it might be OK---I cannot tell at this point in the code).

This changes the behaviour of the command a lot when a fatal happens
anywhere after this point til we reset the index to match the HEAD,
doesn't it, I wonder.  The original code refrained from touching the
index so after such a "fatal:" error message, the user would have
seen the original state (with previous "git add" etc. the user did)
in the index.  New code now added all the working tree changes to
the index, so the user would lose the work made so far in the main
index, no?  With later patch in the series applied, we will end up
having even untracked paths in the main index---I am not sure to
what extent that step would make things even worse, but it cannot be
harmless.

> How is the use of second on-disk index hurting us?  I must be
> missing something obvious, but at this point, it is not clear what
> we are gaining---I only see downsides.
