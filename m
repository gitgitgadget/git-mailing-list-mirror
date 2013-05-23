From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 00:10:51 +0200
Message-ID: <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
	<loom.20130523T185301-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Jim Greenleaf <james.a.greenleaf@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufdj7-0001Vz-V3
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759713Ab3EWWKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 May 2013 18:10:55 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:22062 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759689Ab3EWWKy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 May 2013 18:10:54 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 May
 2013 00:10:43 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.208.253) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 24 May 2013 00:10:52 +0200
In-Reply-To: <loom.20130523T185301-635@post.gmane.org> (Jim Greenleaf's
	message of "Thu, 23 May 2013 16:57:23 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225308>

Jim Greenleaf <james.a.greenleaf@gmail.com> writes:

> Adeodato Sim=C3=B3 <dato <at> net.com.org.es> writes:
>
>> I was unpleasantly surprised to discover yesterday that doing `git
>> stash` on a repository where I had previously run `git update-index
>> --assume-unchanged FOO` completely lost all changes I had in file FO=
O.
>
> I just ran into this today.
>
> Was a decision about this behavior reached in the intervening time?

When you mark a file assume-unchanged, git internally sets a flag that
this file should not be considered when doing cache refreshes -- the
file is always assumed to be up-to-date.

So while I haven't actually looked into all of the code, I imagine it
goes something like this:

* git-stash uses git update-index --all on all modified files.  But it
  doesn't show up as modified, because you promised it isn't.

* Later it calls git reset --hard, which blows away the existing state.
  This would seem to ignore the assume-unchanged flag in this case, as
  otherwise it wouldn't overwrite it.

Whether the last behavior is a bug is in the eye of the beholder.  In
your case you apparently lost work.  However, 'git reset --hard' in
itself should discard all uncommitted work without asking any further
questions (because it's --hard).  So the bug is then in the sequence

  ask about uncommitted work
  save it elsewhere
  git reset --hard

assuming that this actually makes sure nothing gets lost.  But the only
thing that was lost was *files that you promised would not be changed*.


What's really unfortunate is that we caused this in the first place by
Pasky's 6259ac6 (Documentation: How to ignore local changes in tracked
files, 2008-07-18).  It recommends exactly the --assume-unchanged
strategy to ignore changes to tracked files.

And it's hard to disagree with its commit message:

    This is currently probably one of the top FAQs at #git and the
    --assume-unchanged switch is not widely known

Except that now the corresponding FAQ is that we have to actively
dissuade people from using --assume-unchanged precisely because it keep=
s
biting people.

So maybe it would be time to first make up our minds as to what
--assume-unchanged should actually mean:

* Ignore changes to a tracked file, but treat them as valuable.  In
  this case we'd have to make sure that failures like git-stash's are
  handled properly.

* Ignore changes to a tracked file, as in "who cares if it was changed"=
=2E

* A very specific optimization for users who know what they are doing.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
