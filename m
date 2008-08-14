From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Thu, 14 Aug 2008 01:26:32 -0700
Message-ID: <7vljz0dmtj.fsf@gitster.siamese.dyndns.org>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
 <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
 <7v1w0sjw47.fsf@gitster.siamese.dyndns.org> <20080814001858.GB14939@cuci.nl>
 <7v63q4ieqw.fsf@gitster.siamese.dyndns.org> <20080814074717.GC9680@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 14 10:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTYBO-0007XX-09
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 10:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYHNI0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 04:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYHNI0n
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 04:26:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYHNI0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 04:26:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6530758D11;
	Thu, 14 Aug 2008 04:26:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 31E6958D0B; Thu, 14 Aug 2008 04:26:34 -0400 (EDT)
In-Reply-To: <20080814074717.GC9680@cuci.nl> (Stephen R. van den Berg's
 message of "Thu, 14 Aug 2008 09:47:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B78A09F0-69DA-11DD-978B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92335>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> Solution A is what you propose, but which I find less appealing because
> any future magic to actually setup the handler needs to be maintained
> and updated in two places.

Well, A is attractive because it leaves the window open for us to later
not rearming it unconditionally from child_handler().  I happen to think
that the interface we will use to call "signal()" is much less likely to
change than what we would do in child_handler().

> Solution C is what follows your train of thought better, because it
> future-proofs the setup as well as the handler.

Surely, we could take this route as the logical conclusion from my
maintainability concerns, except that, if we are to make things as fine
grained as you suggest, we would definitely will not have a single
"setup", but "setup" and "rearm" as separate functions.  Perhaps "setup"
may start using sigaction() with SA_RESETHAND cleared, and we can make
"rearm" truly a no-op everywhere.

 
