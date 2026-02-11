Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC4469D
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801218; cv=none; b=FvNvmnyHm20zTK0HreBrMCn/G4YzS6JWmk6r/3ZClToZDNZvBfARWfSBqfh5L0aTGDn9UuD9Cl8cR2n85zfaWnkCe+vD7cEbthTkg4GgyhyOUH/Mh/tJA1QRpkY1U+ErKWMSYwK7kkd9u0GEnbV2dw1Za1uaBCgmC1dEfykX0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801218; c=relaxed/simple;
	bh=NVUKfcHE3HqP4hwmYWXH/fjntFy+r6tM6Jh7x+sdjL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K53OD5P3S+gwScmNMXF+lxVOYYubyqOdBFRZIOIwebOGRCMELBKfRQvUtHE+lZlCo94mk3+ztC6ChacQJzwZKSVGK1q1MfKrpWaeJ6KFZBLR1UpvrLak4YqKmjA/Hn2FTNsuGGUDXiXg51wqudxh52Bz0zubFbrQuS8pcZh+A1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dyG1KLg7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dyG1KLg7"
Received: (qmail 13195 invoked by uid 109); 11 Feb 2026 09:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NVUKfcHE3HqP4hwmYWXH/fjntFy+r6tM6Jh7x+sdjL0=; b=dyG1KLg7luYKpL6DVag24zTGEIgNWtjFZ2Vb/OL3xVZeDXCkQmlTTFbvXRb7rJ4OSqkIorYTOhZUxm5iOGmxGOhRuk3BUvYgUddhBBFInVyGquTi1J7zD4/FXck54qWC3+vVo0g43PHOTd0LJaWF4EhYuOEIjVuSBaTsGwBytbX91NS8p5QGs2RIeiwMeAm/Gi7ag0CxK6Ela46QImvWBwS03KtbEGABwyRZ9Jkc0TwprMO8pElBZKUo6PTSuitNaGmbNYty5X2l/yrpz8Z/Af0jozzQL6oCxl9qk4Xzafjl8YuLXxNTlzCMyHOJMu3e4tKSBuqpA2ZvQriXQ+7ZOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Feb 2026 09:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21540 invoked by uid 111); 11 Feb 2026 09:13:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Feb 2026 04:13:39 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Feb 2026 04:13:33 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
Message-ID: <20260211091333.GA1868492@coredump.intra.peff.net>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
 <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
 <aYvV2W5pcvqZig8S@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYvV2W5pcvqZig8S@nand.local>

On Tue, Feb 10, 2026 at 08:05:29PM -0500, Taylor Blau wrote:

> > diff --git a/http-push.c b/http-push.c
> > index 60a9b75620..ddb9948352 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -716,6 +716,10 @@ static int fetch_indices(void)
> >  	case HTTP_MISSING_TARGET:
> >  		ret = 0;
> >  		break;
> > +	case HTTP_RATE_LIMITED:
> > +		error(_("rate limited by '%s', please try again later"), repo->url);
> > +		ret = -1;
> > +		break;
> >  	default:
> >  		ret = -1;
> >  	}
> > @@ -1548,6 +1552,10 @@ static int remote_exists(const char *path)
> >  	case HTTP_MISSING_TARGET:
> >  		ret = 0;
> >  		break;
> > +	case HTTP_RATE_LIMITED:
> > +		error(_("rate limited by '%s', please try again later"), url);
> > +		ret = -1;
> > +		break;
> 
> I wonder if there is an opportunity to DRY this up a bit? I think the
> case in fetch_indices() is very similar to remote_Exists(), and ditto
> for fetch_indices() in the http-walker.c code.

IMHO it is not worth trying to clean up http-push here. It's the dumb
push-over-webdav implementation that nobody uses. I'd actually be happy
to see it ripped out, but am too lazy to go through the effort of a big
deprecation period myself.

So I would actually consider not touching this code at all, and letting
it continue to behave as it did before (returning -1 and not producing
any specialized message). Though I suppose in remote_exists() we'd fail
to even print the curl error anymore, which would be a regression.

Ditto for http-walker.c's fetch_indices() function. It is used only for
dumb-http fetches (which are forbidden by most forges). And if not
touched at all, it would continue to function in the same way (not
producing any specialized message).

> As a separate but related note, I don't know if this function properly
> handles header continuations for Retry-After headers, but in practice I
> suspect it doesn't matter, as servers should not be continuing
> Retry-After headers across multiple lines.

Yeah, I noticed that, too. And all of the parsing actually makes me
nervous. Surely curl can do some of this for us?

...studies some manpages...

Ah, indeed. How about:

  curl_off_t wait = 0;
  curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER, &wait);

You can see how we already dig out similar info in finish_active_slot().
And more extended (but optional) info in http_request(). It looks like
CURLINFO_RETRY_AFTER was added in 7.66.0, so this would have to be a
conditional feature at build-time. But that seems like a reasonable
trade-off.

  Side note: the obvious question is why we need fwrite_wwwauth() in the
  first place. And the answer is that curl does not provide structured
  access to the information from those headers. It does make me wonder
  if we could be using curl_easy_header() to get rid of all of this
  manual parsing and continuation code. That was introduced in 7.83.0,
  which would again make it conditional. But it seems like a nicer path
  forward for us. Anyway, way out of scope for this patch.

> > @@ -1660,44 +1729,98 @@ void run_active_slot(struct active_request_slot *slot)
> [...]
> > -	while (!finished) {
> > +	while (waiting_for_delay || !finished) {
> > +		if (waiting_for_delay) {
> > +			gettimeofday(&current_time, NULL);
> > +			elapsed_time.tv_sec = current_time.tv_sec - start_time.tv_sec;
> > +			elapsed_time.tv_usec = current_time.tv_usec - start_time.tv_usec;
> > +			if (elapsed_time.tv_usec < 0) {
> > +				elapsed_time.tv_sec--;
> > +				elapsed_time.tv_usec += 1000000;
> > +			}
> > +
> > +			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
> > +				slot->retry_delay_seconds = -1;
> > +				waiting_for_delay = 0;
> > +
> > +				if (slot_not_started)
> > +					return;
> 
> I wonder if run_active_slot() is the right place for these changes or if
> it should be handled separately. I think it may be somewhat surprising
> for run_active_slot() to return without actually running the slot, even
> if the slot is marked as "active" but just waiting for a delay.

Yeah, I agree. The point of run_active_slot() is to run the slot to
completion (I think; it has been a while since I've had to dig into any
of this). So I'd either expect it to handle the retry and delay itself
internally, or to return the failed request to the caller, who will then
delay and initiate the retry.

That's all assuming we're making one request at a time (which I think is
mostly all that run_active_slot() handles). There's a much more
complicated question when we have multiple simultaneous requests, which
we'd do only with the dumb protocol (trying to fetch multiple objects at
once). In that case we need to be queuing requests. And I _think_ that
might be what this code is trying to do. But I'm not sure if it would
actually work, as we try to advance those via step_active_slots().

> OTOH, like I mentioned earlier, I am far from an expert in this part of
> the code, so perhaps this is totally OK. shortlog says that Peff (CC'd)
> is among the most active contributors to this file in the past year, so
> I'll be curious what he thinks as well.

Most of the details of this active slot stuff have long been paged out
of my memory. It's all _so_ messy because of the desire for the
dumb-http code to handle multiple requests. But for smart-http (and I
would be perfectly content for this feature to only apply there), we
could probably just focus on run_one_slot(), I'd think.

I.e., what I'd expect the simplest form of the patch to look like is
roughly:

  - teach handle_curl_result() to recognize 429 and pull out the
    retry-after value, returning HTTP_RETRY

  - in run_one_slot(), recognize HTTP_RETRY and if appropriate, sleep
    and retry

I do wonder if even that might be too low-level, though. For a real
large request, we'll be streaming data into the request, and I'm not
sure we _can_ retry. We send a probe_rpc() first in that case to try to
resolve issues like credential-filling. But there's nothing to say that
we can't get a 200 on the probe and a 429 on the real request.

Which I guess implies to me that http_request_reauth() should be where
the magic happens. And it somewhat does in this patch, but...why not do
the sleeping there, and why push it all the way down into
run_active_slot()?

I know I'm kind of talking in circles here, which is indicative of my
confusion (and the general complexity of the http code). But as the
patch stands, I'm not really convinced which cases it is trying to cover
(single requests vs multi, repeatable requests vs streaming POSTs), how
well it covers them, and that it is doing it as simply as possible (or
at least keeping the logic together).

> > @@ -518,21 +529,25 @@ static struct discovery *discover_refs(const char *service, int for_push)
> >  	case HTTP_OK:
> >  		break;
> >  	case HTTP_MISSING_TARGET:
> > -		show_http_message(&type, &charset, &buffer);
> > -		die(_("repository '%s' not found"),
> > -		    transport_anonymize_url(url.buf));
> > +		show_http_message_fatal(&type, &charset, &buffer,
> > +					_("repository '%s' not found"),
> > +					transport_anonymize_url(url.buf));
> 
> Thanks for taking my suggestion here as well. I think that the end
> result reads much cleaner, though I do think that introducing the new
> show_http_message_fatal() function and rewriting the existing code
> should happen in a preparatory commit before this one to more clearly
> separate the changes.

Yeah, I had the same thought.

> > diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> > index 5091db949b..8a43261ffc 100644
> > --- a/t/lib-httpd.sh
> > +++ b/t/lib-httpd.sh
> 
> I may solicit Peff's input here on the remainder of the test changes,
> since he is much more familiar with the lib-httpd parts of the suite
> than I am.

The lib-httpd parts looked about as I'd expect (and I found the use of
custom URL components to encode the retry parameters quite clever).

There were lots of uses of "date" that I suspect may give us portability
problems. "+%s" is not even in POSIX, but maybe it is universal enough.
But stuff like '-d "+2 seconds"' seems likely to be a GNU-ism.

Using "test-tool date" might get around some of that. We even understand
relative dates like "2 seconds ago", but I think only in the past. :-/
So you'd probably have to do:

  now=$(test-tool date timestamp now | cut -d' ' -f3)
  then=$((now + 2))
  test-tool date show:rfc2822 $then

or something.

-Peff
