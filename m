From: Miklos Vajna <vmiklos@frugalware.org>
Subject: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 10:42:29 +0200
Message-ID: <20110411084229.GW5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6nSyB+bcl/pT7+kx"
Cc: timar74@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 10:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Chi-0001q1-HG
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 10:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab1DKImd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 04:42:33 -0400
Received: from virgo.iok.hu ([212.40.97.103]:36866 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839Ab1DKImc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 04:42:32 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E25115809E;
	Mon, 11 Apr 2011 10:42:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A583744965;
	Mon, 11 Apr 2011 10:42:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DB7441358449; Mon, 11 Apr 2011 10:42:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171313>


--6nSyB+bcl/pT7+kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Background: We at LibreOffice are trying to use the 'filter'
gitattributes feature to clean up line wrappings in po files.

The problem is that it seems the clean filter - which is supposed to be
invoked only in case a new blob is created - is invoked even on
clone/pull, and other developers are claiming that it slows down their
workflow.

Is this a bug? I don't exactly understand why this would be necessary.

Here is a short script to reproduce the issue:

----
rm -rf client*
mkdir client
cd client
git init
git config filter.po.clean 'echo foo >&2 && cat'
git config filter.po.smudge cat
echo '*.po filter=3Dpo' > .gitattributes
touch foo.po
git add .gitattributes foo.po
git commit -m foo
cd ..
git clone client client2
cd client2
git config filter.po.clean 'echo foo >&2 && cat'
git config filter.po.smudge cat  =20
cd ..
cd client
echo aaa > foo.po=20
git commit -am second
cd ..
cd client2/
git pull
----

Its output here with 1.7.4.4:

----
$ sh test.sh=20
Initialized empty Git repository in /home/vmiklos/git/t/client/.git/
foo
foo
[master (root-commit) bbf8490] foo
foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes
 create mode 100644 foo.po
Cloning into client2...
done.
foo
[master foo
foo
e37f5ab] second
foo
foo
 1 files changed, 1 insertions(+), 0 deletions(-)
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/vmiklos/git/t/client
   bbf8490..e37f5ab  master     -> origin/master
Updating bbf8490..e37f5ab
foo
Fast-forward
foo
 foo.po |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
----

Any thoughts why the clean filter is invoked on pull?

Thanks.

--6nSyB+bcl/pT7+kx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2ivvUACgkQe81tAgORUJbuhQCeLcYxbfLVbcnuurLZocjQrarh
RpQAn3k4/5DOAmLHUOAG0+r5BT0gcAKO
=XsFP
-----END PGP SIGNATURE-----

--6nSyB+bcl/pT7+kx--
