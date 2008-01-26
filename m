From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull --rebase: be cleverer with rebased upstream branches
Date: Sat, 26 Jan 2008 11:34:05 -0800
Message-ID: <7vk5lwz8ia.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site>
	<7vir1nxcoh.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801261801360.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 26 20:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIqnb-0005zq-Sq
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 20:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYAZTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 14:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYAZTeN
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 14:34:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbYAZTeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 14:34:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C26B94473;
	Sat, 26 Jan 2008 14:34:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 26080446F;
	Sat, 26 Jan 2008 14:34:08 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801261801360.23907@racer.site> (Johannes
	Schindelin's message of "Sat, 26 Jan 2008 18:04:37 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71787>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When the upstream branch is tracked, we can detect if that branch
> was rebased since it was last fetched.  Teach git to use that
> information to rebase from the old remote head onto the new remote head.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This is certainly nicer than the original (which is not in
1.5.3, so even this late in the cycle it is "fixing up a new
feature we will be introducing in 1.5.4" category that I will
apply).  But I think a bit of caution and perhaps an
illustration or two in the doucmentation would help.

If you do "git fetch" from the origin since the last time you
ran "pull --rebase" for the remote, we will have the same
issue.  Suppose you have this history:

                   .---x---x---x
                  /
         .---A---B
        /
    ---0---o---o---A'--B'--C'--D'
                \
                 o---o---A''-B''-C''-D''-E''

Originally your upstream had 0---A---B; you built your 'x' on
top of it.  Then the upstream rebases and publishes history that
leads to D' (i.e. A and B are rewritten).  Later, the history is
further rewritten and E'' is the latest upstream tip.

If you haven't done "git fetch" since you started building on
top of B, refs/remotes/ will still say B and using B as base
(and E'' as onto) will give you the right rebase.  Earlier, we
did not use B in the rebase in any way, so your patch is
definitely an improvement.

However, if you have run "git fetch" (say, to peek what the
upstream has been up to), your refs/remote/ may say D'.  Using
that as the base and rebasing onto E'' is not quite optimal,
isn't it?

So it might make sense to make the logic to figure out B, given
your local history that leads from 0 to x's (and nothing else),
a bit cleverer than looking at the tracking branch.  We can look
at reflog for example.  "git log -g --pretty=oneline" may have
entries of this form:

    * branch: Created from B
    * rebase finished <branch> onto B

and the latest (i.e. younguest) entry is where the part of your
current history to be rebased (i.e. base commit) starts.  This
is much more reliable than looking at the tracking branch, whose
answer may or may not match B at all.

I do not mean this comment makes your approach invalid, though.
It is a start in the good direction.
