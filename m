From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin, submodules
Date: Mon, 04 Feb 2008 11:59:06 -0800
Message-ID: <7vbq6wjxx1.fsf@gitster.siamese.dyndns.org>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
	<alpine.LSU.1.00.0802032237320.7372@racer.site>
	<47A68C01.9000600@gmail.com>
	<alpine.LSU.1.00.0802041443420.7372@racer.site>
	<30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7UH-0002bP-1d
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117AbYBDT7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 14:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757078AbYBDT7V
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 14:59:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbYBDT7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 14:59:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A46B324B;
	Mon,  4 Feb 2008 14:59:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C82D03248;
	Mon,  4 Feb 2008 14:59:13 -0500 (EST)
In-Reply-To: <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
	(Mark Levedahl's message of "Mon, 4 Feb 2008 12:24:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72552>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

> BIG difference here:
> $HOME = <name> of home directory, <name> is arbitrary. Files there are
> found as $HOME/<foo> or <name>/foo, they are the same, and I am free
> to set HOME=<arbitrary name>.

I think you misunderstood Dscho's $HOME analogy.

For example, the value of HOME environment variable is used as a
shorthand to where you go to when you say

	$ cd

Everybody is happy that the variable is called HOME, and nobody
would complain that the shell does not have another mechanism to
let you have this in your .bashrc

	#!/bin/bash
	HOMEENVVAR=BASE
	BASE=/home/mark
        export HOMEENVVAR BASE

and make the parameterless "cd" honor the environment variable
named with HOMEENVVER (in this case, BASE) instead.

Remote shorthand is exactly like a variable name.  We say "git
pull origin" and do not say "git pull $origin", but that is just
a syntax issue.  And "git pull" and friends are defined to
default to the value of the origin 'variable' exactly like "cd"
is defined to default to the value of the HOME variable.

I would agree 100% with Dscho on this point, if we did not have
"clone -o".

"clone -o" is like the above HOMEENVVAR variable.  It lets you
rename what name other than origin is used to name what the
origin 'variable' usually names, or at least pretends to let you
do so.  But its effect may not extend far enough and if there is
such inconsistency, that is a bug worth fixing.  For example, I
think "git fetch" is Ok for basic use, because "clone -o" writes
branch.master.remote in .git/config that points to the name you
gave instead of 'origin', but there may be places that do use
hardwired 'origin' and nothing else.

And that is the only reason I am still responding to this
thread.

If a supermodule wants a specific remote to be used in a
submodule, it should not default to 'origin' but it should name
that specific remote explicitly.  Even if we added the mechanism
that looks like HOMEENVVAR to tell commands other than "git
fetch" to default to something other than 'origin', I do not
think such a use of submodule should depend on that fallback.  I
still haven't dismissed Dscho's argument that submodule related
issues should be handled inside git-submodule for that reason.

We could remove support for "clone -o" and consistently use
'origin' as the default everywhere and completely remove the
half-baked HOMEENVVAR lookalike.  I do not think such a move is
a good idea, but the point is that the solution to your
submodule problem should work even if we did so.  If the
supermodule and a set of submodules are configured to use a
specific remote that is not 'origin', it should use that
specific remote by _naming_ it, not relying on where the
fallback value is taken by other unrelated parts of the system,
no?
