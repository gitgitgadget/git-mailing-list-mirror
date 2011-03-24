From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on
 timezone
Date: Thu, 24 Mar 2011 16:04:45 -0700
Message-ID: <4D8BCE0D.3080504@eaglescrag.net>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <1300925335-3212-2-git-send-email-warthog9@eaglescrag.net> <AANLkTincAcVQQtH+T9+K7tyBd0P5S=8YxXpsfrQ=68gE@mail.gmail.com> <201103242119.40214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:05:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2taM-00014u-6f
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934341Ab1CXXEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 19:04:53 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:54782 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933783Ab1CXXEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:04:52 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2ON4joi018155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 24 Mar 2011 16:04:46 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <201103242119.40214.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 24 Mar 2011 16:04:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169952>

On 03/24/2011 01:19 PM, Jakub Narebski wrote:
> On Thu, 24 Mar 2011, Kevin Cernekee wrote:
>> On Wed, Mar 23, 2011 at 5:08 PM, John 'Warthog9' Hawley
>> <warthog9@eaglescrag.net> wrote:
> 
>>> This patch takes the same basic goal, display the appropriate times
>>> in a given timezone, and implements it in Javascript.  This requires
>>> adding / using a new class, dtcommit, which is based on the
>>> dtstart/dtend microformats.  Appropriate commit dates are wrapped in
>>> a span with this class, and a title of the time in ISO8601 format.
>>
>> John,
>>
>> Thanks for coding this up.  I tested it on a couple of different
>> browsers and wanted to share my observations with you.
> 
> I wonder if there is any site that allows to check JavaScript for
> compatibility with different browsers...

Not that I know of, would be useful but probably horrifically
complicated.  When I was doing Javascript and web stuff as my day job,
about half of what you would write were wrappers to work around the
brokenness on various browsers (mostly IE - ohhh IE...)

>> First, the easy stuff:
>>
>> 1) "git am" complains about whitespace violations
> 
> It would be more helpful if you wrote here what are those whitespace
> violations.
> 
>>
>> 2) HH:MM:SS times need zero padding; otherwise you see:
>>
>> Tue, 8 Mar 2011 20:29:9 -0700
> 
> There is even padLeft function in gitweb.js ready to be (re)used...

I'd rather use one that exists than recreate it, probably worth moving
that to common-lib.js, but that is a separate commit.

Sorry about that, didn't notice it in testing (it took me a while to
find one of my local repos with a commit i nthe first 10 minutes or so),
and the documentation I was reading implied that should have been padded.

> [...] 
>> 4) IE6 does not seem to like ISO 8601 format:
>>
>> x = new Date("2011-03-09T03:29:09Z");
>>
>> This sets all fields to NaN.  I suspect that getTime() values
>> (milliseconds since 1970-01-01) are more portable.
> 
> Do you mean using epoch in title attribute, or fallback to parsing
> ISO 8601 UTC format with regexps?

Parsing it with regexps is doable if completely inelegant, that said
this is Javascript...

Looky that MS provides Virtual PC images for compat testing for IE6
http://www.microsoft.com/downloads/en/details.aspx?FamilyID=21eabb90-958f-4b64-b5f1-73d0a413c8ef&displaylang=en

Ok reading through the documentation I can find for MS and their
Date.parse (
http://msdn.microsoft.com/en-us/library/dctx55bc(v=VS7.1).aspx ) and
some quick experimentation:

2011-03-09 - breaks
2011/03/09 - works

2011/03/09T01:01:01  - works, sorta - the hour comes out as 10 vs. 01
2011/03/09 01:01:01  - works, hour is correct
2011/03/09 01:01:01Z - works and seems to get the TZ correct
2011/03/09T01:01:01Z - breaks

Not really sure what the "right" way to fix this is going to end up
being.  Suppose our options are:

1) Try and find a format that is generally accepted and parseable on all
the browsers
2) Declare IE6 an unsupported browser
3) Trap what browser we are on and do a regex parsing of the string and
do appropriate sets or a more verbose format that works everywhere
4) Use a regex and sets for every browser.
5) Switch all the embedded times over to epochs in the title=""'s

4 is probably the "most" right that I can see of those options, and
avoids possible other browser inconsistencies with respect to date
parsing.  I'm going to code that up (it shouldn't be terribly
complicated), unless someone likes one of the other ideas better.
Suppose we could even go down the more complicate microformat route and
just write some code to parse that, just more complicated all the way
around.

5 has the appeal that everything handles the epoch correctly, but it
does have the downside of being less readable in the html code (and
shifts us slightly further away from the accepted "standard" of the
microcode formats)

[...]
>> 6) Most U.S. timezones honor daylight savings, so they could be
>> something like -0700 for part of the year, and -0800 for the rest of
>> the year.  Picking the "local" option would automatically adjust for
>> this, but DST limits the usefulness of permanently storing a fixed TZ
>> offset in the cookie.
> 
> Dealing with DST (zoneinfo library) is simply too hard for JavaScript 
> IMHO.  What we could do is to store "local" in cookie, not a fixed TZ
> offset (or perhaps store both as to not recalculate it).

I already provide the option for "local" in the cookie, the other fixed
timesets are more for people wanting to be more explicit or look at time
zones from a different location.

>> 8) The " + " popup menu is a little quirky.  On FF 3.6 it partially
>> collapses after selecting a value from the dropdown.  On IE6 it shows
>> "Error in parsing value for 'display'" and does not render.  On Opera
>> 11 it seemed to work OK.
>>
>> Firefox breakage: http://img217.imageshack.us/f/firefoxa.png/
>>
>> I'm wondering if there might be a better place on the page to put the
>> TZ selection.  It isn't immediately obvious to the user what the extra
>> " + " does, and it seems to cause some issues.
> 
> Hmmm... perhaps a 'config' page?

Already made my comments on that in the other e-mail.

- John 'Warthog9' Hawley
