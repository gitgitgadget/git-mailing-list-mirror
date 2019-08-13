Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608FC1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHMRVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 13:21:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54823 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfHMRVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 13:21:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E50A915A75E;
        Tue, 13 Aug 2019 13:21:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UekoTt2hzbkiE3w9HmzTsXDjTI8=; b=bHsWm5
        +MbZ5qq9mIM2SmXX+eY05y4p3QSyIvJBirwwmJlnwAmEXslf5zjnSXyu7uyRQYc4
        kYGBipyW979idyedl19hIrs2h1f/UFLckYNvnN/DNkynzACyWZW/Hbw8LPEpIqGW
        5yFBxLJiYe+wPBWeVV/U6kZCsDnUY9ELwb9oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O737xfMGtm7cf9Pn9USXt0fZNkdQtTI6
        auyutrlOJH/XZlR7ESktVs6siqio0qddb2Xcq33jXprvnJ4ak3kHs2pe1hEk/U/y
        5Gv0kT+eNRbcSPXy7Xcj0ejZiQcty3B6WjNoWKRRVkgyRwb6pPbGint+ngE3egRz
        jzXGGvnn1OA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC34115A75D;
        Tue, 13 Aug 2019 13:21:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E1F115A75B;
        Tue, 13 Aug 2019 13:21:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
        <b59f0aa2-1dc3-905a-0094-5f63718dffcf@gmail.com>
Date:   Tue, 13 Aug 2019 10:21:26 -0700
In-Reply-To: <b59f0aa2-1dc3-905a-0094-5f63718dffcf@gmail.com> (Phillip Wood's
        message of "Tue, 13 Aug 2019 14:28:23 +0100")
Message-ID: <xmqqo90t7zhl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8640A54-BDEE-11E9-988D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +static void push_dates(struct child_process *child)
>> +{
>> +	time_t now = time(NULL);
>> +	struct strbuf date = STRBUF_INIT;
>> +
>> +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
>> +	argv_array_pushf(&child->args, "--date=%s", date.buf);
>
> it doesn't matter but it might have been nicer to set both dates the
> same way in the environment.
> +	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);

We can see that this date string lacks timezone information, which
would likely fall back to whatever timezone the user is in.  Is that
what we want?  I am guessing it is, as we are dealing with "now"
timestamp, but wanted to double check.

>> +			if (opts->ignore_date) {
>> +				if (!author)
>> +					BUG("ignore-date can only be used with "
>> +					    "rebase, which must set the author "
>> +					    "before committing the tree");
>> +				ignore_author_date(&author);
>
> Is this leaking the old author? I'd rather see
>
> 	tmp_author = ignore_author_date(author);
> 	free(author);
> 	author = tmp_author;

Or make sure ignore_author_date() does not leak the original, when
it rewrites its parameter.

But I have a larger question at the higher design level.  Why are we
passing a single string "author" around, instead of parsed and split
fields, like <name, email, timestamp, tz> tuple?  That would allow us
to replace only the time part a lot more easily.  Would it make the
other parts of the code more cumbersome (I didn't check---and if
that is the case, then that is a valid reason why we want to stick
to the current "a single string 'author' keeps the necessary info
for the 4-tuple" design).

>> +			}
>>   			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
>>   					  NULL, &root_commit, author,
>>   					  opts->gpg_sign);
>> +		}
>>     		strbuf_release(&msg);
>>   		strbuf_release(&script);
>> @@ -1053,6 +1087,8 @@ static int run_git_commit(struct repository *r,
>>   		argv_array_push(&cmd.args, "--amend");
>>   	if (opts->gpg_sign)
>>   		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> +	if (opts->ignore_date)
>> +		push_dates(&cmd);
>>   	if (defmsg)
>>   		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>   	else if (!(flags & EDIT_MSG))
>> @@ -1515,6 +1551,11 @@ static int try_to_commit(struct repository *r,
>>     	reset_ident_date();
>>   +	if (opts->ignore_date) {
>> +		ignore_author_date(&author);
>> +		free(author_to_free);
>
> Where is author_to_free set? We should always free the old author, see
> above.

Or require callers to pass a free()able memory to ignore_author_date()
and have the callee free the original?
