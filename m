From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 01:58:43 -0700
Message-ID: <7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	<7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPJo-0007Qn-J2
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 09:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933898AbXCNI6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 04:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbXCNI6q
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 04:58:46 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60912 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933898AbXCNI6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 04:58:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314085845.CMFN3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 04:58:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aYyj1W00i1kojtg0000000; Wed, 14 Mar 2007 04:58:44 -0400
In-Reply-To: <81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 09:19:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42186>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> ...
>> Exiting with 0 for no-change, 1 for has-change and other value
>> for error is something that falls into the
>>
>>     "I wish if we did it from day one, but now many people's
>>     scripts depend on the behaviour, and heck we ourselves say
>>     that the right way to see if there is difference is to check
>>     if the output is an empty string (look at a few scripts of
>>     our own), so it would be a huge backward compatibility
>>     hassle"
>>
>> category.
>>
>> e.g.
>>
>> git-am.sh:      files=$(git-diff-index --cached --name-only HEAD) || exit
>> git-am.sh:      changed="$(git-diff-index --cached --name-only HEAD)"
>
> Isn't this crazy? Get the information and never really use it?

The information is used.

The first one says "see if we have already difference stashed in
the index for our own committing --- by the way, if there is an
error, do not do any further harm but error out".  If we do not
get an error, that line is followed by this:

	files=$(git-diff-index --cached --name-only HEAD) || exit
        if [ "$files" ]
        then
        	echo "Dirty index: ..." >&2
                exit 1
	fi

I've been telling you since the #git session that I know that is
*different* from how "diff" works, and I think everybody agrees
if we were doing git from scratch today we would have done exit
status with 0/1/other to signal no-change, have-diff and error.

But the established way for scripts that use plumbing is

 - to check error with $? (or ... || )
 - to check modified-or-not with output

and people who have been learning from the scripts (we used to
have lot more scripts) would have picked up that pattern.
That's why I already told you that --exit-status is the right
thing to do if we were doing it from scratch, but is a wrong
thing to do at this point.  Maybe in a release as big as 1.5.0
that we pre-announce a lot of interface changes.

In short, Linus is right in that the current exit code is not
useful to see what the end users are interested in (and they are
not in the business of debugging git, and diff would error out
only when the repository has problems, perhaps a corrupt object
or something like that).  But being not useful and being
currently not relied upon are two different things.

And I am being conservative, especially after a big release.
