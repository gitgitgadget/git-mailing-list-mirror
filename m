From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Mon, 02 Feb 2009 20:30:36 -0800
Message-ID: <7v7i48f8gj.fsf@gitster.siamese.dyndns.org>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
 <20090131071238.GC3033@coredump.intra.peff.net>
 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
 <20090131215514.GB9415@coredump.intra.peff.net>
 <7v7i4b2bto.fsf@gitster.siamese.dyndns.org>
 <20090202130755.GA8487@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:32:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUCxH-0005TC-LT
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZBCEap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZBCEap
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:30:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZBCEao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:30:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13E4D96326;
	Mon,  2 Feb 2009 23:30:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3AC896325; Mon,
  2 Feb 2009 23:30:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B29B2A0-F1AB-11DD-9606-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108140>

Jeff King <peff@peff.net> writes:

> The hardlink code operates by default because it was thought to be a
> safe optimization that couldn't bite people. But it interacts badly with
> the concept of alternates.

Yes, you are right.

To be fair, I think it was proposed/implemented by somebody who almost
never uses alternates himself, and certainly never a relative alternates.
The intention of hardlinking was while saving tons of disk space, still be
independent from the original repository.

Back when e95ab1e ([PATCH] Short-circuit git-clone-pack while cloning
locally (take 2)., 2005-07-06) was done, the packfile implementation was
still only a week old, and hardlinking made a lot of sense from space
saving's point of view.  These days, if you make a local hardlinked clone,
work a little there and then repack it, most of the space saving will be
gone; there isn't much point in the hardlink optimization anymore from
that angle, even though it still is a good compromise between the clone
speed and safety, especially when no alternates are involved.

I think a possible fix would be not to copy alternates file literally, but
install an alternates file to directly borrow from the same repositories
the clone-source repository borrows from ourselves, taking relative paths
into account.  Another would be to look at the alternates and hardlink the
objects and packs while cloning, and if the repositories involved reside
across filesystem boundaries, we need to fall back to copying.
