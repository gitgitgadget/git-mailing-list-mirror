From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one
 argument
Date: Tue, 4 Mar 2014 17:04:03 +0100
Message-ID: <20140304160403.GF11566@login.drsnuggles.stderr.nl>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
 <20140304135106.GD11566@login.drsnuggles.stderr.nl>
 <CALKQrgfC1Cf=ZnwhaDUz-2q=vLa0UbO4ONybvCPu7RiF+3sm3w@mail.gmail.com>
 <20140304145703.GE11566@login.drsnuggles.stderr.nl>
 <CALKQrgcDZD=eDnK5ssqZ3bCpB2gvWPts2W22_ZsCq5UtCxtmhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K7aE7P/AKa2gsrZH"
Cc: Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:04:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrpP-0003bF-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbaCDQES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 11:04:18 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:46103 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbaCDQER (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:04:17 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1WKrp5-0002V7-Fy; Tue, 04 Mar 2014 17:04:06 +0100
Received: (nullmailer pid 9611 invoked by uid 1000);
	Tue, 04 Mar 2014 16:04:03 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Johan Herland <johan@herland.net>, Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALKQrgcDZD=eDnK5ssqZ3bCpB2gvWPts2W22_ZsCq5UtCxtmhg@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243354>


--K7aE7P/AKa2gsrZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Johan,

> Ok, so IINM, Anders' original commit was about making "git submodule
> foreach <command>" behave more like "<command>" (from a naive user's
> perspective),
Ok, that makes sense.

> while you rather expect to insert quotes/escapes to finely control
> exactly when shell interpretation happens.
Well, I mostly expect that the $name and $path that git submodule makes
available to each command invocation can actually be used by the
command.

> Aren't these POVs mutually incompatible? Is the only 'real' solution
> to forbid multitple arguments, and force everybody to quote the entire
> command?
Yes, I think you're right that they're mutually exclusive. Specifically,
if you expect git submodule foreach <command> to behave like <command>,
that means you expect the (interactive) shell to do all the
interpolation, word-splitting, etc. If so, you can't then later still do
interpolation (of course, you could do sed magic to just replace $name
and $path, etc., but that's broken).

> I don't particularly care which way it goes, as long as (a) the common
> case behaves as most users would expect, (b) the uncommon/complicated
> case is still _possible_ (though not necessarily simple), and (c) we
> don't break a sizable number of existing users.
Well, if you call submodule directly, you can now just put everything in
a single command and get $name interpolation.

As I mentioned, I couldn't do this because I was using a git alias.
However, a bit of fiddling showed a solution to that using a shell
function:

[alias]
	each = "!f(){ git submodule foreach --quiet \"echo \\$name $*\";}; f"

This uses a shell function to collect all alias arguments and then uses
$* to expand them again into the single submodule foreach argument. Note
that $* is expanded when evaluating the alias, while \\$name is expanded
later inside submodule.

This suggests that with the current code, the more complicated cases are
still possible. There is one catch in this approach, in that the
original word splitting is not preserved ($* expands to just the
unquoted arguments as a single word). I'm not sure if this is fixable
($@ expands to multiple quoted words, but then foreach sees multiple
arguments and doesn't do the eval). One would need to escape the output
of $@ somehow (e.g., add \ before ", but that would become terribly
complicated I expect...).


Perhaps an explicit --eval switch to git submodule makes sense for
complete control? If it has a correspondning --no-eval, you can even
pass a single-argument command without evalling, while still keeping the
current "least surprise" approach as the default?

Whatever behaviour is settled for, it should be documented in the
submodule manpage (which I think is not the case now).

Gr.

Matthijs

--K7aE7P/AKa2gsrZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlMV+XMACgkQz0nQ5oovr7xv8QCeIa8eSY+1l9KE9WhLMNAgZcfe
u00AnA+gTb80HJlWKwxMKX18nGS5X1NX
=9AE3
-----END PGP SIGNATURE-----

--K7aE7P/AKa2gsrZH--
