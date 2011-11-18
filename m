From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 11:22:08 -0800
Message-ID: <7v62ihkzhb.fsf@alter.siamese.dyndns.org>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
 <20111118103355.GA4854@sigill.intra.peff.net>
 <7vd3cpl1cw.fsf@alter.siamese.dyndns.org>
 <20111118184455.GA13782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 20:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRU0y-0007pi-DO
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 20:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab1KRTWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 14:22:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48634 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab1KRTWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 14:22:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 319206F63;
	Fri, 18 Nov 2011 14:22:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lvRDuvZt1CAYmsekPHNlOHIYts0=; b=kXtORI
	JOYvGuWao+Chxbc7TLp/6bwVY9VkI9Gbb170vVFuQiku+8ZU1noDaGHQ3rp2wMcM
	2Zhknx60KSG9l2lJWnCRlXTH3D2/mB7zbKTM7zTM9bi4E4BsC0isXmbXCPgCKRcZ
	jC+b4sDpNOFfl/wGhbk7Sm0tF2sO+stq8TXgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVrqRtwmzYYSJchvyk2uX3JM56h4AgVV
	pJml6Ik6QDVOkCS/CZz/3KZsVCXUyZoKzl9WUzxdX3g70HLv5r8ez3U8y0pfEtnE
	n3IlPPEwaFe+3X+NhHRiiVjzCsvhKFXOKsFZESwQ2FqUA8IdAuasko0F+e4iU/wk
	77o860Q3jDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275886F62;
	Fri, 18 Nov 2011 14:22:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFFB46F61; Fri, 18 Nov 2011
 14:22:09 -0500 (EST)
In-Reply-To: <20111118184455.GA13782@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 18 Nov 2011 13:44:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C3A0966-121A-11E1-BEA2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185674>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 18, 2011 at 10:41:35AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If we are fixing a thin pack (which should be the case most of the
>> > time), we are rewriting the packfile anyway. Shouldn't we just omit
>> > the duplicate?
>> ...
> ... But I guess there is some complexity
> with deltified entries? As in, if the first entry is deltified but the
> second is not, you would want to keep the second one?

I think you answered your own question here; it is not "some complexity"
but is exactly the "you need to memmove() in the output file" situation in
the message you are responding to.

Upon seeing a delta, you would not know if the same object as this delta
represents appears later in the pack stream, which means until you read to
the end you wouldn't know.  You obviously would not want to hold onto all
deltas in-core to "just omit the duplicate".
