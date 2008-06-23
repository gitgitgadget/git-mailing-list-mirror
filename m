From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 10:22:23 +0200
Message-ID: <20080623082223.GA12130@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qDbXVdCdHGoSgWSk";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 10:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAhKe-0005OW-V8
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 10:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYFWIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYFWIW2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 04:22:28 -0400
Received: from pan.madism.org ([88.191.52.104]:52894 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbYFWIW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 04:22:26 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0892437BC6;
	Mon, 23 Jun 2008 10:22:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7AB2A2D030D; Mon, 23 Jun 2008 10:22:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85846>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2008 at 05:15:41AM +0000, Linus Torvalds wrote:
> I think I'll want to add a PARSE_OPT_IGNORE_UNRECOGNIZED flag, and also=
=20
> make it not write the resulting array into argv[0..] but back into=20
> argv[1..] (so that you can use parse_options() as a _filter_ for options=
=20
> parsing and make it easier to do partial conversions), but in the meantim=
e=20
> this mostly works.

You can't, mainly because of option aggregation: if the parser1 knows
about -a and -b, parser2 about -c, then, this kind of things is
problematic: -acb because you need to go to the parser '2' to know about
-c, and you can't filter the arguments and keep -c and give -b to
parser1 again, *BECAUSE* 'b' could also be -c argument.

This "PARSE_OPT_IGNORE_UNRECOGNIZED" thing has been discussed many times
in the past, but it just doesn't fly.

Though to help migrations we can probably introduce a new parse option
construct that would be a callback that is responsible for dealing with
"things" the upper level parser doesn't know about, something where the
callback could be:

enum {
    FLAG_ERROR =3D -1,
    FLAG_NOT_FOR_ME,
    FLAG_IS_FOR_ME,
    FLAG_AND_VALUE_ARE_FOR_ME,
}

int (*parse_opt_unknown_cb)(int shortopt, const char *longopt,
                            const char *value, void *priv);

Where the callback is supposed to work that way:
we pass to it either a shortopt ('\0' else) or a longopt (NULL else) but
never both, and what the parser could find as a possible value in value
(NULL if no value found). Then the parser does what it has to, and
returns one of the previous enum values. ERROR would be a fatal error
(-1 chosen so that one can return error(...)), NOT_FOR_ME if it didn't
want the flag after all, IS_FOR_ME if it took only the flag, without the
value, the last one being if it consumed both the option flag _and_ the
value.

Of course for things like --long-opt=3Dvalue if the callback doesn't eat
the value, then parse_options would have to barf loudly.


The major drawback of this method is that parse_options won't generate
the nice usage help for the things that recurse in such a function. But
at least it eases migration to parseoptions, because I believe rev_parse
and diff_opt_parse to be _way_ easier to migrate to such a callback
_and_ with the old API together (I really believe that the old big
consuming loops could use such a callback directly e.g.) so that
commands using diff and revision options can be migrated to parse-opt
*slowly* rather than all at a time (which is a no-go and is such a big
amount of work that I avoided it in despair).

If people believe it's a sane approach I can do it. I absolutely don't
know why no one thought of that before, but I don't see any major
drawback (except for the "help" bits, but like I said, it's a "code
upgrade path" and not meant to be the final state).



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhfXT4ACgkQvGr7W6HudhyFCgCePCsHkG/sLNuIpDn/bVDgaDO8
8QIAn3HJBuvez+KFJhNuplpQMzF4lg7E
=8S1n
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
