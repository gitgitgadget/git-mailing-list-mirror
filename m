From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 11:06:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
 <20090411140756.GA15288@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 20:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lshja-0000Gp-9B
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 20:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712AbZDKSNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 14:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758471AbZDKSNS
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 14:13:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39723 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758661AbZDKSNR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 14:13:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BI6J3E012175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 11:06:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BI6HwY001949;
	Sat, 11 Apr 2009 11:06:17 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090411140756.GA15288@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116306>



On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
>=20
> And for completeness, here are the results for linux-2.6.git
>=20
>      | With my patch | With your patch on top
> -----|---------------|-----------------------
> VSZ  |        460376 | 407900
> RSS  |        292996 | 239760
> time |       0:14.28 | 0:14.66

Ok, it uses less memory, but more CPU time. That's reasonable - we "was=
te"=20
CPU time on doing the extra free's, and since the memory use isn't a hu=
ge=20
constraining factor and cache behavior is bad anyway, it's then actuall=
y=20
slightly slower.

> And again, the new pack is slightly worse than the old one
>  (window=3D250, --depth=3D250).
> Old: 240238406
> New: 240280452
>=20
> But again, it's negligible.

Well, it's sad that it's consistently a bit worse, even if we're talkin=
g=20
just small small fractions of a percent (looks like 0.02% bigger ;).=20

And I think I can see why. The new code actually does a _better_ job of=
=20
the resulting list being in "recency" order, whereas the old code used =
to=20
output the root trees all together. Now they're spread out according to=
=20
how soon they are reached.

The object sorting code _should_ sort them by type, name and size (and=20
thus the pack generation should generate the same deltas), but the name=
=20
hashing is probably weak enough that it doesn't always do a perfect job=
,=20
and then we likely get a slightly worse pack.

But it would be good to really understand that part. It's a _small_=20
downside, but it's a downside.

But it's interesting to note how the bigger gentoo case actually improv=
ed=20
in performance, probably because by then the denser memory use actually=
=20
meant that we had noticeably better cache and TLB behavior. So the patc=
h=20
helps the bad case, at least.

			Linus
