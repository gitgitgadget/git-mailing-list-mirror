From: Junio C Hamano <gitster@pobox.com>
Subject: Re: move detection doesnt take filename into account
Date: Wed, 09 Jul 2014 15:18:43 -0700
Message-ID: <xmqqa98i9nwc.fsf@gitster.dls.corp.google.com>
References: <53B105DA.30004@gmail.com>
	<287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
	<xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
	<53B2CE4A.9060509@gmail.com>
	<xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
	<20140709064521.GA14682@sigill.intra.peff.net>
	<xmqqegxu7cpg.fsf@gitster.dls.corp.google.com>
	<20140709220337.GF25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elliot Wolk <elliot.wolk@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X50CU-0001PG-L3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbaGIWSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:18:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51335 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaGIWSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DBB128C90;
	Wed,  9 Jul 2014 18:18:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MWlOJwkiPiaB9rpB2EspwnEBr7c=; b=V9CPTR
	6osWd/lZB5HM6A+d88g2b/AmTy1GwnfGq0Kq5A9vHAPOrGvtfTlrpq32ZDXbSKLJ
	y7QCIaJr3AHD4du/J16dTG6pv25x5Mu/kLQrih9OHP0f3g5K5QCy7dgvNPg23ARy
	NXV2+nffUff2vcQpxgk+Zm4+wI8hw0kzuFcp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yXYU1Iu+w6/GdX3p2C2PkE8t0ClS7eGn
	NMDiEwud6nKTMYOTZ6UqkhEUKJuuRj0Q6wqFp/cawX0eSxicdtCvHbY4qXw7ZJ+8
	U/hkjl9qDHjONzfpQrz/ac3HjwrNKzp0WvdXUIqMOzZRa4fSoplv6wiQld7B+Ax8
	w26krA+MJlA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 838B328C8F;
	Wed,  9 Jul 2014 18:18:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4750C28C8B;
	Wed,  9 Jul 2014 18:18:29 -0400 (EDT)
In-Reply-To: <20140709220337.GF25854@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 9 Jul 2014 18:03:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F45B2B5E-07B6-11E4-B3BA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253165>

Jeff King <peff@peff.net> writes:

> I think the hash here does not collide in that way. It really is just
> the last sixteen characters shoved into a uint32_t.

All bytes overlap with their adjacent byte because they are shifted
by only 2 bits, not 8 bits, when a new byte is brought in.  We can
say that the topmost two bits of the result must have come from the
last character, but other than these, there are more than one input
byte for each bit position to be set/unset by, so two names that human
would not consider "similar" would be given the same hash, no?

That is useful for delta code because the code only needs that
similar things are grouped together, it does not mind things that
are not similar is also mixed to a group, as the end result is
primarily determined by similarity of the actual contents, not
pathnames.

What is under topic in this discussion is the other way around; we
know two paths have contents of the same similarity to the third one
and want to tie-break these two using how similar their pathnames
are to the third one.  
