From: david@lang.hm
Subject: Re: metastore
Date: Sun, 16 Sep 2007 15:52:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm> <7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2z4-0005u6-Tq
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbXIPWwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbXIPWwx
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:52:53 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:60053
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbXIPWww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:52:52 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GMqNsC025925;
	Sun, 16 Sep 2007 15:52:23 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58364>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
>
>>> I'd rather not implement it at such a low level where a true
>>> "checkout" happens.  For one thing, I am afraid that the special
>>> casing will affect the normal codepath too much and would make
>>> it into a maintenance nightmare.
>>
>> as I understand it, at this point you already choose between three
>> options.
>>
>> 1. write to a file (and set the write bit if needed)
>> 2. write to stdout
>> 3. write to a pager program
>>
>> I am suggesting adding
>> ...
>> or am I missing something major here?
>
> I do not think we are choosing any option in the codepath at
> all.
>
> What I mean by the normal "checkout" is what checkout_entry in
> entry.c does.  There is no other option than (1) above.  I would
> want to see an extremely good justification if you need to touch
> that codepath to implement this fringe use case.
>
> I do not think there is nothing that writes file contents to
> stdout/pager other than "git cat-file" or "git show"; I do not
> think they are what you have in mind when talking about managing
> the files under /etc.  So unfortunately I do not understand the
> rest of the discussion you made in your message.

Ok, I thought that there was common code for these different uses. could 
you re-read the rest of the logic based on the change being done in 
checkout_entry?

if you are unwilling to have any changes made to the checkout_entry code 
then the only remaing question is what you think of Daniel's suggestion to 
have a hook to replace check_updates()?

if it's not acceptable either then we are down to doing a post-checkout 
trigger.

one concern I have with that approach is how to deal with partial 
checkouts. if a user checks out one file how can the post-checkout trigger 
know if it's looking at the correct permissions file as opposed to one 
left over from something else? can/should it go and read the file from the 
index instead of reading the file on the filesystem? (I don't like this 
becouse it leads to non-obvious behavior), or can/should there be a config 
option to say that whenever any file is checked out the permissions file 
needs to be checked out as well.

a post checkout trigger is useful in enough different situations that the 
answers to the above questions don't eliminate the usefulness of the 
trigger, they just map out the pitfalls of useing it.

David Lang
