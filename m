From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 20:12:10 +0200
Message-ID: <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:12:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gayqp-0002dz-Jr
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992572AbWJTSMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Oct 2006 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992561AbWJTSMI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:12:08 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:54982 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964830AbWJTSME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 14:12:04 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 7E7F14C8C; Fri, 20 Oct 2006 20:12:10 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610201821.34712.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29515>

On Fri, Oct 20, 2006 at 06:21:34PM +0200, Jakub Narebski wrote:
> Aaron Bentley wrote:
>=20
> > =3D=3D=3D added directory =A0// file-id:TREE_ROOT
>=20
> Gaaah, so rename detection in bzr is done using file-ids?
> Linus will tell you the inherent problems with that "solution".

Ok, I tried to read
http://permalink.gmane.org/gmane.comp.version-control.git/217

It's all nice and well, but my question is whether the below cases work
in git. Yes, they are particular cases, but they are particularly
important. If they don't, I'd rather have file-id scheme, that is
limited to just them, but handles them, than something with big plans,
but nothing working.

Let's consider following scenario:

(where A$ means working in branch A, B$ means working in branch B and
 VCT stands for version control tool of choice)

A$ echo Hello Warld! > hello.txt
A$ VCT add hello.txt
A$ VCT commit -m "Created greeting"
$ VCT branch A B
A$ VCT mkdir data
A$ VCT mv hello.txt data/
A$ VCT commit -m "Moved hello.txt to data dir"
B$ ed hello.txt
? 1s/Warld/World/
? wq
B$ VCT commit -m "Fixed typo in greeting"
A$ VCT merge B

At this point, I expect the tree to look like this:
A$ ls -R
=2E:
data/
data:
hello.txt
A$ cat data/hello.txt
Hello World!

The file-id algorithm is not exceptionaly clever, is a bit of
special-case and all that, but it handles the above case right. And
while that scenario is just a special case of general moving contents,
it is:
1) Very common
2) Possible to handle in an obviously correct way

It is very important for me that a version control tool I use handles
this case. If it handles the more general cases, that's nice, but this
is a must.

Oh, and there is one more complicated case, that I also require to work
and that works in Bzr, but did not work in Arch:

=2E..let's start with the tree at the end of previous example...

A$ VCT mv data greetings
A$ VCT commit -m "Renamed the data directory to greetings"
B$ echo "Goodbye World!" > data/goodbye.txt
B$ VCT add data/goodbye.txt
B$ VCT commit -m "Added goodbye message."
A$ VCT merge B

And now I expect to have tree looking like this:

A$ ls -R
=2E:
greetings/
greetings:
hello.txt
goodbye.txt

And note, that it is /not/ required to use file-ids to handle this.
Darcs handles this just as well with it's patch algebra
(http://darcs.net/DarcsWiki/PatchTheory) without need of any IDs.

-----------------------------------------------------------------------=
---------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
