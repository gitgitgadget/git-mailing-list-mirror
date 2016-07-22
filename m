Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFA6203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbcGVRN4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:13:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcGVRNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:13:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA2602D6BC;
	Fri, 22 Jul 2016 13:13:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PehSyk2Xr/JHk9O49VU5EkD6nlE=; b=geEDGD
	LGiG+QUyQhazB9s0wj9KQQHVDdpMjG8BZ9Db5E6YmaabM8W7e1Ll5J8J4tb3vLye
	K4NXhpz+kBTKuPpyFJ/cnb5nOgtXFCNK8y801HY6GntOEDCmjJEutuVcwZtlJYen
	vBEkJzF/SmwxwHJkB/uUYPOuSPjQoL05k7v0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a6C1Dere0r4aiB5++a9kldTYhuxebNbI
	fsKjAYFjpKdUQ0qIGYccX4FFRffzSARXbr90uWRVeWJ3MR23gW4gbWmCMVrCI6qf
	zcMSMqYnv36lNM0gW4o0GC6ip8kpj2nRW+ixVLOMMcS7WltYJiUJAJyNfGZJ+80o
	8phuR1kTBcU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2A992D6BB;
	Fri, 22 Jul 2016 13:13:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C5932D6B9;
	Fri, 22 Jul 2016 13:13:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org
Subject: Re: [RFC] git-svn: allow --version to work anywhere
References: <20160720004734.GA19635@whir>
Date:	Fri, 22 Jul 2016 10:13:51 -0700
In-Reply-To: <20160720004734.GA19635@whir> (Eric Wong's message of "Wed, 20
	Jul 2016 00:47:34 +0000")
Message-ID: <xmqqeg6lbnow.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA701E0A-502F-11E6-87A8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Checking the version of the installed SVN libraries should not
> require a git repository at all.  This matches the behavior of
> "git --version".
>
> Add a test for "git svn help" for the same behavior while we're
> at it, too.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   I'm hoping "cd /" in the test will always succeed;
>   but I suppose non-*nix systems might fail, here.

How about digging a few levels of directory hierarchy, exporting
GIT_CEILING_DIRECTORIES so that we won't find any repository and
going there to run these tests?

>   And maybe a BOFH did "chmod 700 /"	:(
>
>   Anyways this is sitting in master of git://bogomips.org/git-svn.git
>
>  git-svn.perl             | 4 ++--
>  t/t9100-git-svn-basic.sh | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index f609e54..4d41d22 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -339,7 +339,7 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  			die "failed to open $ENV{GIT_DIR}: $!\n";
>  		$ENV{GIT_DIR} = $1 if <$fh> =~ /^gitdir: (.+)$/;
>  	}
> -} else {
> +} elsif ($cmd) {
>  	my ($git_dir, $cdup);
>  	git_cmd_try {
>  		$git_dir = command_oneline([qw/rev-parse --git-dir/]);
> @@ -356,7 +356,7 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  
>  my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
>  
> -read_git_config(\%opts);
> +read_git_config(\%opts) if $ENV{GIT_DIR};
>  if ($cmd && ($cmd eq 'log' || $cmd eq 'blame')) {
>  	Getopt::Long::Configure('pass_through');
>  }
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index 28082b1..10408d0 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -19,6 +19,14 @@ case "$GIT_SVN_LC_ALL" in
>  	;;
>  esac
>  
> +test_expect_success 'git svn --version works anywhere' '
> +	( cd / || exit 0; git svn --version )
> +'
> +
> +test_expect_success 'git svn help works anywhere' '
> +	( cd / || exit 0; git svn help )
> +'
> +
>  test_expect_success \
>      'initialize git svn' '
>  	mkdir import &&
