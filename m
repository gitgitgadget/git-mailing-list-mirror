From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Sun, 07 Sep 2008 10:28:56 -0700
Message-ID: <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org>
References: <20080907103415.GA3139@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 19:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcO5T-0002j3-HW
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 19:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYIGR3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 13:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbYIGR3E
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 13:29:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbYIGR3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 13:29:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CBC45A158;
	Sun,  7 Sep 2008 13:29:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 65C735A154; Sun,  7 Sep 2008 13:28:58 -0400 (EDT)
In-Reply-To: <20080907103415.GA3139@cuci.nl> (Stephen R. van den Berg's
 message of "Sun, 7 Sep 2008 12:34:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75DB8980-7D02-11DD-9AAF-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95154>

"Stephen R. van den Berg" <srb@cuci.nl> writes:
> The questions now are:
> - Would there be good reason not to record the backport/forwardport
>   relationship in the additional parents of a commit?

In general, I do not think what you did is a good idea.  The _only_ case
you can do what you did and keep your sanity is if you cherry-picked every
single commit that matters from one branch to the other.

If something is not "parent", you shouldn't be recording it as such.

Remember, when you are making a commit on top of one or more parents, you
are making this statement:

 * I have considered all histories leading to these parent commits, and
   based on that I decided that the tree I am recording as a child of
   these parents suits the purpose of my branch better than any of them.

This applies to one-parent case as well.

Imagine you have two histories, forked long time ago, and have side-port
of one commit:

             o---...o---B---A
            /
        ---o---o---...o---X---A'

What side-porting A from the top history to create A' in the bottom
history means is that the change between B and A in the top history, and
no other change from the top history, is applied on top of X to produce
state A' in the bottom history.  What B did is not included in the bottom
history.

If you recorded A' with parents A and X.  Here is what you would get:

             o---...o---B---A
            /                \ (wrong)
        ---o---o---...o---X---A'

But that is not what you did.  The tree state A' lacks what B did, which
could be a critical security fix, and you didn't consider all history that
leads to A when you cherry-picked it to create A'.

To put it another way, having the parent link from A' to A is a statement
that A' is a superset of A.  Because A contains B, you are claiming A'
also contains B, which is not the case in your cherry-picked history.
