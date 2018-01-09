Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91D51F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760418AbeAISte (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:49:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59934 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757128AbeAIStd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:49:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47704C83F9;
        Tue,  9 Jan 2018 13:49:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XEkkmRvCNPHcMr9tsxUYydoy1tE=; b=oVpFUA
        EdOObqFH2XuVDYJes2V2jNENsM90eBO9VQmWShuWUWjzfxyZneJEv9LYVE85fTgs
        fi5BCGJDdsYGqPnBJ1taVSnhp0W0R5UV5uZPz+yFLzvPcShZa00UEyWNqRkbwFAO
        F0lrzGVQKLn0uc1vYlZ05NzQKbzwAk0qBEgtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f9y7bFL0sb8EHE3GePdyPnOP7RMb9zHE
        o1pUpLJveMCRoOuN5c/SBIfVBp8oZUgFikLJX9ahuydIH4H1GPswmLJWuSZnmgHs
        3pldNguy0wmGlU+eDE+hGfoWO0Ji6NplFEMtAPsBCQFop7q3bxtwOyBQMrRayN5a
        IGnExZf+LD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 402E3C83F8;
        Tue,  9 Jan 2018 13:49:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8745C83F7;
        Tue,  9 Jan 2018 13:49:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] merge-recursive: do not look at the index during recursive merge
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-3-newren@gmail.com>
        <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com>
        <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
        <CABPp-BEJS+59FD-1WduHMmtnBBrgS7xDWJm8Z5URrthDp-0Bwg@mail.gmail.com>
Date:   Tue, 09 Jan 2018 10:49:31 -0800
In-Reply-To: <CABPp-BEJS+59FD-1WduHMmtnBBrgS7xDWJm8Z5URrthDp-0Bwg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 9 Jan 2018 11:29:50 -0700")
Message-ID: <xmqqy3l66f5w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4C046F0-F56D-11E7-85FE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Tue, Jan 9, 2018 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>     > I haven't come up with an addition to the test suite, but I suspect
>>     > this change is conceptually wrong.  What if a call to this function
>>     > is made during a recursive, inner merge?
>
> Eek, good catch.
>
>>  merge-recursive.c          |  2 +-
>>  t/t3030-merge-recursive.sh | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 780f81a8bd..0fc580d8ca 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -1954,7 +1954,7 @@ int merge_trees(struct merge_options *o,
>>         if (oid_eq(&common->object.oid, &merge->object.oid)) {
>>                 struct strbuf sb = STRBUF_INIT;
>>
>> -               if (index_has_changes(&sb)) {
>> +               if (!o->call_depth && index_has_changes(&sb)) {
>>                         err(o, _("Dirty index: cannot merge (dirty: %s)"),
>>                             sb.buf);
>>                         return 0;
>
> Yep, looks good to me; sorry for overlooking this.
>
> Elijah

Thanks.  The breakage is already in 'master' so this fix needs to be
fast-tracked.
