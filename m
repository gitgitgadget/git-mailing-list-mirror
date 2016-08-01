Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C031F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbcHARQH (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:16:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754451AbcHARQG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:16:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C04F321DE;
	Mon,  1 Aug 2016 13:16:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=amKwsOjh4PlbykCj6fvc+TaqVPM=; b=R6hxFw
	h96E6GP1rjl4lqkw0G1TtDtbjdVhn90RNNH0/0uyc5a3ctrRoBw+oTGRbho/DfG9
	25Kb89vvF1ETPOL6h5WdhWFZLyzLK0x0Nynbv39sC3odMB7fWVLAw+eT3YzpyRXj
	Aer387Fst2MlDg2Yiq0aEwHRX4L2iZmKtn5f8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aOjSLEblBQZPYsBnSPJloVaanX9xidni
	obxS+GlrGXyu3TP1RaKlfjG5RRNiiA/0f493vtH5nxqkL/PwYFZCf+cw730QH+6x
	OAXPw9kmqtUyR7X86OQNKZPAgqmP+m0Vru2Cr33OdEGkMkTxtfmzHehyvOVa9/NU
	JOPLo7p6cdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 245A9321DD;
	Mon,  1 Aug 2016 13:16:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97447321DB;
	Mon,  1 Aug 2016 13:16:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] diff-highlight: add support for --graph output.
References: <20160730151149.15980-1-henderson.bj@gmail.com>
	<20160730151149.15980-4-henderson.bj@gmail.com>
Date:	Mon, 01 Aug 2016 10:16:01 -0700
In-Reply-To: <20160730151149.15980-4-henderson.bj@gmail.com> (Brian
	Henderson's message of "Sat, 30 Jul 2016 08:11:49 -0700")
Message-ID: <xmqqk2g0l8a6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0293524-580B-11E6-86A8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> ---
>  contrib/diff-highlight/diff-highlight | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
> index ffefc31..ec31356 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -20,6 +20,7 @@ my @NEW_HIGHLIGHT = (
>  my $RESET = "\x1b[m";
>  my $COLOR = qr/\x1b\[[0-9;]*m/;
>  my $BORING = qr/$COLOR|\s/;
> +my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;

I didn't read the other parts (or existing code this patch changes,
for that matter) of the series, but this looks like an attempt to
catch the leading "|" bar showing direct ancestry.  It makes a
reader wonder what happens in a mergy histroy, though.

I _think_ that the patch portion of "log -p" output would only have
"|" and never "\" or "/" that are used to adjust the number of
tracks to deal with forks and merges, but perhaps the fact that this
code relies on that assumption deserves to be written down here as
an in-code comment?

>  my @removed;
>  my @added;
> @@ -32,12 +33,12 @@ $SIG{PIPE} = 'DEFAULT';
>  while (<>) {
>  	if (!$in_hunk) {
>  		print;
> -		$in_hunk = /^$COLOR*\@/;
> +		$in_hunk = /^$GRAPH*$COLOR*\@/;
>  	}
> -	elsif (/^$COLOR*-/) {
> +	elsif (/^$GRAPH*$COLOR*-/) {
>  		push @removed, $_;
>  	}
> -	elsif (/^$COLOR*\+/) {
> +	elsif (/^$GRAPH*$COLOR*\+/) {
>  		push @added, $_;
>  	}
>  	else {
> @@ -46,7 +47,7 @@ while (<>) {
>  		@added = ();
>  
>  		print;
> -		$in_hunk = /^$COLOR*[\@ ]/;
> +		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
>  	}
>  
>  	# Most of the time there is enough output to keep things streaming,
> @@ -211,8 +212,8 @@ sub is_pair_interesting {
>  	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
>  	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
>  
> -	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
> -	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
> +	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
> +	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
>  	       $suffix_a !~ /^$BORING*$/ ||
>  	       $suffix_b !~ /^$BORING*$/;
>  }
