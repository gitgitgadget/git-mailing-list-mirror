From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Slow "git rev-list origin/master --not --all" or "git fetch"
 slow when downloading nothing
Date: Wed, 5 Nov 2008 14:08:06 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811051344050.3419@nehalem.linux-foundation.org>
References: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>  <alpine.LFD.2.00.0811050935270.3419@nehalem.linux-foundation.org> <adf1fd3d0811051337i5fd501e1hdd3a6452930581a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:10:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxqa7-0000Xx-N9
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYKEWJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 17:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbYKEWJE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:09:04 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54418 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753674AbYKEWJB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 17:09:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA5M87oO014962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Nov 2008 14:08:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA5M86Wk018157;
	Wed, 5 Nov 2008 14:08:07 -0800
In-Reply-To: <adf1fd3d0811051337i5fd501e1hdd3a6452930581a@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100189>



On Wed, 5 Nov 2008, Santi B=E9jar wrote:
> >
> > Hmm. It sounds like you possibly don't have packed refs.
>=20
> They are packed up to v2.6.27.

Yeah, your strace isn't at all horrible. You don't open very many files=
 at=20
all, and you don't have any big directories.

The biggest cost when things are cold-cache is probably the seeking fro=
m=20
just opening all those index files.=20

> It is an old computer (Pentium 4 2.5 GHz) and the repo is on an exter=
nal=20
> USB drive.

There should be basically no CPU spent on that load, so your computer i=
s=20
fine. But I think the issue is the dog-slow IO on the USB drive,=20
especially since there are multiple pack-files and thus index files.

Your strace would be more interesting with "-Ttt", but much of the cost=
 is=20
likely in the page faulting of the mmap'ed data, and none of that would=
=20
show up in the trace, except indirectly (ie just looking at the times=20
between the system calls).

> Yes, in the general case it is, but in this case we can bypass the
> checking of the --all refs after checking if all the given refs are
> equal to some of the --all refs.

I don't think we'll actually walk anything, because all commits will en=
d=20
up being negative.

But we'll look up the objects for even the negative commits, yes. So we=
're=20
doing several "unnecessary" object lookups, and in that sense we could=20
make this much faster by not even bothering to look them up.

But we do that to validate that the refs are _valid_, so in that sense =
the=20
object lookup is not "unnecessary" at all. Oh, and we need to peel them=
 to=20
see if they are tag objects, in order to mark the _commit_ uninterestin=
g=20
if the object itself was uninteresting.

So in practice we do end up having to pretty much parse them all.=20

We could do some crazy special case for the empty set, but it would be=20
better to see if you can improve performance with a slow disk some othe=
r,=20
less hacky, way. If you use a USB stick to move between machines, maybe=
=20
you can make sure that it's fully packed (ie a single index file) befor=
e=20
moving it to the USB stick? That would likely help quite a bit.

		Linus
