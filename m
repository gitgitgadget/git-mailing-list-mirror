From: martin f krafft <madduck@madduck.net>
Subject: Branch dependencies
Date: Mon, 1 Aug 2011 14:19:46 +0200
Message-ID: <20110801121946.GA575@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: Petr Baudis <pasky@ucw.cz>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:32:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnuTq-000575-97
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1HAPca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 11:32:30 -0400
Received: from seamus.madduck.net ([213.203.238.82]:36504 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1HAPc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 11:32:28 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Aug 2011 11:32:28 EDT
Received: from fishbowl.rw.madduck.net (sysyphus.madduck.net [77.109.139.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id D8B14407D25;
	Mon,  1 Aug 2011 17:25:33 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 3719021736; Mon,  1 Aug 2011 14:19:47 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178349>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

We are trying to approach a functionality I call "branch
dependencies". Essentially, the idea is rooted in distro
development, but probably applies to normal development too.

For instance, you might have a feature branch off upstream. Once
upstream advances, you should merge upstream into your feature
branch (or rebase your feature branch) to ensure that you are
working on the right assumptions.

Another case might be a feature you want to write, which depends on
two (or more) feature branches of other people, e.g. say you need
a new configuration option introduced in feature branch
"conf-option", and you also base your work on the "speedup" branch,
because otherwise the software is too slow for your new feature. If
one or both feature branches advance, you should merge, as before.

It would be useful if Git could help you keep track of what needs to
be merged, especially as the number of feature branches and
dependencies increases. TopGit was Petr's answer to this challenge,
and it works fine, albeit it's a bit too complex and we find it
scaring new contributors, rather than making their lives easier.

Therefore I am investigating ways in which to simplify/improve
TopGit. In doing so, I discovered that you guys made a lot of
progress in Git since the last time I had time to really dive into
your tool.

If you would permit me, then please let me ask if you can think of
Git functionality that could be useful in achieving what we're
trying to do.

For instance, there is git-branch --set-upstream, which could be
useful, but it only seems to support one "dependency" (which is
usually the remote ref being tracked by a branch).

One challenge seems to be that a branching point has no information
about which of the children continues as mainline =E2=80=94 this information
is only available in a project's workflow policy. For instance:

  o--o--o--=E2=97=8F    upstream
      \
       o--=E2=97=8F     feature

But his is actually just the same as

      ,o--=E2=97=8F     feature
  o--o
      `o--=E2=97=8F     upstream

and Git has no way to find out whether it is now "feature" that
needs a merge of "upstream" or vice versa.

It is thus necessary somehow to store the (project-specific)
dependency information, to be able to (automatically) determine that
"feature" needs an update in the above.

TopGit does this using a file in the worktree, but many of us find
this suboptimal.

I have had the following alternative ideas:

  1. a separate DAG, like Git notes. The problem is that this
     requires additional refspecs to be set up for merges and
     fetches;

  2. like (1.), but a ref in refs/heads/* (like pristine-tar). This
     could be considered ugly as it exposes too much implementation
     detail;

  3. information stored in the Git commit messages. Again, too much
     implementation detail exposed and ugly;

  4. additional Git commit headers =E2=80=94 this is not supported at the
     moment (cf. commit generation discussion);

  5. orphan parent nodes to certain commits, in which these data can
     be stored, e.g.

       o--o--o--=E2=97=8F
            /
           o

     To fetch these data, one would walk up the DAG until one finds
     a multi-parent commit with a parent having a specific format
     (somewhat brittle=E2=80=A6)

     To me, this is the least offensive, but it does expose
     implementation details in the commit history.

How else could I store the dependency information, keeping in mind
that I might have more than one dependency?

And the original question remains: given such dependency
information, which Git tools could I harness for the purpose, trying
to reduce the amount of additional code needed?

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
it is better to have loft and lost
than to never have loft at all.
                                                       -- groucho marx
=20
spamtraps: madduck.bogus@madduck.net

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJONpnfwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xAmx
EACrxmRqHeXqbZ8qYJU4gCA0PX06kznLoHM1UQ5lCzONpXxAmM/C1+IJY6JpZj+O
jccoCQ6vy5qOXEevnRZ8satRX94KfYzIFFfCuMEGEo2gCuTnWTOf4GZiTU31YBSX
SY6woY/llchhYt2DFk9RnZpAzOl8ibJm0ab8RJb2jHYW3rigl68ae4ogMoYJY5us
9T5BnGLr7fGnoSC/0pFJxl2SHH56dq7dkkm9NtOKqVGle0HtW2AfYD21bjq6r4wa
XzCXCX1AZZqst41DKjgeGXPevWve6byiMW6el8OGhQQa8def9xtPyjJ3YUH4vAwB
oS/whFbTqX/nwGdVVgOBu5TWWv9EXizP/jloUOixQ6gykG1OftEXTIuhwJdt81EI
2ILIIpu05H6AMdT9H9mrvVaaDJGjJ9c786GIw3FnXTH24MQdaYXk75tE6Msg2yEP
XDDhnvtG7kUB9ImD9w1waCbZtCTiFEC1LtQr6IZzFjnO2WXyBEN6DVHqdYxBAWRv
c1OAAc3NjuVprK4F1lkinsoHMFSYNR6kX0RAJRn+nCbRRxIVdVGRVClOpC/D9oY0
3wsFZK9OGQVui/5glQ/8/eI0NP5KyFwXRqGQxpMZf1UYU4ZUoqX3QXIAgsAZmUDU
pZU8rIPaui5ttcnWcr/Yca8Q1VFNNdIyT5N5RCwbj0jeMQ==
=urI/
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
