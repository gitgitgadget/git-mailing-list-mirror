From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Mon, 14 Mar 2011 23:02:07 +0100
Message-ID: <1300140128.4320.39.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:11:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzFyo-0003Ez-84
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab1CNWLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 18:11:01 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:45980 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab1CNWLA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 18:11:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id AF9381B4B91;
	Mon, 14 Mar 2011 23:02:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9O2E3yXT8Cii; Mon, 14 Mar 2011 23:02:09 +0100 (CET)
Received: from [192.168.1.16] (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id DFF7F1B4B52;
	Mon, 14 Mar 2011 23:02:08 +0100 (CET)
In-Reply-To: <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169029>

On lun, 2011-03-14 at 13:25 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > Sometimes (at least in t-0001-init.sh test 12), the return value of
> > make_absolute_path() is passed to it as an argument, making the fir=
st
>=20
> I don't think it is a bad idea per-se to avoid a copy from the same m=
emory
> location into the same memory location, but independent of the necess=
ity
> of fixes at the low-level, shouldn't we fix the callers that do not c=
heck
> if what they have is already absolute?

 If we'd like the semantics to be "whatever I had, I now know what the
absolute path is" then we could make the check in the beginning of the
function, to centralise the check. If the semantics should be "I don't
have an absolute path, so I need to figure out what it is", then there
should be a check before calling make_absolute_path() (the name suggest=
s
the second).

 As there are only ~15-20 uses of make_absolute_path(), we could just
leave this as it is (as it works under normal conditions and causes
valgrind to warn us), and I'll examine the callers tomorrow.

 There is however the extra functionality the function offers, namely
resolving links. It might be good to split it into two functions so eac=
h
caller can specify what it wants.

 There is also this in setup.c:prefix_path()

        const char *orig =3D path;
        char *sanitized;
        if (is_absolute_path(orig)) {
                const char *temp =3D make_absolute_path(path);
                sanitized =3D xmalloc(len + strlen(temp) + 1);
                strcpy(sanitized, temp);
        } else {
                sanitized =3D xmalloc(len + strlen(path) + 1);
                if (len)
                        memcpy(sanitized, prefix, len);
                strcpy(sanitized + len, path);
        }

which doesn't seem to make sense. Should the call to
make_absolute_path() actually be a call to a function resolve_links()
that just incorporates that functionality from make_absolute_path()?


>=20
> > and second arguments to strlcpy() the same, making the test fail wh=
en
> > run under valgrind.
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> > ---
> >
> > This patch assumes the path returned by make_absolute_path() is nev=
er
> > longer than PATH_MAX, which I think is a safe assumption.
>=20
> >
> >  abspath.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/abspath.c b/abspath.c
> > index 91ca00f..9149a98 100644
> > --- a/abspath.c
> > +++ b/abspath.c
> > @@ -24,7 +24,7 @@ const char *make_absolute_path(const char *path)
> >  	char *last_elem =3D NULL;
> >  	struct stat st;
> > =20
> > -	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> > +	if (buf !=3D path && strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> >  		die ("Too long path: %.*s", 60, path);
> > =20
> >  	while (depth--) {
