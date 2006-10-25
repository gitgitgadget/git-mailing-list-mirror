X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories
 and ranges
Date: Tue, 24 Oct 2006 18:59:33 -0700
Message-ID: <453EC505.7060807@freedesktop.org>
References: <451A30E4.50801@freedesktop.org>	<7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>	<453C96C9.4010005@freedesktop.org>	<Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>	<453D17B5.6070203@freedesktop.org> <7vu01tfe6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDE85A4A98B45E40B30ED5CB"
NNTP-Posting-Date: Wed, 25 Oct 2006 02:06:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <7vu01tfe6u.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30024>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcY3X-00032b-SE for gcvg-git@gmane.org; Wed, 25 Oct
 2006 03:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422778AbWJYB7p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 21:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWJYB7o
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 21:59:44 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:36241 "EHLO
 mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP id S1422778AbWJYB7n
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 21:59:43 -0400
Received: (qmail 8211 invoked from network); 25 Oct 2006 01:59:43 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.142])
 (josh@[66.93.40.92]) (envelope-sender <josh@freedesktop.org>) by
 mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP for
 <junkio@cox.net>; 25 Oct 2006 01:59:42 -0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDE85A4A98B45E40B30ED5CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
>> Linus Torvalds wrote:
>>> And yes, that's done by the core revision parsing code, so when you d=
o
>>>
>>> 	git log --full-history --parents -- $project
>>>
>>> you do get the rewritten parent output (of course, it's not actually =

>>> _simplified_, so you get a fair amount of duplicate parents etc which=
=20
>>> you'd still have to simplify and which don't do anything at all).
>>>
>>> Without the "--full-history", you get a simplified history, but it's =

>>> likely to be _too_ simplified for your use, since it will not only=20
>>> collapse multiple identical parents, it will also totally _remove_ pa=
rents=20
>>> that don't introduce any new content.
>> Considering that git-split does exactly that (remove parents that don'=
t
>> introduce new content, assuming they changed things outside the
>> subtree), that might actually work for us.  I just checked, and the
>> output of "git log --parents -- $project" on one of my repositories
>> seems to show the same sequence of commits as git log --parents on the=

>> head commit printed by git-split $project (apart from the rewritten
>> sha1s), including elimination of irrelevant merges.
>=20
> So one potential action item that came out from this discussion
> for me is to either modify --pretty=3Draw (or add --pretty=3Drawish)
> that gives the rewritten parents instead of real parents?  With
> that, you can drop the code to simplify ancestry by hand in your
> loop, and also you do not have to do the grafts inforamation
> yourself either?
>=20
> If that is the case I'd be very happy.
>=20
> The only thing left for us to decide is if reporting the true
> parenthood like the current --pretty=3Draw makes sense (if so we
> need to keep it and introduce --pretty=3Drawfish).
>=20
> The only in-tree user of --pretty=3Draw seems to be git-svn but it
> only looks at path-unlimited log/rev-list from one given commit,
> so the only difference between dumping what is recorded in the
> commit object and listing what parents we _think_ the commit has
> is what we read from grafts.  I think we are safe to just "fix"
> the behaviour of --pretty=3Draw

I actually think I want to look further into the idea of just using git
--pretty=3Draw --parents -- $project, and see if I can find any corner ca=
ses
where it generates a different history than what we want.  This combinati=
on of
options seems like it provides everything we need: redundant history
simplification, parent rewriting based on simplification and grafts, and =
easy
parsing.  If the only case in which it differs occurs when you have two
distinct commits with identical trees, I don't know that I care too much;=
 that
particular scenario seems unlikely to occur in any of the trees I care ab=
out,
and any sane simplification behavior for it seems OK. :) As long as it ru=
ns
correctly with various ancestor/descendant/cousin/unrelated relationships=

between merged branches (which I want to test further), I think it will d=
o the
job nicely.

- Josh Triplett


--------------enigCDE85A4A98B45E40B30ED5CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPsUNGJuZRtD+evsRAjHSAJ98lvpxIL8CyhBwh8m/TvndwpGm/ACeMv6H
1m4teG8a7OJYdZg60nkMWAs=
=G0WX
-----END PGP SIGNATURE-----

