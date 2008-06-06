From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Fri, 06 Jun 2008 16:08:45 -0700
Message-ID: <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:10:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4l4e-0006m7-4X
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbYFFXI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756364AbYFFXI5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:08:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbYFFXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:08:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37003375D;
	Fri,  6 Jun 2008 19:08:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 64E25375B; Fri,  6 Jun 2008 19:08:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86DA2DD2-341D-11DD-8A33-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84133>

Paolo Bonzini <bonzini@gnu.org> writes:

> +For example, `git commit --amend` also has this effect, and it can
> +happen that you use it even though you had already pushed to the
> +remote repository before amending your commit.  You can then
> +use `git rebase` (with the --onto option) to transform the `--amend`
> +commit into a separate commit (as if you had not used the `--amend`
> +option).  The situation is like this:
> +
> +------------
> +    o---D---E  origin/master
> +         \
> +          E'---F---G---H---I  master
> +------------
> +
> +because the parent of the amended commit E' is D, that is
> +origin/master^.  To avoid a forced update from master to
> +origin/master, you need the history to look like this:
> +
> +------------
> +    o---D---E  origin/master
> +             \
> +              E''---F'---G'---H'---I'  master
> +------------
> +
> +You can achieve this with:
> +
> +    git-rebase -s theirs --onto origin/master origin/master^ master
> +
> +The merge strategy `-s theirs` resolves conflicts in favor of the commits
> +being rebased---in this case, you know that the only conflicts will occur
> +when replaying E', and you definitely E'' to have those changes.

Isn't this a very risky thing to suggest as if it is a generally
applicable solution?  What happens if others have already worked on top of
E and your history looked like this?

    o---D---E---X---Y  origin/master
         \
          E'---F---G---H---I  master

The reader would want this history:


    o---D---E---X---Y  origin/master
                     \
                      E''--F'--G'--H'--I'  master

where difference between Y and E'' contains the change between E and E'.

However, neither "rebase -s theirs --onto Y D master" (use of D is more in
the spirit of your original example than literal origin/master^) nor
"rebase -s theirs --onto Y origin/master^ master" (which is nonsense but
careless readers would be tempted to "adjust" your example to their
situation) would give such a tree.  E'' should not have the same tree as
E' in this case.

I think I know why you wanted to do it in the original context without X
and Y.  Use of "-s theirs" would allow you to record the tree of E'
without conflicts.  But even that I do not agree is a good thing to do.

Because original E' was an amend of E, its log message explained
everything E did and more.  You cannot leave that same commit message in
E''.  What you did in E was already explained in the history, so now you
would want to talk about the incremental change on top of it when you
desribe E''.  For that, replaying of E' must stop to allow you to fix up
the log message.  It shouldn't silently go on.

Yes, you may want an easy way to say "the result should have the same tree
as E'" while replaying of E' on top of E _when_ you have to resolve the
conflict.  But that is a separate issue ("git checkout $other_head --
$conflicted_paths", or somesuch).  Using this in rebase is a horrible
example inviting misuse and a broken history, I think.
