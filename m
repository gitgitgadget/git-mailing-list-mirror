From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Mon, 11 Aug 2008 13:34:19 -0700
Message-ID: <7vprofwat0.fsf@gitster.siamese.dyndns.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:35:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSe76-0006Y3-03
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYHKUec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYHKUec
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:34:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYHKUeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:34:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52E0759FAA;
	Mon, 11 Aug 2008 16:34:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5197A59FA9; Mon, 11 Aug 2008 16:34:22 -0400 (EDT)
In-Reply-To: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Sun, 10 Aug 2008 15:44:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E33766E4-67E4-11DD-B0E5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91993>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index ee6822a..0eaefd2 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -191,20 +191,6 @@ endif::git-rev-list[]
> ...
> +--

What was the meaning of the double-dash at the beginning of line in
AsciiDoc markup?  I forgot.

> +History Simplification
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +When optional paths are given, 'git-rev-list' simplifies merge and
> +non-merge commits separately.  First, all non-merge commits that do
> +not touch the given paths are marked as such.  We'll call them
> +'non-touching' commits, and all other commits 'touching'.
> +
> +Second, merges are simplified.  You can choose three levels.  We
> +illustrate the strategies with the following example history, where
> +touching commits are shown with capital letters and both B and C
> +contain the same changes:
> +
> +-----------------------------------------------------------------------
> +	o -- A -- B -- m
> +	     |\	      /|
> +	     | \- C -/ |
> +	     \	       /
> +	      \-- d --/
> +-----------------------------------------------------------------------

Please draw it a bit more consistently with pictures in other existing
documentation, perhaps like this:

              d---.  
             /     \
        o---A---B---m
             \     /
              C---.

> +--prune-merges::
> +
> +	This is the default.  A merge is has its parents rewritten as
> +	follows:
> ++
> +	* All parents that do not have any touching ancestors are
> +	  removed.
> ++
> +	* Of a set of parents that agree on the path contents, only
> +	  the first is kept.
> ++
> +In our example, we get the following:
> ++
> +-----------------------------------------------------------------------
> +	o -- A -- B -- m
> +-----------------------------------------------------------------------

I'd rather make this the part of the base text.  In other words, remove
the "--prune-merges" header, dedent the description and start the sentence
with "By default, parents of a merge is rewritten with the following
rules:".

Then before listing the options, say something like "You can influence how
simplification works using the following options".

> +--simplify-merges::
> +
> +	For each commit C, compute its replacement in the final history:
> ++
> +* First compute the replacements of all parents of C, and
> +  rewrite C to have these parents.  Then remove parents that
> +  are either identical to or ancestors of an existing parent.
> ++
> +* If, after this simplification, the commit is touching, a root or
> +  merge commit, or marked as uninteresting, it remains.
> ++
> +In the example, history is simplified as follows.  (Note that while
> +'o' remains, it will not be output with '\--dense'.)
> ++

Also this option implies --full-history's true meaning "do not cull side
branches even when they led to the same conclusion", with --parent's
meaning "do not drop merges that are necessary to keep the rewritten
history still connected".

> +-----------------------------------------------------------------------
> +	o -- A -- B -- m
> +	      \	      /
> +	       \- C -/
> +-----------------------------------------------------------------------

Same comment on the way the picture is drawn.

> +--full-history::
> +
> +	Do not simplify merges at all.  Their ancestor lines are still
> +	only shown if they have any touching commits, but the merges
> +	themselves are always output.

With clarification from Linus yesterday, this would need rewording.  It is
not about "simplifying merges", but its main focus is "do not cull side
branches".  When --parents is in effect, merges need to be shown because
otherwise the resulting list of commits won't be connected, but otherwise
you are getting a flat list of commits and useless merges won't be shown.
