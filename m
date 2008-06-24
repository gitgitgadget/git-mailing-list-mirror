From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 15:31:12 -0700
Message-ID: <7v8wwubh3j.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
 <20080624163810.GA4654@sigill.intra.peff.net>
 <alpine.DEB.1.00.0806241750030.9925@racer>
 <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu>
 <alpine.DEB.1.00.0806242137120.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBH46-0002rc-S0
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbYFXWbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbYFXWbr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:31:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYFXWbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:31:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE6508C33;
	Tue, 24 Jun 2008 18:31:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC4C48C32; Tue, 24 Jun 2008 18:31:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44527702-423D-11DD-81C2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86159>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 24 Jun 2008, Michael Haggerty wrote:
> ...
>> It seems to me that your problem is that git-bisect requires the "good" 
>> revision to be older than the "bad" one.  If this requirement were 
>> removed, would there still be a need for "fixed" vs. "unfixed"?
>
> Nope.
>
> The thing that makes "fixed" and "bad" special is that _one_ commit 
> introduced that.

That was my initial reaction, and I actually was about to phrase it more
bluntly: you do not understand what "bisect" is.

But that was a reaction without thinking things through.  It may not be
what "git bisect" currently is, but the suggestion does not go against
what the underlying "git rev-list --bisect" is at all.  I think what
Michael is speculating is different, and it makes sense in its own way.

Instead of having a set of bisect/good-* refs and a single bisect-bad ref,
your "fixed and unfixed" mode could work quite differently.  By noticing
that the topology the user specified with initial good and bad have
ancient bad and recent good --- that is, "it used to be bad but now it is
good" --- you could instead use a set of bisect/bad-* refs and a single
bisect-good ref, and feed good and bad swapped to "rev-list --bisect" in
bisect_next().  That way, the labels given by visualize will match what
the user is doing automatically.

I said "it makes sense in its own way", because it is _quite_ different
from how git-bisect currently assumes, and restructuring git-bisect to
operate naturally in a way Michael describes would be a much larger
surgery with costs (including risks of bugs) associated with it, which
needs to be weighed in when judging that approach would actually make
sense.
