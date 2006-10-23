From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories
 and ranges
Date: Mon, 23 Oct 2006 03:17:45 -0700
Message-ID: <453C96C9.4010005@freedesktop.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig65D60DA86B0426A41DFC3DAD"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 12:18:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbwsS-0003jv-Ca
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 12:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJWKRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 06:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWJWKRs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 06:17:48 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:59039 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751851AbWJWKRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 06:17:48 -0400
Received: (qmail 29355 invoked from network); 23 Oct 2006 10:17:47 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 23 Oct 2006 10:17:47 -0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29824>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65D60DA86B0426A41DFC3DAD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
>> Jamey Sharp and I wrote a script called git-split to accomplish this
>> repository split. git-split reconstructs the history of a sub-project
>> previously stored in a subdirectory of a larger repository. It
>> constructs new commit objects based on the existing tree objects for t=
he
>> subtree in each commit, and discards commits which do not affect the
>> history of the sub-project, as well as merges made unnecessary due to
>> these discarded commits.
>=20
> Very nicely done.

Thanks!

>> We would like to acknowledge the work of the gobby team in creating a
>> collaborative editor which greatly aided the development of git-split.=

>=20
>> from itertools import izip
>> from subprocess import Popen, PIPE
>> import os, sys
>=20
> How recent a Python are we assuming here?  Is late 2.4 recent
> enough?

We ran it with 2.4, so yes.  git-split does require at least 2.4,
though, because it uses set(), str.rsplit(), and subprocess, none of
which existed in 2.3.

>> def walk(commits, new_commits, commit_hash, project):
>>     commit =3D commits[commit_hash]
>>     if not(commit.has_key("new_hash")):
>>         tree =3D get_subtree(commit["tree"], project)
>>         commit["new_tree"] =3D tree
>>         if not tree:
>>             raise Exception("Did not find project in tree for commit "=
 + commit_hash)
>>         new_parents =3D list(set([walk(commits, new_commits, parent, p=
roject)
>>                                 for parent in commit["parents"]]))
>>
>>         new_hash =3D None
>>         if len(new_parents) =3D=3D 1:
>>             new_hash =3D new_parents[0]
>>         elif len(new_parents) =3D=3D 2: # Check for unnecessary merge
>>             if is_ancestor(new_commits, new_parents[0], new_parents[1]=
):
>>                 new_hash =3D new_parents[0]
>>             elif is_ancestor(new_commits, new_parents[1], new_parents[=
0]):
>>                 new_hash =3D new_parents[1]
>>         if new_hash and new_commits[new_hash]["new_tree"] !=3D tree:
>>             new_hash =3D None
>=20
> This is a real gem.  I really like reading well-written Python
> programs.

Thanks.  We had some fun writing this; git's elegant repository
structure made it a joy to work with.

> I wonder if using "git-log --full-history -- $project" to let
> the core side omit commits that do not change the $project (but
> still give you all merged branches) would have made your job any
> easier?

I don't think it would.  We still need to know what commit to use as the
parent of any given commit, so we don't want commits in the log output
with parents that don't exist in the log output.  And rewriting parents
in git-log based on which revisions change the specified subdirectory
seems like a bad idea.

> You are handling grafts by hand because --pretty=3Draw is special
> in that it displays the real parents (although traversal does
> use grafts).  Maybe it would have helped if we had a --pretty
> format that is similar to raw but rewrites the parents?

Yes, that would help.  We could then avoid dealing with grafts manually.


How would you feel about including git-split in the GIT tree?  We could
certainly write up the necessary documentation for it.

- Josh Triplett


--------------enig65D60DA86B0426A41DFC3DAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPJbJGJuZRtD+evsRAqO5AKCoaeUOrH/1x2Q2ImzsK3kQz2+dIgCeLZbQ
Z55RSw8VvkOkcnYu28DStOw=
=zMIf
-----END PGP SIGNATURE-----

--------------enig65D60DA86B0426A41DFC3DAD--
