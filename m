From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [msysGit] [PATCH] Prevent buffer overflows when path is too big
Date: Sun, 20 Oct 2013 08:05:17 +0200
Message-ID: <20131020060517.GA8436@domone.podge>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com>
 <52636E5A.1080909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 20 08:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXm8n-0001SR-8m
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 08:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab3JTGFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Oct 2013 02:05:25 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:53091 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3JTGFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Oct 2013 02:05:25 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 7E7544756C;
	Sun, 20 Oct 2013 08:05:20 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 3BB7B5F96A; Sun, 20 Oct 2013 08:05:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52636E5A.1080909@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236414>

On Sun, Oct 20, 2013 at 07:47:06AM +0200, Torsten B=F6gershausen wrote:
> (may be s/path is too big/path is too long/ ?)
>=20
> On 19.10.13 12:52, Antoine Pelisse wrote:
> > Currently, most buffers created with PATH_MAX length, are not check=
ed
> > when being written, and can overflow if PATH_MAX is not big enough =
to
> > hold the path.
> >=20
> > Fix that by using strlcpy() where strcpy() was used, and also run s=
ome
> > extra checks when copy is done with memcpy().
> >=20
> > Reported-by: Wataru Noguchi <wnoguchi.0727@gmail.com>
> > Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> > ---
> > diff --git a/abspath.c b/abspath.c
> > index 64adbe2..0e60ba4 100644
> > --- a/abspath.c
> > +++ b/abspath.c
> > @@ -216,11 +216,15 @@ const char *absolute_path(const char *path)
> >  const char *prefix_filename(const char *pfx, int pfx_len, const ch=
ar *arg)
> >  {
> >  	static char path[PATH_MAX];

Why do you need static there?
> > +
> > +	if (pfx_len > PATH_MAX)
> I think this should be=20
> if (pfx_len > PATH_MAX-1) /* Keep 1 char for '\0'
> > +		die("Too long prefix path: %s", pfx);
> > +
> >  #ifndef GIT_WINDOWS_NATIVE
> >  	if (!pfx_len || is_absolute_path(arg))
> >  		return arg;
> >  	memcpy(path, pfx, pfx_len);
> > -	strcpy(path + pfx_len, arg);
> > +	strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len);
>=20
> I'm not sure how to handle overlong path in general, there are severa=
l ways:
> a) Silently overwrite memory (with help of memcpy() and/or strcpy()
> b) Silently shorten the path using strlcpy() instead of strcpy()
> c) Avoid the overwriting and call die().
> d) Prepare a longer buffer using xmalloc()
>=20
There is also
e) modify allocation to place write protected page after buffer end.
