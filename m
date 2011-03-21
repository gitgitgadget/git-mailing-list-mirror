From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Mon, 21 Mar 2011 11:39:44 -0700
Message-ID: <4D879B70.8070405@eaglescrag.net>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <201103210120.50337.jnareb@gmail.com> <4D86B968.9030304@eaglescrag.net> <201103211701.01785.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k1h-0008CR-4Q
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1CUSkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:40:20 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48605 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab1CUSkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:40:19 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2LIdiZ5014971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 21 Mar 2011 11:39:44 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <201103211701.01785.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 21 Mar 2011 11:39:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169639>

On 03/21/2011 09:01 AM, Jakub Narebski wrote:
> On Mon, 21 Mar 2011 at 03:35, J.H. wrote:
>> On 03/20/2011 05:20 PM, Jakub Narebski wrote:
>>> On Sun, 20 Mar 2011, J.H. wrote:
>>>
>>>>> With this feature enabled, all timestamps are shown in the local
>>>>> timezone instead of GMT.  The timezone is taken from the appropriate
>>>>> timezone string stored in the commit object.
>>>>
>>>> I'd argue there are two types of "local" time that anyone using gitweb
>>>> would be looking for (particularly if this is called local time)
>>>>
>>>> 1) Time Local to the observer:  Specifically I don't care where every
>>>> other commit has taken place, I want to know what time it was in my
>>>> preferred time zone (local time zone likely)
>>>
>>> This can be done only via JavaScript, otherwise how would you get user's
>>> timezone?  Well, you could specify timezone via a form, save it in
>>> a cookie and do conversion to timezone from cookie on server... but this
>>> means more code, and would screw up with output caching if/where 
>>> implemented.
>>
>> I think this would screw up less caching vs. more caching w/ Javascript.
>> Without doing this with Javascript having any hard coded timezone like
>> what's proposed here is bad, particularly if for some reason two people
>> can select different time zones for whatever reason (not an unreasonable
>> extension of what's been proposed)
> 
> First, it would complicate caching, as output would depend not only purely
> on URL, but can also depend on cookies.  Cache key would have to take it
> into account.
> 
> Second, it would reduce effectiveness of cache, as single page would have
> to have multiple versions (up to 24, one per timezone, I guess).

The implementation I have running in the back of my head would be
completely independent, so I'm not sure what implementation you are
thinking of that would cause this.  One of the reasons I'm suggesting
Javascript at all is to avoid exactly this problem.

>>>> 2) Time local to the project:  There will be instances where a project
>>>> is based in a specific time zone (home office perhaps?) and you will
>>>> want to see the commits from that perspective.
>>>
>>> Kevin's patch assumes that geographically concentrated project means all
>>> or almost all commits are generated "in office" and use the same timezone,
>>> which is a timezone of a project.
>>>
>>> Currently there is no way to specify _project_ timezone.  Perhaps instead
>>> of 'localtime' feature, which since v2 means also per-project 
>>> `gitweb.localtime' configuration variable, we would allow for 
>>> `gitweb.timezone' configuration variable, which can be "gmt", "utc", or
>>> "localtime" (meaning local to author / committer / tagger).
>>>
>>> What do you think?
>>
>> Not specifically thinking of setting a per-repo timezone, when I was
>> thinking of "project" I was thinking of the entire gitweb install (I.E.
>> git.kernel.org as a project or pkgs.fedoraproject.org or drupal.org as a
>> project)
> 
> Well, if we are doing it on server side, then by having 'timezone' feature
> rather than 'localtime' one from Kevin patches, we would have per-repo
> configuration "for free".

Doing it on the server overly complicates things, breaks web caches,
gitweb-caching and generally I'd argue is not what we want.  It would
work for small installations, in particular those not using
gitweb-caching, but honestly this is a useful enough feature for a more
distributed audience it needs to work with gitweb-caching, without
putting undue burden on the caching engine (as a whole).  Javascript is
the obvious, and simple answer to that.  Won't add any substantial
complexity to the backend, and will allow for more complex choices and
instant changes (without involving the backend at all).

That pretty much sounds like a win to me anyway...

>> I would think, if we are doing this in JavaScript, that this is an over
>> complication to do on a per-repo basis.  I would guess setting a generic
>> default and letting people deviate makes more sense.  Just my thought
>> anyway, but I think there's a lot of extra per-repo configurations that
>> add complexity with minimal gain.
> 
> It it is set _by client_, then of course it doesn't make much sense to
> make it configurable per-repository.  Besides it would be difficult to
> implement and store in JavaScript, I think.

Cookies solve the problem, and those are basically trivial to deal with
in Javascript.

> Per-repository settings makes sense for _server-side_; different 
> repositories may have different character: some might be geographically
> distributed, some might have all contributors in single timezone.

Agreed, since I've been arguing for the client side work, I think we are
on the same page here.

> [...]
>>>> Basically the change would leave things alone should this be disabled
>>>> (you are already doing this, which is good), however should this be
>>>> enabled a couple of minor things change:
>>>>
>>>> 	1) By default gitweb will continue to display things in UTC.
>>>> 	   This is a good fallback, and a reasonably safe thing to do
>>>> 	   should someone have JavaScript disabled.  The reality is
>>>> 	   most users with it disabled will know or understand what to
>>>> 	   do with UTC times
>>>>
>>>> 	2) Keep the original TZ marked in the html, somewhere hidden on
>>>> 	   the page is fine
>>>
>>> We can use what microformats use for date, i.e. 1997-07-16T19:20:30+01:00
>>> or 1997-07-16T19:20:30+0100, in 'date' or 'title' attribute (with 
>>> appropriate microformat class)... or we can use raw git date, i.e. epoch
>>> plus numerical timezone.
>>
>> Well we already have the time in the html, it's just the original TZ
>> that would need to get added.  Though it's still likely easier to store
>> the timestamp + tz than use the microformats in the JS.
> 
> I agree that epoch + timezone should be easier to manipulate in JavaScript
> than ISO-8601 or similar format... I think.  Note that at least with epoch
> timezone is necessary only if you want to display date in author etc. zone;
> if you want to use client (web browser) timezone, it is not necessary.
> 
> Note that _where and how_ timestamp is stored for JavaScript manipulation
> would become gitweb API as much as its links are.  I wonder if HTML5 says
> anything on attribute values used for machine-readable data; microformats
> site says that using "title" for non human-readable stuff is deprecated
> for accessibility reasons.

I wouldn't entirely agree with that.  While I'd say sticking the hidden
data into a commonly accepted and suggested place would be ideal,
looking back over the wonderful world of Javascript indicates it's a
giant messy jungle as ever.  Since what I'm also thinking will be just
about completely independent of the backend, I wouldn't call what I'm
doing / suggesting here an API, and in particular one I would not
declare as externally usable - I.E. if we have to change this to be more
compliant in a year or two (particularly once microformats are more
generally agreed upon) I don't think it would break anyone or anything.

That said from what I can find of microformats (today) the most widely
agreed upon date formatting is either to use a full hCalendar (this
would be completely unweildly and if that's the "right" way to do it, I
would suggest we ignore it), or to use a date time element, of which
there are no specific ones for commit / applied / etc (I see no reason
why we can't just start using them to define the standard fundamentally)

<span class="dtcommit" title="YYYY-MM-DDTHH:MM:SSZ"></span>

or

<span class="dtcommit">
	<abbr class="value" title="2011-03-11">March 21st, 2011</abbr>
	<span class="value"> 18:30 </span>
</span>

But to be clear all that is currently accpeted (as far as I can tell)
for microformats with respect to this are dtstart (to specify the start
of an event, more specifically like I'm having a party at dtstart) and
dtend - when the event ends.  There, as far as I can tell, isn't the
idea of a single point microformat which would be more useful to us, and
doing the start/end properly would bloat the page a lot (for index pages
it would be substantial)

Also keeping in mind that miroformats are almost explicitly for the
benefit of search engines, which I'm not sure if a majority of gitweb
installations care about, it may not be worthwhile to actually go down
that road.

>>> Note that JavaScript mangling of dates is quite independent on whether
>>> dates are displayed in GMT/UTC or in author / committer / tagger timezone
>>> like for current 'localtime' feature.
>>
>> I wasn't intending to change the current formatting of the times we have
>> in place currently.  Just allowing people to change what time was being
>> displayed.
> 
> I wanted to say that JavaScript post-processing of dates is a bit 
> orthogonal to David's server-side localtime (or similar) feature.

It's a different direction, yes, but it's definitely not orthogonal.  If
you do this on the server side, as David originally suggested, you can
create a mess in other places (external proxies, external web caches,
gitweb-caching, etc).  I like his idea, just not where it's implemented
at current.  If you leave the server side alone, and deal with the
processing of the dates on the client side you alleviate all of the
server side gotchas, while only introducing one or two gotchas to the
client side.

This isn't an orthogonal discussion, it's a discussion of where the
right place / right solution to accomplish the same goal is.

>>>> 	3) Once a page is loaded attempt to execute the Javascript,
>>>> 	   which will just cycle through the page and update the Date /
>>>> 	   Times based on a set of possible (though user choosable
>>>> 	   options):
>>>> 		- Local Time (could easily default to this and
>>>> 		  JavaScript can detect that from the browser)
>>>> 		- Specific Timezone
>>>> 		- Default / UTC
>>>> 		- Original Timezone (from author / commit)
>>>
>>> Hmmm... we could also automatically update relative dates to reflect
>>> passing of time ;-)
>>
>> Yup, which could also go into changing the "22 minutes ago" kind of
>> stuff in real time (beyond just dates).  Bonus to cached pages.
> 
> ...though this should probably made it into separate commit.

I'd agree.

- John 'Warthog9' Hawley
