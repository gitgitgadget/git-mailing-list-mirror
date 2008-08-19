From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 16:35:34 -0700
Message-ID: <7vy72swpbt.fsf@gitster.siamese.dyndns.org>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
 <20080819185804.GA17943@coredump.intra.peff.net>
 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
 <7v63pw3ick.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0808191258i9037a84k267c09795dffb3b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVakq-0007Rm-Bp
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbYHSXfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbYHSXfo
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:35:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYHSXfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:35:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E950605F7;
	Tue, 19 Aug 2008 19:35:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2527A605F6; Tue, 19 Aug 2008 19:35:36 -0400 (EDT)
In-Reply-To: <d411cc4a0808191258i9037a84k267c09795dffb3b8@mail.gmail.com>
 (Scott Chacon's message of "Tue, 19 Aug 2008 12:58:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89D4044A-6E47-11DD-A9E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92936>

"Scott Chacon" <schacon@gmail.com> writes:

> I would be happy to add the name of the branch being updated and the remote
> we're trying to push to.  Is there interest then, in the patch?

I do not see a fundamental reason not to have a pre-push hook that
inspects what is going to be pushed where and declines it.  We already do
"don't push non-fast-forward" on the sending end, and we can think of this
as an exhancement of that.

IOW, I am Ok with the goal.  I haven't looked at the implementation,
though. I seem to recall all of tabstops in the patch were lost somewhere
between your editor and my MUA to make the patch unappliable, and stopped
reading there.

> Should I spend my
> precious brain cycles on adding that functionality?

Well, submitters pushing changes to scratch their own itch don't say "my
precious brain cycles".  Reviewers working with submitter to polish and
accept the change to help the submitter, even when it is not their own
itch, do ;-).

In any case, I think passing the information necessary for the validation
to the hook is essential to make this patch worthwhile.  Without it, I
have to agree with Jeff and Shawn that it is no better than a wrapper.

I merely raised destination URL and the tip that is sent as an example,
but I suspect we may also want to know the name of branch on the remote
side that is being updated, and the old tip commit on that branch as well.

The real issue about "that functionality" is what kind of information is
often needed and/or is enough, and we may need to look at what kind of
validation are useful in expected use scenarios.

For example, if your goal is "to enforce that the tip of the tree is
always without compilation errors", then you only need the commit that you
are sending.  If however that policy applies only to some branches but not
other, you would need to know which branch you are sending things to.  If
you are scanning what is sent to the remote side so that your published
history does not leak confidential information, you further need to know
the old tip and run "rev-list --objects old..new" and inspect all the new
objects you are sending, not just the tip.

I am just listing these off the top of my head; you as the original
submitter of the patch must have thought about the issues and use cases
much deeper than I did in the past 7 minutes while I am typing this
message, so you are in a better position to come up with various use cases
and the set of parameters the hook would need to do its validation job.
