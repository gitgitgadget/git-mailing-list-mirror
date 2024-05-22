Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D7E0F6
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365719; cv=none; b=Wtl+7p9zOUYQzaf/ttE/PZueoV3Zqz4ATPTjnTvuVUaks9oC9xST0z/PJAy6F554nbxVEB1jdVH8xFjGQps3ICGRUhvftfeKsvyPvL1qKN4o+CyBzmTKRLYjonwy7fM5J0+Wj+ZBSo8E3EBlMvgAXDA2kJGSX/T/LOj174OPYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365719; c=relaxed/simple;
	bh=51o0aNssnAUkolyxU6hvMQ8PZ9pgoYUrWVTwSPAldTU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=K+/FEt3CCmMYfOurWKOU1FW4Rd66oEnT0o16auT89A70q1uYQNjLq/xPXe/mRRcaUQD6SiNI7hHuiww3Tf/3Bs8M9bmtUW+TGJ/K8g4/XpGk5wx/0wQ9ZJroN0m/qkpDn+xAMRZy0IL+xCkuuw6a30osdjLflflnKfDsdtMwL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=v7miyp3K; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v7miyp3K"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716365715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BDBEKKEIY05CRLCbvY/YUCveQ7h2DPy1lKHRJmMdRA=;
	b=v7miyp3Ksy4VldnzFVspJsXHqwfXNayRAcWnWpY734Ry/mBQT61G0vo9oDY+nSf1rbBowr
	nQhoneQEVYbdv6AGukzQCQ6H0xuk8waTmFkjlLLX74soZsU215EYGmWwy93WAHhV8g5/7t
	PIodRyqHFRwd9mJx5OKn4bj0jY91Xt40gfsDV28kTSuA+mYrOcEAXDDaJUwaqKzcpF8Qyp
	8laxffLqRFqBuQ5tKzrbrFDFrvFBU9d+A+cqTwbwO99wzwiISslpo5s5l8McLp64eU4ILB
	zrDSjJk6BT4UIFKXp+a47NshzAHco7wsjqSfSpdsXh6qWxikCUruzyRRiD6WkQ==
Date: Wed, 22 May 2024 10:15:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 02/12] send-email: avoid creating more than one
 Term::ReadLine object
In-Reply-To: <20240521195659.870714-3-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
 <20240521195659.870714-3-gitster@pobox.com>
Message-ID: <c55528b5c08e722fff8b6109e42a7752@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-21 21:56, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
> 
> Every time git-send-email calls its ask() function to prompt the user,
> we call term(), which instantiates a new Term::ReadLine object. But in
> v1.46 of Term::ReadLine::Gnu (which provides the Term::ReadLine
> interface on some platforms), its constructor refuses to create a 
> second
> instance[1]. So on systems with that version of the module, most
> git-send-email instances will fail (as we usually prompt for both "to"
> and "in-reply-to" unless the user provided them on the command line).
> 
> We can fix this by keeping a single instance variable and returning it
> for each call to term(). In perl 5.10 and up, we could do that with a
> "state" variable. But since we only require 5.008, we'll do it the
> old-fashioned way, with a lexical "my" in its own scope.
> 
> Note that the tests in t9001 detect this problem as-is, since the
> failure mode is for the program to die. But let's also beef up the
> "Prompting works" test to check that it correctly handles multiple
> inputs (if we had chosen to keep our FakeTerm hack in the previous
> commit, then the failure mode would be incorrectly ignoring prompts
> after the first).
> 
> [1] For discussion of why multiple instances are forbidden, see:
>     https://github.com/hirooih/perl-trg/issues/16
> 
> [jc: cherry-picked from v2.42.0-rc2~6^2]
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Acked-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking good to me.  Thanks for taking care of this issue.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  git-send-email.perl   | 18 +++++++++++++-----
>  t/t9001-send-email.sh |  5 +++--
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 72d876f0a0..ad51508790 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -917,11 +917,19 @@ sub get_patch_subject {
>  	do_edit(@files);
>  }
> 
> -sub term {
> -	require Term::ReadLine;
> -	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
> -			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
> -			: Term::ReadLine->new('git-send-email');
> +{
> +	# Only instantiate one $term per program run, since some
> +	# Term::ReadLine providers refuse to create a second instance.
> +	my $term;
> +	sub term {
> +		require Term::ReadLine;
> +		if (!defined $term) {
> +			$term = $ENV{"GIT_SEND_EMAIL_NOTTY"}
> +				? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
> +				: Term::ReadLine->new('git-send-email');
> +		}
> +		return $term;
> +	}
>  }
> 
>  sub ask {
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1130ef21b3..0f08a9542b 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -337,13 +337,14 @@ test_expect_success $PREREQ 'Show all headers' '
>  test_expect_success $PREREQ 'Prompting works' '
>  	clean_fake_sendmail &&
>  	(echo "to@example.com" &&
> -	 echo ""
> +	 echo "my-message-id@example.com"
>  	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$patches \
>  		2>errors &&
>  		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
> -		grep "^To: to@example.com\$" msgtxt1
> +		grep "^To: to@example.com\$" msgtxt1 &&
> +		grep "^In-Reply-To: <my-message-id@example.com>" msgtxt1
>  '
> 
>  test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
