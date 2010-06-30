From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Wed, 30 Jun 2010 08:15:00 -0700
Message-ID: <7vbpas8scr.fsf@alter.siamese.dyndns.org>
References: <20100628080234.GA7134@pvv.org>
 <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org> <4718B1FE-4525-41C2-A4D3-27E99C5A6973@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 17:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTz3T-00017b-4n
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab0F3PPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:15:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab0F3PPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:15:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7EAC06BD;
	Wed, 30 Jun 2010 11:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jzXNGk2V8J8cogPyqgTvaye2VEs=; b=smo5HJ
	u275AXn+L/I5tFA8A/G2ax32yZrXs2sRoIrLJCbg+HtItdp5umYLDYH+0rqz3Gxy
	0cqpeZh4VBSlc7RT7svfDoHp3SOgMO8dzcoxw2dAnaV2F31mvSInlWHCrcK/AilQ
	Y17Z8TUOmi6i4nPFGu1qQclDDEsG2dLZ5Fmes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pBGJciw//C+R6hxW6kt+msU5yXppKaj/
	EsJ2SrpNQ7jhNV9mb9mBxD6VSgXgTUHH4QIp1FZJIciFSTcrAANPd5bvc9yhhLi4
	poiXLI9WY4I2gVl/r2gUc7lbM+5h35OKMhJhdUJQ94pWNSzCNfUgq4ryYyvmYqHg
	Z6uvRfbcRFE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A93C06BC;
	Wed, 30 Jun 2010 11:15:07 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C325C06B4; Wed, 30 Jun
 2010 11:15:02 -0400 (EDT)
In-Reply-To: <4718B1FE-4525-41C2-A4D3-27E99C5A6973@gmail.com> (Eyvind
 Bernhardsen's message of "Wed\, 30 Jun 2010 10\:20\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 444B30B2-845A-11DF-9689-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149962>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> Are you thinking that we could check changes in .gitattributes during a
> merge and only turn on normalization for those files where relevant
> attributes have changed?

Nothing that elaborate.

I was envisioning that we would compare object names of the .gitattributes
files in directories that lead to the path being merged in three trees,
and we use the new slowpath unless all three match.  You could look _into_
the actual contents of .gitattributes and decide that a particular change
does not affect the path you are merging, but I don't think it is worth
it; sane people are expected not to flip CRLF/LF around many times a day
anyway, so changes to .gitattributes should already be rare events.

We will be walking the trees in parallel while merging anyway, so when you
have to merge a/b/c.txt, we would already have opened the top-level tree,
tree "a", and tree "a/b" already, and we should be able pick up the object
name of .gitattributes, a/.gitattributes and b/.gitattributes cheaply
without opening any extra object.
