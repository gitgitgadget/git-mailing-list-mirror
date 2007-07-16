From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vc-git: support asynchronous annotations, and improve versioning.
Date: Sun, 15 Jul 2007 23:14:16 -0700
Message-ID: <7v4pk46fk7.fsf@assigned-by-dhcp.cox.net>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
	<cfa5ed80635135dd7544f2b4c6df521a4353e90d.1184548803.git.dak@gnu.org>
	<7v3azpavae.fsf@assigned-by-dhcp.cox.net>
	<85k5t0or0d.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 08:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJqq-0001eZ-BJ
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 08:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXGPGOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 02:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbXGPGOT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 02:14:19 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45303 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbXGPGOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 02:14:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716061417.ZQIY1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 02:14:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q6EH1X0031kojtg0000000; Mon, 16 Jul 2007 02:14:17 -0400
In-Reply-To: <85k5t0or0d.fsf@lola.goethe.zz> (David Kastrup's message of "Mon,
	16 Jul 2007 07:29:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52644>

David Kastrup <dak@gnu.org> writes:

> How do I go about resubmitting with better comments?  Make an extra
> branch and redo the part in artificial new commits?

The original was not even numbered so I cannot judge how the
development proceeded, but I think the series is somewhat ill
organized and the problem is not just commit log messages.

For example, "vc-git.el: various improvements." removes NIL
check for 'commit' and then later "Make several improvements"
reinstates that check, perhaps because you realized the earlier
change to remove it was a mistake (without the explanation in
the log I can only guess the reason).  Same for 'async to 0
change which is made by "Make synchronous for now".

Preserving a honest, true-to-reality, history is one thing
during the development, but when the overall improvements and
enhancements reached a usable state, it is much more pleasant to
review if the series is presented as if you knew what necessary
changes are and what pitfalls to avoid from the beginning, and
did your development in logical sequence, building one commit on
top of the previous enhancements without "oops, that was a
mistake so fix it while we are improving something else".

My cursory review suggests that:

* contrib/emacs/Makefile: Also install .el files.

This is a good patch, independent from anything else.

* contrib/emacs/vc-git.el: various improvements.
* Make several improvements and get annotations to work (Emacs support pending).

These two try to improve the same area, but the latter contains
bugfixes for the former, not necessarily a logical succession
(if it were a logical sequence to build and enhance, the first
should be usable by itself, without a later bugfix).

If these were to be made more than one logically independent
patches, then probably the first would be to simplify
vc-git-symbolic-commit implementation and update its callers
(without having to say "oops, I needed the check for NIL commit
after all" later), and without changing what the callers do.
The second one would be "prev and next can be made much
simpler".  The third one would be "annotate can take 'rev' and
extract-revision-at-line is now usable".  But judging from how
closely these changes are tied together (all of them depend on
the external interface to vc-git-symbolic-commit) and how small
each change is, I would probably make them a single commit that
you do not have to say "oops" anywhere.

* vc-git: support asynchronous annotations, and improve versioning.
* (vc-git-annotate-command):  Make synchronous for now.

The same discussion here.  The first one goes in the right
direction, but then the moment of "oops" comes --- async does
not necessarily work.  Probably the right separation, if these
two were to become two separate commits, would be to add async
(but leave it synchronous, with a big code comment at the
calling site of vc-do-command why you pass 0 instead of async),
and then make "and improve versioning" part (whatever that is --
I cannot figure out which part of the patch "improve"-ment
refers to) a separate commit.

I would end this message with a very useful URL:

    http://article.gmane.org/gmane.comp.version-control.git/10894

I am with Linus 100%, regarding "honest" vs "disgusting"
history.
