From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4import.py robustness changes
Date: Tue, 5 Jun 2007 09:21:56 +0200
Message-ID: <200706050922.01431.simon@lst.de>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <20070604055433.GD4507@spearce.org> <99C09A45-EACF-43C0-8EF6-85450B109BF6@slamb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2818005.Tciclf7Eio";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 10:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvUeH-0001Cc-JS
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 10:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbXFEIoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 04:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757143AbXFEIoH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 04:44:07 -0400
Received: from verein.lst.de ([213.95.11.210]:41553 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbXFEIoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 04:44:06 -0400
Received: from office228.trolltech.de (gate.trolltech.fta-berlin.de [141.16.82.122])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l558hvo6001257
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 5 Jun 2007 10:43:58 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <99C09A45-EACF-43C0-8EF6-85450B109BF6@slamb.org>
X-Spam-Score: 0.001 () BAYES_50
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49169>

--nextPart2818005.Tciclf7Eio
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 June 2007 09:19:56 Scott Lamb wrote:
> On Jun 3, 2007, at 10:54 PM, Shawn O. Pearce wrote:
> > I think writing data to fast-import is much easier than running
> > the raw Git commands, especially when you are talking about an
> > import engine where you need to set all of the special environment
> > variables for git-commit-tree or git-tag to do its job properly.
> > Its a good tool that simply doesn't get enough use, partly because
> > nobody is using it...
>
> Yeah, I'm sold. I read git-p4 more thoroughly and tried it out...it's
> pretty nice. The P4Sync command has a simpler, more trustworthy flow
> than git-p4import.py.
>
> On the Perforce side, I particularly like the use of "p4 print" to
> grab the files instead of "p4 sync". It avoids playing weird games
> with the client - I think nothing good can come of git-p4import.py's
> "p4 sync -k" and symlinks to map multiple branches into the same
> directory, which is not the Perforce way. Makes me nervous that
> what's submitted to git won't be the same as what's in the Perforce
> depot.
>
> I would have thought launching a "p4 print" on each file would be
> horribly slow with the network latency of each request, but...well,
> apparently not.

I've found it to be fast enough for "standard software development". When=20
importing big changes like integrations of an entire branch then it natural=
ly=20
slows down. The workaround me and my colleague have come up with is to=20
combine git-p4 usage with the regular git protocol:

=46or imports of simple projects from perforce the direct use of git-p4 clo=
ne=20
and sync/rebase is good enough.

=46or big projects we have set up a dedicated (recycled old) machine that=20
continuously imports from the perforce server. That makes the initial clone=
=20
very fast thanks to the use of the git protocol, it still allows imports fr=
om=20
perforce afterwards and when the developer syncs the chances are very high=
=20
that the dedicated machine already imported the necessary changes/objects=20
from the perforce server and the faster git protocol instead of "p4 print" =
on=20
a lot of files can be used.

In order to avoid that machine constantly polling the p4 server we've come =
up=20
with a neat little trick by adding a change-commit trigger on the p4 server=
=20
that consists of a little perl script that just sends a single udp packet=20
with the latest change number as notification to the git machine, which upo=
n=20
reception imports then.

That is why git-p4 sync/rebase call "git fetch" by default (configurable=20
through config key) if there is an origin remote present.

> Maybe I'll work up git-p4 patches for subcommand error handling, like
> my git-p4import.py ones. And fix some style - seriously, who puts
> semicolons at the end of Python commands? *grumble*

I'd be more than happy to apply style patches. I'm not a very experienced=20
python programmer and I admit that I certainly lack the style there :)

Simon

--nextPart2818005.Tciclf7Eio
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZQ8YWXvMThJCpvIRAvVpAKD8TCKo8DjCO3qrWxuhFIKjhmTZoACg2Qc8
+Hs72gVHFsPOSMuGDt0tZvA=
=hbDl
-----END PGP SIGNATURE-----

--nextPart2818005.Tciclf7Eio--
