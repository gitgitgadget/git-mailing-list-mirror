From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 07 Nov 2008 15:43:19 -0800
Message-ID: <7vhc6jdrvs.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
 <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
 <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
 <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vskq3fdgz.fsf@gitster.siamese.dyndns.org>
 <20081107221224.GK5158@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:44:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyb0Y-0005g8-CA
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbYKGXnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYKGXni
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:43:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbYKGXnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 18:43:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A49794407;
	Fri,  7 Nov 2008 18:43:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2739694406; Fri, 
 7 Nov 2008 18:43:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E531D624-AD25-11DD-A194-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100364>

Yann Dirson <ydirson@altern.org> writes:

> I hope I just miss your point.  Letting unaware tools handle such a
> patch "the right way" would imply just adding the information "dir foo
> moved to bar", and not removing the individual file moves, which goes
> in the way of the exact reason why I have started to work on this.

If your change is to move a/{1,2,3} to b/{1,2,3} and without content
change to a/{1,2} to b/{1,2}, then do you want to say "a/ moved to b/
and by the way here is the content change from a/3 to b/3" without saying
anything about a/{1,2} and b/{1,2}?

Two points.

 * I do not think it is a good idea to begin with.  If you are to apply
   such a patch (with git-apply that is updated with your patch to
   understand that notation) to the exact tree that has only {1,2,3} under
   a/, you would get an expected result.  But if the recipient of your
   patch has a/4 (or lacks a/2), there is no cue in the patch that
   automatically moving a/4 to b/4 may or may not be what is sane (or the
   patch is unapplicable in general).

 * If you give at least the names of paths that were moved without any
   content changes as I suggested, at least the recipient of your patch
   can catch the case where his tree is structurally different from what
   you used to prepare the patch for by noticing the a/2 in the patch that
   he does not have.

In addition, if you keep the movements for the paths whose contents did
not change, existing tools are perfectly capable of applying (or showing)
the output.  I seriously doubt that keeping 4 lines per perfectly moved
paths is too much a price to pay to keep backward compatibility.

> Compare this to the addition of the "file rename" feature (correct me
> if I'm wrong): it was added without bothering whether plain old
> "patch" can deal with it,...

Sorry, but that's an old history whie git-diff output format was rapidly
being developed, when we did not have that many users, and when we did not
have an old version of git-apply that did not understand the new feature
in majority of user's hands.

We do not have that kind of luxury anymore.  git is much more widespread
now and the majority of people use pre-1.6.1 git now (including me ;-)).
