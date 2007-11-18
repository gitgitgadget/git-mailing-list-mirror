From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v4] user-manual: Add section "Why bisecting merge
	commits can be harder ..."
Date: Sat, 17 Nov 2007 22:59:34 -0500
Message-ID: <20071118035934.GA29374@fieldses.org>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de> <1194702594213-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 05:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItbKj-0005su-Tr
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 05:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbXKREAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 23:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbXKREAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 23:00:09 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43801 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbXKREAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 23:00:07 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1ItbJm-0001zW-3Y; Sat, 17 Nov 2007 22:59:34 -0500
Content-Disposition: inline
In-Reply-To: <1194702594213-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65337>

On Sat, Nov 10, 2007 at 02:49:54PM +0100, Steffen Prohaska wrote:
> +[[bisect-merges]]
> +Why bisecting merge commits can be harder than bisecting linear history
> +-----------------------------------------------------------------------
> +
> +This section discusses how gitlink:git-bisect[1] plays
> +with differently shaped histories.  The text is based upon
> +an email by Junio C. Hamano to the git mailing list
> +(link:http://marc.info/?l=git&m=119403257315527&w=2[link:http://marc.info/?l=git&m=119403257315527&w=2]).
> +It was adapted for the user manual.

This is not the only text that's been taken from someplace else, but if
we attributed them all in the text it would get a little cumbersome....
I think the place for that kind of thing is in the commit message, but
if we really think we need to include it in the main text, we could add
a separate "'acknowledgements" section.

> +
> +Using gitlink:git-bisect[1] on a history with merges can be
> +challenging.  Bisecting through merges is not a technical
> +problem. The real problem is what to do when the culprit turns
> +out to be a merge commit.  How to spot what really is wrong, and
> +figure out how to fix it.  The problem is not for the tool but
> +for the human, and it is real.

I think we can pare that down a little.

> +
> +Imagine this history:
> +
> +................................................
> +      ---Z---o---X---...---o---A---C---D
> +          \                       /
> +           o---o---Y---...---o---B
> +................................................
> +
> +Suppose that on the upper development line, the meaning of one
> +of the functions that existed at Z was changed at commit X.  The
> +commits from Z leading to A change both the function's
> +implementation and all calling sites that existed at Z, as well
> +as new calling sites they add, to be consistent.  There is no
> +bug at A.
> +
> +Suppose that in the meantime the lower development line somebody
> +added a new calling site for that function at commit Y.  The
> +commits from Z leading to B all assume the old semantics of that
> +function and the callers and the callee are consistent with each
> +other.  There is no bug at B, either.
> +
> +Suppose further that the two development lines were merged at C
> +and there was no textual conflict with this three way merge.
> +The result merged cleanly.
> +
> +Now, during bisect you find that the merge C is broken.  You
> +started to bisect, because you found D is bad and you know Z was
> +good.  The breakage is understandable, as at C, the new calling
> +site of the function added by the lower branch is not converted
> +to the new semantics, while all the other calling sites that
> +already existed at Z would have been converted by the merge.  The
> +new calling site has semantic adjustment needed, but you do not
> +know that yet.
> +
> +You need to find out what is the cause of the breakage by looking
> +at the merge commit C and the history leading to it.  How would
> +you do that?
> +
> +Both "git diff A C" and "git diff B C" would be an enormous patch.
> +Each of them essentially shows the whole change on each branch
> +since they diverged.  The developers may have well behaved to
> +create good commits that follow the "commit small, commit often,
> +commit well contained units" mantra, and each individual commit
> +leading from Z to A and from Z to B may be easy to review and
> +understand, but looking at these small and easily reviewable
> +steps alone would not let you spot the breakage.  You need to
> +have a global picture of what the upper branch did (and
> +among many, one of them is to change the semantics of that
> +particular function) and look first at the huge "diff A C"
> +(which shows the change the lower branch introduces), and see if
> +that huge change is consistent with what have been done between
> +Z and A.
> +
> +On the other hand, if you did not merge at C but rebased the
> +history between Z to B on top of A, you would have get this
> +linear history:
> +
> +................................................................
> +    ---Z---o---X--...---o---A---o---o---Y*--...---o---B*--D*
> +................................................................
> +
> +Bisecting between Z and D* would hit a single culprit commit Y*
> +instead.  This tends to be easier to understand why it is broken.
> +
> +For this reason, many experienced git users, even when they are
> +working on an otherwise merge-heavy project, keep the histories
> +linear by rebasing their work on top of public upstreams before
> +publishing.

I'd say "partly for this reason", as I don't think this is the only
reason people do that.

I've done the above revisions and a few others and pushed them to

	git://linux-nfs.org/~bfields/git.git maint

I'll take another look in the morning.

--b.
