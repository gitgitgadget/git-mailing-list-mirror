Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C241F855
	for <e@80x24.org>; Mon,  1 Aug 2016 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcHAUkV (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 16:40:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbcHAUkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 16:40:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3B7320E9;
	Mon,  1 Aug 2016 16:32:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oibSokcLdyes5jqRh+tEDEbyYUw=; b=Xn8WJN
	ahGxWZjJwD6ejORmeOvOdHuwBNMaHD6GKrKe39X1fgu3jx7ttbG1VbC7n6e7HtPR
	RZH0J3ba/kBVtIe4UYrA2UbFXRR0aGRoNxil089/W+EGTx5GsWeCvOYAZrcAKrzU
	Knw8Ec/r68ro1CVk4n1Obt3oBYmy/Z+w7VI1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3D4Yn+IWdyguT9L6OeizCtMPgZnifNV
	JpM/HweGrX3Nl4DZ34BXUYa6mwnAIgpnVXVq1j3fA/9HbTHPr0dujmZMQF5fcxUX
	pep46PcBwZQx1iT3PfWNstKApKG9TkNECUDfBpP8Q9lmsz6AhO31TWBym4r2/djF
	j/Oa1Z8tHaU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06F07320E8;
	Mon,  1 Aug 2016 16:32:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73524320E7;
	Mon,  1 Aug 2016 16:32:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] format-patch: Add a config option format.from to set the default for --from
References: <cover.8678faa71de50c8e78760b0bcb3d15ebeda207d5.1469871675.git-series.josh@joshtriplett.org>
	<20160730094156.etvrzqbhcpg3is2z@x>
Date:	Mon, 01 Aug 2016 13:32:49 -0700
In-Reply-To: <20160730094156.etvrzqbhcpg3is2z@x> (Josh Triplett's message of
	"Sat, 30 Jul 2016 02:41:56 -0700")
Message-ID: <xmqqpopsi61a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E30AB80-5827-11E6-A26B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> +static char *from;
>  static const char *signature = git_version_string;
>  static const char *signature_file;
>  static int config_cover_letter;
> @@ -807,6 +808,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		base_auto = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.from")) {
> +		int b = git_config_maybe_bool(var, value);
> +		free(from);
> +		if (b < 0)
> +			from = xstrdup(value);
> +		else if (b)
> +			from = xstrdup(git_committer_info(IDENT_NO_DATE));
> +		else
> +			from = NULL;
> +		return 0;
> +	}

One potential issue I see here is that if we ever plan to switch the
default, we may want to issue a warning message to users who do not
have any format.from configured when they do run the program on a
commit that will get a different result before and after the switch
in a release of Git before that default switch happens.  The message
would say something like "you are formatting somebody else's commit.
the output will change in future versions of Git and show an explicit
in-body From: header; if you want to keep the current behaviour, set
format.from configuration variable to false".

But you cannot tell by looking at from that is NULL between two
cases, it is NULL because we defaulted to it (in which case we do
want to warn), or the user set it explicitly to false (we do not
want to give the warning).

So "... makes it easier to change the default in the future." in the
log message is a bit of exaggeration.  The change in this patch is
not there yet.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 1206c48..b0579dd 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -229,6 +229,46 @@ check_patch () {
>  	grep -e "^Subject:" "$1"
>  }
>  
> +test_expect_success 'format.from=false' '
> +
> +	git -c format.from=false format-patch --stdout master..side |
> +	sed -e "/^\$/q" >patch &&
> +	check_patch patch &&
> +	! grep "^From: C O Mitter <committer@example.com>\$" patch

I know you are only mimicking the style of the existing tests but
the piping loses a potential error exit code from format-patch.  I'd
suggest leaving this as low-hanging fruit for later, not fixing them
as part of this series.

This stops at the blank after the header, so there is no point doing
master..side to format three patches.  Just do "-1 side" instead?

More importantly, this only checks the From: in the header, which is
just the half of what --from does.  Shouldn't we be testing that the
in-body From: is added as necessary?

Thanks.
