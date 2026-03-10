Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF040DFAA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181930; cv=none; b=UqMgBTZ3NeuRdGdpahru0s1NBvQzyDc8ZcbrXv55+afMY+QDFsRTLauWf1QmF2znMyLvIoiK8Myw6VPPC1P2KrTEiCoL+93XNxUD+oxCZRuKFf5JOTQxdPZRk2wfuhqd7p+iGNVOVYf5HMlrJzlC1UfSzi0qYU6G7Zx2m2jswZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181930; c=relaxed/simple;
	bh=VI6YfE7rfeAzBXqAUE+++7CukfVQbIqdJ6M5+WzHKi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKLHccolzAnGylHaftq8N2dH/6ApJOZEoJOl0Yuk7LPtpbYWy6EIci4SJLEG2bZUXS3Fst8O72fwTDx73JyCsnjG4qAw4iPu9YbiJP3WqkJwRAW6zBqmVLdlFYLcmvQ1cNQ4x8LyrDAgH3fDqCltJIaX8AfI5k6f/WclGyGBP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=F9jkibF1; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="F9jkibF1"
Date: Tue, 10 Mar 2026 23:32:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773181926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPBLM2FqxSeqKffq50ha+HSR/ASZOl2MrSXhOIs/3uU=;
	b=F9jkibF1RJGaiacY9GcA6zlTvtbOUyRgZ45oY52+aTVOFdzPEW7ULX8Ef/foZcQiZoJiyO
	/GZ94epUgx5aVrxerSwn3npIIZQsGLsiYvdAI5u7LYqCywwoGSsxAa90dO8R7w16cxYpwb
	Ds5TnnyuMECCl3mEgABcro6vwVx8sFg3o7kOlefrOeRluydxuhXDA0K+rSIqqo/bXy4NKn
	W6I6RDAeYikE16rUTU3FFNZD4YGdJRZqe4M/7VTVI+gOF/rsy7rnfr0AL9X3vhl5o3fiPn
	CrQO1mVmndv4IwZ69MLgEFn01F0RLDDWJiEFxOa6SxQl0jS74ANalgDKYTK+vA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v6 3/5] format-patch: add ability to use alt cover format
Message-ID: <abCbhOt26wJNnHGJ@exploit>
References: <cover.1772232373.git.mroik@delayed.space>
 <cover.1772837832.git.mroik@delayed.space>
 <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772837832.git.mroik@delayed.space>
 <xmqqldfzs567.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldfzs567.fsf@gitster.g>
X-Spamd-Bar: --

On Tue, Mar 10, 2026 at 03:14:40PM -0700, Junio C Hamano wrote:
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index 21d6d0cd9e..458da80721 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -380,6 +380,54 @@ test_expect_success 'filename limit applies only to basename' '
> >  	done
> >  '
> >  
> > +test_expect_success 'cover letter with subject, author and count' '
> > +	rm -rf patches &&
> > +	test_when_finished "git reset --hard HEAD~1" &&
> > +	test_when_finished "rm -rf patches result test_file" &&
> > +	touch test_file &&
> > +	git add test_file &&
> > +	git commit -m "This is a subject" &&
> > +	git format-patch --cover-letter \
> > +	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
> > +	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
> > +	test_line_count = 1 result
> > +'
> > +
> > +test_expected_success 'cover letter with author and count' '
> 
> Has this test been run successfully?  It is unsual that only one
> among several you are adding has this typo.

Sorry, didn't notice. I saw no red tests and assumed it was workig when
it didn't even run.

Will fix
