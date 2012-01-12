From: Jeff King <peff@peff.net>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 12:15:36 -0500
Message-ID: <20120112171536.GA18102@sigill.intra.peff.net>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOFb-0007la-SX
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab2ALRPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:15:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36125
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493Ab2ALRPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 12:15:38 -0500
Received: (qmail 360 invoked by uid 107); 12 Jan 2012 17:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 12:22:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 12:15:36 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188457>

On Thu, Jan 12, 2012 at 10:39:48PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> >                  I agree it would be nice to make:
> > =C2=A0git cherry-pick commit1 commit3 commit2
> >
> > work in the order specified, but how does that interact with existi=
ng
> > cases that provide more traditional revision arguments?
>=20
> What are your thoughts on making it a flag in the revision API to be
> activated with "cherry-pick --literal-order commit1 commit3 commit2"
> or similar?  I'm not sure how to get it to reconcile with the more
> traditional revision arguments yet. My current worktree (WIP):

I think that is a sensible first-cut. It may even be possible to use
heuristics to identify when --literal-order is needed, and eventually i=
t
could go away. But that is a much riskier feature that can be built on
top of the much safer proposal you are making.

> diff --git a/revision.c b/revision.c
> index 064e351..301ef58 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2054,7 +2054,10 @@ int prepare_revision_walk(struct rev_info *rev=
s)
>                 if (commit) {
>                         if (!(commit->object.flags & SEEN)) {
>                                 commit->object.flags |=3D SEEN;
> -                               commit_list_insert_by_date(commit,
> &revs->commits
> +                               if (revs->literal_order)
> +                                       commit_list_insert(commit,
> &revs->commits
> +                               else
> +
> commit_list_insert_by_date(commit, &revs-

My only concern is that there are other parts of the revision machinery
that depend on the date-ordering of the commit list. What would happen,
for example, with:

  git rev-list --literal-order --do-walk foo

It probably doesn't make sense to allow literal-order without no-walk,
anyway (which of course is the default in cherry-pick anyway, so it's
not a big deal here).

I'm also not sure what:

  git rev-list --literal-order foo..bar

would or should do.

-Peff
