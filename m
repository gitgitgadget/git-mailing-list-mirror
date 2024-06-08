Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591625761
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838938; cv=none; b=NHqnYy5//SYgVIv5yykVxoDELAlvueb/+p7OdIFFpYw0T7+/LxvIgAnxTqaqmaXQvB6DA+y+az6joD7AzfuPNwabtdYIUn6IYbMerGHAPTqzTwEwtKN+86lq3EO7Ekiv5OdccYS5W4uJTlUohjroY+aY1WrLFlhytFDXg3la44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838938; c=relaxed/simple;
	bh=Su3FsO/kvmCcb+TK/BPRMymUbaPix2DltP5lSAnBtVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHq82jF/zBzGyicyV6pOXipxHOIJ2LWfqxLdiIYX5etojRp9OgvfAjbyIANdD7YJ8AKAiBJgN6AefA6x6D2V0hRKcuGTl8EP3bOYL40WmomDAUoiRVLMF0hKKUN3Mu3q0YRO84Fk822PMY0FZSVBw3Wj48XCNv1TToYCjRnhXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7712 invoked by uid 109); 8 Jun 2024 09:28:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 09:28:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28907 invoked by uid 111); 8 Jun 2024 09:28:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 05:28:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 05:28:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ci: detect more warnings via `-Og`
Message-ID: <20240608092855.GE2390433@coredump.intra.peff.net>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
 <xmqqwmn0eazm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmn0eazm.fsf@gitster.g>

On Fri, Jun 07, 2024 at 01:47:25PM -0700, Junio C Hamano wrote:

> I am not sure how annoying people will find the V=1 output.  It is
> irrelevant that it is in a collapsible section.  What matters is if
> it helps those who *need* to expand that collapsible section to take
> a look, or if it clutteres what they have to wade through.
> 
> When studying a build failure, I rarely found the exact command line
> given by V=1 helpful, but YMMV---while I am not 100% convinced, let's
> take the series as-is, because not losing information may sometimes
> help even when we need to visually filter out extra clutter.

I had the same thought. I have used V=1 for debugging, but usually
debugging Makefile changes locally (i.e., why is my option not being
passed correctly). I don't think I've ever wanted it for a CI run.

And I do think people see the output. It may be in a collapsible section
on the site, but:

  - you'd uncollapse that section if there is a build failure, and now
    your error messages are that much harder to find

  - if you look at the output outside of the site, you'll see the
    uncollapsed sections. And I usually view them in a local pager using
    curl[1].

I guess I won't know until I see it in action, but I have a pretty
strong suspicion that it will be annoying.

-Peff

[1] For the curious, I use the script below to grab the logs from the
    last failed workflow run. It's pretty old, and I won't be surprised
    if there's a less ugly way to do it with the "gh" CLI tool or
    similar these days.

-- >8 --
repo=peff/git
GITHUB_TOKEN=...your.pat.here...

actions() {
  curl -sL \
    -H 'Accept: application/vnd.github.v3+json' \
    -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/repos/$repo/actions/$1"
}

run=$(
  actions runs?status=failure |
  jq -r '.workflow_runs | .[] | .id' |
  head -1
)

actions runs/$run/jobs?per_page=100 |
jq -r '.jobs | .[] | select(.conclusion == "failure") | "\(.id) \(.name)"' |
while read id name; do
  {
    echo "==> $name"
    actions jobs/$id/logs
  } | less '+/not.ok|##\[error\]'
done
