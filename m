From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] rebase -i --autosquash: auto-squash commits
Date: Sat, 20 Jun 2009 01:07:04 +0200
Message-ID: <18DDBEE4-8107-4E0D-B503-0F3BB0A81DC9@wincent.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <7vvdmu15j0.fsf@alter.siamese.dyndns.org> <20090619065534.6117@nanako3.lavabit.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 01:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHnBO-0006h7-Th
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 01:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbZFSXHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 19:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZFSXHc
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 19:07:32 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:53253 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZFSXHb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 19:07:31 -0400
Received: from [192.168.1.2] (221.Red-83-59-197.dynamicIP.rima-tde.net [83.59.197.221])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n5JN75Wf007731
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 19 Jun 2009 19:07:07 -0400
In-Reply-To: <20090619065534.6117@nanako3.lavabit.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121920>

El 18/6/2009, a las 23:55, Nanako Shiraishi escribi=F3:

> Teach a new option, --autosquash, to the interactive rebase.
> When the commit log message begins with "!fixup ...", and there
> is a commit whose title begins with the same ..., automatically
> modify the todo list of rebase -i so that the commit marked for
> squashing come right after the commit to be modified, and change
> the action of the moved commit from pick to squash.
>
> This will help the use case outlined in
>
>    From: Junio C Hamano <gitster@pobox.com>
>    Date: Wed, 17 Jun 2009 09:33:19 -0700
>    Subject: Re: git rebase --interactive squash/squish/fold/rollup
>    Message-ID: <7vvdmurfao.fsf@alter.siamese.dyndns.org>

Definitely a fairly common workflow for me. Faced with a sequence like =
=20
this:

	[1/3] Cleanup
	[2/3] Lay groundwork
	[3/3] Implement feature
	[4/4] Doh! more cleanup that should have gone in [1/3]

I usually just let 4/4 stand as a separate commit with a message like:

	More cleanup of XYZ

	Ideally this should have been included in commit abcd1234,
	but wasn't noticed until too late.

Seeing as I'm not perfect, I don't necessarily spend time manipulating =
=20
the history to make it appear that I really am perfect.

Even so, if asked to imagine an ideal workflow for this scenario, I =20
don't really want a new switch for "git rebase -i", but rather the =20
ability to do "git commit --amend" on a non-head commit. (I know this =20
has come up on the list back in February under the subject "FEATURE =20
suggestion git commit --amend <ref>".)

Basically, if you do the following:

	edit
	git add foo
	git commit -m "Cleanup"
	edit
	git add foo
	git commit -m "Lay groundwork"
	edit
	git add foo
	git commit -m "Implement feature"
	# doh! found stuff that should have gone in in step one!
	edit
	git add foo
	git commit --amend HEAD~3

My intention would be for git to actually:

	1. Create a temporary throw-away commit (without updating the HEAD)

	2. Do the equivalent of using "git rebase -i" to squash that =20
temporary commit into the HEAD~3 commit, providing you with the =20
opportunity to edit the adjust the commit message if necessary.

	3. In the event of failure to replay the other commits on top, you =20
would want the process to dump you back where you started (same HEAD =20
as before, with same changes staged in the index) and an error message =
=20
informing you that the changes didn't apply cleanly and that you =20
should use "git rebase -i" instead to walk through the process manually=
=2E

At least for me that would be the ideal interface to this kind of =20
feature. I can't really see myself using these magic commit messages =20
and the --autosquash switch.

However, the "FEATURE suggestion git commit --amend <ref>" thread =20
caused a lot of objections to be raised. Things like:

	- what if <ref> is a merge?

	- what if there are merges between <ref> and the current HEAD?

	- what if the amendment breaks reapplication of later commits?

	- what if <ref> is not an ancestor of the current HEAD?

	- what if <ref> is part of more than one branch? (and would the user =20
be confused if it was only rewritten on one branch?)

Basically as I see it, the kind of workflow being discussed here =20
should only be for the simple case of amending really simple histories =
=20
(basic topic branches) and should bail loudly if pretty much any of =20
the above conditions are true.

Cheers,
Wincent
