From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Wed, 1 Jul 2015 07:50:37 -0400
Message-ID: <20150701115036.GA31158@peff.net>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
 <CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
 <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
 <19801032cd7af95bc8030f54d740bf48@www.dscho.org>
 <20150630122323.GY18226@serenity.lan>
 <CAKDoJU4cEvWvfnFsvfOJ_P0UOrD3RpLK1NdfxaUPiDTWXYg-oA@mail.gmail.com>
 <CAKDoJU42kDs3QXYjo7rJ-vLMJtUdv9AwttJLHnya+toG6cSatQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tanoku@gmail.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 13:50:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAGXO-0007uZ-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 13:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbGALum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 07:50:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:54266 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752595AbbGALuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 07:50:40 -0400
Received: (qmail 26517 invoked by uid 102); 1 Jul 2015 11:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jul 2015 06:50:40 -0500
Received: (qmail 24576 invoked by uid 107); 1 Jul 2015 11:50:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jul 2015 07:50:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jul 2015 07:50:37 -0400
Content-Disposition: inline
In-Reply-To: <CAKDoJU42kDs3QXYjo7rJ-vLMJtUdv9AwttJLHnya+toG6cSatQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273153>

On Tue, Jun 30, 2015 at 08:00:53PM -0700, Lawrence Siebert wrote:

> The following doesn't currently run:  `git rev-list --count
> --use-bitmap-index HEAD`
> 
> This is an optional parameter for rev-list from commit
> aa32939fea9c8934b41efce56015732fa12b8247 which can't currently be used
> because of changes in parameter parsing, but which modifies `--count`
> and which may be faster. I've gotten it working again, both by
> changing the current repo code to make it work, and also by building
> from that commit, and when I tested it on the whole repo, it seems
> like it's less variable in speed then `git rev-list --count HEAD`. but
> not necessarily consistently faster like tests suggested it was when
> it was committed. Obviously I'm not testing on the same system as the
> original committer, or with the same compiler, or even using the same
> version of the linux kernel repo, so those may be a factor.  It may
> also work better in a circumstance that I haven't accounted for, like
> an older repo, on a per file basis when getting per file commit counts
> for all files, or something like that.

Can you give more details?

In a copy of linux.git with bitmaps:

  $ git log -1 --oneline
  64fb1d0 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc

  $ ls -l .git/objects/pack/
  total 892792
  -r--r--r-- 1 peff peff  24498374 May 21 13:39 pack-182149ca37c3f2d8fa190e4add772ae08af0e9d2.bitmap
  -r--r--r-- 1 peff peff 115283036 May 21 13:39 pack-182149ca37c3f2d8fa190e4add772ae08af0e9d2.idx
  -r--r--r-- 1 peff peff 774420808 May 21 13:39 pack-182149ca37c3f2d8fa190e4add772ae08af0e9d2.pack

The packfiles were created with "git repack -adb". It shows big
speedups for this exact operation:

  $ git version
  git version 2.5.0.rc0

  $ time git rev-list --count HEAD
  515406

  real    0m9.500s
  user    0m9.424s
  sys     0m0.092s

  $ time git rev-list --use-bitmap-index --count HEAD
  515406

  real    0m0.392s
  user    0m0.328s
  sys     0m0.064s

Note that this would not work with, say:

  git rev-list --use-bitmap-index --count HEAD -- Makefile

as the bitmap index does not have enough information to do path limiting
(we should probably disallow this or fall back to the non-bitmap code
path, but right now we just ignore the path limiter).

> I'm thinking I could submit a patch that makes it work again, and
> leave it to the user to decide whether to use it or not.   There is
> also a --test-bitmap option which compares the regular count with the
> bitmap count. I'm not sure if the implication there was regression
> testing or that --use-bitmap-index might give the wrong results in
> certain circumstances.  Vincent, could you clarify?

Yes, `--test-bitmap` is just for internal testing; you should always get
the same results.

-Peff
