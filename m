From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 14:05:46 -0800
Message-ID: <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org>
References: <4790BCED.4050207@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFzMC-0001uk-9Z
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 23:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760875AbYARWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760824AbYARWGF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 17:06:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760094AbYARWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 17:06:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 26847556F;
	Fri, 18 Jan 2008 17:06:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 88FC1556D;
	Fri, 18 Jan 2008 17:05:58 -0500 (EST)
In-Reply-To: <4790BCED.4050207@gnu.org> (Paolo Bonzini's message of "Fri, 18
	Jan 2008 15:51:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71069>

I do not particularly like hooks that act before or after an
operation is initiated locally, act solely on local data.  This
is maybe because I still consider git tools building blocks
suitable for higher level scripting more than other people do.

There are five valid reasons you might want a hook to a git
operation:

 (1) A hook that countermands the normal decision made by the
     underlying command.  Examples of this class are the update
     hook and the pre-commit hook.

 (2) A hook that operates on data generated after the command
     starts to run.  The ability to munge the commit log message
     by the commit-msg hook is an example.

 (3) A hook that operates on the remote end of the connection
     that you may not otherwise have access to other than over
     the git protocol.  An example is the post-update hook.

 (4) A hook that runs under a lock that is acquired by the
     command for mutual exclusion.  Currently there is no
     example, but if we allowed the update hook to modify the
     commit that was pushed through send-pack => receive-pack
     pair, which was discussed on the list a while ago, it would
     be a good example of this.

 (5) A hook that is run differently depending on the outcome of
     the command.  The post-merge hook conditionally run by
     git-pull is an example of this (it is not even run if no
     merge takes place).  Another example is the post-checkout
     hook that gets information that is otherwise harder to get
     (namely, if it was a branch checkout or file checkout --
     you can figure it out by examining the command line but
     that already is part of the processing git-checkout does
     anyway, so no need to force duplicating that code in the
     userland).

You cannot do an equivalent operation from outside the git
command for the above classes of operations.  You need hooks
for them.

On the other hand, if you want to always cause an action before
running a git opeation locally, you do not have to have a hook.
You can just prepare such a message based on GNU ChangeLog and
then run git-commit with -F, both inside your wrapper.

Of course there can be a very valid exception to the above
policy.  If it is common enough so that the policy means
effectively everybody has to reinvent the same wrapper.  But for
this particular case I still do not see that is the case.
