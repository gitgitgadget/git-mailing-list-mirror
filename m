From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/4] color-words: refactor to allow for 0-character word boundaries
Date: Mon, 12 Jan 2009 09:47:11 +0100
Message-ID: <200901120947.13566.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12446487.EqnjjFEoIl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIT8-0002fP-W2
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:48:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZALIq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbZALIq6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:46:58 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:36310 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZALIq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 03:46:57 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 09:46:56 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Jan 2009 09:46:56 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 12 Jan 2009 08:46:56.0092 (UTC) FILETIME=[52DB49C0:01C97492]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105304>

--nextPart12446487.EqnjjFEoIl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

As a side remark, this patch makes a good use-case for --patience, and
is not isomorphic to the other edit-and-move examples; rather it's a
delete-and-edit.

Johannes Schindelin wrote:
> Subject: [PATCH 3/4] color-words: refactor to allow for 0-character word =
boundaries

I do not think the term "refactor" is accurate.  Wikipedia roughly
defines it as a code change that preserves all external semantics by
some standard method, and lists methods such as variable renaming,
common code extraction, etc.  You are actually completely replacing
the algorithm "under the hood" with a new one, so no such standard
method applies.

And there is also a tiny semantic change: compare

  A: a b  c
  B: x y  z
        ^^

The old version implicitly generated an empty line at the double
spaces (marked ^^), which subsequently became context and caused the
words to be printed as follows, where <..> is old and [..] is new:

  <a b >[x y ] <c>[z]

Your patched version does not generate empty lines for any space
whatsoever, not even for newlines.  Thus the result is

  <a b  c>[x y  z]

I think this is actually a good change, since it results in longer
chunks for "entirely rewritten" parts of the diff.  It also answers
Junio's question in the other thread:

Junio C Hamano wrote:
>>=20
>> What happens if the input "language" does not have any inter-word spacing
>> but its words can still be expressed by regexp patterns?
>>=20
>> ImagineALanguageThatAllowsYouToWriteSomethingLikeThis.  Does the mechani=
sm
>> help users who want to do word-diff files written in such a language by
>> outputting:
>>=20
>> 	ImagineALanguage<red>That</red><green>Which</green>AllowsYou...
>>=20
>> when '[A-Z][a-z]*' is given by the word pattern?

Your patch handles this as a side-effect *even if the lines are
indented*, since no sequence of spaces whatsoever is special.  (Mine
would have given hard-to-predict results based on the number of
newlines between them, and xdiff's decision whether the newlines or
the words are more valuable as context.)

So I think this is actually an improvement, but the commit message
should point out the change in semantics.

> +static void fn_out_diff_words_aux(void *priv, char *line, unsigned long =
len)
>  {
> +	if (line[0] !=3D '@' || parse_hunk_header(line, len,
> +			&minus_first, &minus_len, &plus_first, &plus_len))

It would be nice to have a comment here that points out that this
method crucially relies on having context length 0 (just as the old
one crucially relied on having the full text in a single hunk).

> +	for (i =3D 0; i < buffer->text.size; i++) {
> +		if (isspace(buffer->text.ptr[i]))
> +			continue;

I think it is this coupling of the loops to find a word, and to find a
word _beginning_, that comes back to haunt you in 4/4.  If the outer
loop was strictly about the words, you could use the regex match info
to find the beginning in the regex case.  This is probably cleaner
than attempting to force an anchored match, since at least the 'grep'
on my system takes '^^foo' to mean 'a "^foo" at the beginning of a
line', so you cannot just unconditionally insert a ^.  (Conditionally
inserting one seems even harder.)


These remarks aside (and the last one is the only one of relevance to
the code), this patch would be a vast improvement of the code even if
we weren't discussing it in the context of the regex feature.  So FWIW

  Acked-by: Thomas Rast <trast@student.ethz.ch>

up to here.  I hope we can agree on some sane regex semantics for
4/4...

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart12446487.EqnjjFEoIl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklrA5EACgkQqUud07tmzP0lsACaAmTivkcGclpffAjlXQLbIpR5
L1UAn3vViStqOYDg5XBZnYy+vT6pk2T1
=9+7G
-----END PGP SIGNATURE-----

--nextPart12446487.EqnjjFEoIl--
