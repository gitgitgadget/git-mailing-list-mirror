From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-save script
Date: Mon, 25 Jun 2007 00:52:35 -0700
Message-ID: <7vir9c1nek.fsf@assigned-by-dhcp.pobox.com>
References: <20070623220215.6117@nanako3.bluebottle.com>
	<Pine.LNX.4.64.0706231605160.4059@racer.site>
	<200706250632.l5P6Wu6A028140@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT <git@vger.kernel.org>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jNH-0005Gc-Gj
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbXFYHwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXFYHwi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:52:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34704 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXFYHwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 03:52:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625075236.WWCL17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:52:36 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fjsc1X0021kojtg0000000; Mon, 25 Jun 2007 03:52:37 -0400
In-Reply-To: <200706250632.l5P6Wu6A028140@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Mon, 25 Jun 2007 15:32:53
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50878>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
>> On Sat, 23 Jun 2007, Nanako Shiraishi wrote:
>>=20
>> > Here is how to use my script:
>> >=20
>> >     $ git save
>> >     $ git pull
>> >     $ git save restore
>>=20
>> This use case has been discussed often, under the name "git-stash".
>
> Thank you for your comments.  Do you suggest I rename the
> script to git-stash and re-submit after fixing according to
> Junio's comments?

        Side note: get into the habit of trimming the quote to
        remove "Hi," and signatures, please.

Because many people on the list (not just me, as I was not
initially involved in the "wish: pulling into dirty tree"
discussion myself) already used the word "stash" for the concept
of the operation, I think it would give continuity to our
discussion if you used that word.

I have to also say that the "restore" subcommand had a certain
"Huh?" factor when I first saw the above "git save restore"
command line.  I would have said "git stash" to save away, and
"git stash apply" to propagate the changes to updated HEAD.

That would make the set of subcommands to:

	$ git stash		-- to save away
	$ git stash list	-- to get the list
        $ git stash show [$it]	-- to view a single stash
        $ git stash apply [$it]	-- to apply changes from a stash

Right now you seem to use reflog so that "list" gives saved@{$n}
and the user is expected to pick from it and say something like
"git stash show saved@{2}", but I suspect that there is some
room for UI improvements.

 * Is comandeering a branch name "saved" for the purpose of the
   stash command a right thing to do?

   Perhaps we would want to use refs/stash/ hierarchy;

 * Is it more convenient to have a single stash that holds
   changes you make anywhere, or is it better to have one stash
   per branch?

   Unlike StGIT and guilt, that are systems to manage patches
   for longer term, I think the concept of stash is more geared
   towards quickly stashing away local changes while you have to
   'get distracted", as you described in your commit log
   message.  So in that sense, I think anything elaborate like
   one stash per branch is a mistake, and a single stash that is
   quickly aged and pruned automatically when reflog expires, as
   you implemented, is the right approach.  Taken together with
   the previous point, I would actually suggest refs/stash as
   the refname.

 * If we settle on the design of having a single stash per
   repository, the name of whatever the ref we use to implement
   the stash should not have to be spelled out by the end user
   (e.g. saved@{2} should not be necessary---the user should be
   able to say "the stash marked with letter '2' in 'git stash
   list' output).

So perhaps as a UI improvement, "git stash list" should show
them just numbered (strip away saved@{$N} part down to just
"$N:" or something), and "git stash show" and "git stash apply"
should take that number.

I think "git stash" is usable standalone, but in the particular
use case you mentioned, I was planning to follow Linus's
suggestion of stashing and unstashing automatically inside "git
pull" (most likely in "git merge", which is the underlying
command to do the actual merging part), when the pull results in
a fast-forward situation.  But that would be a separate change
that uses "git stash" command.
