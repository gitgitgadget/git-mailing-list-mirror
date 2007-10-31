From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 06:53:03 +0100
Message-ID: <20071031055303.GB3326@atjola.homenet>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 06:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In6W2-0006V2-Sk
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 06:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbXJaFxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXJaFxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 01:53:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:37836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446AbXJaFxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 01:53:07 -0400
Received: (qmail invoked by alias); 31 Oct 2007 05:53:04 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp049) with SMTP; 31 Oct 2007 06:53:04 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19sk2lPH01sP4iqnl9l8XGqX6vYL9B61d3jAJJ2v+
	WinycaOKRAdocl
Content-Disposition: inline
In-Reply-To: <7vodefj2lk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62794>

On 2007.10.30 22:05:27 -0700, Junio C Hamano wrote:
> Your MUA seems to mark the UTF-8 message you are sending out as
> 8859-1, which means your name in the message gets corrupt.

Hm, that would be git-send-email then, anything I need to configure?
(Actually I don't see it marking the message as anything)

> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > By default, rebase will take all commits from the branch that is to=
 be
> > rebased which are missing in upstream. The new --first-parent optio=
n
> > allows to just follow the first parent and thus completely ignore
> > merges.
> >
> > Additionally, when used together with --preserve-merges (which is t=
he
> > more useful use-case) it will no longer rebase the commits from the
> > merged-in branches, but instead redo the merge with the original
> > parents.
> >
> > That means that:

Given this situation:

> >      ---H------I topicB
> >     /    \      \
> > ...
> > does no longer become:

Which results in:

> >                 -H'--------I'
> >                /  \         \
> >               D'---E'---F'---G' topicA
> >              /
> >     A---B---C master
> >      \
> >       H---I topicB

When you do "git-rebase -p -i master topicA"

You can now also get:

> >     A---B---C master
> > ...
> >         ---------H---------I topicB

When you do "git-rebase -p -i --first-parent master topicA"


That's better, right?

> And crucially, you forgot to say "... when you do X".
>=20
> I am assuming that you meant:
>=20
>     This (picture) becomes this (picture) instead of this (picture)
>     when you run "git rebase -p -m master topicA".
>=20
> but without it, the nice ASCII drawings loses their value.

:-/

> It is somewhat disturbing that this treats the first parent too
> special.

The original use-case for the "-p -i --first-parent" case was a questio=
n
on #git, where someone had sth. like this:

   o---o---o---o---o remote/branch
        \           \
     o---o---o---o---o topicA
    /
   o---o---o master trunk

Now that guy was using git-svn to dcommit into svn from master. To
dcommit the changes from topicA he had to have that based on master, an=
d
he wanted to preserve the merges from remote/branch to have them
squashed when dcommitted to svn. So what he wanted was:


     ...---o---o---o---o---o remote/branch
                \           \
             o---o---o---o---o topicA
            /
   o---o---o master trunk

The default behaviour of rebase would totally flat out the history and
instead of two sqaush merges (which he wanted), svn would've seen a hug=
e
amount of commits comning from remote/branch. And the plain -p behaviou=
r
would have duplicated all those branches from remote/branch for no good
reason, so I came up with that --first-parent thing.

Better ideas are welcome, I just don't know git well enough to come up
with anything better...

Thanks,
Bj=F6rn
