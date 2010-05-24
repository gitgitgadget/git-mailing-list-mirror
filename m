From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Mon, 24 May 2010 19:08:08 +0200
Message-ID: <1274720888.4838.13.camel@localhost>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
	 <4BF2BABC.2010405@drmicha.warpmail.net>
	 <1274202486.4228.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 19:08:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGb8V-000714-9T
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 19:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943Ab0EXRIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 May 2010 13:08:14 -0400
Received: from smtp27.orange.fr ([80.12.242.94]:43612 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757394Ab0EXRIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 13:08:13 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2701.orange.fr (SMTP Server) with ESMTP id 5BF631C002EE
	for <git@vger.kernel.org>; Mon, 24 May 2010 19:08:10 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2701.orange.fr (SMTP Server) with ESMTP id 4E8831C00518
	for <git@vger.kernel.org>; Mon, 24 May 2010 19:08:10 +0200 (CEST)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2701.orange.fr (SMTP Server) with ESMTP id 35B5B1C002EE
	for <git@vger.kernel.org>; Mon, 24 May 2010 19:08:10 +0200 (CEST)
X-ME-UUID: 20100524170810220.35B5B1C002EE@mwinf2701.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id 6C152506; Mon, 24 May 2010 19:08:09 +0200 (CEST)
In-Reply-To: <1274202486.4228.22.camel@localhost>
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147637>

Le mardi 18 mai 2010 =C3=A0 19:08 +0200, Yann Droneaud a =C3=A9crit :
> Le mardi 18 mai 2010 =C3=A0 18:05 +0200, Michael J Gruber a =C3=A9cri=
t :
> > Yann Droneaud venit, vidit, dixit 18.05.2010 16:41:
> > > Since I don't have en_US.utf8, some tests failed:
>=20
> > >=20
> > > On my system locale -a reports:
> > >=20
> > >    en_US
> > >    en_US.ISO-8859-1
> > >    en_US.UTF-8
> > >=20
> >=20
> > locale -a|grep en_US
> > en_US
> > en_US.iso88591
> > en_US.iso885915
> > en_US.utf8
> >=20
> > This is on Fedora 13, which is not exactly exotic. What is your sys=
tem?
> >=20
>=20

I've checked carefully multiple system and configuration, and found why
we have some little locale problem here.

Since glibc 2.3, a file can hold all locales in file "locale-archive"
instead of having a tons of directory. To store all the locales in this
file, it uses an index based on a "normalized" codeset, e.g. it convert=
s
codeset to lowercase, removes dash and minus.=20
So when one ask for the locale list, locale first go through the
"locale-archive" content and report normalized codeset (utf8)  instead
of canonical codeset (UTF-8), then it proceed with the legacy locales
directories, using for them the canonical codeset.

Until recently, Mandriva Linux doesn't make use of "locale-archive", so
UTF-8 locales were reported. Version in development uses
"locale-archive" + legacy locale directories, hence the mix I've
reported. Other Linux distributions like Fedora and Ubuntu uses only
"locale-archive" and so, have only "normalized" codeset.
POSIX doesn't specify the output of locale -a, so it's not really a bug
to show "normalized" codeset name.

But all others "POSIX" system I've found report "canonical" codeset,
e.g. UTF-8 (all but latest cygwin).=20

Here's the bug report:
http://sourceware.org/bugzilla/show_bug.cgi?id=3D11629

BTW, I will shortly provided a fix for the testcase, which will handle
all cases.

Regards.

--=20
Yann Droneaud
