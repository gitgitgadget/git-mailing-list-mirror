Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A3DC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AB26105A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhETRGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 13:06:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:60814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233986AbhETRGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 13:06:19 -0400
Received: (qmail 28740 invoked by uid 109); 20 May 2021 17:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 17:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1016 invoked by uid 111); 20 May 2021 17:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 13:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 13:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] p5400: add perf tests for git-receive-pack(1)
Message-ID: <YKaWuYy+iz3qhBad@coredump.intra.peff.net>
References: <cover.1621451532.git.ps@pks.im>
 <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 09:13:27PM +0200, Patrick Steinhardt wrote:

> +while read name repo
> +do
> +	refs=("create updated:new")

This (and the other array manipulation below) is a bash-ism. Presumably
you've got TEST_SHELL_PATH pointed at bash. Without that, on a system
where /bin/sh is dash, the script chokes here.

For your purposes here, I think you can get by with just a single string
with newlines in it. Or even a file (see below).

> +	while read desc ref
> +	do
> +		test_expect_success "setup $name $desc" "
> +			test_must_fail git push --force '$repo' '$ref' \
> +				--receive-pack='tee pack | git receive-pack' 2>err &&
> +			grep 'failed in pre-receive hook' err
> +		"

This inverts the double- and single- quotes from our usual style. So if
$repo is "foo", you are creating a string that has:

  test_must_fail git push --force 'foo' ...

in it, and then the test harness will eval that string. That will fail
if $repo itself contains a single quote. Pretty unlikely, but I think it
contains the absolute path.

The usual style is:

  test_expect_success "setup $name $desc" '
	test_must_fail git push --force "$repo" "$ref" \
	...etc...
  '

where the variables are dereferenced inside the eval'd snippet. So no
quoting is necessary, no matter what's in the variables.

> +		test_perf "receive-pack $name $desc" "
> +			git receive-pack '$repo' <pack >negotiation &&
> +			grep 'pre-receive hook declined' negotiation
> +		"

Likewise here, but note that test_perf is tricky! It runs the snippet in
a sub-process. You have to export $repo to make it visible (you can use
test_export, but you don't need to; there's some discussing in
t/perf/README).

> +	done < <(printf "%s\n" "${refs[@]}")
> +done < <(printf "%s\n" "clone $TARGET_REPO_CLONE" "extrarefs $TARGET_REPO_REFS" "empty $TARGET_REPO_EMPTY")

These process substitutions are also bash-isms. I guess you're trying to
avoid putting the while on the right-hand side of a pipe like:

  printf "%s\n" ... |
  while read ...

which is good, because they set variables and those values don't
reliably make it out of the pipeline. If you stick the contents of $refs
into a file, then you can just do:

  while read ...
  do
     ...
  done <ref-descs

For the outer one, a here-doc is probably a bit simpler:

  while read ...
  do
     ...
  done <<-EOF
  clone $TARGET_REPO_CLONE
  extrarefs $TARGET_REPO_REFS
  empty $TARGET_REPO_EMPTY
  EOF

-Peff
