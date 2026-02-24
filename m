Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54152366DD3
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922515; cv=none; b=K5joWuvJmhF9KSeS0qvIELUye3s9DP3EMVfVDf3T6Q2km1NMOYDbJV3XewYpVWda3Crql5IR0zl3OdmVXS60c3TniVxcbWTOkJZ58owSUl04yPkfT7r0atOZjMjnn4hW3UcNiB8luZc/TRiGtR9Hths+7ScB9cWnPDgUd6u2oDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922515; c=relaxed/simple;
	bh=Z5v0PPYNP/hBWDo9rlSq6JTdbO9a/dak8zQdpNM5Taw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKqS8rP1Hyvheh9ZICllH1clpg68PCdkGaiqczkB0Eam5C6RqAifSle6g25YKBpKVHSaFPf0Mms6UMZmfzywkbo22UbE0zYSWZ+RnxVCZX6DxkfXnX3onVPMi/6sfQ20pJtgYjQwC2Ofygy64ANNB23mBJ++iLOWUM3EcC9gJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gpaf7AHm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gpaf7AHm"
Received: (qmail 59458 invoked by uid 109); 24 Feb 2026 08:41:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z5v0PPYNP/hBWDo9rlSq6JTdbO9a/dak8zQdpNM5Taw=; b=gpaf7AHmZ/G3x1U3oRObejqas4AjX7dTt/kqIj+2mo3nHUxHi1nX4VY1RDzlwzp7wZtS/uo2Cjpw+ypR3XFnnhV34XSZzE3ZoqM+UIh8EXTA875ukFnshW5Ul0rQTrZYRcVq1UuSDD0vqwmO+QRMvXZLRbeYJ2x8WvcbV+n1tjy2Av0EPXTV+n8KCPI+bnw7aNX9oYPtUVQvZm88o2FOH+soC+P3m5tw9xNwkDZpWYLUYnzl5IHSGblsAWhLiXtwAfRh9l7f6g2jNlr4CJVU0fhiR1SzTrvMlbucpA4cSgPhXUwheEdIjkv3j+hqn4tJeHO0GF36wTmE4X4ucrMRDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Feb 2026 08:41:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 142318 invoked by uid 111); 24 Feb 2026 08:41:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Feb 2026 03:41:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Feb 2026 03:41:49 -0500
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] pretty.c: fix null pointer dereference
Message-ID: <20260224084149.GA986367@coredump.intra.peff.net>
References: <20260220230633.132213-1-mroik@delayed.space>
 <20260224040400.751247-2-mroik@delayed.space>
 <xmqqcy1uk69o.fsf@gitster.g>
 <aZ1JND7sGspCJEoc@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ1JND7sGspCJEoc@exploit>

On Tue, Feb 24, 2026 at 08:08:35AM +0100, Mirko Faina wrote:

> On Mon, Feb 23, 2026 at 10:25:07PM -0800, Junio C Hamano wrote:
> > Interesting.
> > 
> > Are any of the existing calls to this function that passes
> > CMIT_FMT_USERFORMAT trigger a segfault with certain condition?
> > 
> > For example, there are only two places where CMIT_FMT_USERFORMAT is
> > assigned to something.  One is save_user_format() where user_format
> > gets a non NULL string before rev->commit_format gets assigned
> > CMIT_FMT_USERFORMAT.  Another is git_pretty_formats_config() that
> > parses configuration variables "pretty.*" and populate
> > commit_formats map.  This is later used in get_commit_format() and
> > that function always calls save_user_format() we just saw when the
> > format used is CMIT_FMT_USERFORMAT.  So the existing code paths seem
> > to be safe by design.
> > 
> > What I am wondering is if a NULL user_format should be flagged as a
> > programming error, instead of getting swept under the rug like this
> > patch does.  IOW,
> > 
> > 	int commit_format_is_empty(enum cmit_fmt fmt)
> > 	{
> > 		if (fmt != CMIT_FMT_USERFORMAT)
> > 			return 0;
> > 		if (!user_format)
> > 			BUG("never called save_user_format() and using USERFORMAT?");
> > 		return !*user_format;
> > 	}
> 
> This doesn't convince me, I think it is a bug. If dereferencing NULL was
> done on purpose why not use die() instead? Also, the only way for us to
> check user_format is through commit_format_is_empty() as it is static.
> In a complex config setup it might be useful to double check just to be
> sure, and I wouldn't want the program to crash on a failed check.
> 
> save_user_format() is not available neither, so evaluation of the format
> string has to be done through get_commit_format(). If I pass any of the
> predefined formats (CMIT_FMT_*) get_commit_format() won't set
> user_format. So the only way for us to check if it was set is through
> commit_format_is_empty() (well technically there's
> rev_info->commit_format but it still doesn't feel like it was
> intentional).
> 
> But if the intended behaviour was for the program to crash then I take
> issue with the name.

I am not quite sure what you are asking. No, the intent of that function
is not to crash. It is to check whether the user passed us an empty
string. Like the "git diff-tree --format= $commit" example given
in the commit message of b9c7d6e433 (pretty: make empty userformats
truly empty, 2014-07-29). If they did, then the first character of the
string will be the NUL terminator.

So dropping the "*" as your patch 1/3 does is just wrong. It is losing
the check for an empty string and replacing it with a check for a NULL
pointer.

The user_format string should never be NULL if we are using
CMIT_FMT_USERFORMAT. That's not checked for explicitly here, but is an
assumption of the pretty.c code. If there's some way to violate that
assumption, that's a bug (but it sounds from digging that there isn't).

If you have _new_ code which is using CMIT_FMT_USERFORMAT without
setting user_format to a non-NULL value, we might need to work around
that assumption. But I think what your 2/3 is doing is not quite at the
right level, which is the source of the trouble. I'll respond separately
to that patch.

-Peff
