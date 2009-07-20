From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] add push --current and remote.*.pushHeadOnly
Date: Mon, 20 Jul 2009 13:38:16 -0700
Message-ID: <7vskgrum2v.fsf@alter.siamese.dyndns.org>
References: <1248091094-31485-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Finn Arne Gangstad <finnag@pvv.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 22:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSzd3-0005J4-R3
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbZGTUi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbZGTUiZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 16:38:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZGTUiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 16:38:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C799DCF5F;
	Mon, 20 Jul 2009 16:38:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3DFC9CF5D; Mon, 20 Jul 2009
 16:38:18 -0400 (EDT)
In-Reply-To: <1248091094-31485-1-git-send-email-bonzini@gnu.org> (Paolo
 Bonzini's message of "Mon\, 20 Jul 2009 13\:58\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4509D56E-756D-11DE-BAFF-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123631>

Paolo Bonzini <bonzini@gnu.org> writes:

> This second series is gets rid of the most annoying part (IMHO) of
> push.default = tracking, i.e. the fact that its behavior cannot be
> achieved using git's ordinary tools.

Having to read this three times made me irritated enough to comment on
this part of the cover letter.

If some feature X cannot be achieved by combinations of other existing
features, is it a bad thing?  Why should that be annoying?

Maybe it is just the matter of phrasing, but I do not think the above
statement helps understanding of the issue.  I would certainly understand
the justification if it were "This feature improved things somewhat, in
that it now allows you to do X, but it did not go far enough.  It does not
help satisfying wishes Y and Z are similar enough to X and are common
enough.  Here is an attempt to extend the mechanism in a more generic way
to do so".  But I do not get a clear sense of what these Y and Z are from
the above description, therefore I personally find it hard to judge if Y
and Z are so important to support with more code, compared to the support
for X we already have.

Maybe Finn Arne Gangstad, who originally did push.default, can shed some
light on this?  Do you agree that Paolo's "annoyance" is justified, and
this series makes things saner?

I actually do agree that it feels somewhat unbalanced that "git push" with
no other arguments can do a "matching" push of _all_ branches without any
funny configuration, while the same parameterless push needs many
configured remote.*.push refspecs to do a "tracking" push of all branches.

And as you say, branch.autosetuppush may make the remote.*.push
configuration less painful to set up for the users.  So the inbalance may
not hurt in practice from the end user's point of view.

But more importantly, I think that inbalance is inherent to a certain
extent, and it probably is _not_ a bad thing in the first place.

If your workflow is to use local branches with the same name as the remote
side as your own local integration branches, "matching" push that pushes
all matching branches makes a good deal of sense.  You keep your local
integration branches clean by never integrating premature topics into
them, so it is always safe to push them out in one go.

If on the other hand your workflow is to fork topics from the remote
integration branch(es) (e.g. topicA and fixB both forked from master taken
from the remote), both topics will be set to push back to the same master
branch on the remote side if you use branch.autosetuppush.  In such a
workflow, you work on these two topics, and when one of them is done, you
want to push that one out, without having to push the other one that is
not yet ready (beside, that one won't fast-forward).

A "tracking" push that pushes all branches is actively a wrong thing to do
in such a workflow.

	Side note: in that sense, branch.autosetuppush might be a well
	intentioned but ill conceived concept, and we may want to remove
	it from 'next'.

Of course, even if you are using "matching", you can (temporarily) have an
experimental integration on one of the matching branches while the other
one is truly ready, and in such a situation you do not want to push out
all matching branches (hence you would occasionally need to be more
explicit than usual, i.e. "git push origin master").  Also, even if you
are forking your topics directly from the remote integration branches and
pushing back to where they forked from, you can adopt a discipline not to
push out when you have some topics that are not ready.

But the point is that the discipline to keep branches that can be pushed
out clean is much easier to follow in "matching push" workflow, because it
is an integral part of the workflow.  If merging a topic to an integration
branch is a declaration of doneness of the topic, by definition, your
integration branches are all ready to be pushed out at any time.

If you fork topics from remote's integration branch and push each of them
back individually, "keeping branches that can be pushed out clean" is not
even a discipline, but it is a hindrance, as the point of such a workflow
is to push things out as they become cooked one-by-one.  In such a
workflow, you do want "one-by-one, push only the current one I just
tested".

> ...set the refspecs correctly, push.tracking does not push _all_ tracked
> branches, but only the current one (because it implicitly adds only one
> refspec, while autosetuppush places them all in the configuration).

In short, it is not necessarily bad that "push all matching" is much
easier to set up and use than "push all tracking", and I think it is
nothing to be annoyed about.
