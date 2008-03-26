From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/4] Head reduction before selecting merge strategy
Date: Wed, 26 Mar 2008 09:17:56 -0700
Message-ID: <7vlk45e9xn.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803252058k2f35b33fr99ec7446235eeb6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeYM2-0007xu-Ua
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 17:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943AbYCZQSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbYCZQSM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 12:18:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813AbYCZQSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 12:18:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BDB42F8D;
	Wed, 26 Mar 2008 12:18:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7B0B62F88; Wed, 26 Mar 2008 12:18:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78287>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> @@ -133,6 +133,47 @@ merge (which is typically a fraction of the whole
> tree), you can
>  have local modifications in your working tree as long as they do
>  not overlap with what the merge updates.
>
> +If more than one commit are specified for the merge, git will try to
> +reduce the number of commits (real parents) by eliminating commits
> +than can be reached from other commits...

In 3/4 you defined "real parents" as "the commits specified to be merged
from the command line", and you are picking only the independent ones out
of "real parents" to change the set of parents used for the merge
operation.  What is the reduced set called?

> +...  The commit message will
> +reflect the actual commits specified but the merge strategy will be
> +selected based on the real parents, but always including `HEAD`....

Now your terminology gets the other way around and reduced ones are called
"real" and the earlier "real parents" are now called "actual".

I think "real" vs "actual" is an invitation for "which is which"
confusion.  How about calling them "given" vs "reduced"?

Anyway, "the commit log message talks about the commits specified by the
end user, but the command outsmarts the user and does something different".

> +... The
> +real parents (only including `HEAD` if it is real) are the parents
> +recorded in the merge commit object.

Specifically, "does something different" above is "does not record some of
the commits given by the end user as parent commit of the resulting
merge".  Hence the name of the operation: "head reduction".

While I suspect that it would make sense to simplify parents, I do not
see why the seemingly deliberate discrepancy between what is recorded as
the parents (i.e. "reduced parents" on "parent " lines of the resulting
merge) and what the log message talks about (i.e. "given parents" you feed
to fmt-merge-msg) is a good idea.  Isn't it more consistent and easier to
explain to the users if they match?  Also it might be arguable that this
head reduction should be an optional feature.

> +The following shows master and three topic branches.  topicB is based
> +on topicA, topicA is previously branched off from master, and topicC
> +is based on the current `HEAD` of master:

We do not say "HEAD of branch".  HEAD spelled in all capital always means
"that pointer thing directly under $GIT_DIR that typically talks about
which branch we are on but sometimes can be detached to name a commit
directly."  Call it the "tip of the master branch".

> +------------
> +                    o---o---o  topicB
> +                   /
> +          o---o---o  topicA
> +         /
> +    o---o---o---o---o---o  master
> +                         \
> +                          o---o  topicC
> +------------
> +
> +A merger of master with topicA, topicB, and topicC will select the

"Merging topicA, B and C to the master branch will select" may be easier
to understand.

> +merge strategy based on the three branches master, topicB, and topicC
> +(topicA is eliminated since it can be reached from topicB).  topicB
> +and topicC are the only real parents and are therefore the only
> +parents recorded in the merge commit object:

> +------------
> +         % git checkout master
> +         % git merge topicA topicB topicC

Please do not use C-shell in our examples.

> +
> +                    o---o---o  topicB
> +                   /         \
> +          o---o---o  topicA   \
> +         /                     \
> +    o---o---o---o---o---o       o  master
> +                         \     /
> +                          o---o  topicC
> +------------

I suspect this would be a _very_ unexpected behaviour to untrained eyes
and would be a source of confusion.  You were on 'master' and merged many
things into it, but the resulting commit does not have 'master' as its
first parent.  So far, ORIG_HEAD would always have matched HEAD^1 unless
you fast-forwarded.  This alone may be a reason enough that this behaviour
can never be the default.

> diff --git a/git-merge.sh b/git-merge.sh
> index 2acd2cc..5398606 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -209,24 +209,41 @@ parse_config () {
> ...
> +                       # This will preserve the order the user gave.
> +                       ff_head=${real_parents%%$LF*}

"%%$LF*"?  Heh, that's clever.
