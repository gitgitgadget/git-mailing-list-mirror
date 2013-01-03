From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 03 Jan 2013 12:34:27 -0800
Message-ID: <7vip7evwdo.fsf@alter.siamese.dyndns.org>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
 <7vehi2xote.fsf@alter.siamese.dyndns.org>
 <20130103202343.GA4632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:34:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqrV4-0003PJ-Lm
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab3ACUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:34:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737Ab3ACUea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:34:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB802BD45;
	Thu,  3 Jan 2013 15:34:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oYqZzE5xWw7KuAeEoq8nR8nvlN8=; b=Y0v4gW
	botPnCTy534MiyMMi8pUhj0HLevmEYyp8Y+th9r03tiryNYZdVkR4XclanKFvQIv
	qbLXudDrEw0mUfW4FPjtE1jrJU92ATTrecBc76xPjfwWIVfWTMVGQfRuQwRkWuyx
	D0OvnCf9lYmt0eMfYBjFkYBQf4f4PYKzV56QM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3nmoYBIIZXjbAojuZuRTzwKezD8Gj6x
	zaEuicTKlO0oiFrUvIc9JGUxYUJcFj6M3inrTIDQRr6bHcRrtwR/DWno1zjc+nFq
	cAiubmLz060Dno/CjWlFMTS3wLrvh8iKUB+ntoOyB7JBCVrFVWQV4lt+zHT4Hqvj
	bKE9Teohah8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDD2BD44;
	Thu,  3 Jan 2013 15:34:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E544BD43; Thu,  3 Jan 2013
 15:34:28 -0500 (EST)
In-Reply-To: <20130103202343.GA4632@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Jan 2013 15:23:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8DCD9C8-55E4-11E2-96DD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212607>

Jeff King <peff@peff.net> writes:

> Or are you suggesting that the three-way case should always be protected
> by checking that there are no unmerged entries before we start it? That
> seems sane to me, but I haven't confirmed that that is the case.

I think the normal (and hopefully only) "-m -u O A B" use case of
threeway is the bog-standard "git merge", which requires even more:
your index must exactly match HEAD, even though you are allowed to
have local changes in the working tree.

That requirement is not likely to change, as cleanly merged paths
are automatically added to the index, so "diff --cached" should show
only the changes from cleanly merged part, while "diff" should show
paths that still needs user's help.

If we allowed local modification to the index (let alone conflicted
entries in it) before the merge begins, the users would not be able
to tell which paths are in what state after a half-merge stops and
asks for help.  Updated paths may not have anything to do with the
merge (i.e. earlier "git add" before the merge started), conflicting
paths may not have anything to do with the merge (i.e. leftover
conflicts before the merge started).
