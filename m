From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Wed, 09 Jun 2010 09:56:26 -0700
Message-ID: <877hm8i1qd.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org> <87eiggiy8g.fsf@yoom.home.cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 18:56:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOaB-0004fj-A4
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 18:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab0FIQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 12:56:45 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:54604 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251Ab0FIQ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 12:56:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 6D55E4196F2;
	Wed,  9 Jun 2010 09:56:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkVJZFi++hw6; Wed,  9 Jun 2010 09:56:32 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id A84294196F0;
	Wed,  9 Jun 2010 09:56:32 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 4FC9B568E33; Wed,  9 Jun 2010 09:56:32 -0700 (PDT)
In-Reply-To: <87eiggiy8g.fsf@yoom.home.cworth.org>
User-Agent: Notmuch/0.3.1-61-ge870437 (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148794>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 22:14:23 -0700, Carl Worth <cworth@cworth.org> wrote:
> On Tue, 08 Jun 2010 20:50:01 -0700, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Carl Worth <cworth@cworth.org> writes:
> > Especially because your implementation quotes lines that begin with "Fr=
om "
> > unconditionally (even when the tail end of the line would never be a
> > valid-looking timestamp).  Such an output will confuse existing mailspl=
it,
> > but the worst part of the story is that somebody who is applying a seri=
es
> > of patches will _not_ notice the breakage.  The payload of the second a=
nd
> > subsequent messages will likely be concatenated as if it were part of t=
he
> > first message, ignoring cruft between patches, but the resulting tree
> > would likely to be the same as what the sending end intended.
...
> Could you describe in more detail how the implementation could lead to a
> case like that? I'm not seeing it myself. But if you can show me, I'll
> be happy to attempt a fix.

Oh, perhaps I understand what you were getting at here.

If a commit is created (by whatever means) with a commit message that
has a line of the form:

	"From ... <timestamp>"

then with the existing code, there will be a failure if someone does a
format-patch and a git-am of that commit. And that might raise attention
that perhaps something went wrong.

But with my patch series, that commit will transfer through the
format-patch and git-am just fine.

I would contend that preserving this commit is the right (and "robust")
thing to do. For example, looking at the log recent of git.git master I
see 5 commits that have a "From ... <timestamp>" line in the commit
message.=20

	34122b57eca747022336f5a3dc1aa80377d1ce56
	48027a918d89bad6735897a2c3da77c0451a038c
        19a8721ef8f82153fee93c62bd050659cf718d6d
	3dc1383290f9db3371a13ae8009ce4fcd5ffc93a
	1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2

They all look to me like mistakes, some worse than others. But now that
they are part of the history of the project, it would be better and more
robust of git to actually be able to replay these successfully.

Git has various tools for rewriting history, which are useful for
various reasons. But these tools will get tripped up on a commit like
one of the above. For example, taking the most recent commit from above,
"git rebase" is unable to replay it successfully:

	$ git checkout -b tmp 34122b57eca747022336f5a3dc1aa80377d1ce56
	Switched to a new branch 'tmp'
	$ git rebase --onto HEAD~2 HEAD~1
	First, rewinding head to replay your work on top of it...
	Patch is empty.  Was it split wrong?

After my patch series this rebase works:

	$ git checkout -b tmp 34122b57eca747022336f5a3dc1aa80377d1ce56
	Switched to a new branch 'tmp'
	0:~/src/git:(tmp)$ git rebase --onto HEAD~2 HEAD~1
	First, rewinding head to replay your work on top of it...
	Applying: gitweb: Always use three argument form of open

That's git being demonstrably more robust. And an operation like that
would make a good test for git's test suite.

Now, it's likely git could also use some help to avoid whatever mistakes
caused these commits to be created in the first place, but that's an
orthogonal issue.

Also, there is one commit that is more particularly broken than any of
the others. Even my patch series is not sufficient to successfully
replay the following commit:

	1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2

That's because in addition to the From_ line in the commit message, this
commit also has an entire additional patch within the commit
message. And git's "patch as email" format has an additional quoting
problem with the "---" delimiter to separate the commit message from the
patch. And again, that's orthogonal from the mbox quoting I'm currently
trying to solve.

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMD8e66JDdNq8qSWgRApUmAKClESfSUXj8mUsOurVxPq2g181krACeKvPs
8b+rignris9aGygZ3ksGvlk=
=xorm
-----END PGP SIGNATURE-----
--=-=-=--
