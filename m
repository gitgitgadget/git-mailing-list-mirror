From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sun, 20 Mar 2011 19:35:20 -0700
Message-ID: <4D86B968.9030304@eaglescrag.net>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <4D8681CF.3060005@eaglescrag.net> <201103210120.50337.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 03:35:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Uxx-0006Wp-JL
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 03:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab1CUCf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 22:35:28 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:41940 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1CUCf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 22:35:26 -0400
Received: from voot-cruiser.eaglescrag.net (c-24-4-6-14.hsd1.ca.comcast.net [24.4.6.14])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2L2ZKNc027764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 20 Mar 2011 19:35:21 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <201103210120.50337.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 20 Mar 2011 19:35:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169551>

On 03/20/2011 05:20 PM, Jakub Narebski wrote:
> On Sun, 20 Mar 2011, J.H. wrote:
> 
>>> With this feature enabled, all timestamps are shown in the local
>>> timezone instead of GMT.  The timezone is taken from the appropriate
>>> timezone string stored in the commit object.
>>
>> I'd argue there are two types of "local" time that anyone using gitweb
>> would be looking for (particularly if this is called local time)
>>
>> 1) Time Local to the observer:  Specifically I don't care where every
>> other commit has taken place, I want to know what time it was in my
>> preferred time zone (local time zone likely)
> 
> This can be done only via JavaScript, otherwise how would you get user's
> timezone?  Well, you could specify timezone via a form, save it in
> a cookie and do conversion to timezone from cookie on server... but this
> means more code, and would screw up with output caching if/where 
> implemented.

I think this would screw up less caching vs. more caching w/ Javascript.
 Without doing this with Javascript having any hard coded timezone like
what's proposed here is bad, particularly if for some reason two people
can select different time zones for whatever reason (not an unreasonable
extension of what's been proposed)

>> 2) Time local to the project:  There will be instances where a project
>> is based in a specific time zone (home office perhaps?) and you will
>> want to see the commits from that perspective.
> 
> Kevin's patch assumes that geographically concentrated project means all
> or almost all commits are generated "in office" and use the same timezone,
> which is a timezone of a project.
> 
> Currently there is no way to specify _project_ timezone.  Perhaps instead
> of 'localtime' feature, which since v2 means also per-project 
> `gitweb.localtime' configuration variable, we would allow for 
> `gitweb.timezone' configuration variable, which can be "gmt", "utc", or
> "localtime" (meaning local to author / committer / tagger).
> 
> What do you think?

Not specifically thinking of setting a per-repo timezone, when I was
thinking of "project" I was thinking of the entire gitweb install (I.E.
git.kernel.org as a project or pkgs.fedoraproject.org or drupal.org as a
project)

I would think, if we are doing this in JavaScript, that this is an over
complication to do on a per-repo basis.  I would guess setting a generic
default and letting people deviate makes more sense.  Just my thought
anyway, but I think there's a lot of extra per-repo configurations that
add complexity with minimal gain.

>> The patch itself (as a commit in gitweb) shows the time + TZ (which is
>> somewhat useful), but there is something quite useful about the rest of
>> gitweb only handling a single timezone (GMT/UTC) from the backend (I'll
>> come back to this point), if for no other reason it makes for uniform
>> handling of time overall.
> 
> Single timezone (currently GMT/UTC, perhaps made configurable, perhaps
> made client local via JavaScript) is good to compare dates.  Author local
> time is good to notice "atnight" commits.
> 
> [...]
>>> This change does not affect relative timestamps (e.g. "5 hours ago"),
>>> nor does it affect 'patch' and 'patches' views which already use
>>> localtime because they are generated by "git format-patch".
>>
>> Agreed.
> 
> [...]
>> Ok, while I agree with the use case(s) I think the solution is barking
>> up completely the wrong tree.  My basic complaint is that this is a
>> change that effects the backend and ties the backend to a specific TZ,
>> when this is a front facing / client issue.
>>
>> While I don't always like JavaScript, this is a situation where I think
>> it would be a much better solution than doing some extensive changes to
>> time handling in gitweb.
>>
>> Basically the change would leave things alone should this be disabled
>> (you are already doing this, which is good), however should this be
>> enabled a couple of minor things change:
>>
>> 	1) By default gitweb will continue to display things in UTC.
>> 	   This is a good fallback, and a reasonably safe thing to do
>> 	   should someone have JavaScript disabled.  The reality is
>> 	   most users with it disabled will know or understand what to
>> 	   do with UTC times
>>
>> 	2) Keep the original TZ marked in the html, somewhere hidden on
>> 	   the page is fine
> 
> We can use what microformats use for date, i.e. 1997-07-16T19:20:30+01:00
> or 1997-07-16T19:20:30+0100, in 'date' or 'title' attribute (with 
> appropriate microformat class)... or we can use raw git date, i.e. epoch
> plus numerical timezone.

Well we already have the time in the html, it's just the original TZ
that would need to get added.  Though it's still likely easier to store
the timestamp + tz than use the microformats in the JS.

> Note that JavaScript mangling of dates is quite independent on whether
> dates are displayed in GMT/UTC or in author / committer / tagger timezone
> like for current 'localtime' feature.

I wasn't intending to change the current formatting of the times we have
in place currently.  Just allowing people to change what time was being
displayed.

>> 	3) Once a page is loaded attempt to execute the Javascript,
>> 	   which will just cycle through the page and update the Date /
>> 	   Times based on a set of possible (though user choosable
>> 	   options):
>> 		- Local Time (could easily default to this and
>> 		  JavaScript can detect that from the browser)
>> 		- Specific Timezone
>> 		- Default / UTC
>> 		- Original Timezone (from author / commit)
> 
> Hmmm... we could also automatically update relative dates to reflect
> passing of time ;-)

Yup, which could also go into changing the "22 minutes ago" kind of
stuff in real time (beyond just dates).  Bonus to cached pages.

>> 	   Could easily include the original timestamp / utc if
>> 	   Javascript modifies it.  Easy enough to just automatically
>> 	   store the choice (should one be made) in a cookie in the
>> 	   browser, and give the maintainer of the site and easy way
>> 	   to set a rational default given their specific environment.
>>
>> The obvious advantages:
>> 	- Doesn't give weird data to people behind caching proxies
>> 	- Ability for people working diverse timezones to see things
>> 	  in their local time zone pretty trivially
>> 	- If a site is using gitweb-caching they can take advantage
>> 	  of the feature
>> 	- Won't break bots / scripts that may be crawling the pages or
>> 	  reading the rss feeds (because the timestamps will all be the
>> 	  same assuming it doesn't try to render the javascript)
>>
>> If you are interested I can bang that out tomorrow (shouldn't take
>> long), but I would *MUCH* rather see this done via JavaScript than to
>> muddy up the backend with multiple timezones and such.
> 
> Note that we would have to write this JavaScript code...

I'll mock something up tomorrow.

- John 'Warthog9' Hawley
