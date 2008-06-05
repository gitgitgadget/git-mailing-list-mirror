From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Thu, 05 Jun 2008 14:16:08 -0700
Message-ID: <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Mpd-0008Tz-Vv
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYFEVQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYFEVQU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 17:16:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFEVQT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 17:16:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1B963DE0;
	Thu,  5 Jun 2008 17:16:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0465B3D1C; Thu,  5 Jun 2008 17:16:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806051720070.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 17:20:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A328770C-3344-11DD-BAC7-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83983>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sometimes, the easiest way to fix up a patch is to edit it directly, even
> adding or deleting lines.  Now, many people are not as divine as certain
> benevolent dictators as to update the hunk headers correctly at the first
> try.
>
> So teach the tool to do it for us.

Two comments and a half.

 * Latest POSIX draft talks about unified context and allows an empty line
   to represent an empty common context line.  GNU diff already emits such
   a diff.  fixup_counts() should take this into account.

 * I'd sleep better at night if 'Probably "diff ..."' part were written in
   a bit more robust way.

 * (minor) There is an established term for this operation: recountdiff,
   so --recount might be a better name.  fixup_counts() also is better
   called recount_diff() if we go this route.

If you are too narrowly focused to only support "git add -e", the first
issue does not matter, because we always emit "SP LF" for such a common
context.  The reason why I care about the first two points is because we
may want to teach git-am about this new option as well in 1.6.0.

And the robustness issue I worry about the second point also applies to a
line that is "^-- $", especially if we were to make this available to
git-am.  Perhaps when the line begins with a '-', the logic could be extra
careful to detect the case where the line looks like the e-mail signature
separator and check one line beyond it to see if it does not look anything
like part of a diff (in which case you stop, without considering the line
you are currently looking at, "^-- $", a deletion of "^- $", as part of
the preimage context).

As to code structure, we might want to make the later parameters to
apply_patch() an integer, of OR'ed flag values, or even a pointer to a
structure that holds options.

Other than that, the patch looks reasonably isolated and clean.
