From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
 significantly speed up packing/walking
Date: Sat, 08 Aug 2009 11:57:28 -0700
Message-ID: <7vmy6agmlj.fsf@alter.siamese.dyndns.org>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 08 20:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZr73-0000zc-5s
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 20:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZHHS5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 14:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbZHHS5p
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 14:57:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZHHS5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 14:57:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2956322CC4;
	Sat,  8 Aug 2009 14:57:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFB5222CC3; Sat,  8 Aug 2009
 14:57:30 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 6 Aug 2009 21\:06\:59 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AFA03D2-844D-11DE-9981-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125297>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My idea with that was that you already have a SHA-1 map in the pack index, 
> and if all you want to be able to accelerate the revision walker, you'd 
> probably need something that adds yet another mapping, from commit to 
> parents and tree, and from tree to sub-tree and blob (so you can avoid 
> unpacking commit and tree objects).
>
> I just thought that it could be more efficient to do it at the time the 
> pack index is written _anyway_, as nothing will change in the pack after 
> that anyway.

After reading the version 2 of the "documentation" patch and commenting
heavily on it, I partly share the same feeling with you.  The codepath to
pack objects is _one of the places_ you can generate rev-cache and slice
information without redoing a lot of work that has already been done
anyway.

But

 - You can write that information separately out to a different file.
   Logically it does not have to be _in_ the same pack idx file; and

 - You may want to generate rev-cache information even if you do not pack
   the repository.  They may practically go hand-in-hand, but logically
   they are orthogonal.

And I am not sure if it is easy to retrofit "rev-list | pack-objects" code
to additionally produce this information, while keeping the standalone
version of rev-cache generation.

Having said all that.

I haven't read the side of the patch that _uses_ the information stored in
the rev-cache to figure out what it optimizes and what its limitations are
(e.g. how it interacts with pathspecs).  Perhaps the rev-cache may turn
out to be _only_ useful for pack-objects and nothing else, in which case
we may not care about standalone version of rev-cache generator after all.

If that is the case, I think it is also a reasonable implementation if the
rev-cache is generated only by "rev-list | pack-objects" codepath as a
side effect of traversal it already does, and it might even make sense to
introduce the version 3 of pack idx format that let you record additional
information, like you suggest.  I am not ready to make that judgement as I
haven't read the rest, but my gut feeling tells me that you might be
right.
