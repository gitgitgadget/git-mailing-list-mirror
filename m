Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDB91F461
	for <e@80x24.org>; Wed, 26 Jun 2019 16:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFZQ1O (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 12:27:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58793 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQ1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 12:27:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0400073C57;
        Wed, 26 Jun 2019 12:27:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g4yAmdL2rEb7SQT90qXOZLX9fjM=; b=p3MZDY
        wud2/5s4OWcZf92tDUoqA39WqQKeA/1xk3riBbaITGvhdQNw7H/CbqtBsP0tJYVb
        B8mup9kjQR3FPczDUCPSMWR0MMt1+UAWhzIAPfHedVxdKS2vz6KhYLV3qYUf0weP
        zVK7SswnpfZaiPS3wvFYhbxcvrVtGh3CQKg8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tIdzeEZDhat62GhWq0rHd0KHJYbmBwb2
        r/ARi/RSMGBSc/ALaU+9lbHONskwtmp2Iel7YI3KzBaRCg0t18CpWMS+gAgKu4Di
        qdRuGpyz4zgXBxTnhws8GvILfVc/vZcKcvrJ80mq5bvAc25Mp8KXaHTkVgPBKRPb
        W1CWIIEoHyo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF95273C56;
        Wed, 26 Jun 2019 12:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DF64F73C55;
        Wed, 26 Jun 2019 12:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/6] tree-walk.c: remove the_repo from fill_tree_descriptor()
References: <20190624095533.22162-1-pclouds@gmail.com>
        <20190624095533.22162-3-pclouds@gmail.com>
        <a2d91c63-86ca-90e7-0087-09df269d3865@gmail.com>
Date:   Wed, 26 Jun 2019 09:27:06 -0700
In-Reply-To: <a2d91c63-86ca-90e7-0087-09df269d3865@gmail.com> (Derrick
        Stolee's message of "Mon, 24 Jun 2019 09:30:14 -0400")
Message-ID: <xmqqblyke2hx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E66A22E-982F-11E9-9E40-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>> index 34ca0258b1..97b54caeb9 100644
>> --- a/builtin/merge-tree.c
>> +++ b/builtin/merge-tree.c
>> @@ -205,6 +205,7 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
>>  static void unresolved_directory(const struct traverse_info *info,
>>  				 struct name_entry n[3])
>>  {
>> +	struct repository *r = the_repository;
>
> I like this trick to make the change below minimal:
>> +	buf0 = fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
>> +	buf1 = fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
>> +	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
>
> I wonder if _every_ conversion should include this trick,
> so when we move to change that method we simply move the definition
> from the method block to the prototype. (No need to adjust what you've
> done already, just an idea for future conversions.)

Hmm, interesting.  So those callers in builtin/rebase.c::reset_head()
and other places that adds the_repository as the new first parameter
can take a local variable "r" (or perhaps a bit more descriptive,
e.g. "repo") that is initialized to "the_repository" (and never
reassigned at least at this step) in this same patch?
