From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: obnoxious CLI complaints
Date: Fri, 11 Sep 2009 15:16:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909111510520.3654@localhost.localdomain>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <200909101116.55098.jnareb@gmail.com> <4AA97B61.6030301@lsrfire.ath.cx>
 <alpine.LFD.2.01.0909110744030.3654@localhost.localdomain> <4AAAC8CE.8020302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmER6-0007zJ-BL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 00:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099AbZIKWR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 18:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757095AbZIKWR1
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 18:17:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36322 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757048AbZIKWR0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 18:17:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BMGqcf003925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Sep 2009 15:16:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8BMGqdB005423;
	Fri, 11 Sep 2009 15:16:52 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4AAAC8CE.8020302@lsrfire.ath.cx>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.458 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128227>



On Sat, 12 Sep 2009, Ren=E9 Scharfe wrote:
>=20
> But what has bugged me since I added zip support is this result:
>=20
> 	# git v1.6.5-rc0
> 	$ time git archive --format=3Dzip -6 v2.6.31 >/dev/null
>=20
> 	real	0m16.471s
> 	user	0m16.340s
> 	sys	0m0.128s
>=20
> I'd have expected this to be the slowest case, because it's compressi=
ng
> all files separately, i.e. it needs to create and flush the compressi=
on
> context lots of times instead of only once as in the two cases above.

Oh no, I think it's easily explained.

Compressing many small files really is often cheaper than compressing o=
ne=20
large one.

With lots of small files, you end up being very limited in the=20
search-space, so the compression decisions get simpler. Compression in=20
general is not O(n), it's some non-linear factor, often something like=20
O(n**2).

Of course, all compression libraries have an upper bound on the=20
non-linearity (often expressed as a "window size"), so a particular=20
compression algorithm may end up being close to O(n) (with a huge=20
constant). But that upper bound will only kick in for large files, smal=
l=20
files that fit entirely into the compression window will still see the=20
underlying O(n**2) or whatever.

But I have no actual numbers to back up the above blathering. But feel=20
free to try to compress 10 small files and compare it to compressing on=
e=20
file that is as big as the sum. I bet you'll see it.

			Linus
