From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Sat, 25 Feb 2012 23:45:33 +0100
Message-ID: <20120225224533.GJ9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
 <20120224161613.GH9526@pomac.netswarm.net>
 <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 23:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1QNb-0005tA-L8
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 23:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab2BYWpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 17:45:40 -0500
Received: from mail.vapor.com ([83.220.149.2]:40859 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab2BYWpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 17:45:40 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id D30772B6005;
	Sat, 25 Feb 2012 23:45:33 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 4818E8E6B54; Sat, 25 Feb 2012 23:45:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8C-8dvXpNTU=JpdupSpS8OuqqTpGvDs6s1ASeKdk9d5Dg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191548>

On Sat, Feb 25, 2012 at 08:49:55AM +0700, Nguyen Thai Ngoc Duy wrote:
> 2012/2/24 Ian Kumlien <pomac@vapor.com>:
> > Writing objects: 100% (1425/1425), 56.06 MiB | 4.62 MiB/s, done.
> > Total 1425 (delta 790), reused 1425 (delta 790)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > fatal: Out of memory, malloc failed (tried to allocate 3310214315 b=
ytes)
> > To ../test_data/
> > =A0! [remote rejected] master -> master (missing necessary objects)
> > =A0! [remote rejected] origin/HEAD -> origin/HEAD (missing necessar=
y objects)
> > =A0! [remote rejected] origin/master -> origin/master (missing nece=
ssary objects)
> > error: failed to push some refs to '../test_data/'
> >
> > So there are additional code paths to look at... =3D(
>=20
> I can't say where that came from. Does this help? (Space damaged, may
> need manual application)

> If not, you might need to apply this to generate coredump, then look
> and see where that failed malloc comes from

Actually, i added a backtrace and used addr2line to confirm my
suspicion... which is:
builtin/index-pack.c:414

ie get_data_from_pack...=20

It looks to me like, if we are to support this kind of things, we need =
a
slightly different approach - instead of passing the data around, it
feels like passing a function pointer around would be beneficial.

Looking at the code i see alot of places where this would be a issue,
just the fact that get_data_from_pack is used in several functions that
might do some small operation and then just free it.

I understand and recognize that my "problem" is not what git was
designed for; it was designed for small files, which is very evident in
how it approaches the data... And I'd most definetly have to look alot
closer to this code... =3D)

> --=20
> Duy
