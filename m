Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854051F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 16:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436636AbfJXQQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 12:16:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2407816AbfJXQQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 12:16:12 -0400
Received: (qmail 14578 invoked by uid 109); 24 Oct 2019 16:16:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 16:16:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2103 invoked by uid 111); 24 Oct 2019 16:19:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 12:19:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 12:16:11 -0400
From:   Jeff King <peff@peff.net>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output
 local-part of email addresses
Message-ID: <20191024161610.GA8448@sigill.intra.peff.net>
References: <20191024125332.29958-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024125332.29958-1-prarit@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 08:53:32AM -0400, Prarit Bhargava wrote:

> In many projects the number of contributors is low enough that users know
> each other and the full email address doesn't need to be displayed.
> Displaying only the author's username saves a lot of columns on the screen.
> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
> columns.
> 
> Add a "%aL"|"%al|%cL|%cl" option that output the local-part of an email
> address.
> 
> Also add tests for "%ae","%an", "%ce", and "%cn".

Thanks, this is looking better, but I think there are still a few minor
bits to address.

> Changes in v2:
> - Changed option to 'L' based on https://www.ietf.org/rfc/rfc2822.txt
>   definition of 'local-part' of email addresses.
> - added additional information to documentation for %cL and %cl
> - added mailmap output test
> - modified code to use mailmap output for "L" option
> - modified code to check if email address field has '@' symbol
> - modified tests based on input from Peff

This change list is very welcome, but it should generally go after the
"---", so that it's not part of the commit message (i.e., it is for
people reading this email and reviewing now, but people reading "git
log" later would not know or care about v1).

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>
> Cc: Jeff King <peff@peff.net>

Likewise we do not generally use "cc:" trailers in this project.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index b87e2e83e6d0..9a1f900f114a 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -163,6 +163,11 @@ The placeholders are:
>  '%ae':: author email
>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>  	or linkgit:git-blame[1])
> +'%al':: author local-part (the portion of the email address preceding the '@'
> +	symbol)

I'm not sure if it is worth saying something like "preceding the @
symbol, or the whole address if no @ symbol". It's a pretty rare case,
I'd think, and it does clutter up the wording. So just a thought.

> +'%aL':: author local-part (the portion of the email address preceding the '@'
> +	symbol, respecting .mailmap, see linkgit:git-shortlog[1] or
> +	linkgit:git-blame[1])

This description gets pretty long. I wonder if we can simplify by
referring to earlier formats, which would also make clear to the user
the relationship between the formats. Perhaps:

  '%aL':: author local-part (see '%al'), respecting .mailmap (see '%aE')

And ditto for %cL.

> diff --git a/pretty.c b/pretty.c
> index b32f0369531c..93eb6e837071 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -696,7 +696,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  	mail = s.mail_begin;
>  	maillen = s.mail_end - s.mail_begin;
>  
> -	if (part == 'N' || part == 'E') /* mailmap lookup */
> +	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */

I think this is sufficient to fix the mailmap issue. Good.

> @@ -706,6 +706,13 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part == 'l' || part == 'L') {	/* local-part */
> +		const char *at = memchr(mail, '@', maillen);
> +		if (at)
> +			maillen = at - mail;
> +		strbuf_add(sb, mail, maillen);
> +		return placeholder_len;
> +	}

And I think this does the counting correctly (mail[maillen] is the "@",
so we wouldn't include it; good).

> +test_expect_success 'log pretty %an %ae %al %aN %aE %aL' '
> +	git checkout -b anaeal &&
> +	test_commit anaeal_test anaeal_test_file &&

Not a big deal, but we could simplify this a bit, I think. There's no
need to make a new branch. And there's no need to specify the filename
to test_commit. IMHO it's worth being as simple as possible in the
tests, because then a reader doesn't have to think about whether those
details are important or not.

> +	git log --pretty="%an%n%ae%n%al%n%aN%n%aE%n%aL" -1 > actual &&

I didn't think about this before, but...surely we're testing %an, etc
already?

Indeed, it looks like t6006 already covers that. Maybe you should be
adding to that test? I note that it just hardcodes "author@example.com"
in the expectation. I'd be OK with either following the lead there, or
doing a separate preparatory patch to use $GIT_AUTHOR_EMAIL, etc.

> +	{
> +		echo "${GIT_AUTHOR_NAME}" &&
> +		echo "${GIT_AUTHOR_EMAIL}" &&
> +		echo "${TEST_AUTHOR_LOCALNAME}"
> +		echo "${GIT_AUTHOR_NAME}" &&
> +		echo "${GIT_AUTHOR_EMAIL}" &&
> +		echo "${TEST_AUTHOR_LOCALNAME}"
> +	} > expect &&

The expectation for %aE is the same as for %ae. So we're not really
testing that we actually applied the mailmap. It looks like t4203 has
some tests for %aE; you'd probably want to check %aL there.

> +test_expect_success 'log pretty %cn %ce %cl %cN %cE %cL' '

Likewise, both of the spots I mentioned cover the committer formats,
too.

> +TEST_AUTHOR_LOCALNAME=author
> +TEST_AUTHOR_DOMAIN=example.com
> +GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}

If you follow the lead of t6006 and just hard-code these, then this hunk
can go away. But if you do keep it, note that...

>  export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
> +export TEST_AUTHOR_LOCALNAME TEST_AUTHOR_DOMAIN
>  export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
> +export TEST_COMMITTER_LOCALNAME TEST_COMMITTER_DOMAIN

These lines are unnecessary. We have to export GIT_AUTHOR_EMAIL, etc, so
that the child git-commit process can read it. But there's no need to do
so for TEST_*, which are meant to be used by the test scripts
themselves.

-Peff
