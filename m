From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: URL substitution and config file precedence
Date: Mon, 2 Aug 2010 15:57:48 -0500
Message-ID: <20100802205748.GA2890@burratino>
References: <20100802153720.GA28481@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 22:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og26P-0002Va-N3
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab0HBU7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 16:59:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37310 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0HBU7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:59:11 -0400
Received: by wwj40 with SMTP id 40so4371924wwj.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sgdF/FCARkRUnVm1RdFz1skzXEMLtdRdnq5WvRX2vMw=;
        b=CwlAJKLi/OQD7vwq88MwmdNQDrEYswin3l+zLjuUJbrOXRy5G+fR8zRdOq6jMKEwPf
         MtOCx/jb2JSdSKAZaxv0TxQ1jEym7m8qZOY9lWaMWMM2B+vVV4vGlek5Tw4sWkaujMA7
         iEYjOSsIC29hAgK2+1+ResBijoBv0L9LOu0Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MQ31lxT26+0yArUOsCbGDZ7//NMY0pz66WXKurV0Ydf1vGbjwzH/IsIETPvby4NKdx
         aKJJzt8PA/EjT9ngGl9N7Xsdk5Q2Gj5tuu1Yef5bE7utbG0qPP08vwp8NXShuq1OdcRs
         KomAE7PzRPaK44Va8Rxn1J/z/0aBGi7fnj69k=
Received: by 10.227.146.139 with SMTP id h11mr5379051wbv.197.1280782749555;
        Mon, 02 Aug 2010 13:59:09 -0700 (PDT)
Received: from burratino ([66.99.2.25])
        by mx.google.com with ESMTPS id e31sm5356159wbe.5.2010.08.02.13.59.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:59:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100802153720.GA28481@fishbowl.rw.madduck.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152457>

martin f krafft wrote:

>   % grep madduck: .git/config
>     url =3D madduck:pub/puppet/modules/git
>=20
>   % grep -B1 nsteadOf /etc/gitconfig ~/.gitconfig
>   /etc/gitconfig-[url "git://git.madduck.net/madduck/"]
>   /etc/gitconfig: insteadOf =3D madduck:
>   --
>   /home/madduck/.gitconfig-[url "ssh://git.madduck.net/madduck/"]
>   /home/madduck/.gitconfig:       insteadOf =3D madduck:
>   /home/madduck/.gitconfig:       pushInsteadOf =3D git://git.madduck=
=2Enet/madduck/
>=20
>   % git push -v
>   Pushing to git://git.madduck.net/madduck/pub/puppet/modules/git
>   fatal: The remote end hung up unexpectedly
>=20
> There seem to be two problems:
>=20
>   1. the value from /etc/gitconfig seems to be preferred over the
>      one from ~/.gitconfig. I think this is due to the fact that the
>      syntax for URL substitution is a bit whack and the two keys
>      different, so the merge is actually a union-merge, and then the
>      result is probably just the first match (git:// sorts before
>      ssh://).

Almost.  I do not think there is any sorting involved.

It instead seems to be an unintended consequence of the "first match
wins" rule from v1.5.5-rc0~142^2 (url rewriting: take longest and
first match, 2008-02-24).  If we were starting over, I think it would
make more sense to make the _last_ match win, which would be closer to
how git configuration works in general.

> Why was the syntax chosen backwards in this way? Why not have
>=20
>   [urlsubst "madduck:"]
>       replaceWith =3D ssh://git.madduck.net/madduck/

I wasn=E2=80=99t there, so I can=E2=80=99t complain.
http://thread.gmane.org/gmane.comp.version-control.git/74535/focus=3D74=
594

I think you=E2=80=99re right, that

	[fakeurl "madduck:"]
		url =3D git://git.madduck.net/madduck/
		pushurl =3D ssh://git.madduck.net/madduck/

or similar would be more convenient to work with than

	[url "ssh://git.madduck.net/madduck/"]
		pushinsteadof =3D madduck:
	[url "git://git.madduck.net/madduck/"]
		insteadof =3D madduck:

Jonathan
