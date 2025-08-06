Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C3243951
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490660; cv=none; b=kk0nLRHz2R26NyTacXtogpQJbkH6z3s9s1Z3qtU56XinhPpzJX0Mj0CHTmVYx1Q8JxPfHtKeqLdYjO3p5TaFhsfiPCZdc2M0PhtGpN9QLVScs5A9B7RJJo7HIl9cEQfHMt7EFW69WDNTcAyAupedPTT4E9eRlV7gqNCJSgWVFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490660; c=relaxed/simple;
	bh=bhnKwHRVoGKBwwBPG2lkNO/J2OROnS2Q0R2Sf5T8qyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFJFtfuQTlBZ8XtOcuqIXheQw1LQgtKLv2gzu4x8kH0t7u1bIbnY+urzDKIBibx0AEvz2Fri9mDZsFNmA8HMJpw/+JDmF0w/SUS5RqE/h0doBJ7o+j95GhaKbHiexdpY9ue53f2f8dofnQ8tShMUsFYxNhf0Vx/3fBgGY/ltaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=xmHDJEaR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="xmHDJEaR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754490648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNn/O6m00snK+mswHBkNx8/YGYX66iKFMOJSy1bITnE=;
	b=xmHDJEaRuZBs5VgU5i3lsAWgzj39U4xp4aibwjAZ2wVys9qoBEao1p6mj3o6J9tNmKBP76
	1CaSYkMTjvEmqS7d3SpXySPKXMZMT7b5PiXJUMOf/CF1zMgqIJD7rA2OAHv0XaZLRCJcZO
	vOOgDaFT5dextO41Lvyplhwnzq9ar9U=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH 2/3] within_depth: fix return for empty path
In-Reply-To: <aIm5vMeTLSLD-6Fz@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250729-toon-max-depth-v1-2-c177e39c40fb@iotcl.com>
 <aIm5vMeTLSLD-6Fz@pks.im>
Date: Wed, 06 Aug 2025 16:30:32 +0200
Message-ID: <87ms8cttdj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 29, 2025 at 08:57:43PM +0200, Toon Claes wrote:
>> From: Jeff King <peff@peff.net>
>> 
>> The within_depth() function is used to check whether pathspecs limited
>> by a max-depth parameter are acceptable. It takes a path to check, a
>> maximum depth, and a "base" depth. It counts the components in the
>> path (by counting slashes), adds them to the base, and compare them to
>
> s/compare/&s/
>
>> the maximum.
>> 
>> However, if the base does not have any slashes at all, we always return
>> `true`. If the base depth is 0, then this is correct; no matter what the
>> maximum is, we are always within it. However, if the base depth is
>> greater than 0, then we might return an erroneous result.
>> 
>> This ends up not causing any user-visible bugs in the current code. The
>> call sites in dir.c always pass a base depth of 0, so are unaffected.
>> But tree_entry_interesting() uses this function differently: it will
>> pass the prefix of the current entry, along with a `1` if the entry is a
>> directory, in essence checking whether items inside the entry would be
>> of interest. It turns out not to make a difference in behavior, but the
>> reasoning is complex.
>> 
>> Given a tree like:
>> 
>>   file
>>   a/file
>>   a/b/file
>> 
>> walking the tree and calling tree_entry_interesting() will yield the
>> following results:
>> 
>>   (with max_depth=0):
>>       file: yes
>>          a: yes
>>     a/file: no
>>        a/b: no
>> 
>>   (with max_depth=1):
>>       file: yes
>>          a: yes
>>     a/file: yes
>>        a/b: no
>> 
>> So we have inconsistent behavior in considering directories interesting.
>> If they are at the edge of our depth but at the root, we will recurse
>> into them, but then find all of their entries uninteresting (e.g., in
>> the first case, we will look at "a" but find "a/*" uninteresting). But
>> if they are at the edge of our depth and not at the root, then we will
>> not recurse (in the second example, we do not even bother entering
>> "a/b").
>> 
>> This turns out not to matter because the only caller which uses
>> max-depth pathspecs is cmd_grep(), which only cares about blob entries.
>> From its perspective, it is exactly the same to not recurse into a
>> subtree, or to recurse and find that it contains no matching entries.
>> Not recursing is merely an optimization.
>
> Okay, well-explained.
>
>> It is debatable whether tree_entry_interesting() should consider such an
>> entry interesting. The only caller does not care if it sees the tree
>> itself, and can benefit from the optimization. But if we add a
>> "max-depth" limiter to regular diffs, then a diff with
>> DIFF_OPT_TREE_IN_RECURSIVE would probably want to show the tree itself,
>> but not what it contains.
>
> I haven't yet read the cover letter, but I guess that the scenario where
> we'll care about this is in git-last-modified(1) if we want to teach
> that command a `--max-depth` parameter?

Well, yes git-last-modified(1) will be able to use this option as well.
And it will be useful there. But those patches are still in flight in a
separate series.

In the commit following this one we see `--max-depth` being used in
git-diff-tree(1). Maybe I can do a better job explaining how this
changes affects that patch. Let me see how I can phrase this.

>> This patch just fixes within_depth(), which means we consider such
>> entries uninteresting (and makes the current caller happy). If we want
>> to change that in the future, then this fix is still the correct first
>> step, as the current behavior is simply inconsistent.
>
> So... do we end up with this now?
>
>    (with max_depth=1):
>        file: yes
>           a: yes
>      a/file: no
>         a/b: no
>
> I think it would be nice to include that in the message to show the
> change in behaviour at a glance.

The change in behavior happens when max_depth equals zero. In that case
the example would be:

    (with max_depth=0):
        file: yes
           a: yes
      a/file: no
         a/b: no

So no change actually. But that's due to how tree_entry_interesting()
calls within_depth(). It doesn't pass the path of the entry, but the
base of it. I'm not sure using tree_entry_interesting() here in the
commit message to explain the change is the best idea, but it's the
callsite that /might/ be affected. But it isn't. So it's pretty involved
trying to put this change into words.

>> Signed-off-by: Jeff King <peff@peff.net>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  dir.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/dir.c b/dir.c
>> index 02873f59ea..900ee5e559 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -277,7 +277,7 @@ int within_depth(const char *name, int namelen,
>>  		if (depth > max_depth)
>>  			return 0;
>>  	}
>> -	return 1;
>> +	return depth <= max_depth;
>>  }
>
> Just for my own understanding: the only difference is when we don't have
> even a single matching slash, as we don't verify `depth > max_depth` in
> that case. So in theory, we could modify the function to the following
> equivalent:
>
> 	int within_depth(const char *name, int namelen,
> 				int depth, int max_depth)
> 	{
> 		const char *cp = name, *cpe = name + namelen;
>
> 		if (depth > max_depth)
> 			return 0;
>
> 		while (cp < cpe) {
> 			if (*cp++ != '/')
> 				continue;
> 			depth++;
> 			if (depth > max_depth)
> 				return 0;
> 		}
> 		return 1;
> 	}
>
> (Not saying we should, I'm just double checking my understanding).

To be honest, I wasn't sure no more. I decided to see if I can write a
unit test. This is what I came up with:

    void test_dir__within_depth(void)
    {
    	struct test_case {
    		const char *path;
    		int depth;
    		int max_depth;
    		int expect;
    	} test_cases[] = {
    		/* depth = 0; max_depth = 0 */
    		{ "",         0, 0, 1 },
    		{ "file",     0, 0, 1 },
    		{ "a",        0, 0, 1 },
    		{ "a/file",   0, 0, 0 },
    		{ "a/b",      0, 0, 0 },
    		{ "a/b/file", 0, 0, 0 },

    		/* depth = 0; max_depth = 1 */
    		{ "",         0, 1, 1 },
    		{ "file",     0, 1, 1 },
    		{ "a",        0, 1, 1 },
    		{ "a/file",   0, 1, 1 },
    		{ "a/b",      0, 1, 1 },
    		{ "a/b/file", 0, 1, 0 },

    		/* depth = 1; max_depth = 1 */
    		{ "",         1, 1, 1 },
    		{ "file",     1, 1, 1 },
    		{ "a",        1, 1, 1 },
    		{ "a/file",   1, 1, 0 },
    		{ "a/b",      1, 1, 0 },
    		{ "a/b/file", 1, 1, 0 },

    		/* depth = 1; max_depth = 0 */
    		{ "",         1, 0, 0 },
    		{ "file",     1, 0, 0 },
    		{ "a",        1, 0, 0 },
    		{ "a/file",   1, 0, 0 },
    		{ "a/b",      1, 0, 0 },
    		{ "a/b/file", 1, 0, 0 },
    	};

    	for (size_t i = 0; i < ARRAY_SIZE(test_cases); i++) {
    		int result = within_depth(test_cases[i].path, strlen(test_cases[i].path),
    					  test_cases[i].depth, test_cases[i].max_depth);
    		cl_assert_equal_b(result, test_cases[i].expect);
    	}
    }

The change in this patch affect the last batch of tests (the batch with
'depth = 1; max_depth = 0'). Running the test on both this patch and
your suggestion gives the same results, so yes your suggestion has the
same output.

Do you think it's worth to add such unit test?

I did add `""` because I've seen cmd_grep() might be passing an empty
path.

-- 
Cheers,
Toon
