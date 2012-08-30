From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 09:33:48 -0700
Message-ID: <7vy5kws5jn.fsf@alter.siamese.dyndns.org>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
 <20120830130327.GB5687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77gs-0003TX-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab2H3Qdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 12:33:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2H3Qdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 12:33:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BEF584CE;
	Thu, 30 Aug 2012 12:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FrYpMv3/l9bpxrM9QBNWglTlRk=; b=K6Q/+K
	rRs7vFd4e6wsVpHllYX3qfyaOa5hC16WA9ToI3llc5/O3OXfgoIPFpb6s/CKooFu
	hkn0dfOTX0kYHfFcgaEkH5A2+3YSLAp4iZmt/NO4RTvg/h68OPlFgxdxXS3uwvW6
	1lWW4cgB/TxVkB+xOC/vKGeKytg8RUpB/y3x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZ9/lk3fSEDP7yruoosuwHANyXudRypW
	xoGM2ExSyS3YQgadpexY38lOGwqpyHNGF8AzdswlQa1mhi+kiCjJP8M1n3JLit9O
	XYQQc9fwAkib2Tnjwc9U4nAkvYQV9F/YEgSgBICoVxOD5sAOaj59zKbdsqIqM5rW
	pnabQjIg5P8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC98484CD;
	Thu, 30 Aug 2012 12:33:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 637B384CB; Thu, 30 Aug 2012
 12:33:50 -0400 (EDT)
In-Reply-To: <20120830130327.GB5687@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 30 Aug 2012 09:03:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB542EC-F2C0-11E1-AE1C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204547>

Jeff King <peff@peff.net> writes:

> The script originally comes from here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/33566/focus=33852
>
> and the discussion implies that the AUTHOR_DATEs were added to avoid a
> race condition with the timestamps. But why would that ever have worked?

I do not see how AUTHOR_DATE would affect anything there, either,
other than to give reprodusible object names.  The test only sets
committer-date upfront, so without setting author-date, you would
still get different object names on commits.  Which suggests me that
there may be something that tiebreaks based on object names?
