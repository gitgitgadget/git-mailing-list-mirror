Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85685211B5
	for <e@80x24.org>; Tue, 29 Jan 2019 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfA2Xau (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:30:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45806 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfA2Xau (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:30:50 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BB8951F453;
        Tue, 29 Jan 2019 23:30:49 +0000 (UTC)
Date:   Tue, 29 Jan 2019 23:30:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net, Matt Wright <mww@apple.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (Apple Git) 11/13] Fix problem found from running the
 test suite.
Message-ID: <20190129233049.65gxzl57qtxv6ebq@dcvr>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-12-jeremyhu@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190129193818.8645-12-jeremyhu@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> wrote:
> From: Matt Wright <mww@apple.com>
> 
> Signed-off-by: Matt Wright <mww@apple.com>

Hi Jeremy/Matt: I expect to see a description of said "problem"

More comments inline below...

> diff --git a/git-svn.perl b/git-svn.perl
> index 050f2a36f4..d29730be3b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1815,6 +1815,36 @@ sub complete_url_ls_init {
>  
>  sub verify_ref {
>  	my ($ref) = @_;
> +
> +	if ($ref =~ /^(.*)\^0$/) {
> +		my $baseref = $1;
> +		my $p = "$ENV{GIT_DIR}/$baseref";
> +		$p = "$ENV{GIT_DIR}/refs/remotes/$baseref" unless -e $p;
> +		$p = "$ENV{GIT_DIR}/refs/$baseref" unless -e $p;
> +		$p = "$ENV{GIT_DIR}/refs/heads/$baseref" unless -e $p;

OK, this looks like we're reproducing rev-parse functionality...

> +		my $resolved = undef;
> +		if (-e $p) {
> +			open FH, $p;
> +			$resolved = <FH>;
> +			chomp $resolved;
> +			close FH;
> +		} elsif (-e "$ENV{GIT_DIR}/packed-refs") {
> +			open FH, "$ENV{GIT_DIR}/packed-refs";
> +			while (<FH>) {
> +				if ($_ =~ /^([0-9a-fA-F]+) ((refs\/)?(remotes\/|heads\/|\/)?$baseref)$/) {
> +					$resolved = $1;
> +					last;
> +				}
> +			}

And even more so...   This would be a pain to maintain with
proposed changes to ref storage (reftable/lmdb/...), so I really
don't want to reproduce rev-parse functionality in Perl.

But while we're in Perl; prefer something like:

	m!^([0-9a-f]+) ((refs/)?(remotes/|heads/|/)?$baseref)$!

So you don't have to escape '/' (leaning-toothpick syndrome) by
using m!$REGEX!.  You can also skip the unnecessary [A-F] match.

> +		}
> +
> +		if (defined($resolved)) {
> +			return verify_ref("$1^0") if $resolved =~ /^ref: (.*)$/;
> +			return $resolved
> +		}
> +	}

So without more details, we really need an explanation of why
this patch was made.  The test suite has been thousands of times
over the years on other platforms without changes to the
verify_ref() sub.

>  	eval { command_oneline([ 'rev-parse', '--verify', $ref ],
>  	                       { STDERR => 0 }); };
>  }
