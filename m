From: Jeff King <peff@peff.net>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Fri, 11 Nov 2011 13:21:09 -0500
Message-ID: <20111111182109.GB16055@sigill.intra.peff.net>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
 <20111107162642.GA27055@sigill.intra.peff.net>
 <20111111140834.GA10025@beez.lab.cmartin.tk>
 <7vr51er4nd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 19:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROvku-00084S-BV
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 19:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab1KKSVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 13:21:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39672
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab1KKSVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 13:21:11 -0500
Received: (qmail 3495 invoked by uid 107); 11 Nov 2011 18:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 13:21:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 13:21:09 -0500
Content-Disposition: inline
In-Reply-To: <7vr51er4nd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185278>

On Fri, Nov 11, 2011 at 08:43:34AM -0800, Junio C Hamano wrote:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On Mon, Nov 07, 2011 at 11:26:42AM -0500, Jeff King wrote:
> > ...
> >> The patch to do "D"eleted is pretty simple:
> >>=20
> >> diff --git a/read-cache.c b/read-cache.c
> >> index dea7cd8..cc1ebdf 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1103,9 +1103,11 @@ int refresh_index(struct index_state *istat=
e, unsigned int flags, const char **p
> >>  	int in_porcelain =3D (flags & REFRESH_IN_PORCELAIN);
> >>  	unsigned int options =3D really ? CE_MATCH_IGNORE_VALID : 0;
> >>  	const char *needs_update_fmt;
> >> +	const char *needs_rm_fmt;
> >>  	const char *needs_merge_fmt;
> >> =20
> >>  	needs_update_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs upda=
te\n");
> >> +	needs_rm_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n=
");
> >>  	needs_merge_fmt =3D (in_porcelain ? "U\t%s\n" : "%s: needs merge=
\n");
> >
> > While the name fits in with the rest of the variables, it's kind of
> > the wrong way around, isn't it? It doesn't need an 'rm', it /was/
> > rm'd.
>=20
> The variable names were chosen to mean "In a situation where the plum=
bing
> traditionally would have said X, use this format to describe it". Thi=
s is
> the first topic to separate a single situation (from the plumbing's p=
oint
> of view) into two and say different things at Porcelain, and the vari=
able
> naming no longer works.

I agree the naming is awkward (but then, I think the "needs update"
message is awkward ;) ). But my interpretation was: if you want the
index to be in sync with the working tree, you must do this. Hence:

  $EDITOR file             ;# triggers needs_update
  git update-index file    ;# and do update in index
  rm file                  ;# triggers needs rm
  git rm --cached file     ;# and do rm in index

So that was my attempt to follow the same scheme, and I think it does
work. But I agree it's awkward, and since we're not changing the
plumbing message (nor do I think we should; most users won't see it, an=
d
we would only be breaking scripts that do), it's not a big deal just to
change the variable names.

> An obvious solution would be to rename all of them to be based on "wh=
at
> happened to the path". E.g. "modified_fmt" would be set to either "M"=
 or
> "needs update", and "removed_fmt" would be set to either "D" or "need=
s
> update", etc.

I'm happy to make that change. What do you think of the feature overall=
?
And should typechanges also be handled here (it's no extra work for git
to detect them; we just have to pass the TYPE_CHANGED flag back up the
stack)?

-Peff
