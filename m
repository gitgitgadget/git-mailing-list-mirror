Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE29C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiDAT7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350173AbiDAT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 15:59:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1B208249
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 12:57:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC9EC12FBCE;
        Fri,  1 Apr 2022 15:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DjjKwmv4CjBKf2ssxw/UDsD2g1k70EiWdBRnRL
        j2yu0=; b=dcd1L19bOTFIE3Y2FN5Tl634YTCFYhtltYx40SMEHmRn41FRzsyQgV
        6Zjloz0NDVE/lkJOTcJs4uLiVQyu8Qos3OEJLLOOj3qHLeI4EW/Bff2u1yiThoFK
        D9YuVTYUdKvfiwYiZrg+W1HSNeSiaVnqusWuzjP74NuYoMDYS1Mos=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B40DB12FBCD;
        Fri,  1 Apr 2022 15:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26C7112FBCC;
        Fri,  1 Apr 2022 15:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v7] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
        <pull.1183.v7.git.1648793113943.gitgitgadget@gmail.com>
        <kl6lmth4sq1m.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 01 Apr 2022 12:57:37 -0700
In-Reply-To: <kl6lmth4sq1m.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 01 Apr 2022 09:53:57 -0700")
Message-ID: <xmqqy20ovaoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB3BFDC6-B1F5-11EC-BE8B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/branch.c b/branch.c
>> index 6b31df539a5..182f1c5a556 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -18,17 +18,31 @@ struct tracking {
>>  	int matches;
>>  };
>>  
>> +struct find_tracked_branch_cb {
>> +	struct tracking *tracking;
>> +	struct string_list ambiguous_remotes;
>> +};
>> +
>>  static int find_tracked_branch(struct remote *remote, void *priv)
>>  {
>> -	struct tracking *tracking = priv;
>> +	struct find_tracked_branch_cb *ftb = priv;
>> +	struct tracking *tracking = ftb->tracking;
>>  
>>  	if (!remote_find_tracking(remote, &tracking->spec)) {
>> -		if (++tracking->matches == 1) {
>> +		switch (++tracking->matches) {
>> +		case 1:
>>  			string_list_append(tracking->srcs, tracking->spec.src);
>>  			tracking->remote = remote->name;
>> -		} else {
>> +			break;
>> +		case 2:
>> +			/* there are at least two remotes; backfill the first one */
>> +			string_list_append(&ftb->ambiguous_remotes, tracking->remote);
>> +			/* fall through */
>> +		default:
>> +			string_list_append(&ftb->ambiguous_remotes, remote->name);
>>  			free(tracking->spec.src);
>>  			string_list_clear(tracking->srcs, 0);
>> +		break;
>>  		}
>>  		tracking->spec.src = NULL;
>>  	}
>
> Ah I see, on the first iteration, we set the first remote's name to
> tracking->remote, and on the second iteration, we copy that value to the
> list before copying the _current_ remote's name to the list.
>
>> -test_expect_success 'avoid ambiguous track' '
>> +test_expect_success 'avoid ambiguous track and advise' '
>>  	git config branch.autosetupmerge true &&
>>  	git config remote.ambi1.url lalala &&
>>  	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
>>  	git config remote.ambi2.url lilili &&
>>  	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
>> -	test_must_fail git branch all1 main &&
>> +	cat <<-EOF >expected &&
>> +	fatal: not tracking: ambiguous information for ref '\''refs/heads/main'\''
>> +	hint: There are multiple remotes whose fetch refspecs map to the remote
>> +	hint: tracking ref '\''refs/heads/main'\'':
>> +	hint:   ambi1
>> +	hint:   ambi2
>> +	hint: ''
>> +	hint: This is typically a configuration error.
>> +	hint: ''
>> +	hint: To support setting up tracking branches, ensure that
>> +	hint: different remotes'\'' fetch refspecs map into different
>> +	hint: tracking namespaces.
>> +	EOF
>> +	test_must_fail git branch all1 main 2>actual &&
>> +	test_cmp expected actual &&
>>  	test -z "$(git config branch.all1.merge)"
>>  '
>
> And this test shows that this indeed does what we think it does. Nicely
> done.
>
> I notice that we there is an instance of test -z "$(some git command)",
> which IIRC is discouraged because it would mask a failure in the git
> command, but that's not new and I don't think it needs to be fixed in
> this series anyway.
>
> Reviewed-by: Glen Choo <chooglen@google.com>

Thanks for giving the patch a careful read.

Will queue.

Thanks.
