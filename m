From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Mon, 13 Apr 2009 09:31:31 -0700
Message-ID: <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
References: <20090413110947.GA15647@coredump.intra.peff.net>
 <20090413112104.GE15982@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtP5w-0001qS-Eh
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbZDMQbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbZDMQbj
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:31:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbZDMQbj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 12:31:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D529A9621;
	Mon, 13 Apr 2009 12:31:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2455AA9619; Mon,
 13 Apr 2009 12:31:32 -0400 (EDT)
In-Reply-To: <20090413112104.GE15982@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 13 Apr 2009 07:21:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F5B00A6-2848-11DE-A7D6-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116447>

Jeff King <peff@peff.net> writes:

> I hope this helps a little bit with Mark's confusion. But while writing
> it, I really think it would be a simpler rule to say "if it's in
> refs/heads/, then it's a branch" (which is similar to what Mark
> suggested earlier).
>
> So "git checkout refs/heads/master" would be identical to "git checkout
> master". That would require a code change, though.

Sorry, but I do not get the logic behind such a change.

Because you won't be breaking "git checkout frotz" that checks out the
branch whose name is frotz (i.e. refs/heads/frotz) even when a tag frotz
exists (i.e. refs/tags/frotz), the updated code cannot be "try to resolve
the token given from the command line as-is, and if it is in refs/heads/
it is a branch switch, otherwise it is a detach at the commit".  The
updated code has to be "try to resolve the token appended to refs/heads
and if it resolves, that is a branch switch.  Otherwise if the token
already begins with refs/heads/ then it also is a switch to the branch
whose name is the token minus the leading refs/heads/, otherwise try to
resolve it as-is and detach at that commit".

The result changes behaviour for two classes of people.

 (1) People who have a branch whose name is refs/heads/frotz.  Before they
     could switch to the branch by mechanically giving its name.  Now they
     have to remember that such a branch with an unusual name needs to be
     fully spelled "git checkout refs/heads/refs/heads/frotz".

 (2) People who have scripts that gets a refname (or a list of refnames),
     and drive "git checkout" to either switch to the branch if that ref
     is a branch or detach at the commit if it isn't.  Their script had to
     check if the ref begins with refs/heads/ and if so strip that before
     giving it to "git checkout", but with your change they do not have
     to.

The former technically is a usability regression which I presume we do not
care.  The user with such a branch name is sick enough and deserve to be
punished ;-)

The latter might be improvement, but does it really matter?

Such a script is already checking with refs/heads/ (and it is easy to
codify in a script anyway), and with or without the change you suggest, it
will check out the master branch when the ref is refs/heads/master and the
script strips the leading refs/heads/.  With the change, it also needs to
delete the logic of stripping refs/heads/ to deal with (1) sanely.

In addition, most likely such a script to check out a series of refs in an
automated fashion is about autobuilding random set of commits, and it
would probably be better off working on the HEAD detached at given commit,
whether the incoming ref happens to be a branch ref or not.

So I am still scratching my head, wondering what improvement from the end
user's point of view you will be getting from such a change...
