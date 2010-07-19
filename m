From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: fixing workdirs
Date: Mon, 19 Jul 2010 11:02:48 +0200
Message-ID: <20100719090248.GA10802@madism.org>
References: <20100708110842.GC12789@madism.org>
 <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
 <20100709075617.GD2304@madism.org>
 <7vy6dkl2d0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 11:02:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OamFW-0008WJ-JX
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 11:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237Ab0GSJCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 05:02:52 -0400
Received: from pan.madism.org ([88.191.52.104]:50394 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760216Ab0GSJCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 05:02:51 -0400
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 115264E0EC;
	Mon, 19 Jul 2010 11:02:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B47421D69FF; Mon, 19 Jul 2010 11:02:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy6dkl2d0.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151247>

On Fri, Jul 09, 2010 at 03:25:15PM -0700, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@madism.org> writes:
>=20
> > On Thu, Jul 08, 2010 at 12:40:11PM -0700, Junio C Hamano wrote:
> >> Pierre Habouzit <madcoder@madism.org> writes:
> >>=20
> >> > for the first one, the fix is simple: workdirs have now a name, =
and
> >> > their HEAD reflog lives in the "master" git repository reflog na=
mespace
> >> > under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog i=
s then a
> >> > symlink to the masters.
> >>=20
> >> I think this is a sane thing to do, except for the "symlink" part =
but that
> >> would be just a minor implementation detail.
> >
> > What would you suggest instead of the symlink then ? (knowing that =
all
> > the workdir is just a full symlink farm at them moment).
>=20
> I can imagine that we may want to have a general mechanism to help an
> object store that belongs to one "primary" repository be aware of ref=
-like
> things that live outside of the repoistory itself, and not just a spe=
cial
> purpose hack suitable only to handle the workdirs.  E.g., we have tal=
ked
> about a "fork" created by "clone -s" wanting the forkee repository to=
 be
> aware of its refs, so that rewinding the refs in the forkee repositor=
y and
> then running gc there won't remove the objects now unnecessary in the
> forkee but still needed by the forker repository.
>=20
> It shouldn't be hard to do something similar to "gitdir: " support fo=
r
> this without using a symlink, no?

Sorry for the delay, I was on vacation.

Okay, I see, this makes sense. I'll see what I can do on this path,
though it's probably harder than simply extending gitfiles. We still
want a .git/ directory as we want most of the top level stuff to be
local to each repository (HEAD, ORIG_HEAD, ...) but not:

  - subdirectories (most of them being references, logs, ...)
  - the lock (which is kind of the weak point in my proposal atm, yours
    is nicer)
  - config (or do we want a cascading semantics: local workdir config,
    master repository config, user .gitconfig, /etc/.... ? I think not
    but ...)
  - packed-refs

Plus, to make everything work, the reflogs of a given "workdir" (or
shared clone) must be put in a different namespace to avoid clashes.
Though this is probably the simplest bit.

All in all, I'm afraid to have to look at every single git script that
for now writes without thinking twice under .git/ :/
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
