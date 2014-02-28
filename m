From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Fri, 28 Feb 2014 13:21:44 +0100
Message-ID: <1393590104.5277.19.camel@centaur.cmartin.tk>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	 <1393491610-19476-2-git-send-email-cmn@elego.de>
	 <xmqqob1sxq8v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:21:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMRv-0006e2-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbaB1MVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 07:21:51 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:44318 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbaB1MVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:21:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id D8D0EDE06A;
	Fri, 28 Feb 2014 13:21:47 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m6engEEEsZzs; Fri, 28 Feb 2014 13:21:47 +0100 (CET)
Received: from [192.168.1.4] (p57A96170.dip0.t-ipconnect.de [87.169.97.112])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id AB532DE068;
	Fri, 28 Feb 2014 13:21:47 +0100 (CET)
In-Reply-To: <xmqqob1sxq8v.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5-2+b2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242947>

On Thu, 2014-02-27 at 12:19 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> >
> > We need to consider that a remote-tracking branch may match more th=
an
> > one rhs of a fetch refspec.
>=20
> Hmph, do we *need* to, really?
>=20
> Do you mean fetching one ref on the remote side and storing that in
> multiple remote-tracking refs on our side?  What benefit does such
> an arrangement give the user?  When we "git fetch $there $that_ref"

No, I mean a different kind of overlap, where the right-hand side
matches more refs than appear on the left side. In this particular case=
,
we would have something like

    refs/heads/*:refs/remotes/origin/*
    refs/pull/*/head:refs/remotes/origin/pr/*

as fetch refspecs. Going remote -> remote-tracking branch is not an
issue, as each remote head only matches one refspec. However, we now
have 'origin/master' and 'origin/pr/5' both of which match the
'refs/remotes/origin/*' pattern. The current behaviour is to stop at th=
e
first match, which would mark it as stale as there is no
'refs/heads/pr/5' branch in the remote.

In lieu of "real" namespacing support for remotes, this seems like a
reasonable way of coalescing the namespaces in the remote repo. I'll
update the commit message with more exact explanation of what kind of
overlap we're dealing with, as it seems it could do with help. Is there
maybe a better word to describe this setup than "overlapping"?

> to obtain that single ref, do we update both remote-tracking refs?
> When the user asks "git log $that_ref@{upstream}", which one of two
> or more remote-tracking refs should we consult?  Should we report
> an error if these remote-tracking refs that are supposed to track
> the same remote ref not all match?  Does "git push $there $that_ref"
> to update that remote ref update all of these remote-tracking refs
> on our side?  Should it?
>=20
> My knee-jerk reaction is that it may not be worth supporting such an
> arrangement as broken (we may even want to diagnose it as an error),
> but assuming we do need to, the approach to solve it, i.e. this...
>=20

=46or this (other) situation, where you duplicate refs, the issue we're
dealing with in these patches wouldn't arise. I have argued similarly
against built-in support in libgit2 for this kind of shenanigans, but
apparently there's people who use it, though their motivations remain a
mystery to me. Luckily we can support *that* quite well by just going
through the refspecs one by one and applying the rules (both in git and
libgit2).

   cmn

> > In such a case, it is not enough to stop at
> > the first match but look at all of the matches in order to determin=
e
> > whether a head is stale.
>=20
> ... sounds sensible.
