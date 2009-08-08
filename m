From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Sat, 08 Aug 2009 09:07:55 -0700
Message-ID: <7vk51el25g.fsf@alter.siamese.dyndns.org>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.LFD.2.00.0908070031160.16073@xanadu.home>
 <alpine.DEB.1.00.0908070806350.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908071010580.16073@xanadu.home>
 <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZoT1-0004Sz-0l
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbZHHQIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbZHHQIN
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:08:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZHHQIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:08:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86967226E0;
	Sat,  8 Aug 2009 12:08:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16858226DE; Sat,  8 Aug 2009
 12:07:57 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat\, 8 Aug 2009 17\:18\:42 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB9F9E22-8435-11DE-8D4E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125283>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It is like having a "git diff" result cache: no one would think of 
>> stuffing that in the pack index.
>
> Do you want to try to kid me?  You'll have to try harder.  Caching "git 
> diff" results... no, really!

I thought Nico meant caching the rename similarity matrix when he said
"git diff" cache.  In a narrow context of "log --follow" it may make
sense.  It also might help "blame" without -C.

But I do not see how we would gain anything if we had that cache tied to
the pack index.

> After all, the parents, referenced tree and blob objects to change as 
> often as the objects in the pack: never.

But I notice that the aspects of objects you listed: the parents,
referenced tree and blob objects.  The frequency of them changing does not
depend on where the actual object is, either packed or loose.  These
aspects of an object (more specifically, you are talking about a commit
object) never change either way.  So I am somewhat puzzled.

It does change if a particular commit and its associated objects are
relevant to the traversal as refs change (especially when they rewind).
Just like an old "kept" pack can suddenly have tons of irrelevant objects
after refs are pruned (e.g. a branch is dropped), cached reachability
data, even though they may stay correct, would become irrelevant when
nobody starts traversing from an object that is no longer reachable.
