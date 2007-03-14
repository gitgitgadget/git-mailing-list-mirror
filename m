From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 18:31:51 -0700
Message-ID: <7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRILZ-0006mb-3Z
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbXCNBbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbXCNBbx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:31:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35499 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbXCNBbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:31:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314013151.IXDX1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 21:31:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aRXr1W00w1kojtg0000000; Tue, 13 Mar 2007 21:31:52 -0400
In-Reply-To: <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 13 Mar 2007 18:13:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42166>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 14 Mar 2007, Alex Riesen wrote:
>>
>> This introduces a new command-line option: --exit-code. The diff
>> programs will return 1 for differences, return 0 for equality, and
>> something else for errors.
>
> I don't think you should need a new command-line option.
>
> Is there any reason to not just do this unconditionally?

Exiting with 0 for no-change, 1 for has-change and other value
for error is something that falls into the

    "I wish if we did it from day one, but now many people's
    scripts depend on the behaviour, and heck we ourselves say
    that the right way to see if there is difference is to check
    if the output is an empty string (look at a few scripts of
    our own), so it would be a huge backward compatibility
    hassle"

category.

e.g.

git-am.sh:	files=$(git-diff-index --cached --name-only HEAD) || exit
git-am.sh:      changed="$(git-diff-index --cached --name-only HEAD)"
t/t0020-crlf.sh:	differs=`git diff-index --cached HEAD` &&
t/t0020-crlf.sh:	differs=`git diff-index --cached HEAD` &&
t/t0020-crlf.sh:	differs=`git diff-index --cached HEAD` &&
t/t0020-crlf.sh:	differs=`git diff-index --cached HEAD` &&

And I expect people's scripts are modelled after how git's
scripts do things --- if they were half competent, they'd know
that would be the way to make sure their scripts would be
compatible with future plumbing changes.
