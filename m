From: Andreas Ericsson <ae@op5.se>
Subject: Re: [(not so) random thoughts] using git as its own caching tool
Date: Wed, 12 Dec 2007 16:35:19 +0100
Message-ID: <475FFFB7.4010102@op5.se>
References: <20071212003813.GG29110@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Tcg-0005Pp-MX
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXLLPfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXLLPfX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:35:23 -0500
Received: from mail.op5.se ([193.201.96.20]:38061 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbXLLPfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:35:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6B8121F08016;
	Wed, 12 Dec 2007 16:35:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qegCMoMBPHPu; Wed, 12 Dec 2007 16:35:20 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 45A5A1F08008;
	Wed, 12 Dec 2007 16:35:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071212003813.GG29110@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68053>

Pierre Habouzit wrote:
>   That's an idea I have for quite some time, and I wonder why it's no=
t
> used in git tools as a general rule.
>=20
>   This idea is simple, git objects database has two (for this
> discussion) very interesting features: its delta compressed cached th=
at
> is _very_ efficient, and the reflog.
>=20
>   I wonder if that would be possible to write some git porcelains (an=
d
> builtin API too) that would be more "map" oriented. I mean, we could =
use
> a reference as a pointer to a given tree that would be the map (where
> keys have a path form, which is nice). When I say that, I'm thinking
> about git-svn, that even with the recent improvements of its .rev_db'=
s
> still eats a lot of space with the unhandled.log _and_ the indexes it
> stores for _each_ svn branch/tag. This way, instead of many:
>     foo/index
>     foo/.rev_map.6ef976f9-4de5-0310-a40d-91cae572ec18
>     foo/unhandled.log
> we would just have a special refs/db/git-svn/foo reference that would=
 be
> a tree with three blobs in it: index, rev_map.xxxx, unhandled.log.  (=
or
> probably index would even be a tree but that's another matter). This
> way, all the unhandled.log that share a lot of common content would b=
e
> nicely compressed by the delta-compression algorithms, with a negligi=
ble
> overhead (git-svn is _very_ slow because of svn anyways, we don't rea=
lly
> care if it needs to get a blob contents instead opening a flat file).
>=20
>=20
>   Another nifty usage we could have is memoization databases that don=
't
> require a specific tool to expire them, but use the reflog expiration
> for that. I remember that we discussed quite some time ago, the idea =
of
> annotating objects. We could use such annotations to link some object=
s
> to memoized datas under different namespaces for each caching scheme
> involved, and with one reference per namespace that will have in its
> reflog each of the linked objects created over time for caching. Good
> candidates to use that are the rr-cache, or git-annotate/blame cachin=
g.
> Of course that would need to write a tool that removes weak annotatio=
ns
> that point to objects that don't exist anymore. We could also cache t=
he
> rename/copies/=E2=80=A6 detection results, and make those really real=
ly cheap to
> use[0].
>=20
>=20
>   I know that some will say something about hammers, problems and nai=
ls,
> though it would allow to develop quite efficient tools with a generic
> and easy to use API, that could directly benefit from already existin=
g
> infrastructure in git. I mean it's silly to write yet-another cache
> expirer when you have the reflog. Or to speak about git-svn again, it
> could even version its state per branch the way I propose, it'll end =
up
> using less disk that what it does now, with the immediate gain that i=
t
> would be fully clone-able[1] (which would be a _really_ nice feature)=
=2E
>=20
>=20
>   So am I having crazy thoughts and should I throw my crack-pipe away=
 ?
> Or does parts of this mumbling makes any sense to someone ?
>=20

A bit of both ;-)

I like the idea to use the git object store, because that certainly
has an API that can't be done away with by user config. The reflog
and its expiration mechanism is subject to human control though, and
everyone doesn't even have them enabled. I don't for some repos where
I know I'll create a thousand-and-one loose objects by rebasing,
--amend'ing and otherwise fiddling with history rewrites.

Having a tool that works on some repos but not on others because it
relies on me living with an auto-gc after pretty much every operation
would be very tiresome indeed.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
