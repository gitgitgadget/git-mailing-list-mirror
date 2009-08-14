From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Thu, 13 Aug 2009 23:32:59 -0700
Message-ID: <7vocqiucpw.fsf@alter.siamese.dyndns.org>
References: <20090813103231.GY14475@mail-vs.djpig.de>
 <20090813111933.GZ14475@mail-vs.djpig.de>
 <7vd46zbjae.fsf@alter.siamese.dyndns.org>
 <20090814060307.GA31721@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqMH-0001wJ-Q3
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZHNGdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbZHNGdF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:33:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZHNGdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:33:04 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AB5190DD;
	Fri, 14 Aug 2009 02:33:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7521390DB; Fri, 14 Aug
 2009 02:33:00 -0400 (EDT)
In-Reply-To: <20090814060307.GA31721@auto.tuwien.ac.at> (Martin Koegler's
 message of "Fri\, 14 Aug 2009 08\:03\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 521D8C72-889C-11DE-8586-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125902>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> To introduce a object with one of its linked objects missing, left it
> out of the pack and push it into the repository. unpack-objects will
> unpack all objects and fail updating the ref (but leave all objects in
> the repository). As second step, simply send a ref update request,
> which should succed, as the object is present in the repository.

Your "ref update request" exploit does not work because your understanding
of how we decide to allow updating a ref is flawed.

We do not blindly update a ref to a commit only because we happen to have
that commit.  We require that commit to reach existing tips of refs
without break.  The logic is in quickfetch() in builtin-fetch.c.

This stronger validation is necessary to deal with any failed transfer by
http walkers, so it is nothing unusual nor new.  They walk from the latest
commits that exist on the other side, and their object transfer can be
interrupted before they transfer enough older commits to make the history
connected with what we already had.  In such a case we obviously do not
update any ref.  And when we re-run the same request, we do not say "Ah,
we have the tip in the object database, so we will update the ref to it".

That is why I said requiring connectivity is a good idea, but keeping them
in core is a misguided waste of memory.
