From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 10 Jun 2015 14:56:36 -0400
Message-ID: <20150610185635.GA22800@peff.net>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:56:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lB8-0000Wx-LO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbbFJS4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 14:56:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:44342 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752757AbbFJS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:56:41 -0400
Received: (qmail 17644 invoked by uid 102); 10 Jun 2015 18:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 13:56:41 -0500
Received: (qmail 30522 invoked by uid 107); 10 Jun 2015 18:56:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 14:56:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jun 2015 14:56:36 -0400
Content-Disposition: inline
In-Reply-To: <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271342>

On Wed, Jun 10, 2015 at 03:19:41PM -0300, b=C3=A4r wrote:

> On Sun, Jun 7, 2015 at 9:40 AM, Jeff King <peff@peff.net> wrote:
> > Hrm. The new protection in v2.4.2 is meant to prevent you from losi=
ng
> > your index state during step 4 when we run into a conflict. But her=
e you
> > know something that git doesn't: that we just created the stash bas=
ed on
> > this same state, so it should apply cleanly.
>=20
>=20
> It is strange that `git stash --keep-index && git stash pop` while
> having something in the index, fails with a "Cannot apply stash: Your
> index contains uncommitted changes." error, even if we have a
> `--force` param it find it awkward that one needs to force
> applying/pop'ing even though the stash was created from the same
> snapshot where the stash is being merged with.
>=20
> I understand the original issue, but at least it was expected, when
> you stash save/pop/apply, you should know what you are doing anyways.

Yeah, I would expect "stash && pop" to work in general. But I find it
puzzling that it does not always with "-k" (this is with v2.3.x):

  $ git init -q
  $ echo head >file && git add file && git commit -qm head
  $ echo index >file && git add file
  $ echo tree >file
  $ git stash --keep-index && git stash pop
  Saved working directory and index state WIP on master: 74f6d33 head
  HEAD is now at 74f6d33 head
  Auto-merging file
  CONFLICT (content): Merge conflict in file

So I am trying to figure out what the use case here is. Clearly the
above is a toy case, but why is "stash -k" followed by a quick pop
useful in general? Certainly I use "stash" (without "-k") and a quick
pop all the time, and I think that is what stash was designed for.

The best use case I can think of is Jonathan's original: to see only th=
e
staged content in the working tree, and then restore the original state=
=2E
But stash does not currently work very well for that, as shown above.

-Peff
