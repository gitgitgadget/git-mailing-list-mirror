From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -i" with path gives "Argument list too long"
Date: Sun, 21 Mar 2010 18:23:38 -0700
Message-ID: <7vwrx56tet.fsf@alter.siamese.dyndns.org>
References: <45CD9D1B-6774-46F2-A444-654B1DEF7F69@wincent.com>
 <20100322003915.GA3212@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 22 02:24:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtWNA-0005Xk-4v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 02:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0CVBXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 21:23:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab0CVBXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 21:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B82FA4A50;
	Sun, 21 Mar 2010 21:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3zFWhekIulwG6tRpjRXWDKEh06s=; b=wZvJWP
	TXyNzyHqHX90dlEOy/u0M7td1ldTQb+rdJEnITp8QX5iz+JGL+rHx6BT2OONJq/7
	Rwyf+6n34RuAIec77ii5UfQpZ0+BhPd3f6K/L5PU85eZKNX6RQhyZ/to+ibBVKij
	rR3o7bBZv/0Ag6ATWnZrlGongKvO55W5AI9So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkcPcDNWiQc80Sr+5BWbKUVWhJv/VrcK
	+GGHdpxhPcQ1c5axPdqgy9Gyw1suJ3blGyta+rxUH1n126xnNzVcogg39EHsO2kB
	+OjcSFMcwaoSqG3SerIc2iJHIR2Bm3K6dv3EAWFcO0wc68IHaJFMrCkWLO2X8Cyt
	wp8n5/0/25Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67020A4A4F;
	Sun, 21 Mar 2010 21:23:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 920EEA4A4A; Sun, 21 Mar
 2010 21:23:39 -0400 (EDT)
In-Reply-To: <20100322003915.GA3212@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 21 Mar 2010 20\:39\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8DE94FCC-3551-11DF-A60A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142880>

Jeff King <peff@peff.net> writes:

> their behavior. Junio could probably say more, or you will have to read
> the code.

Or read what I already said here a few times ;-) I generally do not want
to repeat myself.

There are two semantics of pathspecs:

  (1) exact match, or leading path.  e.g.

  	git ls-files Makefile Documentation/

  (2) exact match, leading path, or fnmatch(3).

	git ls-files Makefile Documentation/ '*.txt'

The former is used by the diff family, and the latter by pretty much
everything else.  In very old days, the former was the only kind we
supported, and originally, ls-files didn't even take any pathspecs.

The 5be4efb ([PATCH] Make "git-ls-files" work in subdirectories,
2005-08-21) taught ls-files to take pathspec that can glob, but diff
family never got updated to match that.

In order to operate on set of paths, you would need to (a) enumerate your
paths, and (b) filter that enumeration efficiently with pathspecs.  If you
are iterating over the index (e.g. "ls-files", "diff-files", "grep"),
there is nothing tricky in the enumeration step.  We have a flat array of
names in the index and you just walk active_cache[] from 0 to active_nr.
If on the other hand you are walking in an inherently hierarchical
namespace (e.g. "ls-tree", "diff-tree", "grep --no-index") with non empty
set of pathspecs, you need to take advantage of the filtering behaviour
while enumerating the paths---otherwise your performance will suck.

"Leading path" semantics is easier to understand; if a tree entry you are
looking at is "contrib", and the pathspecs you have are "Makefile" and
"Documentation/", then there is no way for anything underneath it
(e.g. "contrib/README") would survive the filtering process, so you can
skip the entry without even opening the sub-tree object.  Linus's argument
was "teaching globs to pathspec code would suck in performance" and he is
right in general.  Because diff-tree is inherently about walking the two
tree objects in parallel, it does not extend its pathspec semantics to
globbing (i.e. if the user asked for '*.txt', you have to open _all_ the
tree objects down to the leaf level to see if they contain any file whose
name ends with .txt), and other family members of diff (namely, diff-files
and "diff" without --cached nor any tree-ish argument) match this
behaviour for consistency, even though theoretically "diff-files" could
easily do globbing, as it walks the flat index namespace.

But I think it is Ok to sacrifice the optimization and descend into any
and all subtrees/directories to see if a path that might match the pattern
exists when the user asks for '*.txt', as long as (and this is a _very_
important point) an update to pathspec logic on the diff side does not
break the optimization unnecessarily.  E.g.

	git diff v1.0.0 v1.2.0 -- Makefile 'Documentation/*.txt'

should still skip opening tree object for 'contrib/' (because anything
underneath contrib/ would never match either pathspecs given), but can
and should descend into Documentation.  And it should _not_ skip 'howto'
subdirectory in Documentation/ directory, as it could find a match with
'*.txt' in that subdirectory.

To prepare for this, later reimplementations of pathspec matching logic
(the one used by "git grep") can compute hints meant to be used by the
path enumeration step, as I explained earlier, enumeration needs to take
advantage of what filtering would do to paths that it will find.

By the way I threw this "pathspec unification" to the list of possible
GSoC ideas, but I suspect it might be a bit too much work to do this
properly for a summer student (and also we might not want to trust this
important part of the system to a summer student).  Other things that
probably needs to be thought through (and I haven't) that may be related
to this codepath is how to handle case-insensitive filesystems.  I think
we currently do not match paths that we obtain from the filesystem case
insensitively with the given pathspecs (we probably shouldn't go case
insensitive when we are walking the index or the tree objects, on the
other hand).
