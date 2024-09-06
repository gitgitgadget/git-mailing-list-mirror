Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E1158D96
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662046; cv=none; b=M0HmW/wjfZ39e7coLDpXpJsLg8gWEN2sT9UesqFAV0VTYyL1A0lX29zxSiIb15LcIpS8mY39+ap6LP5fT/7vhW7r7833xheUx8Qwetha0wQjRlSafRyD6FEpKAOE+77PBwHlggMzD2FO7ilL3Mj1evL/au7SxpaP8gb9eNpOy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662046; c=relaxed/simple;
	bh=ODohzIRzCkc6GRuHpO2Zk5ZXOW9BxsKa9d49pe+GnT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEy5xY/6mLCDC48JHxUZrzS4tRWbVAb45ZZEN36VxGqAWzr3VFwGipZlgRce4miO8G/S285FHFCeQhifXX8DkX1WQ1V69mPerV+RXZxFjY7w5JNzJCrkL5sRDPwTtF7W8kAZF3GCOnKxguGVw5vL3IeY49bR4C+mEj3RMBW5pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24795 invoked by uid 109); 6 Sep 2024 22:34:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 22:34:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24196 invoked by uid 111); 6 Sep 2024 22:34:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2024 18:34:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Sep 2024 18:34:02 -0400
From: Jeff King <peff@peff.net>
To: Brooke Kuhlmann <brooke@alchemists.io>
Cc: git@vger.kernel.org
Subject: Re: Fix issue with formatting multiple trailer keys
Message-ID: <20240906223402.GA1221600@coredump.intra.peff.net>
References: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF5AE27D-B7CE-4337-B928-6073837218CA@alchemists.io>

On Fri, Sep 06, 2024 at 01:55:46PM -0600, Brooke Kuhlmann wrote:

> ``` 
> git tag --list \
>         --format="%(refname:short) %(taggerdate:short) %(taggername) %(subject) %(trailers:key=Files) %(trailers:key=Duration)"
> ```
> 
> ...I get this output:
> 
> 0.0.0 2024-09-06 Brooke Kuhlmann Version 0.0.0 Files: 1
> Duration: 1
>  Files: 1
> Duration: 1
> 
> 0.0.1 2024-09-06 Brooke Kuhlmann Version 0.0.1 Files: 1
> Duration: 1
>  Files: 1
> Duration: 1
> 
> Notice, when logging trailer information for commits and tags, I get
> unexpected new line characters showing up in the output. I expect to
> see all information printed on the same line without any new lines
> showing up.
> 
> Also, I want to point out that when listing tag trailers, I get the
> "Duration" key showing up twice. I'm not sure if that's related or not
> but seems like very weird behavior.

There are two things going on here:

  1. Some of the trailer options are stored in a global, rather than a
     per-placeholder basis. This includes the list of keys to show. So
     you basically end up with a filter list that includes _both_ keys,
     and that list is used for both %(trailers) items.

     IMHO this is a bug, and I have a patch (which I'll send along with
     the one I mentioned in the other thread) to fix it.

     In the meantime you can work around it by specifying both keys in
     a single invocation, like:

       %(trailers:key=Files,key=Duration)

     Obviously that doesn't work if you don't want them adjacent in the
     final output.

  2. By default, each trailer is terminated with a newline. But you can
     specify your own separator, like so:

       %(trailers:key=Files,key=Duration,separator= )

     See the documentation for the trailers placeholder in "git help
     log". Depending on your trailers, "valueonly" might also be useful
     for this kind of formatting.

-Peff
