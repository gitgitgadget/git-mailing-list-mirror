From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: libify pick
Date: Fri, 31 Jul 2009 00:15:19 -0700
Message-ID: <7v8wi52uig.fsf@alter.siamese.dyndns.org>
References: <20090731032548.4169.16389.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 31 09:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWmLJ-0006eH-UX
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 09:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZGaHPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 03:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbZGaHP3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 03:15:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbZGaHP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 03:15:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 408A61ABE9;
	Fri, 31 Jul 2009 03:15:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 20E4C1ABE8; Fri,
 31 Jul 2009 03:15:21 -0400 (EDT)
In-Reply-To: <20090731032548.4169.16389.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri\, 31 Jul 2009 05\:25\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ECBA1E72-7DA1-11DE-87AB-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124508>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This commit is made of code from the sequencer GSoC project:
>
> git://repo.or.cz/git/sbeyer.git
>
> (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)
>
> The goal of this commit is to abstract out pick functionnality
> into a new pick() function made of code from "builtin-revert.c".
>
> The new pick() function is in a new "pick.c" file with an
> associated "pick.h".
>
> "pick.h" and "pick.c" are strictly the same as on the sequencer repo,
> but a few changes were needed on "builtin-revert.c" to keep it up to
> date with changes on git.git.
>
> Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> ---
>
> 	This patch is part of trying to port git-rebase--interactive.sh
> 	to C using code from the sequencer GSoC project. But maybe it can
> 	be seen as a clean up too.

Thanks.  Why doesn't this have Stephan's sign-off?

The new "pick.c" file seems to be a nicer implementation of the main logic
of builtin-revert.c and its primary niceness comes from the use of strbuf.

A few minor points and comments.

 * error() returns -1.

        error("message");     =>        return error("message");
        return -1;

 * pick() might be a bit too short and abstract name for a generic library
   function.

 * REVERSE is made to imply ADD_NOTE but the codepath that acts on
   ADD_NOTE never seems to be reached if REVERSE is set.

The intent of pick() funtion looks like it starts from the current index
(not HEAD), and allow the effect of one commit replayed (either forward or
backward) to that state, leaving the result in the index.

You do not have to start from a commit, so you can replay many commits to
the index in sequence without commiting in between to squash multiple
steps if you wanted to.  I think that makes sense as a nice general
interface.

The "if (no_commit)" codepath in the original code did things very
differently from the usual "start from HEAD and replay the effect"
codepath and it warranted the big "We do not intend to commit immediately"
comment.  For pick() function, however, the "start from index" is the
normal and only mode of operation.  Keeping the big comment is misleading.

When it replays another commit on HEAD, the new code does not read "HEAD"
by hand into head anymore, but it still has the check between the index
and "HEAD" and refuses to run if the index is dirty, which means the tree
you get from write_cache_as_tree() is guaranteed to be the same as "HEAD",
so this conversion looks correct.
