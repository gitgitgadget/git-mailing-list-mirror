Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891E120229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbcJWJCM (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:02:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:33124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbcJWJCK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:02:10 -0400
Received: (qmail 9425 invoked by uid 109); 23 Oct 2016 09:02:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 09:02:09 +0000
Received: (qmail 16951 invoked by uid 111); 23 Oct 2016 09:02:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Oct 2016 05:02:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2016 05:02:07 -0400
Date:   Sun, 23 Oct 2016 05:02:07 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron M Watson <watsona4@gmail.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] Allow stashes to be referenced by index only
Message-ID: <20161023090207.sg52l4mijqtfvip6@sigill.intra.peff.net>
References: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1473378397-22453-1-git-send-email-watsona4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 07:46:37PM -0400, Aaron M Watson wrote:

> Instead of referencing "stash@{n}" explicitly, it can simply be
> referenced as "n".  Most users only reference stashes by their position
> in the stash stask (what I refer to as the "index"). The syntax for the
> typical stash (stash@{n}) is slightly annoying and easy to forget, and
> sometimes difficult to escape properly in a script. Because of this the
> capability to do things with the stash by simply referencing the index
> is desirable.
> 
> This patch includes the superior implementation provided by Øsse Walle
> (thanks for that), with a slight change to fix a broken test in the test
> suite. I also merged the test scripts as suggested by Jeff King, and
> un-wrapped the documentation as suggested by Junio Hamano.

Just cleaning out my list of leftover bits, and it looks like this patch
fell through the cracks.

The last thing before this was generally people agreeing with the
approach that Øsse showed:

  http://public-inbox.org/git/CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com/

  http://public-inbox.org/git/xmqqbmzzoazy.fsf@gitster.mtv.corp.google.com/

and we just needed to roll that up into a patch. Which this _mostly_ is,
but there are a few funny things still:

> diff --git a/git-stash.sh b/git-stash.sh
> index 826af18..d8d3b8d 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -384,9 +384,10 @@ parse_flags_and_rev()
>  	i_tree=
>  	u_tree=
>  
> -	REV=$(git rev-parse --no-flags --symbolic --sq "$@") || exit 1
> +	REV=$(git rev-parse --no-flags --symbolic --sq "$@" 2> /dev/null)

Style: we don't put a space between ">" and the filename.

So here we assign REV, and we no longer exit (to handle something like
"1" by itself, which is good).

>  	FLAGS=
> +	ARGV=
>  	for opt
>  	do
>  		case "$opt" in
> @@ -404,10 +405,13 @@ parse_flags_and_rev()
>  					die "$(eval_gettext "unknown option: \$opt")"
>  				FLAGS="${FLAGS}${FLAGS:+ }$opt"
>  			;;
> +			*)
> +				ARGV="${ARGV}${ARGV:+ }'$opt'"
> +			;;
>  		esac
>  	done
>  
> -	eval set -- $REV
> +	eval set -- $ARGV

But what's going on here? Why did we bother running rev-parse earlier if
we don't actually use the value of REV?

You mentioned tweaking it to fix a broken test, and indeed, just using
$REV here breaks a few tests in t3903.

Offhand, I do not see anything wrong with pulling the non-option values
out in the loop. But in that case I think the assignment of REV can just
go away completely.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 2142c1f..f82a8c4 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -131,6 +131,26 @@ test_expect_success 'drop middle stash' '
>  	test 1 = $(git show HEAD:file)
>  '
>  
> +test_expect_success 'drop middle stash by index' '
> +	git reset --hard &&
> +	echo 8 > file &&
> +	git stash &&
> +	echo 9 > file &&

Ditto on the ">" style here and elsewhere.

The tests otherwise look good to me.

-Peff
