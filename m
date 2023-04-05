Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F0C77B6C
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjDEVaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDEVaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:30:21 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B821FF6
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:30:20 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5F3311F452;
        Wed,  5 Apr 2023 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1680730220;
        bh=f9d1ZZxlTbC+BJGvqUFOR6OJ/tj1Ts9hljpctcvUQYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PChPSmZh+e3SjTdDsa7yqZc1V1t/nGMLgx84jSiTZF9LJBP9AMFr6UFkXct+H+jOg
         9bU0oYUvlgI8QTXP9aRRd60Dus7y2E2PITdIK8C+HsMmUlFEN/uMVh5URiFuU5eEeD
         VsWUuCRFki/IVsKiW9LakjUkIXr37ob84PIg8pqY=
Date:   Wed, 5 Apr 2023 21:30:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <20230405213020.M231170@dcvr>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> wrote:
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> index 755a110bc4..3fe43b8968 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -1,5 +1,6 @@
> -#!/usr/bin/perl -w
> +#!/usr/bin/env perl
>  
> +use warnings;

Fwiw, adding `use warnings' only affects the current scope
(package main), whereas `-w' affects the entire Perl process.

I prefer `-w' since adding `use warnings' everywhere is
annoyingly verbose and I only use 3rd-party code that's
warning-clean.

In *.t test scripts and stuff I intend to be overwritten in
install scripts; I've been using `#!perl -w' as the shebang
as a clear signal that it should be overwritten on install
or or run via `$(PERL) FOO' in a Makefile.

For personal scripts in ~/bin, I've been going shebang-less
and having the following as the first two lines:

	eval 'exec perl -w -S $0 ${1+"$@"}'
	if 0; # running under some shell

(Only tested GNU/Linux and FreeBSD, though).  This (and
`env perl') will fail if distros someday decide to start
using `perl5' as the executable name.


That said, I don't know if anything I've said above is
appropriate for the git project aside from noting the
difference between `-w' and `use warnings'.
