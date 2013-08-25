From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] write_index: optionally allow broken null sha1s
Date: Sat, 24 Aug 2013 23:15:00 -0700
Message-ID: <20130825061500.GR2882@elie.Belkin>
References: <20130824013310.GA9343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:15:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTba-0001Dd-Ea
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab3HYGPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:15:07 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:43966 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab3HYGPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:15:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so2220602pbc.32
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=08O3EwGaAzUnjOv2exRqh+2Gi7XINwPnjXgQ34iRv7E=;
        b=e/Yoi9FiE0knYbi+BG++kjRBfyVX0PBUe1vMAfXV9dkfKAwij0Z9hfhb3/fz3ja4vd
         diCAgrQ6Kn2jqIyoMfZYm/M9AYqp2mlASum2bg6kig3X8+3yePaHS3orwHf09gd5uO9O
         mRpK/oqJhwBAIdZDmCrszEqNdN+ALB4TqrOatZ2vPsIl5lczeXM0wv4mQ0Umc7vnqCZG
         BE8KYGY3h5aYcwxcRQtWqhx4VuV89y/DN4hfYoQyCiIhPwjvtf3x6YbqaAvGXqXhAelK
         K+WSTbZFBeyJydQ9SiDOHveP4CM0VdG+kEf8cWbZnLebDXXYr/AXoXBZ3/bI0LukGJL5
         3wMQ==
X-Received: by 10.66.227.194 with SMTP id sc2mr7950864pac.41.1377411305328;
        Sat, 24 Aug 2013 23:15:05 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xn12sm11747518pac.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 23:15:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130824013310.GA9343@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232928>

Hi,

Jeff King wrote:

> ---
> I was tempted to not involve filter-branch in this commit at all, and
> instead require the user to manually invoke
>
>   GIT_ALLOW_NULL_SHA1=1 git filter-branch ...
>
> to perform such a filter.  That would be slightly safer, but requires
> some specialized knowledge from the user (and advice on using
> filter-branch to remove such entries already exists on places like
> stackoverflow, and this patch makes it Just Work on recent versions of
> git).

The above few paragraphs explained the most mysterious part of the
patch to me.  I think they would be fine to include in the commit
message.

[...]
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1817,8 +1817,17 @@ int write_index(struct index_state *istate, int newfd)
>  			continue;
>  		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
>  			ce_smudge_racily_clean_entry(ce);
> -		if (is_null_sha1(ce->sha1))
> -			return error("cache entry has null sha1: %s", ce->name);
> +		if (is_null_sha1(ce->sha1)) {
> +			static const char msg[] = "cache entry has null sha1: %s";
> +			static int allow = -1;
> +
> +			if (allow < 0)
> +				allow = git_env_bool("GIT_ALLOW_NULL_SHA1", 0);
> +			if (allow)
> +				warning(msg, ce->name);
> +			else
> +				return error(msg, ce->name);
> +		}

Makes sense.

[...]
> --- /dev/null
> +++ b/t/t7009-filter-branch-null-sha1.sh
> @@ -0,0 +1,54 @@
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
> +	test_tick &&
> +	tree=$(
> +		{
> +			git ls-tree HEAD &&
> +			printf "160000 commit $_z40\\tbroken"
> +		} | git mktree
> +	) &&

To avoid pipes involving git commands, since they can losing the exit
status (and hence information about whether git crashed):

	{
		git ls-tree HEAD &&
		echo "160000 commit $_z40	broken"
	} >listing &&
	echo "add broken entry" >msg &&

	tree=$(git mktree <listing) &&
	test_tick &&
	commit=$(git commit-tree "$tree" -p HEAD <msg) &&
	git update-ref HEAD "$commit"

The rest looks good.

Thanks,
Jonathan
