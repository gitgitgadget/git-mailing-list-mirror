From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Centralized processes in git
Date: Mon, 20 Aug 2007 21:29:47 +0200
Message-ID: <20070820192947.GD8542@efreet.light.src>
References: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Cc: git@vger.kernel.org
To: Robert Boone <robert@rlb3.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INCws-0000wX-FH
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760508AbXHTT36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760484AbXHTT36
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:29:58 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53829 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbXHTT35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:29:57 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1031E5742C;
	Mon, 20 Aug 2007 21:29:56 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id WKlUl7CBDvzB; Mon, 20 Aug 2007 21:29:53 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E40615730B;
	Mon, 20 Aug 2007 21:29:52 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INCwd-0006vu-Q7; Mon, 20 Aug 2007 21:29:47 +0200
Content-Disposition: inline
In-Reply-To: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56241>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 13:30:47 -0500, Robert Boone wrote:
> Hello,
>     My company is looking at git to replace subversion as our scm. We hav=
e=20
> a small team of developers which need to publish to a centralized=20
> repository. One thing we would like is to have an automated bug fix merge=
=20
> ability. So if I make a bug fix to master we want that fix to be merged=
=20
> into other branches that we set. If there is a conflict we want that pers=
on=20
>  to be notified by email or some other way. I would like to know if anyon=
e=20
> on the list has a good way to implement this?

Normal way of pushing changes to the central repo is over the ssh protocol,
which invokes git (specifically git-receive-pack) on the server and that in
turn invokes pre-receive, update, post-receive and post-update hooks. The
first two can prevent the refs to be updated, the later two are for arbitra=
ry
post-processing.

To do the automatic merging like you describe, you'd probably put up
a script to run from post-receive and start whatever merges you want to do.

That script gets a list of updated refs along with new and old version names
on standard input, so you just look for your mainline name (refs/heads/mast=
er
probably) and if you find, run the appropriate merges. You can of course
program whatever notifications you want in that script.

Commit would undo any changes pushed between checking out a branch and
commiting, so you should probably do the merges on a separate repository,
that will only be managed by the scripts. You can use the alternates
mechanism to avoid duplicating the data if that repository will be on the
central server.

I'd recommend the hook script to write the things to just write the
instructions what to merge somewhere (into a named pipe, probably -- or
socket, which could be extended to separate server) and process that with
a continually running "daemon" script, to avoid synchronization issues.

In git distribution is a pair of scripts in contrib/continuous directory,
that use the notifying hook + daemon approach to run tests against each
commit, so you can use that for inspiration. It's in perl and being univers=
al
complicates it quite a bit though; you can get a lot shorter with shell and
everything hardcoded.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyeurRel1vVwhjGURAtH0AJ9HCJtvqOYETFLkr6rtu0E5Dv3uEACeI1O/
AiTDvby3FnmmCFg2D1+mo+Y=
=KC5d
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
