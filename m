From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 21:23:33 -0700
Message-ID: <7vd32g3ol6.fsf@alter.siamese.dyndns.org>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <20120823092624.GG6963@sigill.intra.peff.net>
 <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley>
 <20120823195648.GB15268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 06:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4lQu-00011d-1t
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 06:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab2HXEXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 00:23:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2HXEXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 00:23:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F8CD9342;
	Fri, 24 Aug 2012 00:23:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RH19ZYw6FNoEnmgvouuX6vqGkTc=; b=Xp8Kcf
	RLG5PRk+46u5tkhDshz5Fy3aDcaNo+KSYP0yFAhsWbfPf6Z++TeqqfIcj/l0IHTV
	2mwt23f1QSPYmIQ0KKavQdlL3fzYDcFk94L/xyERnUfqPDFcfqtqnlK3Pq5ECHBe
	rlKOdxjF4mvn5wrQpRh7IX6z++V0Nm/5hlnGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0AO9W0DMzUDIZ1jWTzclIGbYPJ9L27f
	JwCg5o2gswNeDD5d4Xq3YCWHt51oqQxB8yPOUeZi/mCliTR2CMfEBrZxjMdqkLg6
	TeIp/A3wgRnntWoKEASeV9S47DcgxZDAghFcoCZWKn3w7JrbDcFqSe/s0KtpUlTy
	GvOWy10OIT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D85A9341;
	Fri, 24 Aug 2012 00:23:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857ED933F; Fri, 24 Aug 2012
 00:23:34 -0400 (EDT)
In-Reply-To: <20120823195648.GB15268@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Aug 2012 15:56:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77F0BE14-EDA3-11E1-919B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204179>

Jeff King <peff@peff.net> writes:

>> It may be (?) that it is a good time to think about a 'datedepth'
>> capability to bypass the current counted-depth shallow fetch that can
>> cause so much trouble. With a date limited depth the relevant tags
>> could also be fetched.
>
> I don't have anything against such an idea, but I think it is orthogonal
> to the issue being discussed here.

Correct.

The biggest problem with the "shallow" hack is that the deepening
fetch counts from the tip of the refs at the time of deepening when
deepening the history (i.e. "clone --depth", followed by number of
"fetch", followed by "fetch --depth").  If you start from a shallow
clone of depth 1, repeated fetch to keep up while the history grew
by 100, you would still have a connected history down to the initial
cauterization point, and "fetch --depth=200" would give you a
history that is deeper than your original clone by 100 commits.  But
if you start from the same shallow clone of depth 1, did not do
anything while the history grew by 100, and then decide to fetch
again with "fetch --depth=20", it does not grow.  It just makes
20-commit deep history from the updated tip, and leave the commit
from your original clone dangling.

The problem with "depth" does not have anything to do with how it is
specified at the UI level.  The end-user input is used to find out
at what set of commits the history is cauterized, and once they are
computed, the "shallow" logic solely works on "is the history before
these cauterization points, or after, in topological terms." (and it
has to be that way to make sure we get reproducible results).  Even
if a new way to specify these cauterization points in terms of date
is introduced, it does not change anything and does not solve the
fundamental problem the code has when deepening.
