Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156BC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7FF207FD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfKYNuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:50:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:59866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727741AbfKYNuR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 08:50:17 -0500
Received: (qmail 26222 invoked by uid 109); 25 Nov 2019 13:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 13:50:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18640 invoked by uid 111); 25 Nov 2019 13:54:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 08:54:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 08:50:16 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: add 'test_bool_env' to catch non-bool
 GIT_TEST_* values
Message-ID: <20191125135016.GA632@sigill.intra.peff.net>
References: <20190907101637.GE32087@szeder.dev>
 <20191122131437.25849-1-szeder.dev@gmail.com>
 <20191122131437.25849-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191122131437.25849-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 02:14:36PM +0100, SZEDER Gábor wrote:

> Let's be more careful about what the test suite accepts as bool values
> in GIT_TEST_* environment variables, and error out loud and clear on
> invalid values instead of simply skipping tests.  Add the
> 'test_bool_env' helper function to encapsulate the invocation of 'git
> env--helper' and the verification of its exit code, and replace all
> invocations of that command in our test framework and test suite with
> a call to this new helper (except in 't0017-env-helper.sh', of
> course).
> 
>   $ GIT_TEST_GIT_DAEMON=YesPlease ./t5570-git-daemon.sh
>   fatal: bad numeric config value 'YesPlease' for 'GIT_TEST_GIT_DAEMON': invalid unit
>   error: test_bool_env requires bool values both for $GIT_TEST_GIT_DAEMON and for the default fallback

This patch looks good to me. A few musings below, but I'm not sure if
they're worth acting on.

> +test_bool_env () {
> +	if test $# != 2
> +	then
> +		BUG "test_bool_env requires two parameters (variable name and default value)"
> +	fi
> +
> +	git env--helper --type=bool --default="$2" --exit-code "$1"
> +	ret=$?
> +	case $ret in
> +	0|1)	# unset or valid bool value
> +		;;
> +	*)	# invalid bool value or something unexpected
> +		error >&7 "test_bool_env requires bool values both for \$$1 and for the default fallback"
> +		;;
> +	esac
> +	return $ret
> +}

The magic of exit code "1" is undocumented, but we have to rely on it
here. I suggested earlier that we could do:

  if ! val=$(git env--helper --type=bool --default="$2" "$1")
    error ...
  fi
  test "$val" = "true"

but as you noted, we exit with code 1 for "false" even without
--exit-code. IMHO this is a mis-design in the interface of env--helper.

I think it would be an option to change it. It's an undocumented
double-dashed internal helper, so I don't think we need to worry about
breaking compatibility. There's only one other caller that you didn't
touch in this patch, and it uses --exit-code (more on that in a second).

> +test_expect_success 'test_bool_env' '

These tests make sense. In fact, they're much more interesting than the
ones in t0017, since these cover a superset of the code that's actually
used in practice. t0017 covers non-exit-code and --ulong invocations,
but nobody uses them!

I'm wondering if this whole env--helper thing is kind of
over-engineered. Should it actually be a test-tool helper instead of a
shipped builtin? The only call outside of the test suite is this one in
git-sh-i18n:

  # First decide what scheme to use...
  GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
  if test -n "$GIT_TEST_GETTEXT_POISON" &&
              git env--helper --type=bool --default=0 --exit-code \
                  GIT_TEST_GETTEXT_POISON
  then
          GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
  elif test -n "@@USE_GETTEXT_SCHEME@@"
  ...

which suffers from the same problem your patch is fixing. But since this
is again a test-suite thing, it seems like it would be simpler for the
test suite to just set GIT_INTERNAL_GETTEXT_SH_SCHEME=poison itself
(with a little rearranging here to let that override the "fallthrough"
case).

That would make the remaining --exit-code problem go away, remove some
test cruft from production code, and remove the last non-test-suite
caller of env--helper.

At that point we could make it a test-tool builtin. Or even implement it
purely in shell, saving some processes (that would require duplicating
the internal bool logic, but that's way shorter than the boilerplate
needed to expose it via env--helper).

I do think env--helper _could_ be useful for user scripts. But then I
think we'd need to document and rename it to make it clear that it's
part of Git's plumbing that you can depend on.

-Peff
