From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH] Add support for changing packed_git_window_size at
 process start time
Date: Mon, 22 Dec 2008 00:25:43 -0600
Organization: Slide, Inc.
Message-ID: <1229927143.14882.17.camel@starfruit>
References: <1229895454-19498-1-git-send-email-tyler@slide.com>
	 <1229895454-19498-2-git-send-email-tyler@slide.com>
	 <20081221222848.GE17355@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lHDtPW9p9UhT//72VjBG"
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 07:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEeFy-0003FQ-79
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 07:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYLVGZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 01:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYLVGZw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 01:25:52 -0500
Received: from mx0.slide.com ([208.76.68.7]:39545 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbYLVGZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 01:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=n
	uBxjZmk3Gjcv/itMpEvFfJkDJL2cdz2+Vxg22Wafso=; b=aUgVGUqK/1V+00nPt
	qI5Q+IB7ao41MUVtmCc+1yI2uiU+vfy8EAo1tMDj3S4vzcuiRrQ6xQxgsElqdqkR
	nzeRNF4tzMimsgawddsJUntTOTzGy9TjuvNUqcKnH+59iuvlyUWeHTvikHPjXh0m
	iZzY241mkWLklChLqa9bzd9FBE=
Received: from nat3.slide.com ([208.76.69.126]:53495 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LEeEe-00075u-RM; Sun, 21 Dec 2008 22:25:48 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id CB965389FD1D;
	Sun, 21 Dec 2008 22:25:48 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irwfe-I579NI; Sun, 21 Dec 2008 22:25:48 -0800 (PST)
Received: from [192.168.1.157] (unknown [65.91.197.241])
	by calculon.corp.slide.com (Postfix) with ESMTP id 1C216389FD18;
	Sun, 21 Dec 2008 22:25:47 -0800 (PST)
In-Reply-To: <20081221222848.GE17355@spearce.org>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103746>


--=-lHDtPW9p9UhT//72VjBG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-12-21 at 14:28 -0800, Shawn O. Pearce wrote:
>=20
> I think this is a good idea, trying to fit within the ulimit
> rather than assuming we can take whatever we please.  But you
> also need to drop the packed_git_limit down.
>=20
> My suggestion is this:
>=20
> 	packed_git_limit =3D as->rlim_cur * 0.85;
> 	packed_git_window_size =3D packed_git_limit / 4;
>=20
> or maybe / 2.  You really want at least 2 windows available within
> your limit.

Ah, gotcha, sounds like a good idea. I went ahead and added the change
and I'm still getting the memory issues.=20

I'm not as familiar with using gdb(1), so I'm having trouble tracking
down the issue in a limited session, I get loads of issues like the
following when trying to step through an execution of `git log`


        1368            if (diff_setup_done(&revs->diffopt) < 0)
        (gdb)=20
        utils.c:1065: internal-error: virtual memory exhausted: can't
        allocate 4064 bytes.
        A problem internal to GDB has been detected,
        further debugging may prove unreliable.
        Quit this debugging session? (y or n) n
        utils.c:1065: internal-error: virtual memory exhausted: can't
        allocate 4064 bytes.
        A problem internal to GDB has been detected,
        further debugging may prove unreliable.
        Create a core file of GDB? (y or n) y
        (gdb) q
        The program is running.  Quit anyway (and kill it)? (y or n) y
        tyler@starfruit:~/source/git/main>


Is there a means in which I can cause a core dump on an ENOMEM error passed=
 back from mmap(2)? That or a way to impose these limits on the gdb git-sub=
process but not on the gdb process?

Appreciate the help :)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-lHDtPW9p9UhT//72VjBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklPMucACgkQFCbH3D9R4W8F6ACgpOBMq9WkvxO0nWFmaSHtEqHu
jVkAn0gZzmVZTTC4dSgdrpqCU/rYDUke
=6dIK
-----END PGP SIGNATURE-----

--=-lHDtPW9p9UhT//72VjBG--
