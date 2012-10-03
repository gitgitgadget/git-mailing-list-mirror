From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 19:21:15 -0400
Message-ID: <20121003232115.GB11618@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <CACBZZX4Fb0OCkh5kwKvLC+_0xb7q-UB7LH2_WY=dFN5SYUeezQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:03:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtLq-0001DP-KK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723Ab2JCXVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 19:21:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39575 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583Ab2JCXVR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 19:21:17 -0400
Received: (qmail 14104 invoked by uid 107); 3 Oct 2012 23:21:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 19:21:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 19:21:15 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4Fb0OCkh5kwKvLC+_0xb7q-UB7LH2_WY=dFN5SYUeezQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206956>

On Thu, Oct 04, 2012 at 12:32:35AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Wed, Oct 3, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
> > What version of git are you using?  In the past year or so, I've ma=
de
> > several tweaks to speed up large numbers of refs, including:
> >
> >   - cff38a5 (receive-pack: eliminate duplicate .have refs, v1.7.6);=
 note
> >     that this only helps if they are being pulled in by an alternat=
es
> >     repo. And even then, it only helps if they are mostly duplicate=
s;
> >     distinct ones are still O(n^2).
> >
> >   - 7db8d53 (fetch-pack: avoid quadratic behavior in remove_duplica=
tes)
> >     a0de288 (fetch-pack: avoid quadratic loop in filter_refs)
> >     Both in v1.7.11. I think there is still a potential quadratic l=
oop
> >     in mark_complete()
> >
> >   - 90108a2 (upload-pack: avoid parsing tag destinations)
> >     926f1dd (upload-pack: avoid parsing objects during ref advertis=
ement)
> >     Both in v1.7.10. Note that tag objects are more expensive to
> >     advertise than commits, because we have to load and peel them.
> >
> > Even with those patches, though, I found that it was something like=
 ~2s
> > to advertise 100,000 refs.
>=20
> FWIW I bisected between 1.7.9 and 1.7.10 and found that the point at
> which it went from 1.5/s to 2.5/s upload-pack runs on the pathologica=
l
> git.git repository was none of those, but:
>=20
>     ccdc6037fe - parse_object: try internal cache before reading obje=
ct db

Ah, yeah, I forgot about that one. That implies that you have a lot of
refs pointing to the same objects (since the benefit of that commit is
to avoid reading from disk when we have already seen it).

Out of curiosity, what does your repo contain? I saw a lot of speedup
with that commit because my repos are big object stores, where we have
the same duplicated tag refs for every fork of the repo.

-Peff
