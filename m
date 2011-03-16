From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2-3/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 19:17:44 +0100
Message-ID: <1300299469.3995.10.camel@centaur>
References: <1300294266-26875-1-git-send-email-cmn@elego.de>
	 <4D80EC57.4050704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:18:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzvII-0002b5-GN
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 19:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1CPSR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 14:17:58 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:59926 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab1CPSR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 14:17:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 8C3111B4B09;
	Wed, 16 Mar 2011 19:17:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiteHm9V+B20; Wed, 16 Mar 2011 19:17:49 +0100 (CET)
Received: from [192.168.1.21] (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 516D11B4B08;
	Wed, 16 Mar 2011 19:17:49 +0100 (CET)
In-Reply-To: <4D80EC57.4050704@drmicha.warpmail.net>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169179>

On Wed, 2011-03-16 at 17:59 +0100, Michael J Gruber wrote:
> Carlos Mart=C3=ADn Nieto venit, vidit, dixit 16.03.2011 17:51:
>>[...]
> > -const char *make_nonrelative_path(const char *path)
> > +/*
> > + * Use this to get an absolute path from a relative one. If you wa=
nt
> > + * to resolve links, you should use real_path.
> > + *
> > + * If the path is already absolute, then return path. As the user =
is
> > + * never meant to free the return value, we're safe.
> > + */
> > +const char *absolute_path(const char *path)
> >  {
> >  	static char buf[PATH_MAX + 1];
> > =20
> >  	if (is_absolute_path(path)) {
> > -		if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> > +		if (strlen(path) >=3D PATH_MAX)
> >  			die("Too long path: %.*s", 60, path);
> > +		else
> > +			return path;
> >  	} else {
> >  		size_t len;
> >  		const char *fmt;
>=20
> This is not simply a renaming change that you're sneaking in here. Wh=
at
> is it about?

 Gah, I've been staring at this patch too long. This is related another
thread where Junio said it'd be a good idea to change the semantics so
we centralise checking wether we already have an absolute path. See
http://thread.gmane.org/gmane.comp.version-control.git/169012/focus=3D1=
69063 (Message-ID: <7vpqptb976.fsf@alter.siamese.dyndns.org>).

>>[...]
> > diff --git a/dir.c b/dir.c
> > index 570b651..5a9372a 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1023,8 +1023,8 @@ char *get_relative_cwd(char *buffer, int size=
, const char *dir)
> >  	if (!getcwd(buffer, size))
> >  		die_errno("can't find the current directory");
> > =20
> > -	if (!is_absolute_path(dir))
> > -		dir =3D make_absolute_path(dir);
> > +	/* getcwd resolves links and gives us the real path */
> > +	dir =3D real_path(dir);
>=20
> Why remove the check? Again, this is not just renaming.

 Semantics change. Same as above. The one below (snipped) is the same.

>>[...]
> I think you should strictly separate the renaming issue from other
> patches (and describe/motivate the latter). It's fine to have a large
> patch with mechanical changes (renaming) if you stick to just those.

 Unfortunately I introduced some modifications trying to reduce the
number of times we call make_absolute_path/real_path and they snuck in.
Sorry.

   cmn
