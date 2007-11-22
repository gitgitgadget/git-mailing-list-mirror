From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 14:34:14 +0100
Message-ID: <FDAFAD8C-8FF5-4DD7-AC5E-BA39790281A4@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org> <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com> <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 14:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCDh-0002mZ-FX
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 14:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbXKVNfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 08:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXKVNfd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 08:35:33 -0500
Received: from wincent.com ([72.3.236.74]:57585 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbXKVNfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 08:35:32 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMDYFVI015267;
	Thu, 22 Nov 2007 07:34:16 -0600
In-Reply-To: <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65821>

El 22/11/2007, a las 12:29, Junio C Hamano escribi=F3:

> It is quite valid for users to run:
>
> 	git add -i \*.sh
>
> and be able to choose from a list which paths to stage (as a
> whole), as well as choose from a list which files to run the
> per-hunk staging interface.  "git add \*.sh" won't give you any
> chance to choose which ones to stage, and that's what we have
> "-i" (interactive) mode in "git add" for.
>
> I think you can massage "git add --partial foo" given by the
> user internally into "git-add--interactive -i --patch foo".  I
> strongly suspect that "direct to patch subcommand" mode needs
> more than just initially jumping into the subcommand (for
> example, you would want to exit when the patch selection
> interaction ends, without going back to the main menu)

This will become especially important if we decide to allow "git =20
commit --interactive" to accept a path spec as well (although exactly =20
when we should exit isn't immediately clear to me); I didn't touch =20
this for the time-being because builtin-commit is getting very close =20
to replacing git-commit.sh.

> and we
> would want a signal stronger than mere presense of pathspecs to
> trigger such a specialized behaviour.
>
> By the way, the arguments on the command line to git commands
> after "--" are generally pathspecs, iow, patterns to specify
> groups of files.  Please do not introduce unnecessary
> inconsistencies to the UI by requiring them to be exact pathname
> only in this particular mode of the command and nowhere else.

Well, I it wasn't my intention to introduce any such requirement. The =20
path parameters get passed in and eventually handed over unmodified to:

	git diff-files -p --

Which was what was previously in the parse_diff function. It turns out =
=20
that if you pass something like \*.sh to git-diff-files then it won't =20
match, but it's not a restriction that I chose to impose, rather it's =20
a consequence of the way git-diff-files works. Are there options we =20
could pass to avoid that restriction?

In any case, one good thing to come out of this discussion is the =20
ability to use pathspecs to limit the number of files displayed when =20
in interactive mode. But it wasn't what I was originally aiming for. =20
My initial goal was to have git-add--interactive do something useful =20
and convenient when you type:

	git add -i foo

If we don't jump straight to the subcommand then the user has to:

	- press 5 or p, then Enter
	- press 1, then Enter

This was easier than it was before (same number of keystrokes, but =20
fewer files to visually scan in the list of candidates), but it's =20
still not that much easier.

Or if we add some kind of "--patch" switch, instead do:

	git add -i --patch foo

Once again, not that easy but you could always set up a Git alias, I =20
guess, as a shortcut. Not sure whether this is offers enough of a =20
workflow improvement to make it worthwhile (ie. you may as well just =20
fire up git-gui).

> There was one funny thing I fixed up.  The arguments to the
> interactive_add() function in builtin-add.c was like this:
>
> 	int interactive_add(const char **argv, int argc)
>
> Anybody who writes a function with such a signature and do not
> notice its craziness before sending it out either (1) has never
> programmed in C, (2) did not review the code before submitting,
> or (3) worked too hard and was too tired.
>
> I suspect, judging from the timestamp of your message, it was
> (3) this time.  The collaborative development is not a race ---
> don't work too hastily and too hard; please relax and review
> after a good night's sleep before sending things out.

In any case I've rebased and squished the changes down to a nice 4-=20
patch series, incorporating all the feedback given so far. Will sit on =
=20
it a while before sending it out, as you suggest. But I don't really =20
have a clear idea where to go forward from here.

Cheers,
Wincent
