From: "J.H." <warthog9@kernel.org>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Tue, 23 Nov 2010 17:45:14 -0800
Message-ID: <4CEC6E2A.9080605@kernel.org>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org> <m3mxp668cy.fsf@localhost.localdomain> <7v1v6icyb0.fsf@alter.siamese.dyndns.org> <201011200142.26522.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 02:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL4Pa-0003d6-6n
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 02:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068Ab0KXBog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 20:44:36 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:43987 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab0KXBof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 20:44:35 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oAO1iLOI027240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 23 Nov 2010 17:44:21 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <201011200142.26522.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 23 Nov 2010 17:44:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162040>

>>>> * jh/gitweb-caching (2010-11-01) 4 commits
>>>>  . gitweb: Minimal testing of gitweb caching
>>>>  . gitweb: File based caching layer (from git.kernel.org)
>>>>  . gitweb: add output buffering and associated functions
>>>>  . gitweb: Prepare for splitting gitweb
>>>>
>>>> Temporarily ejected while I shuffled jn/gitweb-testing; will queue the
>>>> latest back in pu or perhaps in next.
>>>
>>> The advantage of 'gitweb: File based caching layer (from git.kernel.org)'
>>> is that it is tested in real-life on heavy load (assuming that 
>>> git.kernel.org uses the same version as is/would be in pu/next).
>>>
>>> The disadvantage is that it is seriously messy code.  Something that I
>>> wanted to improve in my rewrite.  This is only minimal fixup.
>>
>> Which is exactly what we want at this point (I want to release 1.7.4 by
>> the end-of-year holidays, which means a feature-freeze will have to start
>> soon).  My understanding is that the serious messiness does not come from
>> the caching layer.
> 
> Well... the capturing, caching and actual gitweb operations are quite
> intermixed in J.H. patch.

I'm not sure how they can be any less intermixed.  The biggest problem
is getting the code launched into the caching engine, which gitweb in
general has no good means of dealing with.  Now that said, since I
switched how I'm capturing the output the diff into the main gitweb code
is quite small, and easily bypassed.

The only place there the code gets really intermixed at all is in the
special case of binary files, and that's just because the entirety of
that code in gitweb.perl assumes it can dump the data straight to the
client, which I point out has a whole slew of disadvantages, not the
least of which is the client has no idea how big the file should be and
is accepting bits blindly until the stream closes.

> I wanted to separate those issues, and have
> them modularized in my rewrite[1], making it easy to use other caching engine
> (tested with Cache::FileCache from Cache::Cache).  On the other hand 
> intermixing allows capturing directly to cache file (although it is only
> since v7), something that would be more difficult in my rewrite.

While I don't disagree, being able to support other caching systems
would be nice, we have this now, it's tested and it works.  I'd argue
this is a step 1, step 2 case at this point.

I'd also point out that while caching the output has been exceedingly
useful, and has proven to be fast, I can definitely see benefits to
caching individual data pieces, however to do that the output and data
accessing bits in gitweb really need to be re-written, and we should
honestly move to some sort of templating engine.  That said, that's not
part of this patch series anyway.

> The Perl code of J.H. patch does not follow style of other parts of gitweb,
> doesn't follow best practices (like e.g. using lexical filehandles instead
> of globs), does include some code repetitions... all of which made me
> attempt rewrite rather than fix it.

Concerning the lexical filehandles vs. globs, I can not find any
documentation anywhere as to why you would prefer one over the other.
Considering that the handles were being use globally the lexical way
made sense (and was the way I wrote it 4 years ago).  I've already done
the quick search and replace to move them over to globs.

Speaking to code repetitions the only thing that I really had repeated
was the check for if the action involved a binary file, I've added a
function that checks for that now.  Beyond that, I'm not really seeing
anything.

> BTW. I didn't get any responses to "[RFC] Implementing gitweb output caching
> - issues to solve".

Because you sent that while I was in Boston at Kernel Summit and LPC.
It got lost in my inbox, and I've only gotten far enough in the last day
or so to start digging back into the gitweb stuff.  I'm not sure how,
but you have perfect timing in every time you send out stuff I'm in the
middle of a big messy trip.  Clearly I should just travel less ;-)

I should have fixes / cleanups and further commentary soon.  I've also
got some changes that are a combination of requests from the gittogether
and from irc that I'll be adding in.

I'm currently working from on top of Jakub's last tree, though I've got
some questions about his reasoning on a few things now that I've been
digging into it.

- John 'Warthog9' Hawley
