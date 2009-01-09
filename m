From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [ILLUSTRATION PATCH] color-words: take an optional regular expression describing words
Date: Fri, 9 Jan 2009 13:24:33 +0100
Message-ID: <200901091324.40583.trast@student.ethz.ch>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901091202250.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901091255230.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3341040.k4NF0UjJgC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 13:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLGQs-0000Hf-Dv
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 13:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZAIMY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 07:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbZAIMY0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 07:24:26 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:17114 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbZAIMYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 07:24:25 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 13:24:23 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Jan 2009 13:24:23 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901091255230.30769@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 09 Jan 2009 12:24:23.0184 (UTC) FILETIME=[344A4900:01C97255]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105009>

--nextPart3341040.k4NF0UjJgC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> In some applications, words are not delimited by white space.  To
> allow for that, you can specify a regular expression describing
> what makes a word with
>=20
> 	git diff --color-words=3D'^[A-Za-z0-9]*'
[...]
> 	> Intuitively, all you would have to do is to replace this part in=20
> 	> diff_words_show()
> 	>=20
> 	>         for (i =3D 0; i < minus.size; i++)
> 	>                 if (isspace(minus.ptr[i]))
> 	>                         minus.ptr[i] =3D '\n';
> 	>=20
> 	> by a loop finding the next word boundary.
[...]
> 	> However, as I said, I think it would be much more intuitive to=20
> 	> characterize the _words_ instead of the _word boundaries_.

That doesn't work.  You cannot overwrite actual content in the strings
to be diffed with newlines.  The current --color-words exploits the
fact that we don't care about spaces anyway, so we might as well
replace them with newlines, but we _do_ care about the words and in
the regexed version, you have no guarantees about where they might start.

To wit:

  thomas@thomas:~/tmp/foo(master)$ cat >foo
  foo_bar_baz
  quux
  thomas@thomas:~/tmp/foo(master)$ git add foo
  thomas@thomas:~/tmp/foo(master)$ git ci -m initial
  [master (root-commit)]: created f110c6c: "initial"
   1 files changed, 2 insertions(+), 0 deletions(-)
   create mode 100644 foo
  thomas@thomas:~/tmp/foo(master)$ cat >foo
  foo_
  ar_
  az
  quux
  thomas@thomas:~/tmp/foo(master)$ git diff
  diff --git i/foo w/foo
  index 5b34f11..a2762c6 100644
  --- i/foo
  +++ w/foo
  @@ -1,2 +1,4 @@
  -foo_bar_baz
  +foo_
  +ar_
  +az
   quux
  thomas@thomas:~/tmp/foo(master)$ git diff --color-words
  diff --git i/foo w/foo
  index 5b34f11..a2762c6 100644
  --- i/foo
  +++ w/foo
  @@ -1,2 +1,4 @@
  foo_bar_bafoo_
  ar_
  az
  quux
  thomas@thomas:~/tmp/foo(master)$ git diff --color-words=3D'[a-zA-Z]+_?'
  diff --git i/foo w/foo
  index 5b34f11..a2762c6 100644
  --- i/foo
  +++ w/foo
  @@ -1,2 +1,4 @@
  quux

Even without the colours, you can see that it has a blind spot for
changes around a newline.  Perhaps there is an easier way to remember
them, but we definitely cannot *forget* about the word boundaries.

That being said, even though my patch correctly sees the changes, the
above test case also exposes some sort of string overrun :-(

> 	> And I would like to keep the default as-is (together _with_ the=20
> 	> performance.  IOW if the user did not specify a regexp, it should fall=
=20
> 	> back to what it does now, which is slow enough).

That's definitely a valid request.

I'll come up with a fixed patch, and probably make it both
funcname-like (Jeff's idea) and command line configurable.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3341040.k4NF0UjJgC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklnQggACgkQqUud07tmzP3HZACfdk+OK5ROKksD6nBKXRvRU0rn
yScAn3/c4Eb4E9t4h7daT+E/0Exh9WAq
=1omY
-----END PGP SIGNATURE-----

--nextPart3341040.k4NF0UjJgC--
