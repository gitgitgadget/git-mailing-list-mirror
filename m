From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sun, 08 Mar 2009 14:53:32 -0700
Message-ID: <7v7i2zk7fn.fsf@gitster.siamese.dyndns.org>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <7v63ikmz11.fsf@gitster.siamese.dyndns.org>
 <B0CBEE84-0F46-4AF2-86B1-C80BADAEF4E5@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQy6-0003to-Jl
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbZCHVxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbZCHVxo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:53:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbZCHVxn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:53:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D05514E1F;
	Sun,  8 Mar 2009 17:53:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0FD914E1E; Sun, 
 8 Mar 2009 17:53:33 -0400 (EDT)
In-Reply-To: <B0CBEE84-0F46-4AF2-86B1-C80BADAEF4E5@pobox.com> (Chris
 Johnsen's message of "Sun, 8 Mar 2009 16:09:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94DE91E8-0C2B-11DE-B1F4-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112650>

Chris Johnsen <chris_johnsen@pobox.com> writes:

> My confusion was that I took "usually a mistake" to refer to the case
> where the user meant to commit content changes but forgot to first
> stage any changed content. But your clarification shows that "usually
> a mistake" really means that making any empty commit, intentional or
> not, is (considered to be) a fundamental misuse of SCM machinery.

The empty commits in your example a few messages ago are used as "piss in
the snow" marking.  If you did not have tags (and commit notes), it may be
the only workaround to say "here is an interesting point", but even then
such a workaround can only be made while the commit is at the tip, and be
made useful only by forcing all the other commits on the branch be on top
of that "piss in the snow" commit, so it is a flawed workaround.

Suppose you have this history.

 ---A---B---C

You found that the point C is interesting in some way, so you mark it:

 ---A---B---C---P

But somebody else may have developed on top of C bypassing P

              D---E---F
             /
 ---A---B---C---P

What would you do in such a case?  You cannot leave P dangling, as that
would mean P will not participate in future rebases (and you do not want
to rebase P on top of F because C is the point that is interesting to you,
not F).  Do you merge F and P only to make P not dangling?  What does such
a merge mean?

Worse yet, if you stared from the original history with three commits, how
would you mark that B is interesting?

          P   D---E---F
         /   /
 ---A---B---C


The facility git and other SCM offer you to leave such mark (possibly
after the fact) is to use tags.

So in your particular "piss in the snow" usage, I would agree that such an
empty commit is a misuse.

I am not however claiming that all uses of an empty commit are fundamental
misuses here, though.  Somebody else may have other valid uses.
