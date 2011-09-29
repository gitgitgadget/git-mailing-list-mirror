From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 19:26:24 +0100
Message-ID: <942277b4139229d6d3e921999859250f@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <201109291038.45290.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	<git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9LJY-00062I-Q1
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 20:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab1I2S01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 14:26:27 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:55894 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754022Ab1I2S00 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 14:26:26 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 56645C060D;
	Thu, 29 Sep 2011 19:26:25 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 302A936A87F;
	Thu, 29 Sep 2011 19:26:25 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9SfIyf+LqvJF; Thu, 29 Sep 2011 19:26:24 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 4B5BC36A7BE;
	Thu, 29 Sep 2011 19:26:24 +0100 (BST)
In-Reply-To: <201109291038.45290.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182420>

On Thu, 29 Sep 2011 10:38:44 -0600, Martin Fick wrote:
> On Wednesday, September 28, 2011 08:19:16 pm Julian Phillips
> wrote:
-- snip --
>> However, I had forgotten to make the orphaned commit as
>> you suggest - and then _bang_ 7N^2, it tries seven
>> different variants of each ref (which is silly as they
>> are all fully qualified), and with packed refs it has to
>> search for them each time, all to turn names into hashes
>> that we already know to start with.
>>
>> So, yes - it is that list traversal.
>>
>> Does the following help?
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 5e356a6..f0f4ca1 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -605,7 +605,7 @@ static int
>> add_one_ref_to_rev_list_arg(const char *refname,
>>                                         int flags,
>>                                         void *cb_data)
>>   {
>> -       add_one_rev_list_arg(cb_data, refname);
>> +       add_one_rev_list_arg(cb_data,
>> strdup(sha1_to_hex(sha1))); return 0;
>>   }
>
>
> Yes, but in some strange ways. :)
>
> First, let me clarify that all the tests here involve your
> "sort fix" from 2 days ago applied first.
>
> In the packed ref repo, it brings the time down to about
> ~10s (from > 5 mins).  In the unpacked ref repo, it brings
> it down to about the same thing ~10s, but it was only
> starting at about ~20s.
>
> So, I have to ask, what does that change do, I don't quite
> understand it?  Does it just do only one lookup per ref by
> normalizing it?  Is the list still being traversed, just
> about 7 time less now?

In order to check for orphaned commits, checkout effectively calls 
rev-list passing it a list of the names of all the refs as input.  The 
rev-list code then has to go through this list and convert each entry 
into an actual hash that it can look up in the object database.  This is 
where the N^2 comes in for packed refs, as it calles resolve_ref() for 
each ref in the list (N), which then loops through the list of all refs 
(N) to find a match.  However, the code that creates the list of refs to 
pass to the rev-list code already knows the hash for each ref.  So the 
change above passes the hashes to rev-list, which then doesn't need to 
lookup the ref - it just converts the string form hash back to binary 
form, avoiding the N^2 work altogether.  This is why packed and unpacked 
are about the same speed, as they are now doing the same amount of work.

> Should the packed_ref list simply be
> put in an array which could be binary searched instead, it
> is a fixed list once loaded, no?

A quick look at the code suggests that probably both the list of loose 
refs, and the list of packed refs could both be stored as binary 
searchable arrays, or in an ordered hash table.  Though whether it is 
actually necessary I don't know.  So far, it seems to have been possible 
to fix performance issues whilst keeping the simple lists ...

> I prototyped a packed_ref implementation using the hash.c
> provided in the git sources and it seemed to speed a
> checkout up to almost instantaneous, but I was getting a few
> collisions so the implementation was not good enough.  That
> is when I started to wonder if an array wouldn't be better
> in this case?
>
>
>
> Now I also decided to go back and test a noop fetch (a
> refetch) of all the changes (since this use case is still
> taking way longer than I think it should, even with the
> submodule fix posted earlier).  Up until this point, even
> the sorting fix did not help.  So I tried it with this fix.
> In the unpackref case, it did not seem to change (2~4mins).
> However, in the packed ref change (which was previously also
> about 2-4mins), this now only takes about 10-15s!
>
> Any clues as to why the unpacked refs would still be so slow
> on noop fetches and not be sped up by this?

Not really.  I wouldn't expect this change to have any effect on fetch, 
but I haven't actually looked into it.

-- 
Julian
