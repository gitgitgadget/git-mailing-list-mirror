From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 15:00:41 -0700
Message-ID: <xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
	<xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
	<20130917201259.GB16860@sigill.intra.peff.net>
	<xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
	<20130917202917.GA20020@sigill.intra.peff.net>
	<xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
	<20130917212106.GB20178@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 00:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3KD-0004TQ-9C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 00:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3IQWAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 18:00:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab3IQWAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 18:00:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E97174375E;
	Tue, 17 Sep 2013 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B+Ri1pWXf/bA7U+z7szAftRAo0Y=; b=T7lhP1
	/hnAdCFTlONPnzBqHlDsmP9H/qfp76+SbIq1MGiP5FSW17/06kQlU5UZrAN8uSIV
	NVAHGChVHeWZ7InkyPQa45gRjRPhzcRRl2nwIO9++zovXe+KCsZBap66CjujbEW3
	tg+ScIcTKzAdginDQNSeJ+HxDZXUn+ho6fDn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sgPqcKDP6OgsezCFUh8i6GgwqrI6i6Mx
	5RoVrsiriBKe7181PsJFJ2Ny180dSc+Gvf+yoW955g2NY5cDJSbY8XxyJEEemxM6
	QVSu0Ibj9lAnXKAnY+jMpN61jVl69SU3JwM4sKbhptqDDvE+3rovFPBX1pKwkfaI
	frepsmz9ZuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6DF4375D;
	Tue, 17 Sep 2013 22:00:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 422084375C;
	Tue, 17 Sep 2013 22:00:43 +0000 (UTC)
In-Reply-To: <20130917212106.GB20178@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Sep 2013 17:21:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9918F7C2-1FE4-11E3-AA0E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234935>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 17, 2013 at 01:40:17PM -0700, Junio C Hamano wrote:
>
>> Taking the state of a subdirectory as a whole as "content", the
>> change we are discussing will make it more like "rm -fr dir && tar
>> xf some-content dir" to replace the directory wholesale, which I
>> personally think is a good thing in the longer term.
>
> Yeah, that makes sense. What about untracked files?

Obviously we cannot literally do "rm -fr dir && tar x", but I agree
that if tree-ish has a path that is not tracked in the current
index, the path should be overwritten and made identical to what is
in the tree-ish.

> Right now we overwrite them if the tree-ish has an entry at the same
> path; that is a bit more dangerous than the rest of git, but does match
> the "ignore local modifications" rule. I assume if we handled deletions,
> though, that we would simply leave them be.
>
> So given that, is it fair to say that a one-way "go here" merge, limited
> by pathspec, is the closest equivalent?

Sorry, but it is unclear to me what you mean by one-way "go here"
merge.  Do you mean oneway_merge() in unpack-trees.c?
