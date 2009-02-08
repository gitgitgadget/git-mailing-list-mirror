From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 08 Feb 2009 01:42:07 -0800
Message-ID: <7v1vu91d00.fsf@gitster.siamese.dyndns.org>
References: <20090207162754.5fb8b63f@perceptron>
 <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com>
 <20090208011802.2b7b9e74@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: =?utf-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6Cb-0003Qz-0o
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbZBHJmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 04:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZBHJmX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:42:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZBHJmV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 04:42:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 762C797389;
	Sun,  8 Feb 2009 04:42:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7705797388; Sun,
  8 Feb 2009 04:42:12 -0500 (EST)
In-Reply-To: <20090208011802.2b7b9e74@perceptron> (Jan =?utf-8?Q?Kr=C3=BCg?=
 =?utf-8?Q?er's?= message of "Sun, 8 Feb 2009 01:18:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C68E8F54-F5C4-11DD-9683-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108936>

"Jan Kr=C3=BCger" <jk@jk.gs> writes:

> 1) a local broken symref should generally be ignored unless we actual=
ly
>    need the symref.
>
> 2) there should be a more convenient (porcelain) way to change a
>    refs/remotes/foo/HEAD symref, e.g. git remote set-default, possibl=
y
>    with an option to re-sync from the remote head (we could even make
>    that an option for git remote update).

It would be good to sugarcoat symbolic-ref with "git remote set-somethi=
ng",
although I am not sure "default" is a good term for it (it feels more
like "primary" to me).

> Regarding 2): if we managed to add an option to that to change the
> remote HEAD, we could disallow deleting a remote branch that HEAD
> points to, and refer to this command.

With (2), you would have the ability to pick the branch you are the mos=
t
interested in among the branches that particular remote 'foo' offers,
which is what remotes/foo/HEAD is about.  But the latter part of your
sentence is talking about disallowing the removal of a branch in the
remote 'foo'.  How would (2) help you if what you want is to delete one
particular branch at the remote 'foo'?  I do not think these two are
related at all.

Rather, if you reject deletion of the current branch at the remote, you
would not get into the situation where your remote/foo/HEAD points at
nonexisting tracking branch by your own "deleting the branch by pushing=
 a
void to the remote", and you would reduce the need for (2).

I said "reduce" because you can get into the same situation by other
means.  For example, somebody else can remove the branch your
remotes/foo/HEAD points at.  Or the repository owner of the remote can =
say
"my HEAD is not 'master' anymore, it is 'next'" and delete 'master' fro=
m
there.  In either case, your next "git remote prune foo" will get you i=
nto
that situation, and you would need (2) to recover (or use symbolic-ref)=
=2E

=46orbidding the deletion of the current branch at remote and (2) do no=
t
have anything to do with each other.

I think forbidding the removal of the current branch falls into the sam=
e
category as forbidding the updating of the current branch.  It is what =
you
would want to avoid in many workflows, and receive.denyDeleteCurrent th=
at
defaults to refuse may eventually be a good way to do this, but we need=
 a
transition plan for that escape hatch.  Most people may not see why the=
y
would want to do such a thing, and many people may perceive that in *th=
eir
own* workflow such an operation can only be a mistake, but that is not =
a
good enough reason to suddenly start forbidding something other people
were allowed to do so far.

The "refer to this command" you mention can and should be issued when t=
he
user actually uses "remotes/foo" (or "remotes/foo/HEAD"), expecting it =
to
resolve to the branch HEAD used to point at but now missing.  The curre=
nt
errors you see in your issue (1) were *meant to* notify you of the
situation as soon as it occurs (i.e. it gives pre-emptive warning, even
before you actually refer to "remotes/foo/HEAD"), expecting that you kn=
ow
what to do (namely, repoint HEAD with symbolic-ref, or remove HEAD), so
theoretically you could also issue the "refer to this command" there as
well.

But I agree the current error messages are a bit too loud, and it would=
 be
better to squelch them and only give the instruction when the user refe=
rs
to "remotes/foo" or "remotes/foo/HEAD".
