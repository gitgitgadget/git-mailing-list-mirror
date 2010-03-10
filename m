From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rebase -i prunes commits with empty commit-message
Date: Wed, 10 Mar 2010 11:53:22 -0800
Message-ID: <7veijsrm19.fsf@alter.siamese.dyndns.org>
References: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
 <4B979AEF.5010201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 10 20:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpRyM-00066F-Rm
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab0CJTxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 14:53:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab0CJTxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 14:53:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C2DA0BEF;
	Wed, 10 Mar 2010 14:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZMIQHPlZEQ/F8piLzBYalTkByOc=; b=KJ5YBb
	kjblvc4e2UqUDcZe2Fhe6wm2mHfRjnxZ8eD8Zc8pq0kRFcOigry6+XksDJfxOwpU
	99Hxh78bv5Bxd4PWdvyCNTc7SdcD2pPmOOOy1Ls3NW5F7n4cqJ4+KkFOP/FZr0dV
	k9fyfWjp+i2wuj1WQ94xUZVBM2VSrUv1PxtAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aD349P+HqZjvgEXEDygLEtAOdjmyQ8cU
	IA7xTn0/QxzmXnlpx+8BimkpZD+0PIPFSHhfT0TvupCKt50h9H4ypZ9CCJRQ9gOS
	0EfWjB7K0BpU/LSsZCJ0gVSawOZIhGVuS7lgji0euzbNv55Lq635pXiWYwKIcRpH
	xQ8lrxOVmgc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D63A0BEB;
	Wed, 10 Mar 2010 14:53:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDA24A0BEA; Wed, 10 Mar
 2010 14:53:23 -0500 (EST)
In-Reply-To: <4B979AEF.5010201@alum.mit.edu> (Michael Haggerty's message of
 "Wed\, 10 Mar 2010 14\:13\:19 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9843EA1C-2C7E-11DF-8137-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141914>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Does git really claim to handle commits with empty commit messages?

Yes, I would say it is a bug in rebase-i if it refuses to deal with
histories with such commits.  Warning and giving the user a chance to
add message _might_ be good, but allowing no way out would be
inexcusable.  Even adding a fake "(original commit had no message)"
as the message and continuing would be better than stopping or
dropping commits.

The Porcelain "git commit" by default complains if you do not give any
message, because it usually is an end-user mistake to directly use
"git commit" and not writing anything about the resulting commit.
However,

 (1) The plumbing allows it because such a policy to forbid commits
     without comments does not belong there, e.g. this would succeed:

     $ git commit-tree HEAD^{tree} </dev/null

 (2) Even the Porcelain allows it if you ask nicely:

     $ git commit --cleanup=verbatim -m ''

These are primarily so that you can deal with histories created by
other people's tools (e.g. foreign SCM, third party Porcelains, etc.).
You do not have much control over histories created by them, and our
commit creating commands need to be usable as an ingredient for you to
write conversion tools (like filter-branch or rebase-i).
