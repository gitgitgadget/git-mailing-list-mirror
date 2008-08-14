From: Andreas Ericsson <ae@op5.se>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 08:33:59 +0200
Message-ID: <48A3D1D7.5030805@op5.se>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWRB-0007va-QY
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYHNGet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYHNGet
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:34:49 -0400
Received: from mail.op5.se ([193.201.96.20]:55733 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbYHNGes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 02:34:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A71A01B80087;
	Thu, 14 Aug 2008 08:38:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1vvuYJNe318; Thu, 14 Aug 2008 08:38:05 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 715E21B80086;
	Thu, 14 Aug 2008 08:38:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92327>

Nicolas Pitre wrote:
> On Wed, 13 Aug 2008, Shawn O. Pearce wrote:
> 
>> Nicolas Pitre <nico@cam.org> wrote:
>>> Well, we are talking about 50MB which is not that bad.
>> I think we're closer to 100MB here due to the extra overheads
>> I just alluded to above, and which weren't in your 104 byte
>> per object figure.
> 
> Sure.  That should still be workable on a machine with 256MB of RAM.
> 
>>> However there is a point where we should be realistic and just admit 
>>> that you need a sufficiently big machine if you have huge repositories 
>>> to deal with.  Git should be fine serving pull requests with relatively 
>>> little memory usage, but anything else such as the initial repack simply 
>>> require enough RAM to be effective.
>> Yea.  But it would also be nice to be able to just concat packs
>> together.  Especially if the repository in question is an open source
>> one and everything published is already known to be in the wild,
>> as say it is also available over dumb HTTP.  Yea, I know people
>> like the 'security feature' of the packer not including objects
>> which aren't reachable.
> 
> It is not only that, even if it is a point I consider important.  If you 
> end up with 10 packs, it is likely that a base object in each of those 
> packs could simply be a delta against a single common base object, and 
> therefore the amount of data to transfer might be up to 10 times higher 
> than necessary.
> 

[cut]

>> This is also true for many internal corporate repositories.
>> Users probably have full read access to the object database anyway,
>> and maybe even have direct write access to it.  Doing the object
>> enumeration there is pointless as a security measure.
> 
> It is good for network bandwidth efficiency as I mentioned.
> 

As a corporate git user, I can say that I'm very rarely worried
about how much data gets sent over our in-office gigabit network.
My primary concern wrt server side git is cpu- and IO-heavy
operations, as we run the entire machine in a vmware guest os
which just plain sucks at such things.

With that in mind, a config variable in /etc/gitconfig would
work wonderfully for that situation, as our central watering
hole only ever serves locally.

>> I'm too busy to write a pack concat implementation proposal, so
>> I'll just shutup now.  But it wouldn't be hard if someone wanted
>> to improve at least the initial clone serving case.
> 
> A much better solution would consist of finding just _why_ object 
> enumeration is so slow.  This is indeed my biggest grip with git 
> performance at the moment.
> 
> |nico@xanadu:linux-2.6> time git rev-list --objects --all > /dev/null
> |
> |real    0m21.742s
> |user    0m21.379s
> |sys     0m0.360s
> 
> That's way too long for 1030198 objects (roughly 48k objects/sec).  And 
> it gets even worse with the gcc repository:
> 
> |nico@xanadu:gcc> time git rev-list --objects --all > /dev/null
> |
> |real    1m51.591s
> |user    1m50.757s
> |sys     0m0.810s
> 
> That's for 1267993 objects, or about 11400 objects/sec.
> 
> Clearly something is not scaling here.
> 

What are the different packing options for the two repositories?
A longer deltachain and larger packwindow would increase the
enumeration time, wouldn't it?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
