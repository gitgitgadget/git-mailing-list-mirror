From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 08:53:45 -0800
Message-ID: <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
	<5281012D.4060708@op5.se>
	<20131112083240.GA1684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 12 17:53:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgHDv-0008MI-CM
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 17:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab3KLQxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 11:53:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab3KLQxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 11:53:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD9A50E47;
	Tue, 12 Nov 2013 11:53:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMVhvvvjgCSZK1QMMMp09gB7U2Y=; b=LtXHl1
	Av6ZmzIZz6tkaZo/0ElLCrIcZfjNZxnxmXtlnYCgc9xa8VBxdKiBC53YnQJEUhvn
	3Pw0B4sD0+dX2KoZ/95XPfy3Utq2HrT62DdhM7t/L58qktBs9vqxJ52RtsK5E9H9
	1c6rZiKkmsOjgynHrtfI7aW1+Kn+wsAzQEohE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQjBtQIAuxMrEPD34c8YjlaYSj3rneYz
	O32YTg+nMmEZzsw61c+BJfxyaGYjkUuwgnmJRhAu7ZaAxMK7WbG8y9G59vmr0BQi
	FtcfgpNMtdgo9ZwzO1JhkYu0cu7x4MWAO0Azv0MSC7PYH4VwbjORzSS42ZojbRFa
	gaKQswewVFY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A1CC50E46;
	Tue, 12 Nov 2013 11:53:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F13750E3B;
	Tue, 12 Nov 2013 11:53:48 -0500 (EST)
In-Reply-To: <20131112083240.GA1684@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Nov 2013 03:32:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 004416A0-4BBB-11E3-BB76-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237717>

Jeff King <peff@peff.net> writes:

> I am ambivalent on the code churn, but if we do apply it, we should
> probably leave off the final patch (dropping prefixcmp) for a cycle to
> let topics in flight catch up to the change. Just diffing "master" and
> "next", I see some new uses of prefixcmp which will need adjusted, along
> with spots where the patches themselves will cause textual conflicts.

Yes, I did that check too (but between 'maint' and 'pu'). I think it
is a good idea to stop using whatever_cmp() name for things that are
not *cmp() functions in the longer term, but smooth migration is a
bit tricky (but not as tricky as end-user visible transitions).

Even though we already added has_suffix() for tail matches, it is
not too late to rethink, as it is not in 'master' yet.

One thing I noticed is that it is probably misnamed, or at least in
a way that invites confusion.  Can people tell which one of these is
correct without looking at existing callsites?

	has_suffix(filename, "txt");
        has_suffix(filename, ".txt");

The semantics of the function we have is the latter and is better
called endswith(), I suspect.  And the corresponding function to
check for head matches should probably be called beginswith().
