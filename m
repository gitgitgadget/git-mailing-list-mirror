From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Mon, 18 Feb 2013 01:29:16 -0800
Message-ID: <7vhalaas2b.fsf@alter.siamese.dyndns.org>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin>
 <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N2m-0004OV-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab3BRJ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:29:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269Ab3BRJ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:29:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09AB29925;
	Mon, 18 Feb 2013 04:29:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JtMHYvNaeVQo8ureiEH5rE83+l8=; b=isl/iv
	2aTSMPYLvzCqSU0Dv9R1Dmc6PvKA7C+aTDWbDfbr5D04AzBWTrqVoS5+2MAH5YMA
	F2OvTF/Q0uM3Bt2Mf4zR2gVUrBHeBj1FHVf7wHNeNIfoQuWQA5CpSZK5O+OuNkW/
	lI9JdeHVwWInGlyti9whMQxyAAz7FHA3PIEjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rTYKCOw332e758TU8wd7t8CWTuE5EpzG
	eHk6enOdaetzuhOQiBYBUuhxoO+KuDRy0aBMP/grZxKETOzBlWIwkeyGG0BdGMz3
	TDMJpucsXIejY7G5/epum26bLPXwLku6ALZIJO4qAflrY0srM3OoSc5TMwXfF522
	1WWjS0nZDYc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFA079924;
	Mon, 18 Feb 2013 04:29:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D3E79923; Mon, 18 Feb 2013
 04:29:19 -0500 (EST)
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Feb 2013 04:12:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABD7F99A-79AD-11E2-ABB1-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216455>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 17, 2013 at 05:41:13PM -0800, Jonathan Nieder wrote:
>
>> > I don't think so. Don't ERR lines appear inside their own packets?
>> 
>> Yes, I misread get_remote_heads for some reason.  Thanks for checking.
>
> Thanks for bringing it up. I had not even thought about ERR at all. So
> it was luck rather than skill that I was right. :)
>
>> I'm not sure whether servers are expected to send a flush after an
>> ERR packet.  The only codepath I know of in git itself that sends
>> such packets is git-daemon, which does not flush after the error (but
>> is not used in the stateless-rpc case).  http-backend uses HTTP error
>> codes for its errors.
>
> I just checked, and GitHub also does not send flush packets after ERR.
> Which makes sense; ERR is supposed to end the conversation.

Hmph.  A flush packet was supposed to be a mark to say "all the
packets before this one can be buffered and kept without getting
passed to write(2), but this and all such buffered data _must_ go on
the wire _now_".  So in the sense, ERR not followed by a flush may
not even have a chance to be seen on the other end, no?  That is
what the comment before the implementation of packet_flush() is all
about.
