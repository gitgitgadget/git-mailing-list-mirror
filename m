From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] simplify history by default
Date: Thu, 30 Aug 2007 00:25:49 -0700
Message-ID: <7vir6x8ow2.fsf@gitster.siamese.dyndns.org>
References: <20070830062512.GB16312@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Aug 30 09:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQePq-0005oJ-TH
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 09:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbXH3H0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 03:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbXH3H0F
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 03:26:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbXH3H0D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 03:26:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DFC0A12AEE1;
	Thu, 30 Aug 2007 03:26:19 -0400 (EDT)
In-Reply-To: <20070830062512.GB16312@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 30 Aug 2007 09:25:12 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57008>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Which is better IMO, because the a branch is actually ignored.
> But, is this behaviour documented?

Formal documentation is probably lacking.  Both Linus and I have
explained this "history simplification" countless times here and
on #git.  As a matter of fact, I think I did my latest round of
explanation on #git just a few days ago.

The thing is, neither of us is very good at documention --- we
tend to offer explanation on demand _in context_.

> Further, man git-rev-list says
> --full-history::
>
> 	Show also parts of history irrelevant to current state of a given path.
> 		This turns off history simplification, which removed merges
> 		which didn't change anything at all at some child. It will still
> 		actually simplify away merges that didn't change anything at all
> 		into either child.
>
> which makes it seem like the default should be to do history simplification, but
> what actually happens is that the default is not to do simplification
> unless you give a path, in which case the default is to do simplification,

I would agree around the part you quoted is a good place to add
descriptions we gave in the past, and it is a good idea to do so
at the very technical level.

At the same time, I think section #2 of the user manual
"Exploring git history" should talk about path limited,
simplified history, in its "Browsing revisions" subsection, when
it gives the example

	$ git log v2.5.. Makefile fs/

As the previous section has already introduced the history
diagram, it would help to draw a merge graph and how the history
is simplified.

Slides #116, #117 and #118 from

	http://members.cox.net/junkio/200607-ols.pdf

talk about history simplification, which may be a good starting
point to steal from.

As to your patch, I am a bit reluctant to make the history
simplification for the "whole tree" history traversal default,
even with --no-merges.  One thing we often use --no-merges is
for shortlog and I do want to see commits from both branches,
when I have something like this:

 ... maint ...----o----A----B---C'
                             \   \
                              \   \
 ... master ... -----o----C----M---N

where I first made a fix C on the 'master' branch, later
backported it to 'maint' as C' to fix the same issue (but
applicable for the context of 'maint').  The merge made at N
will most likely result as if 'maint' was merged using 'ours'
strategy to 'master' because at point M, the master branch is
supposed to be in sync with and contain everything from 'maint',
including the effect C' would bring to 'maint'.  I feel somewhat
uneasy to drop C' when I am preparing to write release notes for
N (or later).  Maybe this is just superstition, but when not
using path-limiting, I am really interested in who contributed
in the whole system, whether the fruits of their efforts
survived at the end or not.  The use case is quite different
when looking at history with path limiters.
