From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] hg-to-git: do not include the branch name as the first
	line of commit msg
Date: Thu, 06 Dec 2007 14:50:43 +0100
Message-ID: <1196949043.5388.18.camel@galileo>
References: <4751A036.1080209@gmail.com>
	 <7vsl2jcl32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Drago <markdrago@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0HPs-0007RD-5v
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbXLFOJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2007 09:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXLFOJF
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:09:05 -0500
Received: from sd-11162.dedibox.fr ([88.191.70.230]:49490 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbXLFOJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:09:04 -0500
X-Greylist: delayed 1099 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2007 09:09:04 EST
Received: from sd-11162.dedibox.fr (localhost.localdomain [127.0.0.1])
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 6E0EF92DDD;
	Thu,  6 Dec 2007 14:50:45 +0100 (CET)
Received: from [192.168.6.8] (voyager.popies.net [62.147.231.2])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sd-11162.dedibox.fr (Postfix) with ESMTP id 089FE92DDC;
	Thu,  6 Dec 2007 14:50:44 +0100 (CET)
In-Reply-To: <7vsl2jcl32.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 
X-AV-Checked: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67286>


Le lundi 03 d=C3=A9cembre 2007 =C3=A0 17:20 -0800, Junio C Hamano a =C3=
=A9crit :

> >      (fdcomment, filecomment) =3D tempfile.mkstemp()
> > -    csetcomment =3D os.popen('hg log -r %d -v | grep -v ^changeset=
: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files:=
 | grep -v ^description: | grep -v ^tag:' % cset).read().strip()
> > +    csetcomment =3D os.popen('hg log -r %d -v | grep -v ^changeset=
: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files:=
 | grep -v ^description: | grep -v ^tag: | grep -v ^branch:' % cset).re=
ad().strip()
> >      os.write(fdcomment, csetcomment)
> >      os.close(fdcomment)
>=20
> Isn't this one of the ugliest lines in the whole git.git project, I h=
ave
> to wonder?

It probably is, and I take full resposibility for the original
version :). Incremental development woes.

> I also wonder missing colon after "date" is a bug from the original
> version, and assuming that it is,=20

It is indeed a bug.

> how about doing something less error
> prone like this?
>=20
>         def included(line):
>             keywords =3D ('changeset', 'parent', 'user', 'date', 'fil=
es',
>                         'description', 'tag', 'branch')
>             for kw in keywords:
>                 if line.startswith(kw + ':'):
>                     return 0
>             return 1
>=20
>         hglog =3D os.popen('hg log -r %d -v' % cset).read();
>         csetcomment =3D '\n'.join(filter(included, hglog.split('\n'))=
).strip()

Seems great to me.

> If you are excluding _all_ of the <word>: header lines, the "included=
"
> function may have to become cleverer but much simpler by doing someth=
ing
> like:
>=20
> 	import re
> 	header_re =3D re.compile(r'^\w+:')
> 	def included(line):
>         	return not header_re.match(line)

I'm afraid something like this will be much more prone to false
positives.=20

Maybe an even better alternative, given the way mercurial outputs the
changeset information, is to search for the '^description:' tag and tak=
e
all the text that follows.

--=20
Stelian Pop <stelian@popies.net>
