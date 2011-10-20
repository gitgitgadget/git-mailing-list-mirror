From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 10:15:26 -0700
Message-ID: <7vmxcva8k1.fsf@alter.siamese.dyndns.org>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
 <7v8vogbgai.fsf@alter.siamese.dyndns.org>
 <20111020080328.GA12337@elie.hsd1.il.comcast.net>
 <4E9FE061.3080601@gmail.com>
 <20111020090912.GA21471@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 19:15:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGwDR-00089f-4w
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 19:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829Ab1JTRPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 13:15:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab1JTRPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 13:15:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1535338;
	Thu, 20 Oct 2011 13:15:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q1aQrGUftncHz9JWY5OIlgy4hYg=; b=epaCU4
	KDnOpm+Xi/OM+RhW5A5xawa0f9olAWY/ku5I4hU58+PYoaT2u/9ojdS17OwNMILw
	GMjC5A/XAD17Tibj3uXSPQKplGN86I4ApbLWKOj44ob9V1qc9tKNzB5+7bSqZSnq
	oEyZemJuBJMV8g9NqCuwAsLbsvsQyMz34J3EE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlgRCNtAZeRZweQBXGq3A305W5ljkqet
	EefZzHbHduIK3PKI8agNvYuye+cFSTvLCpYFhVn2paRhE8oo4k1XVkzol34oI54i
	IMwwCxDcl6B9cud3KGWCUoeeJb6ne4olGZ1lsjFlw7ZdAI0tQXbIjFNM+geFxRoZ
	R7wzn5/2TrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52FAC5337;
	Thu, 20 Oct 2011 13:15:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC0505336; Thu, 20 Oct 2011
 13:15:27 -0400 (EDT)
In-Reply-To: <20111020090912.GA21471@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Thu, 20 Oct 2011 04:09:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B35AD44-FB3F-11E0-9799-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184031>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Looks good, except I would explain it differently, to avoid referring
> to hypothetical implementation details ("What buffer overflow?"):
>
> 	test: git cherry-pick --continue should cope with long object names
>
> 	A naive implementation that uses a commit-id-shaped buffer
> 	to store the word after "pick" in .git/sequencer/todo lines
> 	would crash often.  Our implementation is not so naive, but
> 	add a test anyway to futureproof it.
>
> Or:
>
> 	test: make sure the "cherry-pick --continue" buffer overflow doesn't come back
>
> 	Before commit ..., "git cherry-pick --continue" would overflow
> 	under ... circumstance.  Add a test to make sure it doesn't
> 	happen again.

I doubt you would need any of that.

You can just explain the commit that stops copying the lines into a
private, fixed buffer a bit better (e.g. "such copying is not just
wasteful but is wrong by unnecessary placing an artificial limit on the
line length"), and say "Incidentally, this fixes a bug in the earlier
round of this series that failed to read lines that are too long to fit on
the buffer, demonstrated by the test added by this patch", or something.

Then the additional test can become part of the patch that corrects the
parsing logic, no?
