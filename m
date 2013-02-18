From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Mon, 18 Feb 2013 01:49:37 -0800
Message-ID: <7v8v6mar4e.fsf@alter.siamese.dyndns.org>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin>
 <20130218091203.GB17003@sigill.intra.peff.net>
 <7vhalaas2b.fsf@alter.siamese.dyndns.org>
 <20130218093335.GK5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:50:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NMK-00046Y-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3BRJtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:49:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab3BRJtj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:49:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77567A09F;
	Mon, 18 Feb 2013 04:49:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wmKP6smpR0M9IB+9yYV9OZCP1YY=; b=bMWnzk
	fuFTZX/0C66KcPA/ls/WuS7508/72z6HjIkNInddMFh+mREgqAlWb/JsbkDhPGrL
	JGs91EH4JRlU+kVxKUY4DR2Mzb6QJ8+o4zzr+Cot1kaH9FYgM6E86PFCtn9gS3J0
	ZI70mpLt8c1iXwJpcyyC8t6ig9YjGX+KHlCQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EadUrymftWCHQICnsJh4vEjPYijlCmGG
	D7XiTX0PzHQIvspVd9SnX3GwJp6uf9+H4+XwLWFUH4C9RNcjOyVjBYBHUVm6zBZU
	kyVFF+KOTz/DBc73NM/QkBuaSPiGEj6+zv9iuu0hlZF1jsnkoRYgR1dQPxOGzk/i
	wFlDleEI2JM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CD7AA09E;
	Mon, 18 Feb 2013 04:49:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0E2DA09D; Mon, 18 Feb 2013
 04:49:38 -0500 (EST)
In-Reply-To: <20130218093335.GK5096@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Feb 2013 04:33:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82AB0082-79B0-11E2-9CC6-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216460>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 18, 2013 at 01:29:16AM -0800, Junio C Hamano wrote:
>
>> > I just checked, and GitHub also does not send flush packets after ERR.
>> > Which makes sense; ERR is supposed to end the conversation.
>> 
>> Hmph.  A flush packet was supposed to be a mark to say "all the
>> packets before this one can be buffered and kept without getting
>> passed to write(2), but this and all such buffered data _must_ go on
>> the wire _now_".  So in the sense, ERR not followed by a flush may
>> not even have a chance to be seen on the other end, no?  That is
>> what the comment before the implementation of packet_flush() is all
>> about.
>
> Despite the name, I always thought of packet_flush as more of a signal
> for the _receiver_, who then knows that they have gotten all of a
> particular list. In other words, we seem to use it as a sequence point
> as much as anything (mostly because we immediately write() out any other
> packets anyway, so there is no flushing to be done; but perhaps there
> were originally thoughts that we could do more buffering on the writing
> side).

Exactly.

The logic behind the comment "we do not buffer, but we should" is
that flush tells the receiver that the sending end is "done" feeding
it a class of data, and the data before flush do not have to reach
the receiver immediately, hence we can afford to buffer on the
sending end if we can measure that doing so would give us better
performance. We haven't measure and turned buffering on yet.

But when dying, we may of course have data before flushing. We may
disconnect (by dying) without showing flush (or preceding ERR) to
the other side, and for that reason, not relying on the flush packet
on the receiving end is a good change. Once we turn buffering on, we
probably need to be careful when sending an ERR indicator by making
it always drain any buffered data and show the ERR indicator without
buffering, or something.
