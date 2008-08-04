From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Sun, 03 Aug 2008 19:06:51 -0700
Message-ID: <7vwsix5y9w.fsf@gitster.siamese.dyndns.org>
References: <200808040057.00221.johan@herland.net>
 <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <200808040147.16797.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 04:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPpUV-0005dn-Hh
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYHDCHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYHDCHA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:07:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYHDCG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:06:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C01A64D77A;
	Sun,  3 Aug 2008 22:06:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A5824D779; Sun,  3 Aug 2008 22:06:52 -0400 (EDT)
In-Reply-To: <200808040147.16797.johan@herland.net> (Johan Herland's message
 of "Mon, 04 Aug 2008 01:47:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03E6FE16-61CA-11DD-9A9F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91302>

Johan Herland <johan@herland.net> writes:

> 1. Consistency: Other git commands in the supermodule does _not_ require the 
> URL rewriting rule to reside in the global config. Why should 'git 
> submodule' be different.

When it comes to "submodules", I do not think such consistency argument
makes much sense.  "git submodule" command crosses module boundary, normal
commands don't.  They are naturally different and they should be.

Your kind of consistency means breaking the separation between module
boundary, doesn't it?

Having said that...

> 2. I believe there are valid use cases for adding URL rewriting rules to the 
> repo config instead of the global config. You may want to check out Fred's 
> version of project X (including submodules), without making your other 
> clones of project X start cloning/fetching from Fred.

I think you are referring to the example given in an earlier thread to
peek what your neighbor did between you two, without affecting other
people.

Personally I think it is partly showing the shortcoming of the current
"git submodule" that minimally supports the workflow to follow what the
canonical repository does, and partly showing that it is an abuse of that
interface to rewrite config file to temporarily switch to peek somewhere
else in such a workflow.

Let's step back and think what we would do if there is no submodule
involved.  That is, you usually follow origin, but you temporarily want to
peek at what Fred did.  How would you do this?

	$ git fetch $fred $branch_fred_wants_you_to_review
        $ git checkout FETCH_HEAD ;# this detaches HEAD.

And you take a look around.  Perhaps you like the change and decide to
merge that to your branch.  Perhaps you create your own branch on top of
that state, build a few fix-up commits, and give the result back to Fred.

Shouldn't peeking what Fred did in the whole submodule hierarchy be
essentially the same thing?  That is,

	$ git submodule for-each-submodule sh -c '
                git fetch "$fred/$1" $branch_fred_wants_you_to_review &&
                git checkout FETCH_HEAD
	' -

where "for-each-submodule" would iterate over the submodules in the
current superproject that you are interested in (that is, you actually
have corresponding repositories there), and runs any given command with
the path to the submodule in that directory.

Hmm?
