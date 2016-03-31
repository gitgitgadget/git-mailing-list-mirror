From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during initial fetch
Date: Thu, 31 Mar 2016 11:56:38 -0700
Message-ID: <xmqq1t6qo4rd.fsf@gitster.mtv.corp.google.com>
References: <20160307153304.GA23010@sigill.intra.peff.net>
	<1459349623-16443-1-git-send-email-szeder@ira.uka.de>
	<xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:56:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhlz-0007oL-32
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbcCaS4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:56:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbcCaS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:56:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FC8F51434;
	Thu, 31 Mar 2016 14:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WBXfjetewQNQhfHMshuRxJw9erU=; b=Bzp2G2
	AZm+w4Rso3DEKwKu/sX7vxYMALEORmDQZ8mhv6W0II51JIrEunDWaGhqK0SMSxWW
	CWmETyGHpp8Qp/lGpPx6wJU+nDP9gktwUTP8WF2vCjnmq6d/m0wRD0rFbyOWz1Vr
	2D6Dw+RFFeqKRotGrud1C+bVXvQZ/mw2YOvz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kehg2TYAENH2/zOWbyYqeTgP+LiW57ls
	RmcQohnObdeg/RSjFQfNgf6b40PgbjvDhVdHEvMjPLFVB2uDA8F20jE25wkZUnOb
	O3MmYTCjZZgELaUqQ7NoFWA6Wk8/UVhvsjy0o9ZTaNXBaJTOUmxzDTLk1qAl8hbP
	Ox2vIjtOecE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67A0F51433;
	Thu, 31 Mar 2016 14:56:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CEBAB51431;
	Thu, 31 Mar 2016 14:56:39 -0400 (EDT)
In-Reply-To: <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 31 Mar 2016 09:15:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4D3967E8-F772-11E5-94A6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290446>

Junio C Hamano <gitster@pobox.com> writes:

> Is the expectation like this?
>
>     git init
>     git config ... # set default configuration and origin remote
>     git config var val # update with what "-c var=val" told us
>     git fetch
>     git checkout   # unless '--bare' is given
>
> or is it something else?
>
> Is "-c var=val" adding to the config variables set by default, or is
> it replacing them?  Does the choice depend on the nature of
> individual variables, and if so what is the criteria?
>
> Are all "-c var=val" update the configuration of the resulting
> repository?  Or are certain "var"s treated as special and placed in
> the config but not other "var"s?  If the latter, what makes these
> certain "var"s special?
>
> These design decisions need to be explained so that they will serve
> to guide people to decide what other variables to propagate and how
> when they have to add new configuration variables in the future.
> Otherwise we'd end up with an inconsistent mess.

The above did not start as rhetorical questions, but was merely me
thinking aloud.  However, it showed me a different approach might be
more appropriate.

Taken as rhetorical questions, the sane answers to them would
revolve around "we do not know the semantics of each and every
configuration variable that will be given to this codepath, and by
definition we will never know in advance the ones that will be
introduced later".  IOW, special casing -c remote.origin.fetch=spec
is a bad idea.

So how about teaching "git clone" a new _option_ that is about what
branches are followed?

	git clone $there --branches="master next pu"

would give

	[remote "origin"]
        	fetch = +refs/heads/master:refs/remotes/origin/master
        	fetch = +refs/heads/next:refs/remotes/origin/next
        	fetch = +refs/heads/pu:refs/remotes/origin/pu

instead of the usual

	[remote "origin"]
		fetch = +refs/heads/*:refs/remotes/origin/*

And that can be made to work orthognonal to --single-branch by a
small additional rule: if the branch given by -b <name> (or their
HEAD) is not part of --branches, then we add it to the set of
branches to be followed (i.e. if you give only --single-branch,
without --branches, the set of branches to be followed will become
that single branch).

Hmm?
