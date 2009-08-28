From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 17:30:59 -0700
Message-ID: <7viqg8hj98.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
 <200908280103.06015.johan@herland.net>
 <20090827233900.GA7347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 02:31:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgpNM-0003eX-3a
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 02:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZH1AbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 20:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbZH1AbV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 20:31:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZH1AbU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 20:31:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D74861B8C8;
	Thu, 27 Aug 2009 20:31:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kmsZHCWsSqO4iyisLIcLc6UB5sw=; b=mjIkf6
	4JPSKw4AHGFS8BMmOlfHhLJoWF13zkWWVPWIIMrW/tEp2Z5UMt0sYZvuJQtUn30u
	18wTptt/n+DPy0q7CBFQFRC7D3hwRcPM4LS0Vzts1gAYkrLcp/JUwaZZd8Dg3BQ1
	M5LT/a4GZwELhFmmaFvJ7Nk2MsLhA/SXxXy/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BO1YNghfeffTRe6pm9SxTpNg2oY71JGf
	MTecdiaeUew79hW7Ob5IDlsNUv4OSiKKRDH5sk76enoQ9ETqSgCr3o0OtX1oj5Sw
	EJ1sDpSLHp8QDsvFDtjKMb4XLoYJCIJmxy0SAEXb4ldxzmNLbL1G33QtBrmdsaOo
	h1whTEVUFrk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57D061B8C7;
	Thu, 27 Aug 2009 20:31:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 085241B8C1; Thu, 27 Aug
 2009 20:31:00 -0400 (EDT)
In-Reply-To: <20090827233900.GA7347@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 27 Aug 2009 19\:39\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 160B02A4-936A-11DE-B235-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127236>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 28, 2009 at 01:03:05AM +0200, Johan Herland wrote:
>
>> Agreed. I'm starting to come around to the idea of storing them in subtrees 
>> based on commit dates. For one, you don't have multiple notes for one commit 
>> in the same notes tree. Also, the common-case access pattern seems tempting.
>> 
>> Dscho: Were there other problems with the date-based approach other than not 
>> supporting notes on trees and blobs?
>> 
>> If not, I'll start preparing another series with the date-based approach.
>
> Would you ever want to load a note for a commit when you did not have
> that commit present (in which case you would not know its date)?

You cannot "git show" nor "git checkout" it, nor have reached it via "git
bisect".  How did you get interested in the commit in the first place?

What is the reason you are not fetching the commit after you somehow got
interested in the commit?

Here is one possible scenario I can think of.  The notes tree is published
and distributed more widely than the project's main source.  You fetch and
usually follow notes tree (which would probably be more lightweight) but
not the source.  Perhaps your bug tracking system is based on notes, and
the project is throwing all the bugs in one such notes tree.  You are a
bug tracking person, and you are following the notes tree closely, but are
only following the 'master' branch but not 'next' nor 'pu'.

And you somehow browse through the 'notes' tree, and learn that a note
refers to an interesting commit.  But the commit the note applies to is
not yet in 'master' so you do not have it.  Even though you would want to
fetch 'next' and 'pu', you are having connection problem and you cannot
fetch the source until your ISP gets back online tomorrow morning.

Nah, that's not a plausible scenario---at that point you already have read
the note.

So, how?
