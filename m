From: Ivan Todoroski <grnch@gmx.net>
Subject: Re: [PATCH/RFC v2 3/4] fetch-pack: test cases for the new --stdin
 option
Date: Wed, 28 Mar 2012 01:36:45 +0200
Message-ID: <4F724F0D.7000602@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net> <4F715DBF.6030909@gmx.net> <7v4ntaj61t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfwV-0004fW-MV
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab2C0XgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:36:15 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46202 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755249Ab2C0XgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:36:14 -0400
Received: (qmail invoked by alias); 27 Mar 2012 23:36:12 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.58]
  by mail.gmx.net (mp072) with SMTP; 28 Mar 2012 01:36:12 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX18HQvpju0QHTn7Ms22XuuWoRM9SkWByUJH1rUs9/d
	kR78M3KNjNgfNw
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7v4ntaj61t.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194097>

On 27.03.2012 19:40, Junio C Hamano wrote:
> 
> It is sensible to expect that we see all the refs we told it to fetch, but
> I do not think it is sensible to require they come in the same order as we
> have given them to the command.

Oh, OK. I was not aware that fetch-pack is free to reorder commits (at 
least in principle). I will adjust the tests to be order-independent.

>> For the --stateless-rpc tests we cannot easily execute fetch-pack to the
>> end because that would require simulating the remote protocol. We settle
>> for only checking 2 cases:
>>
>> 1) Whether fetch-pack correctly fails to parse the refs if they are not
>> terminated by a flush packet
>>
>> 2) Whether fetch-pack finishes parsing the refs without error when they
>> are correctly terminated by a flush packet
>>
>> The fetch-pack invocation fails in both cases due to the missing remote
>> side of the protocol, but it fails in different ways which allows us to
>> determine how the refs parsing ended by inspecting the different error
>> messages.
> 
> Ick.

Yeah... I couldn't figure out a way to do an isolated test of the 
packetized version of --stdin when --stateless-rpc is also in effect. 
Any guidance here would be welcome.

On second thought, maybe we can just drop these two --stateless-rpc 
tests from this patch? The "git clone" test in the next patch also 
exercises the packetized refs in --stateless-rpc mode and if there was 
anything wrong with them it would fail.

>> +
>> +test_expect_success 'fetch refs from cmdline, make sure it still works OK' '
>> +	cd client &&
>> +	git fetch-pack --no-progress .. $(cat ../stdin.exp) |
>> +	cut -d " " -f 2 > ../stdin.act &&
>> +	cd .. &&
>> +	test_cmp stdin.exp stdin.act
>> +'
> 
>  - Do not chdir around without being in a subprocess ();

Sorry, I didn't realize the tests were eval-ed in the current 
environment. I will correct all such problems in the next version.

>  - Do not place the command you are testing that might crash on the
>    upstream of the pipe;
> 
>  - style;

Noted.

> 	(
> 		cd client &&
>                 git fetch-pack ... <../stdin.exp >stdin.raw
> 	) &&
> 	cut -d " " -f 2 <stdin.raw | sort >stdin.act &&
> 	test_cmp stdin.exp stdin.act
> 
> By the way, why are these not called "expect" and "actual" like most other
> tests?

The test files I worked with used the shorter exp/act convention so I 
followed that.

Or are you wondering about the "stdin." prefix I added? That was because 
I didn't want to overwrite any exp/act files that might be created by 
the previous tests, or is that not a concern?

Sorry, my inexperience with the Git test framework is showing...

> Do we want to have a separate test to see what happens when there are dups
> in the input?

Good idea. I will check what happens in the current fetch-pack if 
duplicate refs are passed on the command line and will write a test to 
ensure that the --stdin version does the same thing.


P.S.
It goes without saying that I implicitly accept all the corrections that 
I did not reply to and will include them in the next version.
