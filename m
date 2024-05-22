Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00AF7E575
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365985; cv=none; b=bMGabFD9DxSHRIpmj9KhVLBXIN5a84kF9NEEaJE7az2df9zRqZoiCFyNpUxR989QjxyQIa9QYGdsu95UnMPg6D50lCDgloqwy+yCG8rHi8M+XXjLxnPvYTqMu9CxqgDCyG8xofJnXk1Znv3LqvFNNSSPwgVR1cwhnu9T/qE/X5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365985; c=relaxed/simple;
	bh=ZldYfDcB5+/tXtzymAeZ9595Xsa5Aisf3II6610+tkQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LRppIJZDFT1Z1ZwKxCweh8ff3Me2t3Dh8uDrr0gZT/o5CpxnDsdq0/N2LYOkebYsmK5gxzosF5QZtuHGeDqc9437zgAQtLec5Z/F3U/BYEmSYa7I4pdIJU0WW5wpYrkKYZKQqEhOyGdRRsBG6ghqBX4gaHiSB2aD+rWP8gRx+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FbVFxpzz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FbVFxpzz"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716365980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=az5cOQrYAhH+ODdL3eaLtT+BZEJYpNFchhnD/aMQLuY=;
	b=FbVFxpzzT267QYnbMmMlEM1g8feBGi4+yRK0UX4/U7WE22i+iyDiWQSoHzDsNGW43e2dX7
	coSJHYPqmaDfgHOJt9rdfTwXlLqnNGDXkUT6R9Ql77ZlJi8L6tPiP4FI8W/2+57CFjDHWk
	lW4JpQ+wiysDrlMoWQ5X4UwZU2KiXtNnHTeuGmvVDgiosfIo4SZQ8PRaLVBsS0zG2YDVAK
	FmBnsiPvL6dWxMCGoftkUdqZcRM0BwSNFSGDsuRVlWzdwaKyrCxVOLzAL/o+S8ICG3lUZc
	fnafqy8o2z51G2+kdiTMZpSahVZgoMrs3p3et/HJU/JYgQbaeCCbFHms+XrsiQ==
Date: Wed, 22 May 2024 10:19:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 01/12] send-email: drop FakeTerm hack
In-Reply-To: <20240521195659.870714-2-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
 <20240521195659.870714-2-gitster@pobox.com>
Message-ID: <3a3c73801ae04db4227ac87e1e302615@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-21 21:56, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
> 
> Back in 280242d1cc (send-email: do not barf when Term::ReadLine does 
> not
> like your terminal, 2006-07-02), we added a fallback for when
> Term::ReadLine's constructor failed: we'd have a FakeTerm object
> instead, which would then die if anybody actually tried to call
> readline() on it. Since we instantiated the $term variable at program
> startup, we needed this workaround to let the program run in modes when
> we did not prompt the user.
> 
> But later, in f4dc9432fd (send-email: lazily load modules for a big
> speedup, 2021-05-28), we started loading Term::ReadLine lazily only 
> when
> ask() is called. So at that point we know we're trying to prompt the
> user, and we can just die if ReadLine instantiation fails, rather than
> making this fake object to lazily delay showing the error.
> 
> This should be OK even if there is no tty (e.g., we're in a cron job),
> because Term::ReadLine will return a stub object in that case whose 
> "IN"
> and "OUT" functions return undef. And since 5906f54e47 (send-email:
> don't attempt to prompt if tty is closed, 2009-03-31), we check for 
> that
> case and skip prompting.
> 
> And we can be sure that FakeTerm was not kicking in for such a
> situation, because it has actually been broken since that commit! It
> does not define "IN" or "OUT" methods, so perl would barf with an 
> error.
> If FakeTerm was in use, we were neither honoring what 5906f54e47 tried
> to do, nor producing the readable message that 280242d1cc intended.
> 
> So we're better off just dropping FakeTerm entirely, and letting the
> error reported by constructing Term::ReadLine through.
> 
> [jc: cherry-picked from v2.42.0-rc2~6^2~1]
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Acked-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking good to me.  Thanks for taking care of this issue.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  git-send-email.perl | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..72d876f0a0 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -26,18 +26,6 @@
> 
>  Getopt::Long::Configure qw/ pass_through /;
> 
> -package FakeTerm;
> -sub new {
> -	my ($class, $reason) = @_;
> -	return bless \$reason, shift;
> -}
> -sub readline {
> -	my $self = shift;
> -	die "Cannot use readline on FakeTerm: $$self";
> -}
> -package main;
> -
> -
>  sub usage {
>  	print <<EOT;
>  git send-email' [<options>] <file|directory>
> @@ -930,16 +918,10 @@ sub get_patch_subject {
>  }
> 
>  sub term {
> -	my $term = eval {
> -		require Term::ReadLine;
> -		$ENV{"GIT_SEND_EMAIL_NOTTY"}
> +	require Term::ReadLine;
> +	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
>  			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
>  			: Term::ReadLine->new('git-send-email');
> -	};
> -	if ($@) {
> -		$term = FakeTerm->new("$@: going non-interactive");
> -	}
> -	return $term;
>  }
> 
>  sub ask {
