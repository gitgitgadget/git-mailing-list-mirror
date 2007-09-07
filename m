From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Thu, 06 Sep 2007 18:58:25 -0700
Message-ID: <7v7in38ce6.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
	<7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITT7K-0001CC-83
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 03:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXIGB6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 21:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbXIGB6g
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 21:58:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbXIGB6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 21:58:35 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F286E12FD47;
	Thu,  6 Sep 2007 21:58:48 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.9999.0709061942320.21186@xanadu.home> (Nicolas
	Pitre's message of "Thu, 06 Sep 2007 20:51:58 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57963>

Nicolas Pitre <nico@cam.org> writes:

> I wonder if this is the best way to go.  In the context of a really fast 
> repack happening automatically after (or during) user interactive 
> operations, the above seems a bit heavyweight and slow to me.

Honestly, I do not believe in that mode of operation that much.

"While the user is waiting for the EDITOR"?

Because you do not know how much time you will be given before
you start, unless

 (1) your process can be snapshotted and you can restart at the
     next chance; or

 (2) it is so cheap and you can afford to abort and start over
     from scratch at the next chance; or

 (3) it is so quick that you can simply have the user wait until
     you are done without adding too much latency to be annoying,
     when you cannnot finish before the EDITOR come back;

I think that is a false sense of "ok, we will be able to do
something else in the background meantime", which is not so
useful in practice.

>> An obvious next steps that can be done in parallel by interested
>> parties would be:
>> 
>>  (1) come up with a way to give "name" aka "clustering cue" (I
>>      think this is very hard);
>
> It is, and IMHO not worth it.  If you do it separately from the usual 
> pack-objects process you'll perform extra IO and decompression when 
> walking tree objects just to reconstruct those paths, becoming really 
> slow by the context definition I provided above.

Well, I said "name" in quotes because you do _NOT_ have to give
the real name.  I was not thinking about doing the actual tree
traversal at all.  What you need to do is to come up with a
token that is the same for the objects in the same deltification
chain so that they cluster together, and that should be doable
by looking at the delta chain patterns inside a packfile.
