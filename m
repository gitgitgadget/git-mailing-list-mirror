From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] write_index: optionally allow broken null sha1s
Date: Sun, 25 Aug 2013 12:54:12 -0700
Message-ID: <20130825195412.GA2752@elie.Belkin>
References: <20130824013310.GA9343@sigill.intra.peff.net>
 <20130825061500.GR2882@elie.Belkin>
 <20130825095818.GA12556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 21:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDgOI-0001ww-UD
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 21:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab3HYTyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 15:54:22 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:48460 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab3HYTyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 15:54:21 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so2632925pbb.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vs/chBPZdWu78Ry0D4MMzME0cCw7aPY6EoydleYL/k4=;
        b=JPjmNXwb+zodKBKxKuzsPqymyRr6syubDhtk46C1dIJv2QjSTG3N+KXg9X6QgFw37D
         0vFB3pPrJRkBh/7VIVKqDOpjkF5qC5ZCk0ZJ44K+eJ/9Ic2ioeWg1KW+ZvGJrsAjZO/d
         Q1CzdyDfplmpBcE54GGdrspsYhLOG23ppJsZG+7u3tcL7L/7zFLjIfbvZiOturttpu6W
         L3wIGfSwmdFlSYL/GMG+/8kZcayXWT1VhuqZsxa87dJtB6d+eDS7zSy9Nbm2IduyZrwW
         6fdCKXKkxUV87kGcrEIPDgQwYJFY61+X375GevvJ2aUNXSH5D8dekIocf21l4osINANT
         GL/A==
X-Received: by 10.66.146.66 with SMTP id ta2mr10918789pab.11.1377460461098;
        Sun, 25 Aug 2013 12:54:21 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id a5sm13490129pbw.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 25 Aug 2013 12:54:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130825095818.GA12556@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232964>

On Sun, Aug 25, 2013 at 05:58:18AM -0400, Jeff King wrote:
> On Sat, Aug 24, 2013 at 11:15:00PM -0700, Jonathan Nieder wrote:

>>> I was tempted to not involve filter-branch in this commit at all, and
>>> instead require the user to manually invoke
>>>
>>>   GIT_ALLOW_NULL_SHA1=1 git filter-branch ...
>>>
>>> to perform such a filter.  That would be slightly safer, but requires
>>> some specialized knowledge from the user (and advice on using
>>> filter-branch to remove such entries already exists on places like
>>> stackoverflow, and this patch makes it Just Work on recent versions of
>>> git).
>>
>> The above few paragraphs explained the most mysterious part of the
>> patch to me.  I think they would be fine to include in the commit
>> message.
>
> I rolled them into the commit message.

Hm --- the most useful part was "advice on using filter-branch to
remove such entries already exists on places like stackoverflow",
which was dropped.  From my point of view, that is exactly the
motivation of the patch.

I also found the "I was tempted to ... That would be slightly safer,
but requires ..." structure easier to read.

In other words, why not use something like this?

	write_index: optionally allow broken null sha1s

	Commit 4337b58 (do not write null sha1s to on-disk index, 2012-07-28)
	added a safety check preventing git from writing null sha1s into the
	index. The intent was to catch errors in other parts of the code that
	might let such an entry slip into the index (or worse, a tree).

	Some existing repositories have some invalid trees that contain null
	sha1s already, though.  Until 4337b58, a common way to clean this up
	would be to use git-filter-branch's index-filter to repair such broken
	entries.  That now fails when filter-branch tries to write out the
	index.

	Introduce a GIT_ALLOW_NULL_SHA1 environment variable to relax this check
	and make it easier to recover from such a history.

	It is tempting to not involve filter-branch in this commit at all, and
	instead require the user to manually invoke

		GIT_ALLOW_NULL_SHA1=1 git filter-branch ...

	to perform an index-filter on a history with trees with null sha1s.
	That would be slightly safer, but requires some specialized knowledge
	from the user.  So let's set the GIT_ALLOW_NULL_SHA1 variable
	automatically when checking out the to-be-filtered trees.  Advice on
	using filter-branch to remove such entries already exists on places like
	stackoverflow, and this patch makes it Just Work again on recent
	versions of git.

	Further commands that touch the index will still notice and fail,	unless
	they actually remove the broken entries.  A filter-branch whose filters
	do not touch the index at all will not error out (since we complain of
	the null sha1 only on writing, not when making a tree out of the index),
	but this is acceptable, as we still print a loud warning, so the problem
	is unlikely to go unnoticed.

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

After this patch, do you think (in a separate change) it would make
sense for cache-tree.c::update_one() to check for null sha1 and error
out unless GIT_ALLOW_NULL_SHA1 is true?  That would let us get rid of
the caveat from the last paragraph.

[...]
> --- /dev/null
> +++ b/t/t7009-filter-branch-null-sha1.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='filter-branch removal of trees with null sha1'
> +. ./test-lib.sh
> +
> +test_expect_success 'create base commits' '
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three
> +'
> +
> +test_expect_success 'create a commit with a bogus null sha1 in the tree' '
> +	{
> +		git ls-tree HEAD &&
> +		printf "160000 commit $_z40\\tbroken\\n"
> +	} >broken-tree
> +	echo "add broken entry" >msg &&
> +
> +	tree=$(git mktree <broken-tree) &&
> +	test_tick &&
> +	commit=$(git commit-tree $tree -p HEAD <msg) &&
> +	git update-ref HEAD "$commit"
> +'
> +
> +# we have to make one more commit on top removing the broken
> +# entry, since otherwise our index does not match HEAD (and filter-branch will
> +# complain). We could make the index match HEAD, but doing so would involve
> +# writing a null sha1 into the index.
> +test_expect_success 'create a commit dropping the broken entry' '
> +	test_tick &&
> +	git commit -a -m "back to normal"
> +'

This is kind of an old-fashioned test, since each step of the setup is
treated as a separate test assertion.  I don't really mind until we
get better automation to make it easy to skip or rearrange tests.
Just for reference, I think the usual way to do this now is

	test_expect_success 'setup' '
		# create base commits
		...

		# create a commit with bogus null sha1 in the tree
		...

		# We have to make one more commit on top removing the broken
		# entry, since otherwise our index does not match HEAD and
		# filter-branch will complain. We could make the index match
		# HEAD, but doing so would involve writing a null sha1 into
		# the index.
		...
	'

	test_expect_success 'nontrivial filter-branch bails out on null sha1' '
		old_head=$(git rev-parse HEAD) &&
		test_must_fail git filter-branch ... &&
		test_cmp_rev "$old_head" HEAD
	'

	test_expect_success 'filter-branch can filter out null sha1' '
		git filter-branch ... &&

		# resulting history is clean
		echo three >expect &&
		git log -1 --format=%s >actual &&
		test_cmp expect actual
	'

Thanks,
Jonathan
