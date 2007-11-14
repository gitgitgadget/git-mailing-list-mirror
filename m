From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert/cherry-pick: allow starting from dirty work tree.
Date: Tue, 13 Nov 2007 17:05:23 -0800
Message-ID: <7vy7d1prfw.fsf@gitster.siamese.dyndns.org>
References: <7vd4udsv6b.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711132154370.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6hS-0002UP-G2
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761694AbXKNBF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759415AbXKNBF3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:05:29 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51220 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760816AbXKNBF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:05:28 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 63CB12F2;
	Tue, 13 Nov 2007 20:05:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DC5A395801;
	Tue, 13 Nov 2007 20:05:46 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711132154370.4362@racer.site> (Johannes
	Schindelin's message of "Tue, 13 Nov 2007 23:37:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64934>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But the more fundamental question is: should we eventually have a mode in 
> cherry-pick (or for that matter, apply!) which can change the submodule?  
> And if so, how to go about it?

I think that would be handled in exactly the same way as
switching between two branches that bind different commits at
the submodule path.

Your work tree and index knows commit X is at the path, an
operation wants to have commit Y at the path as its result.

What's next?

It does not make much difference what that "an operation" is.
It can be apply, cherry-pick, revert, merge, or branch
switching.  I think they can and should follow the same rules.

The most important rule is not to lose local changes, be they in
the index or in the work tree.  So "an operation" would error
out if the index does not match HEAD at such a path, and the
work tree does not match the index.

The implementation of "work tree does not match the index" is
different when you are talking about a regular blob vs a
submodule.  For a blob you know what we do.  For a submodule, I
would imagine that we would check if both the index matches the
HEAD and the work tree matches the index in the submodule
(this would go recursively).

And after making sure we won't lose local changes, we switch the
submodule directory from commit X to commit Y.  Most likely
detaching the HEAD with "cd sub && git checkout Y^0" or
something like that.

Then probably there will be an option added to loosen that "work
tree matches the index" check and uses "-m" option to the
checkout in the submodule directory.

More tricky is what to do with a submodule that would disappear,
though.  For that, we would want .git/subprojects/foo.git/ trick
we have discussed in the past or something similar.
