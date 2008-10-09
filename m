From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2] Documentation: add manpage about workflows
Date: Thu, 09 Oct 2008 05:50:52 -0700
Message-ID: <7v8wsyortf.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0810010254k5961b182ked9acda55e2aa57c@mail.gmail.com>
 <1223552537-6918-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <santi@agolina.net>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 09 14:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knv0C-00031R-2M
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 14:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895AbYJIMvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYJIMvM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 08:51:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbYJIMvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 08:51:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6783788A54;
	Thu,  9 Oct 2008 08:51:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 16A8088A53; Thu,  9 Oct 2008 08:50:56 -0400 (EDT)
In-Reply-To: <1223552537-6918-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Thu, 9 Oct 2008 13:42:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1EF4A86-9600-11DD-9AD8-FA2D76724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97847>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> new file mode 100644
> index 0000000..037ace5
> --- /dev/null
> +++ b/Documentation/gitworkflows.txt
> @@ -0,0 +1,362 @@
> +gitworkflows(7)
> +===============
> ...
> +DESCRIPTION
> +-----------
> +
> +This document attempts to write down and motivate some of the workflow
> +elements used for `git.git` itself.  Many ideas apply in general,
> +though the full workflow is rarely required for smaller projects with
> +fewer people involved.

Hmm.  Even though I have to wonder if the workflow used in git.git should
be treated as a representative BCP.  For one thing, git.git is on the
smaller end of the spectrum (from the point of view of the size of the
codebase, but not from the size of the contributor base), it is something
we know well enough and probably is a good place to take examples from.

> +Graduation
> +~~~~~~~~~~
> +
> +As a given feature goes from experimental to stable, it also
> +"graduates" between the corresponding branches of the software.
> +`git.git` uses the following 'main branches':
> +
> +* 'maint' tracks the commits that should go into the next "maintenance
> +  release", i.e., update of the last released stable version;
> +
> +* 'master' tracks the commits that should go into the next release;
> +
> +* 'next' is intended as a testing branch for topics not stable enough
> +  for master yet.

s/not stable enough/being tested for stability/;s/ yet//;

The point being that commits on next are deemed stable enough from code
inspection but are kept out of master for a while because your maintainer
wants to be extra careful.

> +Topic branches
> +~~~~~~~~~~~~~~
> +
> +Any nontrivial feature will require several patches to implement, and
> +may get extra bugfixes or improvements during its lifetime.
> +
> +Committing everything directly on the main branches leads to many
> +problems: Bad commits cannot be undone, so they must be reverted one
> +by one, which creates confusing histories and further error potential
> +when you forget to revert part of a group of changes.  Working in
> +parallel mixes up the changes, creating further confusion.
> +
> +The key concept here is "topic branches".  The name is pretty self
> +explanatory, with a caveat that comes from the "merge upwards" rule
> +above:

I'd reword the first sentence --- Use of "Topic branches" solves these
problems.

> +We should point out that "habitually" (regularly for no real reason)
> +merging a main branch into your topics -- and by extension, merging
> +anything upstream into anything downstream on a regular basis -- is
> +frowned upon:
> +
> +.Merge to downstream only at well-defined points
> +[caption="Rule: "]
> +=====================================
> +Do not merge to downstream except:
> +
> +* with a good reason: upstream API changes affect your branch; your
> +  branch no longer merges to upstream cleanly; etc.
> +
> +* at well-defined points such as when an upstream release has been tagged.
> +=====================================
> +
> +Otherwise, the many resulting small merges will greatly clutter up
> +history.  Anyone who later investigates the history of a file will
> +have to find out whether that merge affected the topic in development.

This description misses the most important reason why merging into topic
branches is not a good idea.  Once you merge a general purpose integration
branch such as master into a topic branch, the branch ceases to be about
the single topic.  It becomes "the topic and other unrelated changes mixed
together".

> +Integration branches
> +~~~~~~~~~~~~~~~~~~~~

Nomenclature.  I think we use the word "integration branches" to mean the
stable branches such as maint/master/next, not the ones you use for
throw-away test merges.

Always merging upward is a good rule, and this is when used with topic
branches, there is one twist you did not mention but is worth knowing
about.  A topic that is meant to eventually merge into older integration
branch (e.g. maint) does not necessarily have to be merged to its final
destination branch first.  I often do this:

	git checkout tr/maint-fix-bla maint
        git am -s fix-mail-from-thomas.txt
        git checkout next
        git merge tr/maint-fix-bla
        ... cook further, perhaps adding more commits to
        ... tr/maint-fix-bla topic and merging the result to next;
	... and then when the topic appears to be stable do:
	git checkout master
        git merge tr/maint-fix-bla
	... and later
        git checkout maint
        git merge tr/maint-fix-bla
	git branch -d tr/maint-fix-bla

This keeps older integration branches stale, until the topic really gets
proven to be regression-free in the field.  This workflow is safer and
more suitable for a final integration branch to which a known breakage is
better than an unintended regression.  An alternative would be what the
reader would assume from your description of merging upwards, which would
look like this:

	git checkout tr/maint-fix-bla maint
        git am -s fix-mail-from-thomas.txt
        git checkout maint
        git merge tr/maint-fix-bla
	git checkout master
        git merge maint
        git checkout next
	git merge master

This can regress maint unintentionally and then the regression is
propagated upwards to contaminate all integration branches.
