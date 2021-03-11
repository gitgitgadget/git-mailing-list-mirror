Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C34C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EC264F00
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKTQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:16:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:60804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhCKTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:15:55 -0500
Received: (qmail 16818 invoked by uid 109); 11 Mar 2021 19:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 19:15:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12927 invoked by uid 111); 11 Mar 2021 19:15:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 14:15:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 14:15:53 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] shortlog tests: rewrite to get rid of --abbrev=35
 hardcoding
Message-ID: <YEpsaZ9Kr+i0Sbyd@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
 <20210311001447.28254-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311001447.28254-4-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 01:14:46AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Rewrite much of the test logic introduced in 600372497c (shortlog:
> Document and test --format option, 2010-05-03), this allows us to get
> rid of the now-unused $_x35 variable in test-lib.sh
> 
> There was a minimal migration of this test to SHA-256 in
> 2ece6ad281 (t: switch $_x40 to $OID_REGEX, 2018-05-13), but actually
> we can just get rid of all the assumptions about hashing here, and
> make this easier to understand and maintain while we're at it.

Sounds like a good goal. I had to spend a few minutes deciphering what
was going on in the diff, so I'll follow along loudly...

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 3095b1b2ff..3ef17c06e4 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -19,82 +19,94 @@ test_expect_success 'setup' '
>  	commit=$(printf "%s\n" "Test" "" | git commit-tree "$tree") &&
>  	git update-ref HEAD "$commit" &&
>  
> +	echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" >message &&
> +
> +	sed "s/i/1234/g" <message >tmp &&
> +	tr 1234 "\360\235\204\236" <tmp >message.2 &&
> +
> +	sed "s/i/1234/g" <message >tmp &&
> +	tr 1234 "\370\235\204\236" <tmp >message.3 &&
> +
> +	echo "a								12	34	56	78" >message.4 &&
> +	echo "Commit by someone else" >message.5 &&
> +

This is all moving the messages into files so that you can pull them
into the expected output later. OK (feels weird to use sed and tr
together like this, but maybe it's a portability thing for sed which
doesn't understand octal; anyway, it's definitely not new in your
patch).

That might have been easier to understand if each message was generated
next to its comment. E.g...

>  	# test if the wrapping is still valid
>  	# when replacing all is by treble clefs.
>  	echo 3 >a1 &&
> -	git commit --quiet -m "$(
> -		echo "This is a very, very long first line for the commit message to see if it is wrapped correctly" |
> -		sed "s/i/1234/g" |
> -		tr 1234 "\360\235\204\236")" a1 &&
> +	git commit --quiet -F message.2 a1 &&

...if we made message.2 here, then the comment would be explaining what
the opaque bytes are doing (and likewise why they differ in message.3).

Also, the mismatch between the "3" going into the file and "message.2"
is confusing. It's not important, but I wonder if using "commit
--allow-empty" and just skipping a1, etc, would make it easier to read.

Similarly, --quiet seems pointless here. If the test isn't run with
--verbose, the user doesn't see it either way. If it is, then they
probably want to see the output.

> -	cat >expect.template <<-\EOF
> +	cat >expect.default <<-EOF
>  	A U Thor (5):
> -	      SUBJECT
> -	      SUBJECT
> -	      SUBJECT
> -	      SUBJECT
> -	      SUBJECT
> +	      Test
> +	      $(cat message)
> +	      $(cat message.2)
> +	      $(cat message.3)
> +	      $(cat message.4)
>  
>  	Someone else (1):
> -	      SUBJECT
> +	      $(cat message.5)
>  
>  	EOF

OK, and here's where we make the actual expected output, rather than a
template. I think this is an improvement in understanding what's going
on (and also is more robust).

I was slightly confused that we are not looking for the messages to have
been wrapped (just based on the surrounding code), but that is not new
to your patch.

> -fuzz() {
> -	file=$1 &&
> -	sed "
> -			s/$OID_REGEX/OBJECT_NAME/g
> -			s/$_x35/OBJID/g
> -			s/^ \{6\}[CTa].*/      SUBJECT/g
> -			s/^ \{8\}[^ ].*/        CONTINUATION/g
> -		" <"$file" >"$file.fuzzy" &&
> -	sed "/CONTINUATION/ d" <"$file.fuzzy"
> -}
> [...]
>  test_expect_success 'pretty format' '
> -	sed s/SUBJECT/OBJECT_NAME/ expect.template >expect &&
> +	cat >expect <<-EOF &&
> +	A U Thor (5):
> +	      $(git rev-parse HEAD~5)
> +	      $(git rev-parse HEAD~4)
> +	      $(git rev-parse HEAD~3)
> +	      $(git rev-parse HEAD~2)
> +	      $(git rev-parse HEAD~1)

And here we expect the real hashes rather than the fuzz() magic, which
makes sense.

Aside: here and in the others, I cringe a little at the cost of all of
the $() calls inside the here-doc. But I don't think there's a better
way to do it. I'd sometimes use environment variables for this, but the
processing we're doing probably makes it better to keep them in real
files. Or maybe not. TBH, just expanding out the messages in the source
like:

  m1=$(printf "Th\370\235\204\236s \370\235\204\236s a very, very long f\370\235\204\236rst l\370\235\204\236ne for the comm\370\235\204\236t message to see \370\235\204\236f \370\235\204\236t \370\235\204\236s wrapped correctly")

is equally unreadable to the original to me. ;) Possibly it would be
even more readable if some more meaningful pattern of replacements was
used. But I am firmly in bikeshedding territory there, so feel free to
ignore.

>  test_expect_success '--abbrev' '
> -	sed s/SUBJECT/OBJID/ expect.template >expect &&
> +	cut -c 1-41 <expect >expect.abbrev &&
>  	git shortlog --format="%h" --abbrev=35 HEAD >log &&
> -	fuzz log >log.predictable &&
> -	test_cmp expect log.predictable
> +	test_cmp expect.abbrev log
>  '

And this is the same thing as %H, but abbreviated.

I agree with Junio that the "1-41" seems magical. His suggestion to show
the math helps with that (or even just a comment). You could also just
build the "expect" file with:

  $(git rev-parse --abbrev=35 HEAD~5)

etc (I also have to wonder if there is much value in this beyond
checking the first commit, but that certainly predates your patch).

>  test_expect_success 'output from user-defined format is re-wrapped' '
> -	sed "s/SUBJECT/two lines/" expect.template >expect &&
> +	cat >expect <<-EOF &&
> +	A U Thor (5):
> +	      two lines
> +	      two lines
> +	      two lines
> +	      two lines
> +	      two lines
> +
> +	Someone else (1):
> +	      two lines
> +
> +	EOF
>  	git shortlog --format="two%nlines" HEAD >log &&
> -	fuzz log >log.predictable &&
> -	test_cmp expect log.predictable
> +	test_cmp expect log
>  '

And this one is IMHO much improved in readability.

>  test_expect_success !MINGW 'shortlog wrapping' '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 5f2ad2fd81..4d5ba558d3 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -511,7 +511,7 @@ SQ=\'
>  # when case-folding filenames
>  u200c=$(printf '\342\200\214')
>  
> -export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
> +export _x05 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX

And now we can get rid of _x05. Yay.

-Peff
