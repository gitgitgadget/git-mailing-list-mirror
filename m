From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Tue, 23 May 2006 16:15:37 -0700
Message-ID: <7vzmh81gfa.fsf@assigned-by-dhcp.cox.net>
References: <4471CF23.1070807@gmx.de>
	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net> <44737353.20904@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 01:15:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fig6J-0001HG-OY
	for gcvg-git@gmane.org; Wed, 24 May 2006 01:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWEWXPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 23 May 2006 19:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEWXPj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 19:15:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4231 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932274AbWEWXPi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 19:15:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523231538.HOBR5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 19:15:38 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
In-Reply-To: <44737353.20904@gmx.de> (=?iso-8859-1?Q?Bj=F6rn?= Engelmann's
 message of "Tue, 23
	May 2006 22:40:51 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20647>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> I am currently wondering where to store the reference to such a
> sub-repository. It certainly is a head, but I would like to avoid any=
one
> commiting code into this "branch". Maybe I will create a new director=
y
> .git/refs/annotations.

I would recommend against that.  Why shouldn't it be an ordinary
branch that is different from the default "master"?

If you are in a shared repository settings, then update hook is
there for you to prevent people who do not have any business
touching that branch head from mucking with it.

> I am not sure how git would perform in such an environment. Do you th=
ink
> the "git-push"-implementation is sufficiently "thread-save" for this =
?

Yes.

And I do not necessarily think your workflow would want to have
such "an empty file works as a lock" convention.

Just do things locklessly.  If two people in the group happened
to do duplicated work, the first push would succeed and the
second person would be prevented from pushing (and suggested to
merge in the work first).  When the second person pulls, he
would realize the scan result by the first person is already
there.  If that is considered to be too much wasted work, then
it means your distributed workflow did not have sufficient
communication among people.  Being able to work distributed does
not mean you need no coordination, and a distributed SCM is not
a substitute for comminication among paticipants.

> 1.) Do you intend to add some more advanced metadata-functionality to
> git in the future or should I send a patch with my implementation onc=
e
> it is finished ? Will be just some scripts using similar commands to
> what Linus sent me (thanks for that, btw)

Neither, until/unless we have a clear design.

I think the annotation branch (or a separate repository) is a
very natural consequence of what the tool already give you, and
the tools work just fine as they are.  There is nothing
innovative in what I suggested above nor Linus outlined in the
other message.

If you are talking about an application that builds on top of
git to do issue management (or QA or whatever), that uses
metadata linked to the commits on the main development branch,
that would be a wonderful system, but that does not necessarily
have to come with git (it's just an application on top of git,
and the workflow of your organization may or may not match other
people's workflow).

> 2.) Searching for a way to add objects to the database I spent quite =
a
> while to find the right command. Don't you think it would be much mor=
e
> intuitive having an
>
>     git-create-object [-t <type>] [-n] [-f] [-z] [--stdin] <file> [-r
> <ref-name>]
>
> command for creating any type of object (-t blob as default).

No, I do not think we would want to make it too easy and relaxed
to create arbitrary object-looking thing.  Each type have
defined format and semantics, and creation of an object of each
type should be validated.  I do not want to encourage bypassing
it by introducing such a backdoor.  The backdoor is easy to
write, but I suspect it would actively harm us, instead of
helping us, by encouraging "let's build a custom type of object,
we do not care if other people would not understand it"
mentality.
