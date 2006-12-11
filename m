X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: 10 Dec 2006 22:40:18 -0500
Message-ID: <20061211034018.16937.qmail@science.horizon.com>
NNTP-Posting-Date: Mon, 11 Dec 2006 03:40:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33974>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtc1l-0003Ud-JX for gcvg-git@gmane.org; Mon, 11 Dec
 2006 04:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762381AbWLKDkU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 22:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759871AbWLKDkU
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 22:40:20 -0500
Received: from science.horizon.com ([192.35.100.1]:15070 "HELO
 science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1762381AbWLKDkT (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 22:40:19 -0500
Received: (qmail 16938 invoked by uid 1000); 10 Dec 2006 22:40:18 -0500
To: koreth@midwinter.com
Sender: git-owner@vger.kernel.org

>>> I posted separately about those. And I've been mulling about whether
>>> the thundering herd is really such a big problem that we need to
>>> address it head-on.
>>
>> Uhm... yes it is.
> 
> Got some more info, discussion points or links to stuff I should read
> to appreciate why that is? I am trying to articulate why I consider it
> is not a high-payoff task, as well as describing how to tackle it.
> 
> To recap, the reasons it is not high payoff is that:
>
>  - the main benefit comes from being cacheable and able to revalidate
>    the cache cheaply (with the ETags-based strategy discussed above)
>  - highly distributed caches/proxies means we'll seldom see a true
>    cold cache situation
>  - we have a huge set of URLs which are seldom hit, and will never see
>    a thundering anything
>  - we have a tiny set of very popular URLs that are the key target for
>    the thundering herd - (projects page, summary page, shortlog, fulllog)
>  - but those are in the clear as soon as the caches are populated
> 
> Why do we have to take it head-on? :-)

I think I agree with you, but not as strongly.  Certainly, having any
kind of effective cacheing (heck, just comparing the timestamp of the
relevant ref(s) with the If-Modified-Since: header) will help kernel.org
enormously.

But as soon as there's a push, particularly a release push, that
invalidates *all* of the popular pages *and* the thindering herd arrives.

The result is that all of the popular "what's new?" summary pages get
fetched 15 times in parallel and, because the front end doesn't serialize
them, populating the caches can be a painful process involving a lot of
repeated work.

I tend to agree that for the basic project summary pages, generating them
preemptively as static pages out of the push script seems best.
("find /usr/src/linux -type d -print | wc -l" is 1492.  Dear me.
Oh!  There is no per-directory shortlog page; that simplifies things.
But there *should* be.)

The only tricky thing is the "n minutes/hours/days ago" timestamps.
Basically, you want to generate a half-formatted, indefinitely-cacheable
page that contains them as absolute timestamps, and a have system for
regenerating the fully-formatted page from that (and the current time).

The ideas that people have been posting seem excellent.  Give a page
two timeouts.  If a GET arrives before the first timestamp, and no
prerequisites have changes, it's served directly from cache.  If it
arrives after the second timeout, or the prerequisites have changed,
it blocks until the page is regenerated.  But if it arrives between
those two times, it serves the stale data and starts generating fresh
data in the background.

So for the fully-formed timestamps, the first timeout is when the next
human-readable timestamp on the page ticks over.  But the second timeout
can be past that by, say, 5% of the timeout value.  It's okay to display
"3 hours ago" until 12 minutes past the 4 hour mark.

It might be okay to allow even the prerequisites to be slightly stale when
serving old data; it's okay if it takes 30 seconds for the kernel.org
web page to notice that Linus pushed.  But on my office gitweb, I'm not
sure that it's okay to take 30 seconds to notice that *I* just pushed.
(I'm also not sure about consistency issues.  If I link from one page
that shows the new release to another, it would be a bit disconcerting
if it disappeared.)


The nasty problem with built-in cacheing is that you need a whole cache
reclaim infrastructure; it would be so much nicer to let Squid deal
with that whole mess.  But it can't deal with anything other than fully
