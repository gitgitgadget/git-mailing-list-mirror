From: Jeff King <peff@peff.net>
Subject: random server hacks on top of git
Date: Mon, 18 Mar 2013 08:12:43 -0400
Message-ID: <20130318121243.GC14789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 18 13:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHYwF-0000ac-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 13:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3CRMMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 08:12:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55961 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab3CRMMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 08:12:47 -0400
Received: (qmail 15860 invoked by uid 107); 18 Mar 2013 12:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 08:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 08:12:43 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218405>

[Re-titled, as we are off-topic from the original patch series]

On Sun, Mar 17, 2013 at 05:38:59PM +0100, Ren=C3=A9 Scharfe wrote:

> Am 17.03.2013 06:40, schrieb Jeff King:
> >We do have the capability to roll out to one or a few of our servers
> >(the granularity is not 0.2%, but it is still small). I'm going to t=
ry
> >to keep us more in sync with upstream git, but I don't know if I wil=
l
> >get to the point of ever deploying "master" or "next", even for a sm=
all
> >portion of the population. We are accumulating more hacks[1] on top =
of
> >git, so it is not just "run master for an hour on this server"; I ha=
ve
> >to actually merge our fork.
>=20
> Did you perhaps intend to list these hacks in a footnote or link to a
> repository containing them?  (I can't find the counterpart of that
> [1].)

I was actually just going to say "some of which are gross hacks that
will never see the light of day, some of which have already gone
upstream, and some of which I am planning on submitting upstream".

But since I happened to be cataloguing them recently, here is the list
of things that have not yet gone upstream.  If anybody is interested in
a particular topic, I'm happy to discuss and/or prioritize moving it
forward.

  - blame-tree; re-rolled from my submission last year to build on top
    of the revision machinery, handle merges sanely, etc. Mostly this
    needs documentation and a clean-up of the output format (which is
    very utilitarian, but probably should share output with git-blame).

  - diff --max-depth; this is a requirement to do blame-tree efficientl=
y
    if you want to do GitHub-style listings (you must recurse to find
    the history of some/subdir, but you do not want to recurse past tha=
t
    for efficiency reasons). This is hung up on two things:

      1. It does not integrate with the pathspec max-depth code, becaus=
e
         we do not use struct pathspec in the tree diff (but I think
         Duy's patches are changing that).

      2. My definition of --max-depth is subtly different from that of
         "git grep".  But I think mine is more useful, and I haven't
         decided how to reconcile it.

  - share ref selection code between "git branch", "git tag", and "git
    for-each-ref". This includes cleaning up the "tag --contains" code
    to be safer for general use (so that "branch --contains" can benefi=
t
    from the speedup), and then getting the same options for all three
    commands (tag doesn't know about --merged, and for-each-ref
    doesn't know about --contains or --merged).

   - receive.maxsize; index-pack will happily spool data to disk
     forever, and you never even get a chance to make a policy decision
     like "hey, this is too big". This patch lets index-pack cut off th=
e
     client after a certain number of bytes. It's not elegant because
     the cutoff transfer is not resumable, but we use it is as a
     last-ditch for DoS protection (the client can reconnect and send
     more, of course, but at that point we have the opportunity to make
     external policy decisions like locking their account). Not sure if
     other sites would want this or not.

   - receive.advertisealternates; basically turn off ".have"
     advertisement. Some of our alternates networks are so huge that
     the cost of collecting all of the alternate refs is very high (eve=
n
     though it can save some transfer bandwidth). Not sure if other
     sites want this or not (and I think it would be more elegant to
     have a small static set of common refs that people build off of,
     and advertise those. e.g., if you fork rails/rails, then we should
     advertise rails/rails/refs/heads/master as a ".have", but not
     anybody else's fork).

    - receive.hiderefs; this is going to become redundant with Junio's
      implementation

    - an audit reflog; we keep a reflog for all refs at the root of the
      repository. It differs from a regular reflog in that:

        1. It never expires.

        2. It is not part of reachability analysis.

        3. It includes the refname for each entry, so you can see
           deletions.

      It's mostly useful for forensics when somebody has screwed up
      their repository (or we're chasing down a git bug; it helped me
      find the pack-refs race recently). Probably too GitHub-specific
      for other people to want it (especially because it grows without
      bound).

    - statistics instrumentation; we keep counters for various things i=
n
      code (e.g., which phase of protocol upload-pack is in, how many
      bytes sent, etc) and expose them in a few ways. One is over a
      socket to run a "top"-like interface. Another is to tweak the arg=
v
      array of the process so that "ps" shows the process state. I thin=
k
      it would be useful to other people running git servers, but the
      code is currently quite nasty and invasive. I have a
      work-in-progress to clean it up, but it's got a ways to go.

    - hacks to set niceness and io-priority; this should be done by a
      wrapper, but in our case it was simpler to catch all processes by
      just building it into git. Too gross to go upstream.

    - ignore some fsck warnings under transfer.fsckobjects; some of the=
m
      are annoyingly common when people pull old history from an
      existing project and try to push it back up. It's not indicative
      of a new bug in an implementation, but we have to live with the
      broken history forever (e.g., zero-padded modes in trees).

-Peff
