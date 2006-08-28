From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] full featured formating function of the --{base,user}_path arguments,
Date: Mon, 28 Aug 2006 08:37:42 +0200
Organization: Polytechnique.org
Message-ID: <200608280837.47870.madcoder@debian.org>
References: <11566787581030-git-send-email-madcoder@debian.org> <7vd5altob5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12883611.JUkj17y8vV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 08:38:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHal4-0006fB-3A
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 08:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWH1Ghw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 02:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWH1Ghw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 02:37:52 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39833 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S932398AbWH1Ghv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 02:37:51 -0400
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id C33BE332E1;
	Mon, 28 Aug 2006 08:37:49 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd5altob5.fsf@assigned-by-dhcp.cox.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Mon Aug 28 08:37:50 2006 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.000000, queueID=EB58A33301
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26145>

--nextPart12883611.JUkj17y8vV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le lun 28 ao=FBt 2006 07:35, Junio C Hamano a =E9crit :
> Pierre Habouzit <madcoder@debian.org> writes:
> > +static struct {
> > +	const char *path;
> > +	int use_as_fmt;
> > +} base_path;
> >
> >  /* If defined, ~user notation is allowed and the string is
> > inserted * after ~user/.  E.g. a request to git://host/~alice/frotz
> > would * go to /home/alice/pub_git/frotz with --user-path=3Dpub_git.
> > */
> > -static const char *user_path;
> > +static struct {
> > +	const char *path;
> > +	int use_as_fmt;
> > +} user_path;
>
> Maybe it does not matter much, but I wonder if we want to keep
> two structs the same type, like:
>
>         static struct {
>                 const char *path;
>                 int use_as_fmt;
>         } base_path, user_path;
>
> I also wondered if we can just extend the semantics of base_path
> and user_path to autodetect the fmt-ness of them, but that means
> we would break existing setups that uses per-cent in the
> pathname.  Arguably that would not be so common and we may not
> need to worry about such an installation, though.  What do you
> think?

I think that merging the structs is indeed good, but that I do not like=20
to break (even non common) setups when avoidable. but well, I've no=20
*very* strong opinion on this, and if the consensus is that extending=20
the argument with a format is good enough, I'll go for it, it would=20
simplify the code a bit, and remove two arguments, both are good.

>
> > @@ -174,24 +285,45 @@ static char *path_ok(char *dir)
> >  				slash =3D dir + restlen;
> >  			namlen =3D slash - dir;
> >  			restlen -=3D namlen;
> > +
> > +			if (user_path.use_as_fmt) {
> > +				loginfo("host <%s>, "
> > +					"userpathfmt <%s>, request <%s>, "
> > +					"namlen %d, restlen %d, slash <%s>",
> > +					vhost,
> > +					user_path.path, dir,
> > +					namlen, restlen, slash);
> > +				dir =3D git_path_fmt(rpath, user_path.path, vhost,
> > +						   slash, dir + 1, namlen - 1);
>
> When vhost is NULL you would feed it to "%s", which I think
> glibc works around with (null) fine but other C libraries would
> not like it.  git_path_fmt()'s logging does not have this
> problem, though.

uuhhh, I've always thought that passing NULL to a %s format was allowed=20
by the C standard ... I've no copy here but one at work, I will verify=20
it (for my peace of mind) but I agree it's not pretty.

> > +	else if (base_path.path) {
> >  		if (*dir !=3D '/') {
> >  			/* Allow only absolute */
> >  			logerror("'%s': Non-absolute path denied (base-path active)",
> > dir); return NULL;
> >  		}
> > +
> > +		if (base_path.use_as_fmt) {
> > +			dir =3D git_base_path_fmt(rpath, base_path.path, vhost, dir);
> > +		} else {
> > +			snprintf(rpath, PATH_MAX, "%s%s", base_path.path, dir);
>
> The level of logging in this branch and in user_path.use_as_fmt
> branch are inconsistent.  Maybe the more detailed one above I
> commented about vhost=3D=3DNULL case was primarily meant for
> debugging and you forgot to remove it?

well, it was here before, so I left it, but I do not liked it much=20
either, so if it's ok to remove it, I'd be glad to.

> > @@ -274,6 +406,7 @@ static int execute(struct sockaddr *addr
> > @@ -303,15 +436,30 @@ #endif
> >  	alarm(0);
> >
> >  	len =3D strlen(line);
> > +
> > +	if (pktlen !=3D len) {
> > +		int arg_pos =3D len + 1;
> > +
> >  		loginfo("Extended attributes (%d bytes) exist <%.*s>",
> >  			(int) pktlen - len,
> > +			(int) pktlen - len, line + arg_pos);
> > +
> > +		while (arg_pos < pktlen) {
> > +			int arg_len =3D strlen(line + arg_pos);
> > +
> > +			if (!strncmp("host=3D", line + arg_pos, 5)) {
> > +				vhost =3D line + arg_pos + 5;
> > +			}
> > +
> > +			arg_pos +=3D arg_len + 1;
> > +		}
> > +	}
> > +
>
> I think it is easier to do:
>
> 	if (!vhost)
>         	vhost =3D default_host;
>
> and have git_base_path_fmt() barf if the format calls for %h and
> vhost passed to it is NULL.  Lack of "host=3D" in the request is
> logged here already.

hmmm, lack of host=3D is only logged in the git_path_fmt function atm. Its=
=20
presence is logged though. But I could obviously log that it's missing=20
while parsing the extending attributes, and then only need to barf when=20
the %h is actually needed in the format string. That seems indeed=20
easier. Will do.

=2D-=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--nextPart12883611.JUkj17y8vV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8o87vGr7W6HudhwRAhNFAKCBeJySrMxToFULie9RS9e5XHJIIwCfSDNQ
cdlVuMl3AXrnrUb+CQM3rfA=
=Wm0S
-----END PGP SIGNATURE-----

--nextPart12883611.JUkj17y8vV--
