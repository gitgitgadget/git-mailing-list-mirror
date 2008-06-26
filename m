From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
 errors.
Date: Thu, 26 Jun 2008 01:19:02 -0700
Message-ID: <7vfxr0sj61.fsf@gitster.siamese.dyndns.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org>
 <20080619133747.GA31209@sigill.intra.peff.net>
 <20080619135159.GA19560@artemis.madism.org>
 <20080619151110.GA31654@sigill.intra.peff.net>
 <20080626075036.GA25770@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBmib-0000z0-Uw
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 10:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbYFZITW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 04:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbYFZITW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 04:19:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbYFZITR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 04:19:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65330F5DE;
	Thu, 26 Jun 2008 04:19:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EF16F5DD; Thu, 26 Jun 2008 04:19:09 -0400 (EDT)
In-Reply-To: <20080626075036.GA25770@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jun 2008 03:50:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 913F71AC-4358-11DD-9FAC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86412>

Jeff King <peff@peff.net> writes:

> Does this seem like a good approach overall? Existing behavior should be
> identical unless the config option is set, and with it set, I think it
> should satisfy Pierre and posters from the original thread. If that is
> sensible, which of the solutions for "no, I really want to force this
> strict rewind" is the most palatable?

That "strict rewind" workaround alone made me so disgusted beyond words.

And then made me step back and think again.

If it is stale, it is stale.  A revert is just a different history that
did not have some things that already happened, while a fork has some
other things that did not happen in the original history on top of that.
They are the same thing -- alternate history that drops some things that
already happened.  It does not matter if you are strictly stale or if you
built a few (or hundreds of) commits on top of something that is stale.
You are losing history if you tried to push such a thing.

And if you do not want to trigger "what you are pushing is not up to
date", the solution is simple.  You do not push them.

I however think what Pierre wanted to do is different, and you do not have
to solve "force this strict rewind" problem to solve it.

What we need is (with a configuration option) to change the meaning of
"matching refs" from the current definition "branches with the same name
between here and there" to "branches with the same name between here and
there, but excluding the ones that do not fast forward (or strictly
behind)".  So if you have tons of stale branches you checked out but
haven't touched most of them, your "matching push" won't even try to push
what you haven't touched.

I do not think we would ever want to allow a configuration that disables
the exit status from push upon a push failure when somebody explicitly
says "git push $there $this" and $this is not non-fast-forward.  If you
asked $this to be pushed, and if $this cannot be pushed, we _should_ error
out.

So...

 (1) when you say "git push" to trigger the "matching refs" push, with the
     new configuration, you do not error out nor even try to push out
     things that do not fast forward.  Pretend that you did not even
     attempt to push them, and do not error out.  This may result in not
     pushing anything out, but that is what the people who have such a
     configuration is asking for.

     If you have configured which branches are pushed when you are on your
     current branch, and that branch --- most likely it is that current
     branch --- does not fast forward, it is your problem.

 (2) even with such a configuration, you can "git push $there $this" and
     "git push $there +$this" to explicitly ask refs to be pushed.  Such a
     push won't be interfered by the new configuration and correctly fail
     (or force).
