From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 23:20:03 +0200
Message-ID: <201007082320.05017.jnareb@gmail.com>
References: <20100701121711.GF1333@thunk.org> <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com> <alpine.LFD.2.00.1007081559300.6020@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, Theodore Tso <tytso@mit.edu>,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 23:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWyW6-0007w2-2Z
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 23:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab0GHVUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 17:20:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56726 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab0GHVUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 17:20:13 -0400
Received: by bwz1 with SMTP id 1so688947bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2La99XkY7JOPEa6+14yfqlmuY9bIfQZw3BZO/65A4Qo=;
        b=ld5JTJ2d/kQ8RH8LU1zir56HyiHf3jLyGBnAF6N+6bwBNmNbdjGjBrmCiqQbmGYIUZ
         l74wPPoIz6UxumvTzfHwYVfBRX6W+AnRdpLoxqbtKyCYsqMDjXA7qzrAXnHHm0QhJYKu
         33+K9YiYqHsJfTZEDO4vViWU9AQQsHlVsUyQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CE8Pmy0fWgDd4bhfNRuyk+Hxu6jreztq4ppK133+2KUarGRegigMj5LWPJx0vVP32K
         qYXk1yPWKKBCE7euUlVVDdad+gr9Lxq02Mc93B7i8axKpaxnEpMLbB+9+JGf1PbEYUWS
         zy7LTZNte+wbptuZ1vCY3gae4xEy7UYNdyCAg=
Received: by 10.204.60.8 with SMTP id n8mr932442bkh.155.1278624011286;
        Thu, 08 Jul 2010 14:20:11 -0700 (PDT)
Received: from [192.168.1.15] (abwl18.neoplus.adsl.tpnet.pl [83.8.235.18])
        by mx.google.com with ESMTPS id bq20sm485685bkb.4.2010.07.08.14.20.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 14:20:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.1007081559300.6020@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150613>

Dnia czwartek 8. lipca 2010 22:13, Nicolas Pitre napisa=B3:
> On Thu, 8 Jul 2010, Avery Pennarun wrote:
> > On Thu, Jul 8, 2010 at 3:29 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:

> > > I might be looking at this from my own perspective as one of the =
few
> > > people who hacked extensively on the Git pack format from the ver=
y
> > > beginning. =A0But I do see a way for the pack format to encode co=
mmit and
> > > tree objects so that walking them would be a simple lookup in the=
 pack
> > > index file where both the SHA1 and offset in the pack for each pa=
rent
> > > can be immediately retrieved. =A0Same for tree references. =A0No =
deflating
> > > required, no binary search, just simple dereferences. =A0And the =
pack size
> > > would even shrink as a side effect.
> >=20
> > One trick that bup uses is an additional file that sits alongside t=
he
> > pack and acts as an index.  In bup's case, this is to work around
> > deficiencies in the .idx file format when using ridiculously huge
> > numbers of objects (hundreds of millions) across a large number of
> > packfiles.  But the same concept could apply here: instead of doing
> > something like rev-cache, you could just construct the "efficient"
> > part of the packv4 format (which I gather is entirely related to
> > commit messages), and store it alongside each pack.
>=20
> No.  I want the essential information in an efficient encoding _insid=
e_=20
> the pack, actually replacing the existing encoding.  One of the goal =
is=20
> also to reduce repository size, not to grow it.

That's a good idea.
=20
> > This would allow people to incrementally modify git to use the new,
> > efficient commit object storage, without breaking backward
> > compatibility with earlier versions of git.  (Just as bup can index
> > huge numbers of packed objects but still stores them in the plain g=
it
> > pack format.)
>=20
> Initially, what I'm aiming for is for pack-objects to produce the new=
=20
> format, for index-pack to grok it, and for sha1_file:unpack_entry() t=
o=20
> simply regenerate the canonical object format whenever a pack v4 obje=
ct=20
> is encountered.  Also pack-objects would be able to revert the object=
=20
> encoding to the current format on the fly when it is serving a fetch=20
> request to a client which is not pack v4 aware, just like we do now w=
ith=20
> the ofs-delta capability.
>=20
> Once that stage is reached, I'll submit the lot and hope that other=20
> people will help incrementally converting part of Git to benefit from=
=20
> native access to the pack v4 data.  The tree object walk code would b=
e=20
> the first obvious candidate.  And so on.

If I remember correctly with pack v4 some operations like getting size
of tree object needs encoding to current format, so they are slower tha=
n
they should be (and perhaps a bit slower than current implementation).
But that should be I think rare (well, unless one streams to=20
'git cat-file --batch / --batch-check').

Would pack v4 need index v4?

By the way, rev-cache project was started mainly to make "counting
objects" part of clone / fetch faster.  Would pack v4 offer the same
without rev-cache?

--=20
Jakub Narebski
Poland
