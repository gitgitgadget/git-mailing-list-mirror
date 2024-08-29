Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC61B29D7
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946921; cv=none; b=lYFlt25EN81VT6cDvNtSL4HjWrpajsg7EBArk11G+1gTrjHYLqxJT55vRmDMQRtzaHturtz0KPlhm7zYCEysAC0XR7nu+f7GUydYzw9/fy+f2iqWQos+7xZCROamw1aM4BEMmX4q6qZz8G3VauBKA08HdL5fI+BEnyACP2j6Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946921; c=relaxed/simple;
	bh=ZacXWhsY84SK8kMzChPOAYiiJ+sIwbAQU3KQf0A1xtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQQW+xsG2a8hZdkqdXPfBNHxyC+MFIyrYGhki9o5o9b8vAodwmfnhJ5mxjJbVi50aUjV9PztSyaYj8sAsEJ0D52DxsQdpavn6MDL7Z9+GDWObFQ/AXAM7x4v8cow+FJ2u1qOCnH3SSYgXtAS1KaAIR9FJSYwpKHlo7Ay3p/h4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nJcnBpoQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJcnBpoQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AA5932121;
	Thu, 29 Aug 2024 11:55:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZacXWhsY84SK8kMzChPOAYiiJ+sIwbAQU3KQf0
	A1xtg=; b=nJcnBpoQPWl4dIDgt1wLvep2o53EYzJNsgoEYr+UQuSliawta6sn6A
	M8XJa33QBiuJHjtsvR+BcfsOZim0qFsnE8xhrqI42s/jkIFEmRoL6UDi6+G1B91S
	/ey1xvAFvqkfQrCuDEwxgPe+AKo8YIZriM5B/WnLdqFpJElAVknHc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22A7D3211F;
	Thu, 29 Aug 2024 11:55:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 815AE3211E;
	Thu, 29 Aug 2024 11:55:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
In-Reply-To: <20240829091625.41297-3-ericsunshine@charter.net> (Eric
	Sunshine's message of "Thu, 29 Aug 2024 05:16:25 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240829091625.41297-3-ericsunshine@charter.net>
Date: Thu, 29 Aug 2024 08:55:17 -0700
Message-ID: <xmqqv7zjwcgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16DE8F50-661F-11EF-B3E1-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> When chainlint detects a problem in a test definition, it highlights the
> offending code with an "?!ERR ...?!" annotation. The rather curious "?!"
> delimiter was chosen to draw the reader's attention to the problem area.
>
> Later, chainlint learned to color its output when sent to a terminal.
> Problem annotations are colored with a red background which stands out
> well from surrounding text, thus easily draws the reader's attention. As
> such, the additional "?!" decoration became superfluous (when output is
> colored), however the decoration was retained since it serves as a good
> needle when using the terminal's search feature to "jump" to the next
> problem.
>
> Nevertheless, the "?!" decoration is noisy and ugly and makes it
> unnecessarily difficult for the reader to pluck the problem description
> from the annotation. For instance, it is easier to see at a glance what
> the problem is in:
>
>     ERR missing '&&'
>
> than in the noisier:
>
>     ?!ERR missing '&&'?!
>
> Therefore drop the "!?" decoration when output is colored (but retain it
> otherwise).

Wait.  That does not qualify "Therefore".

We talked about a "good needle" and then complained how ugly the
string that was happened to be chosen as good needle is.  That is
not enough to explain why it is justified to "lose" the needle.  The
only thing you justified is to move away from the ugly pattern, as a
typical "terminal's search feature" does not give us an easy way to
"jump to the next text painted yellow".

> Note that the preceding change gave all problem annotations a uniform
> "ERR" prefix which serves as a reasonably suitable replacement needle
> when searching in a terminal, so loss of "?!" in the output should not
> be overly problematic.

Drop this separate paragraph, promote its contents up from "Note"
status and as a proper part of the previous sentence in its rewrite,
something like:

    Since the errors are all uniformly prefixed with "ERR", which
    can be used as the "good needle" instead, lose the "!?"
    decoration when output is colored.

to replace "Therefore" and everything that follow.

> @@ -663,7 +666,7 @@ sub check_test {
>  	$checked =~ s/^\d+ \n//;
>  	$checked =~ s/(\s) \?!/$1?!/mg;
>  	$checked =~ s/\?! (\s)/?!$1/mg;
> -	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
> +	$checked =~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;

Hmph.  With $erropen and $errclose, I was hoping that we can shed
the reliance on the "?!" mark even internally.  This is especially
true that in the early part of this sub, the problem description was
very much structured piece of data, not something the consuming code
need to pick out of an already formatted text like this, risking to
get confused by the payload (i.e. the text that came from the
problematic test script inside "substr($body, $start, $pos-$start)"
may contain anything, including "?!", right?).

>  	$checked =~ s/^\d+/$c->{dim}$&$c->{reset}/mg;
>  	$checked .= "\n" unless $checked =~ /\n$/;
>  	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
> @@ -805,9 +808,9 @@ sub check_script {
>  			my $c = fd_colors(1);
>  			my $s = join('', @{$parser->{output}});
>  			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
> -			$nerrs += () = $s =~ /\?![^?]+\?!/g;
>  		}
>  		$ntests += $parser->{ntests};
> +		$nerrs += $parser->{nerrs};
>  	}
>  	return [$id, $nscripts, $ntests, $nerrs];
>  }
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 54247604cb..b652cb98cd 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1606,7 +1606,7 @@ if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
>     test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
>  then
>  	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
> -		BUG "lint error (see '?!...!? annotations above)"
> +		BUG "lint error (see 'ERR' annotations above)"
>  fi
>  
>  # Last-minute variable setup

Overall the two patches looked great.
Thanks.
