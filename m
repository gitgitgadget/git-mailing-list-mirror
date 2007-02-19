From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/3] git-fetch: Split fetch and merge logic
Date: Mon, 19 Feb 2007 15:27:09 -0800
Message-ID: <7vfy91684y.fsf@assigned-by-dhcp.cox.net>
References: <874ppmplw7.fsf@gmail.com> <87vei2o75x.fsf@gmail.com>
	<7v649x7u90.fsf@assigned-by-dhcp.cox.net>
	<8aa486160702191413p10c8ca0ek949580ffe953ea79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHuq-0006DZ-67
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965537AbXBSX1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Feb 2007 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965536AbXBSX1P
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:27:15 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51628 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965537AbXBSX1L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 18:27:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219232710.IHZN21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 18:27:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RbT91W00L1kojtg0000000; Mon, 19 Feb 2007 18:27:10 -0500
In-Reply-To: <8aa486160702191413p10c8ca0ek949580ffe953ea79@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 19 Feb 2007 23:13:35
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40161>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

>> > There are two cases where the behaviour is changed:
>> >
>> > 1) branch.*.merge no longer must exactly match the remote part
>> >    of the branch fetched. Both are expanded in full (as refs/heads=
/...)
>> >    and matched afterwards.
> ...
>>  I see this as a regression.
>> If you are setting configuration, wouldn't you rather see the
>> behaviour consistent even when remote adds new refs?

Maybe I misread your description, but I took it to mean that you
are allowing:

	branch.master.merge =3D a

to mean what we traditionally spelled

	branch.master.merge =3D refs/heads/a

and guessed (I haven't looked for where it happens in the code)
the way you do that conversion is by tail-matching the ref; if
the other end creates "refs/heads/b/a", suddenly remote branch
b/a starts matching that pattern wouldn't it?

Earlier we fixed the ambiguous use of branch.*.merge in
756373da; I think the same reasoning should apply here.

Configuration is something you set once because you want to
forget about it afterwards (iow, not having to type every time),
and I think making sure it names things unambiguously outweighs
one-time convenience of being able to write the configuration in
a looser fashion. =20

If somebody does "git checkout -B origin/next" which does:

	git checkout -b next origin/next &&
        git repo-config branch.next.merge $merge

I would expect that the enhanced "checkout" script would not
have any trouble arranging $merge to fully spell out
refs/heads/next.

>> Merging this at this moment would be a pain even if there were
>> no downsides, as there are a few topics that want to touch
>> parse-remote and fetch (two already in 'pu', and git-bundle
>> series also wants to hook into git-fetch); these topics would
>> need to get adjusted if this clean-up goes in first.
>
> A problematic decision :)

Not at all.
