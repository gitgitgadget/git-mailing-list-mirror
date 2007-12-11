From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 11:40:22 -0800
Message-ID: <7v7ijldnq1.fsf@gitster.siamese.dyndns.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	<alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	<9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	<9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	<9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	<alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
	<9e4733910712111043h6a361996x740f4dba3d742da5@mail.gmail.com>
	<alpine.LFD.0.9999.0712111055590.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Nicolas Pitre <nico@cam.org>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AyS-0002A4-26
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbXLKTkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbXLKTkj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:40:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbXLKTki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:40:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 91FBF4083;
	Tue, 11 Dec 2007 14:40:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 109EA38FF;
	Tue, 11 Dec 2007 14:40:23 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712111055590.25032@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 11 Dec 2007 11:17:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67920>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 11 Dec 2007, Jon Smirl wrote:
>> >
>> > So if you want to use more threads, that _forces_ you to have a bigger
>> > memory footprint, simply because you have more "live" objects that you
>> > work on. Normally, that isn't much of a problem, since most source files
>> > are small, but if you have a few deep delta chains on big files, both the
>> > delta chain itself is going to use memory (you may have limited the size
>> > of the cache, but it's still needed for the actual delta generation, so
>> > it's not like the memory usage went away).
>> 
>> This makes sense. Those runs that blew up to 4.5GB were a combination
>> of this effect and fragmentation in the gcc allocator. Google
>> allocator appears to be much better at controlling fragmentation.
>
> Yes. I think we do have some case where we simply keep a lot of objects 
> around, and if we are talking reasonably large deltas, we'll have the 
> whole delta-chain in memory just to unpack one single object.

Eh, excuse me.  unpack_delta_entry()

 - first unpacks the base object (this goes recursive);
 - uncompresses the delta;
 - applies the delta to the base to obtain the target object;
 - frees delta;
 - frees (but allows it to be cached) the base object;
 - returns the result

So no matter how deep a chain is, you keep only one delta at a time in
core, not whole delta-chain in core.

> So what you actually want to do is to just re-use already packed delta 
> chains directly, which is what we normally do. But you are explicitly 
> looking at the "--no-reuse-delta" (aka "git repack -f") case, which is why 
> it then blows up.

While that does not explain, as Nico pointed out, the huge difference
between the two repack runs that have different starting pack, I would
say it is a fair thing to say.  If you have a suboptimal pack (i.e. not
enough reusable deltas, as in the 2.1GB pack case), do run "repack -f",
but if you have a good pack (i.e. 300MB pack), don't.
