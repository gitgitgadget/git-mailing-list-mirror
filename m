From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Wed, 10 Sep 2014 09:51:03 -0700
Message-ID: <xmqq7g1bifm0.fsf@gitster.dls.corp.google.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<20140910081358.GB16413@peff.net>
	<CACsJy8AO5Ni1BNJGa1Wy5ZdX=HNE1UuVM-gnwtHBw01sfcZNrg@mail.gmail.com>
	<20140910103014.GA15461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 18:51:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRl6v-0000gX-H3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 18:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaIJQvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 12:51:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54835 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbaIJQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 12:51:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A0C2B3813A;
	Wed, 10 Sep 2014 12:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BWSUs0KxEgvGb/OLj91hROX/6Dw=; b=LvvuVt
	0MgFGIa3Hr0WpaZtu0RJN+LC6HPs38SCCqSBaWxurKYnBLONo4VtvVADeN2ytjxm
	5d+Wd0Jy0lJ42vSGnjcpZTlPhyGWHQR11UjT/+6rF7R0CNv9j/aq/NvUh6W7cF4Z
	vhq7fTSWb4jHMRwCnD5HTzYHTEq3WhgAUCkdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wx332MNz6ye/TgNi102qCpvYfAQi090O
	8bIweMqv3cy5DQaYiz0psvMfKUyF4FxSy5GMxDyDnTKRVoHdBjDQkOJMr8njNRGX
	X+z2J/4H99ceuUAWkEMz2sJp5ijHwOU5t5duV2CZ0OPsa5ihPQNbsnZz/r8bZ2nX
	ZigEc12tSq8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9496438139;
	Wed, 10 Sep 2014 12:51:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECD9238138;
	Wed, 10 Sep 2014 12:51:05 -0400 (EDT)
In-Reply-To: <20140910103014.GA15461@peff.net> (Jeff King's message of "Wed,
	10 Sep 2014 06:30:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A80E5C5A-390A-11E4-BF47-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256752>

Jeff King <peff@peff.net> writes:

> Yes, we don't let normal fetchers see these repos. They're only for
> holding shared objects and the ref tips to keep them reachable.

Are these individual refs have relations to the real world after
they are created?  To ask it another way, let's say that a branch in
a repository, which is using this as a shared object store, caused
one of these refs to be created; now the origin repository rewinds
or deletes that branch---do you do anything to the ref in the shared
object store at that point?

I am wondering if it makes sense to maintain a single ref that
reaches all the commits in this shared object store repository,
instead of keeping these millions of refs.  When you need to make
more objects kept and reachable, create an octopus with the current
tip and tips of all these refs that causes you to wish making these
"more objects kept and reachable".  Obviously that won't work well
if the reason why your current scheme uses refs is because you
adjust individual refs to prune some objects---hence the first
question in this message.
