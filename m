Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBA155A26
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519164; cv=none; b=oLs6dK0yoaePW88AaDhiEo2Yfbz0ZfYtYIvh52GKfugKT5ukVCSEUtQq4pf9AdXYkoDWo9ao9U81bcjJqAXzRhEvodlTUb2NjsVk60QXiAdFvN6uFNfNRXuEhjhOZcrY5JSXoZmP3Z6cALTg2RZ/k3mF5xwPUQuWNiyBQtqvWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519164; c=relaxed/simple;
	bh=CDJ3Nj9zR0hAnlIrNS5HQoKpMGkZOgoceozRx91cxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOXwITpSZowVGgukCuJc3eof9ioi6Xjn1PHBrBomrregp9iroo7MaKkVqndW8L7wK1NN3U/aiZ0dnnKHECbRsBfWw4OwWVoYgiQvPjKKFhYVt/R/6VMMACP3kxKiul2S80b9/M0ziu8cFeAMGp86osKjYzE2HoGnqwBpn7+1aLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24632 invoked by uid 109); 9 Jul 2024 09:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jul 2024 09:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31667 invoked by uid 111); 9 Jul 2024 09:59:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 05:59:11 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 05:59:13 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/push: call set_refspecs after validating remote
Message-ID: <20240709095913.GA966429@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240708233220.GA934035@coredump.intra.peff.net>
 <CAOLa=ZTDhXfh3rW8mcv7N51psRZ-k_w+vfFe7Hc4a5OE4O42TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTDhXfh3rW8mcv7N51psRZ-k_w+vfFe7Hc4a5OE4O42TQ@mail.gmail.com>

On Tue, Jul 09, 2024 at 05:05:58AM -0400, Karthik Nayak wrote:

> >> +test_expect_success 'detect empty remote' '
> >> +	test_must_fail git push "" main 2> stderr &&
> >> +	grep "fatal: bad repository ''" stderr
> >> +'
> >
> > The test makes sense. Your single-quotes are not doing what you expect,
> > though (they are closing and re-opening the outer test body, so end up
> > as the empty string). You can use $SQ$SQ instead (I'm also working on
> > patches to allow you to specify the body as a here-doc to avoid exactly
> > this kind of situation, but I don't think we should depend on that yet).
> 
> Good catch. I'm wondering how it worked though, since I wrote the test
> before the fix and used the test to validate the failure and the fix.

You end up grepping for the sub-string "fatal: bad repository ",
which still matches. It's just not quite as careful as what you
intended.

-Peff
