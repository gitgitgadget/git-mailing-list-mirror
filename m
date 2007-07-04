From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [Qgit RFC] commit --amend
Date: Wed, 4 Jul 2007 20:28:06 +0200
Message-ID: <20070704182806.GA3268@efreet.light.src>
References: <20070610150839.GG4084@efreet.light.src> <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com> <20070611044258.GJ4084@efreet.light.src> <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com> <20070701122625.GC26243@efreet.light.src> <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com> <20070702180309.GA4400@efreet.light.src> <7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net> <e5bfff550707040544l6272bdeao3a891c1793d29eae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 20:31:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I69dO-0006H0-OI
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 20:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbXGDSbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755636AbXGDSbY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 14:31:24 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:33811 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbXGDSbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 14:31:23 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 72FC357348;
	Wed,  4 Jul 2007 20:31:22 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id qNzqAMNscxxT; Wed,  4 Jul 2007 20:31:20 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D5ACF572CF;
	Wed,  4 Jul 2007 20:31:19 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I69aA-000116-9m; Wed, 04 Jul 2007 20:28:06 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550707040544l6272bdeao3a891c1793d29eae@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51631>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2007 at 14:44:16 +0200, Marco Costalba wrote:
> On 7/4/07, Junio C Hamano <gitster@pobox.com> wrote:
>> But if a Porcelain like StGIT or Qgit would want to do that kind
>> of operation for different use case than "amending", it can and
>> should use plumbing commands, just like the implementation of
>> "commit --amend" does, with different constraints and error
>> checks.

I would prefer if there was something between git-commit-tree and git-commi=
t.
There are several steps one has to do for commit, that are the same for most
ways of commit:
 - call pre-commit hook (unless --no-verify)
 - write-tree
 - commit-tree
 - update-ref
 - mv next-index index
 - call post-commit hook (unless --no-verify or unconditionally?)

Would factoring out such script from the end of git-commit.sh be accepted?

Or would it be possible to get just that from git-commit with right options?
Basically I need to replicate the logic with=20

I would suggest a name git-commit-index. It would take the index to commit,
index to move in after commit, head to update, list of parents and commit
message on standard input (as commit-tree does).

The other thing is, that of course qgit (or any other frontend) can't start
using it until it's accepted and released with git. So I'll first try to get
it working in qgit and than think about making it a separate plumbing comma=
nd
in git.

> I always prefer qgit to use the highest level commands as possible becaus=
e:
>
> 1- Less error prone
> 2- Easier to implement

Definitely.

> 3- More robust to API change
> 4- Less easy to break by changes in git.

Actually, no. The porcelains are more likely to change than the plumbing.

> Having said that, from '-F' option documentation:
>
> -F <file>::
> 	Take the commit message from the given file.  Use '-' to
> 	read the message from the standard input.
>
> Jan, what about to use '-' and feed message from stdin?

I actually am, because I am rewriting it to use plumbing, which means
git-write-tree and git-commit-tree directly. And git-commit-tree always rea=
ds
commit message from stdin.

> Indeed the full signature of run() is:
>
> bool Git::run(SCRef runCmd, QString* runOutput, QObject* receiver, SCRef=
=20
> buf)
>
> Where the last parameter 'buf' it's a string that, if not empty, is
> passed to the launched program stdin.

=2E.. except if I read the code correctly, it will create a temporary file
anyway. The comment in QGit::startProcess says it is because of windows, but
there is nothing to disable it in Unix, so to me it seems temporary file is
used anyway.

> I don't know if it is already too late, but I would suggest to stick
> to git-commit if possible, I see only downsides in not doing so. But
> of course who writes the code decides.

The old code needs rewriting in any case, because if I read it correctly, it
will not commit merges either. Yes, you rarely do it, because git
automatically commits non-conflicting merges, but amending such commits is
much more common.

I would personally most like qgit to do all playing with index on it's own
and than call a single command to commit the index. But commit can't really
do that, because I can't give commit the parent list and I don't like the
idea of reset --soft HEAD^ + reinstate whatever MERGE_HEAD there needs to be
(to not clutter reflog and also to leave the tree is as sensible state as
possible if something goes wrong).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGi+a2Rel1vVwhjGURAi2OAKDZrWcUbAjlLdKAlWZK1oESkPFOowCfXKFh
cLdd5TVRdXob+4S7COJqYFM=
=4zle
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
