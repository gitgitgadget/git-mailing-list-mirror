From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 17:10:09 -0500
Message-ID: <20151204221009.GA23129@sigill.intra.peff.net>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
 <20151204212712.GA22493@sigill.intra.peff.net>
 <xmqqoae5ri5x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 23:10:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4yYb-0002fY-OU
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 23:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbbLDWKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 17:10:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:37561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750958AbbLDWKM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 17:10:12 -0500
Received: (qmail 8002 invoked by uid 102); 4 Dec 2015 22:10:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 16:10:11 -0600
Received: (qmail 29302 invoked by uid 107); 4 Dec 2015 22:10:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 17:10:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 17:10:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoae5ri5x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282013>

On Fri, Dec 04, 2015 at 01:57:30PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This seems to reproduce consistently for me:
> >
> >   $ git clone --depth=1 git://github.com/git/git
> >   Cloning into 'git'...
> >   remote: Counting objects: 2925, done.
> >   remote: Compressing objects: 100% (2602/2602), done.
> >   remote: Total 2925 (delta 230), reused 2329 (delta 206), pack-reused 0
> >   Receiving objects: 100% (2925/2925), 6.17 MiB | 10.80 MiB/s, done.
> >   Resolving deltas: 100% (230/230), done.
> >
> >   $ cd git
> >   $ git fetch --unshallow
> >   remote: Counting objects: 185430, done.
> >   remote: Compressing objects: 100% (46933/46933), done.
> >   remote: Total 185430 (delta 140505), reused 181589 (delta 136694), pack-reused 0
> >   Receiving objects: 100% (185430/185430), 52.80 MiB | 10.84 MiB/s, done.
> >   Resolving deltas: 100% (140505/140505), completed with 1784 local objects.
> >   remote: Counting objects: 579, done.
> >   remote: Compressing objects: 100% (579/579), done.
> >   remote: Total 579 (delta 0), reused 579 (delta 0), pack-reused 0
> >   Receiving objects: 100% (579/579), 266.85 KiB | 0 bytes/s, done.
> >   [... fetch output ...]
> >
> > That looks like two packs being received for the --unshallow case.
> 
> What is puzzling is that I do not seem to see this "two fetches"
> with the local transport.  I only see "deepen 2147483647" in the
> protocol log.

Yeah, I do not ever see "deepen 0" from GIT_TRACE_PACKET output. FWIW,
here's the output I am using to reproduce this locally:

  # do this once
  git clone --bare git://github.com/git/git src.git

  # do this for each test run
  rm -rf repo
  git clone --no-local --depth=1 src.git repo
  cd repo
  echo "==> unshallow" &&
  git fetch --progress --unshallow 2>&1 | grep remote

And you can see that there are two separate sections (and I traced this
to backfill_tags() with gdb).

Note that the issue goes away if the shallow clone is done with "--bare"
(I guess because we pick up tags differently in the initial clone?).

-Peff
