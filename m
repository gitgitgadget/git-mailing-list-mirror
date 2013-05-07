From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: another packed-refs race
Date: Tue, 07 May 2013 06:32:12 +0200
Message-ID: <518883CC.7050609@alum.mit.edu>
References: <20130503083847.GA16542@sigill.intra.peff.net> <51879C1C.5000407@alum.mit.edu> <20130506184122.GA23568@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 06:32:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZZh-0007S6-E8
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658Ab3EGEcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:32:18 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53487 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759650Ab3EGEcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 00:32:16 -0400
X-AuditID: 12074413-b7f226d000000902-95-518883cf508b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.03.02306.FC388815; Tue,  7 May 2013 00:32:15 -0400 (EDT)
Received: from [192.168.69.140] (p57A24E33.dip0.t-ipconnect.de [87.162.78.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r474WCf6018036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 May 2013 00:32:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130506184122.GA23568@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqHu+uSPQYM5mfouuK91MFvPu7mKy
	+NHSw+zA7HHp5Xc2j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOeH1iE1PBbu2KjtXTmBoY
	9yp1MXJySAiYSMx93s4CYYtJXLi3nq2LkYtDSOAyo8TSZWvYIZyzTBKnF7xhBKniFdCWOHDj
	GROIzSKgKjF53gwwm01AV2JRTzOYLSoQJrFq/TJmiHpBiZMzn4BtEBGQlfh+eCPYHGYBK4lV
	V9pYQWxhoDkTl02AWtbJKHFv63J2kASngLXE+bdXgIZyADWoS6yfJwTRKy+x/e0c5gmMArOQ
	rJiFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCHBK7yDcddJ
	uUOMAhyMSjy8CqfaA4VYE8uKK3MPMUpyMCmJ8k5u6ggU4kvKT6nMSCzOiC8qzUktPsQowcGs
	JMIrrQ2U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8M4BGSpYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPZeBmnnLS5IzAWKQrSeYtTl
	WHnlyWtGIZa8/LxUKXHeNSBFAiBFGaV5cCtgqeoVozjQx8K8W0GqeIBpDm7SK6AlTEBLEvja
	QZaUJCKkpBoYGVqcq+cofJ6t8KTw5K9TepL8s27mGT5OWpXpZZH2/dp5ew7W10G7P149oXZx
	44dN9fOadqYaPP/f1PKiVuqBTJ1jYfHvSYxb01QsJXaGyD47s8bk37qiz5r7lgYk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223539>

On 05/06/2013 08:41 PM, Jeff King wrote:
> On Mon, May 06, 2013 at 02:03:40PM +0200, Michael Haggerty wrote:
> [...]
>> The loose refs cache is only used by the for_each_ref() functions, not
>> for looking up individual references.  Another approach would be to
>> change the top-level for_each_ref() functions to re-stat() all of the
>> loose references within the namespace that interests it, *then* verify
>> that the packed-ref cache is not stale, *then* start the iteration.
>> Then there would be no need to re-stat() files during the iteration.
>> (This would mean that we have to prohibit a second reference iteration
>> from being started while one is already in progress.)
> 
> Hmm. Thinking on this more, I'm not sure that we need to stat the loose
> references at all. We do not need to care if the loose refs are up to
> date or not. Well, we might care, but the point here is not to pretend
> that we have an up-to-date atomic view of the loose refs; it is only to
> make sure that the fallback-to-packed behavior does not lie to us about
> the existence or value of a ref.
> 
> IOW, it is OK to come up with a value for ref X that was true at the
> beginning of the program, even if it has been simultaneously updated.
> Our program can operate as if it happened in the instant it started,
> even though in real life it takes longer. But it is _not_ OK to miss the
> existence of a ref, or to come up with a value that it did not hold at
> some point during the program (e.g., it is not OK to return some cruft
> we wrote into the packed-refs file when we packed it three weeks ago).

This all sounds correct to me.

Another potential problem caused by the non-atomicity of loose reference
reading could be to confuse reachability tests if process 1 is reading
loose references while process 2 is renaming a reference:

1. Process 1 looks for refs/heads/aaaaa and finds it missing.

2. Process 2 renames zzzzz -> aaaaa

3. Process 1 looks for refs/heads/zzzzz and finds it missing.

Process 2 would think that any objects pointed to by aaaaa (formerly
zzzzz) are unreachable.  This would be unfortunate if it is doing an
upload-pack and very bad if it is doing a gc.  I wonder if this could be
a problem in practice?  (Gee, wouldn't it be nice to keep reflogs for
deleted refs? :-) )

> That is a weaker guarantee, and I think we can provide it with:
> 
>   1. Load all loose refs into cache for a particular enumeration.
> 
>   2. Make sure the packed-refs cache is up-to-date (by checking its
>      stat() information and reloading if necessary).
> 
>   3. Run the usual iteration over the loose/packed ref caches.

This sounds reasonable, too, though I'll need some more time to digest
your suggestion in detail.

> [...]
>> Of course, clearing (part of) the loose reference cache invalidates any
>> pointers that other callers might have retained to refnames in the old
>> version of the cache.  I've never really investigated what callers might
>> hold onto such pointers under the assumption that they will live to the
>> end of the process.
> 
> My proposal above gets rid of the need to invalidate the loose refs
> cache, so we can ignore that complexity.

The same concern applies to invalidating the packed-ref cache, which you
still want to do.

>> Given all of this trouble, there is an obvious question: why do we have
>> a loose reference cache in the first place?  I think there are a few
>> reasons:
>>
>> 1. In case one git process has to iterate through the same part of the
>> reference namespace more than once.  (Does this frequently happen?)
> 
> I'm not sure how often it happens. There are a few obvious candidates if
> you "git grep 'for_each[a-z_]*ref'", but I'm not sure if the actual
> performance impact is measurable (the cache should be warm after the
> first run-through).
> 
>> 2. Reading a bunch of loose references at the same time is more
>> efficient than reading them one by one interleaved with other file
>> reads.  (I think this is a significant win.)
> 
> Makes some sense, though I don't recall whether it was ever measured.

I think I measured it once and found it a significant benefit, though I
can't remember whether this was with a warm cache or only with a cold cache.

In fact, I experimented with some other strategies for loose reference
loading for performance reasons.  Currently loose references are read
into the cache lazily, one directory at a time.  I experimented with
changes in both directions:

* Preloading the whole tree of loose references before starting an
iteration.  As I recall, this was a performance *win*.  It was on my
to-do list of things to pursue when I have some free time (ha, ha).  I
mostly wanted to check first that there are not callers who abort the
iteration soon after starting it.  For example, imagine a caller who
tries to determine "are there any tags at all" by iterating over
"refs/tags" with a callback that just returns 1; such a caller would
suffer the cost of reading all of the loose references in "refs/tags".

* Lazy loading loose references one reference at a time.  The ideas was
that this would allow the reference cache to be used for
single-reference lookups.  This change alone caused a significant
performance loss, so it would have had to be combined with code for
preloading directories or subtrees before a for_each_ref() iteration.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
