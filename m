From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Thu, 16 Jun 2011 17:05:51 -0400
Message-ID: <20110616210551.GA15505@sigill.intra.peff.net>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
 <BANLkTin-sAXAZ4ZJ9z77SSYx+xYTYeZMww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 23:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXJlH-00055y-P5
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271Ab1FPVFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 17:05:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52957
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab1FPVFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 17:05:54 -0400
Received: (qmail 18974 invoked by uid 107); 16 Jun 2011 21:06:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 17:06:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 17:05:51 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin-sAXAZ4ZJ9z77SSYx+xYTYeZMww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175932>

On Mon, Jun 13, 2011 at 10:27:50PM -0600, Elijah Newren wrote:

> On Sun, Jun 12, 2011 at 12:49 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > Here are the topics that have been cooking. =C2=A0Commits prefixed =
with '-' are
> > only in 'pu' while commits prefixed with '+' are in 'next'.
> >
> > --------------------------------------------------
> > [Stalled]
> >
> > * jk/maint-merge-rename-create (2011-03-25) 3 commits
> > =C2=A0- merge: turn on rewrite detection
> > =C2=A0- merge: handle renames with replacement content
> > =C2=A0- t3030: fix accidental success in symlink rename
> >
> > Peff wanted to reroll this. Perhaps will discard to make room for E=
lijah's
> > merge-recursive series in the meantime.
>=20
> Peff: Do you want any help rerolling, updating, reviewing, etc.?  I
> don't want to cause any undue problems with my merge-recursive series=
,
> and besides, the idea you have in this series looks like it may be
> interesting.

Thanks. The sticking point in my series that there is a weird regressio=
n
it introduces, and I haven't quite figured out the cause.

I'm cc'ing Jay Soffian, who found it. You can reproduce with this recip=
e
(sorry, the chromium repo is huge, but I don't have a smaller test case
yet):

  git clone http://git.chromium.org/git/chromium.git &&
  cd chromium &&
  git config merge.renameLimit 0 &&
  git checkout 0f6d00c &&
  git cherry-pick d7081a74

Looking at d7081a74, you can see that it's a tiny commit, and in fact i=
t
should cherry-pick just fine. But due to the 3-way merge that
cherry-pick does, we still end up considering a lot of renames between
the merge base (d7081a74^) and 0f6d00c. Which is fine and correct, of
course, but makes the merge a lot more complex than it would at first
appear.

With git v1.7.5.3, it works just fine. With my patches on top, it
reliably fails the merge (even though there were no conflicts!), and
leaves a ton of crufty temporary files in the working directory.

Bumping up the merge verbosity, it does report a bunch of rename/add
conflicts. Which are totally bogus, of course. Here's what I wrote
earlier to Jay:

   The final patch turned on break detection. The patch before it fixed
   the "source" case: when the source of a rename comes from something
   besides empty (because the source is a broken pair), we need to merg=
e
   properly and not just delete. But I never did the "dest" case, in
   which merge-recursive assumes that renamed content started as empty.

   And that's why you see the bogus "rename/add" conflict, I think. It'=
s
   assuming the file came from nowhere, but it came from a break pair.
   So the good news is I think I can come up with a simple test case,
   and the fix is probably something like comparing against the ancesto=
r
   sha1 instead of the null sha1.

But then I got sidetracked, and as you probably know from working on
merge-recursive, it's some pretty hairy code. Every time I start to loo=
k
at it I get confused and can't remember what breakthrough I thought I
was close to making before. :)

If you have any input, I'd appreciate it.

-Peff
