From: Daniel Carosone <dan@geek.com.au>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 09:21:39 +1000
Message-ID: <20060913232139.GU29625@bcd.geek.com.au>
References: <45084400.1090906@bluegap.ch>
	<20060913225200.GA10186@frances.vorpus.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0285268247=="
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 01:22:00 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNe3F-0001ML-AG
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 01:21:53 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNe3E-0005YF-KR
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 19:21:52 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNe37-0005Vs-KI
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 19:21:45 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNe35-0005Tn-T3
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 19:21:45 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNe35-0005Td-L9
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 19:21:43 -0400
Received: from [203.17.37.1] (helo=geek.com.au)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNe4s-0003T5-RI
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 19:23:36 -0400
Received: by geek.com.au (Postfix, from userid 106)
	id 8F83049F7B; Thu, 14 Sep 2006 09:21:39 +1000 (EST)
To: Markus Schiltknecht <markus@bluegap.ch>, monotone-devel@nongnu.org,
	dev@cvs2svn.tigris.org, Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Markus Schiltknecht <markus@bluegap.ch>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060913225200.GA10186@frances.vorpus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26963>


--===============0285268247==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AYCDT44HuZYhsDxA"
Content-Disposition: inline


--AYCDT44HuZYhsDxA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2006 at 03:52:00PM -0700, Nathaniel Smith wrote:
> This isn't trivial problem.  I think the main thing you want to avoid
> is:
>     1  2  3  4
>     |  |  |  |
>   --o--o--o--o----- <-- current frontier
>     |  |  |  |
>     A  B  A  C
>        |
>        A
> There are a lot of approaches one could take here, on up to pulling
> out a full-on optimal constraint satisfaction system (if we can route
> chips, we should be able to pick a good ordering for accepting CVS
> edits, after all).  A really simple heuristic, though, would be to
> just pick the file whose next commit has the earliest timestamp, then
> group in all the other "next commits" with the same commit message,
> and (maybe) a similar timestamp. =20

Pick the earliest first, or more generally: take all the file commits
immediately below the frontier.  Find revs further below the frontier
(up to some small depth or time limit) on other files that might match
them, based on changelog etc (the same grouping you describe, and we
do now).  Eliminate any of those that are not entirely on the frontier
(ie, have some other revision in the way, as with file 2).  Commit the
remaining set in time order. [*]

If you wind up with an empty set, then you need to split revs, but at
this point you have only conflicting revs on the frontier i.e. you've
already committed all the other revs you can that might have avoided
this need, whereas we currently might be doing this too often).

For time order, you could look at each rev as having a time window,
=66rom the first to last commit matching.  If the revs windows are
non-overlapping, commit them in order.  If the rev windows overlap, at
this point we already know the file changes don't overlap - we *could*
commit these as parallel heads and merge them, to better model the
original developer's overlapping commits.

> Handling file additions could potentially be slightly tricky in this
> model.  I guess it is not so bad, if you model added files as being
> present all along (so you never have to add add whole new entries to
> the frontier), with each file starting out in a pre-birth state, and
> then addition of the file is the first edit performed on top of that,
> and you treat these edits like any other edits when considering how to
> advance the frontier.

CVS allows resurrections too..

> I have no particular idea on how to handle tags and branches here;
> I've never actually wrapped my head around CVS's model for those :-).
> I'm not seeing any obvious problem with handling them, though.

Tags could be modelled as another 'event' in the file graph, like a
commit. If your frontier advances through both revisions and a 'tag
this revision' event, the same sequencing as above would work. If tags
had been moved, this would wind up with a sequence whereby commits
interceded with tagging, and we'd need to split the commits such that
we could end up with a revision matching the tagged content.

> In this approach, incremental conversion is cheap, easy, and robust --
> simply remember what frontier corresponded to the final revision
> imported, and restart the process directly at that frontier.

Hm. Except for the tagging idea above, because tags can be applied
behind a live cvs frontier.

--
Dan.

--AYCDT44HuZYhsDxA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (NetBSD)

iD8DBQFFCJKDEAVxvV4N66cRAkFNAKDkNYjXOnGjFyf8PTe0vHRoGdmf1QCgupKI
X0XXnlbNNpq6bUYs3d6r1Rg=
=7wJy
-----END PGP SIGNATURE-----

--AYCDT44HuZYhsDxA--



--===============0285268247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Monotone-devel mailing list
Monotone-devel@nongnu.org
http://lists.nongnu.org/mailman/listinfo/monotone-devel

--===============0285268247==--
