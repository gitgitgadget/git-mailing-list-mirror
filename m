From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Mon, 30 Mar 2009 15:58:34 -0700
Message-ID: <20090330225834.GA24254@dcvr.yhbt.net>
References: <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net> <20090329061045.GA29721@dcvr.yhbt.net> <7v8wmoqdc1.fsf@gitster.siamese.dyndns.org> <20090329215651.GA4355@dcvr.yhbt.net> <7v3acvldc7.fsf@gitster.siamese.dyndns.org> <20090330174151.GA32728@dcvr.yhbt.net> <7vy6umdgxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 01:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQTS-0002Hs-Qm
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 01:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736AbZC3W6h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbZC3W6g
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:58:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53885 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbZC3W6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:58:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788EF1F43E;
	Mon, 30 Mar 2009 22:58:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vy6umdgxq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115199>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>=20
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> I think that is an independent bug.  Not just "--" but it appears =
"--d"
> >> seems to hit it (and this is an ancient bug---even v1.0.0 seems to=
 have
> >> it).
> >
> >> I suspect that ls-tree needs a fix, not about "--" but about the p=
athspec
> >> filtering.  It appears that the part that decides if a subtree is =
worth
> >> traversing into uses the correct "is a pathspec pattern match lead=
ing path
> >> components?" semantics (i.e. "--dashed" matches but "--" doesn't),=
 but
> >> after traversing into subtrees, the part that emits the output use=
s a
> >> broken semantics "does the path have any pathspec patter as its pr=
efix?"
> >> It shouldn't check for "prefix", but for "leading path components"=
, in
> >> other words, the match must happen at directory boundaries.
> >>=20
> >> And I do not think *this* bug is too late to fix.  We should fix i=
t.
> >
> > From the ls-tree documentation, I was under the impression that "--=
"
> > matching "--dashed" was intended:
> >
> >   When paths are given, show them (note that this isn't really raw
> >   pathnames, but rather a list of patterns to match).
> >
> > It doesn't make sense to me match like this, either; but I do think=
 it
> > was intended and it will break things if people depend on the
> > existing behavior.
>=20
> Ok, but then the decision to descend into --dashed should be consiste=
nt
> with that policy, no?  Right now, it appears that giving "--" alone s=
ays
> "Anything under --dashed can never match that pattern, so I wouldn't
> bother recursing into it".

Right.  Except in the case when there are multiple files inside --dashe=
d/
as Bj=F6rn's email illustrated.  So there seems to be a bug in the way
the number of files inside --dashed/ affects what "--" does when used
with "--dashed/1" (if --dashed/2 also exists).  Very confusing :x

--=20
Eric Wong
