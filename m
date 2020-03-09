Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFEBC10F25
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7901224656
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCITpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:45:31 -0400
Received: from mta-05-3.privateemail.com ([68.65.122.15]:20715 "EHLO
        MTA-05-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCITpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 15:45:31 -0400
Received: from MTA-05.privateemail.com (localhost [127.0.0.1])
        by MTA-05.privateemail.com (Postfix) with ESMTP id A9F036004A;
        Mon,  9 Mar 2020 15:45:29 -0400 (EDT)
Received: from [192.168.0.88] (unknown [10.20.151.246])
        by MTA-05.privateemail.com (Postfix) with ESMTPA id 0293D60049;
        Mon,  9 Mar 2020 19:45:28 +0000 (UTC)
Subject: Re: [RFC PATCH v2 1/2] git-merge: add option to format default
 message using multiple lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <2f0417b3-9e9e-f0db-ab11-92dd7cd2b29a@dark-templar-archives.net>
 <20200309120722.4987-1-darktemplar@dark-templar-archives.net>
 <20200309120722.4987-2-darktemplar@dark-templar-archives.net>
 <xmqqblp51owb.fsf@gitster-ct.c.googlers.com>
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Message-ID: <39919b91-fae6-d7c7-1c1e-acb3cc7f63b1@dark-templar-archives.net>
Date:   Mon, 9 Mar 2020 22:45:24 +0300
MIME-Version: 1.0
In-Reply-To: <xmqqblp51owb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Thank you for your feedback!

09.03.2020 19:20, Junio C Hamano пишет:
> "i.Dark_Templar" <darktemplar@dark-templar-archives.net> writes:
> 
>> +static int use_multiline = -1;
>>  
>>  int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>>  {
>> @@ -32,6 +33,8 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>>  			merge_log_config = DEFAULT_MERGE_LOG_LEN;
>>  	} else if (!strcmp(key, "merge.branchdesc")) {
>>  		use_branch_desc = git_config_bool(key, value);
>> +	} else if (!strcmp(key, "merge.usemultiline")) {

I'm wondering if this config option name could be improved, but out of
ideas at the moment. Maybe you have some ideas?

>> +		use_multiline = git_config_int(key, value);
>>  	} else {
>>  		return git_default_config(key, value, cb);
>>  	}
>> @@ -413,6 +416,39 @@ static void shortlog(const char *name,
>>  	string_list_clear(&subjects, 0);
>>  }
>>  
>> +static int fmt_merge_refs_count(void)
>> +{
>> +	int i = 0;
>> +	int j = 0;
>> +	int objects_count = 0;
> 
> Call it "object_count" and drop "j"; that's shorter.
> 
> Also, this is a "STATIC" function, an implementation detail of the
> fmt_merge_msg program.  There is no need to repeat that fact by
> replicating fmt_merge_ in its name to differenciate with other
> things, unlike the functions that are visible from other places.
> 
> Just call it "count_srcs()" or something like that and do not use
> the word "ref" in its name, as "merging refs" is probably too
> ancient, limiting and misleading concept---we do not merge "refs".
> We merge commits (and more recently) tags, and "refs" is merely one
> of the ways to name these things that are merged.
> 
> 

Thanks, I'll rename this function to 'count_srcs'.

>> +	for (i = 0; i < srcs.nr; i++) {
>> +		struct src_data *src_data = srcs.items[i].util;
>> +
>> +		if (src_data->head_status == 1) {
>> +			++objects_count;
>> +			continue;
>> +		}
>> +		if (src_data->head_status == 3) {
>> +			++objects_count;
>> +		}
> 
> This part deserves commenting.  The bit #0 of head_status is special
> in that it signals a pull of the default branch (HEAD) of the remote
> repository, and it is special because in that case (and only in that
> case) none of the string lists in src_data is updated, so the number
> of merged heads is one more than the case where the bit #0 is off.
> 

I didn't know about such details. Thanks.

>> +		for (j = 0; j < src_data->branch.nr; j++) {
>> +			++objects_count;
>> +		}
>> +		for (j = 0; j < src_data->r_branch.nr; j++) {
>> +			++objects_count;
>> +		}
>> +		for (j = 0; j < src_data->tag.nr; j++) {
>> +			++objects_count;
>> +		}
>> +		for (j = 0; j < src_data->generic.nr; j++) {
>> +			++objects_count;
>> +		}
> 
> Isn't it sufficient to add .nr to object_count?  Why increment
> object_count by one as many times as j counts up from 0 to .nr?
> 

That's my fault, I overlooked optimization here.

> If the merge involves only the remote HEAD, then the lists are all
> empty, isn't it?  I do not see the point of treating the case where
> head_status is 3 == 1|2 any special, so the following is sufficient
> as the replacement for the above and should be far easier to follow,
> no?  Or am I missing something subtle in your version?
> 
> 		if (src_data->head_status & 01)
> 			/* 
>                          * the set of merged heads includes the
>                          * default branch of the remote, aka HEAD,
> 			 * which is not counted in any of the lists
> 			 * in src_data.
> 			 */
> 			object_count++;
> 
>                 object_count += (src->data->branch.nr +
>                                  src->data->r_branch.nr +
>                                  src->data->tag.nr +
>                                  src->data->generic.nr);
> 
> By the way, if you read the original code, you may have noticed that
> our codebase prefers post-increment over pre-increment, when the
> difference does not matter (in other words, "a = ++b;" is perfectly
> legit; it is just that we do not say "++b;" when "b++;" would do).
> 

I copied behaviour of 'fmt_merge_msg_title' function here. Thanks for
clarifying special cases and optimizing it. I didn't know most of these
details about head_status and branches/tags/etc lists. I'll replace it
with your optimized version.

>> +	}
>> +
>> +	return objects_count;
>> +}
>> +
>>  static void fmt_merge_msg_title(struct strbuf *out,
>>  				const char *current_branch)
>>  {
>> @@ -467,6 +503,68 @@ static void fmt_merge_msg_title(struct strbuf *out,
>>  		strbuf_addf(out, " into %s\n", current_branch);
>>  }
>>  
>> +static void fmt_merge_msg_title_multiline(struct strbuf *out,
>> +				const char *current_branch, int count)
>> +{
>> +	int i = 0;
>> +	int j = 0;
>> +
>> +	if (!strcmp("master", current_branch))
>> +		strbuf_addf(out, "Merge %d %s\n", count, (count == 1) ? "commit" : "commits");
>> +	else
>> +		strbuf_addf(out, "Merge %d %s into %s\n", count, (count == 1) ? "commit" : "commits", current_branch);
> 
> Overlong lines.
> 

Thanks, I'll fix it.

>> +	strbuf_addch(out, '\n');
>> +
>> +	if (count == 1)
>> +		strbuf_addstr(out, "Following commit is merged:\n");
>> +	else
>> +		strbuf_addstr(out, "Following commits are merged:\n");
> 
> The above makes me wonder if you are better off having "if there is
> only one, do these things, otherwise do these other things" at the
> top level, i.e.
> 
> 	if (count == 1) {
> 		strbuf_addstr(out, "Merge 1 commit");
> 		if (strcmp(current_branch, "master"))
> 			strbuf_addstr(out, " into %s", current_branch);
> 		strbuf_addstr(out, "\n\nFollowing commit is ...");
> 	} else {
> 		...similarly...
> 	}
> 
> But stepping back a bit, is there a point in handing count==1 case
> in this new format in the first place?  Why waste the most precious
> information real estate, which is the title line, to say a lot less
> informative "merge 1 commit" instead of what topic is merged there?
> 

By default, this new format is disabled. In patch 2 it's enabled only
when at least 2 new objects are merged. Due to that new message format
shouldn't ever be used with default settings for only 1 merged object,
but user could set new configuration option to '1' and hit this code path.

If such format for just 1 merged object is undesired, I can modify code
and documentation to make sure it turns on only when at least 2 objects
are merged, and get rid of 1 merged object use-case after that.

> Also, I am not sure if "Following commits are merged" is a good
> message for a few reasons.
> 
>  - Obviously, we allow pulling and merging a signed tag and in that
>    case, we are merging a tag, not a commit.
> 
>  - When we pull a topic branch and nothing else, the above code
>    would say "Merge 1 commit", but there may probably be more than
>    one commit on the history leading to that commit we are merging
>    into our history.
> 
> 
> What actually is happening, instead of "merge 1 commit", is that we
> are merging one lineage of history, which may have one or more
> commits.  The phrase suitable to call the lineage of history may be
> "a topic branch", but it may be "a release tag", in which case what
> you are merging would be the entire history built while developing
> towards that tag that you have been missing.
> 

I'll describe a bit why I used a word 'commit' in this code. When
deciding how to name merged objects, I came down to two options: just
'object' or 'commit'. I used 'commit' because 'man git-merge' usually
uses this word. What word would you want to use here instead? An
'object'? 'History'? Something else?
