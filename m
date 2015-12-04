From: Jeff King <peff@peff.net>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 4 Dec 2015 16:27:12 -0500
Message-ID: <20151204212712.GA22493@sigill.intra.peff.net>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
 <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Paller-Rzepka <jasonpr@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:27:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4xsu-0002ju-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbbLDV1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:27:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754906AbbLDV1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:27:15 -0500
Received: (qmail 4776 invoked by uid 102); 4 Dec 2015 21:27:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 15:27:15 -0600
Received: (qmail 28289 invoked by uid 107); 4 Dec 2015 21:27:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 16:27:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 16:27:12 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282005>

On Fri, Dec 04, 2015 at 12:46:59PM -0800, Stefan Beller wrote:

> On Mon, Nov 30, 2015 at 11:35 AM, Jason Paller-Rzepka
> <jasonpr@google.com> wrote:
> > Hi all,
> >
> > Would anyone be willing to help me understand some shallow-clone
> > behavior?  (I found a bug in Dulwich, and I'm looking for some context
> > so I can determine how to fix it.)
> >
> > I learned that cgit sometimes performs two fetches for a `git fetch
> > --unshallow`: one with depth 'infinity', and a subsequent one with
> > depth zero.
> 
> Is there a condition to trigger this 'sometimes' ?
> 
> I just tried reproducing via
> $ GIT_TRACE=1 git fetch --unshallow
> 
> and could not see a second fetch, but only a
> fetch-pack with --depth=2147483647

This seems to reproduce consistently for me:

  $ git clone --depth=1 git://github.com/git/git
  Cloning into 'git'...
  remote: Counting objects: 2925, done.
  remote: Compressing objects: 100% (2602/2602), done.
  remote: Total 2925 (delta 230), reused 2329 (delta 206), pack-reused 0
  Receiving objects: 100% (2925/2925), 6.17 MiB | 10.80 MiB/s, done.
  Resolving deltas: 100% (230/230), done.

  $ cd git
  $ git fetch --unshallow
  remote: Counting objects: 185430, done.
  remote: Compressing objects: 100% (46933/46933), done.
  remote: Total 185430 (delta 140505), reused 181589 (delta 136694), pack-reused 0
  Receiving objects: 100% (185430/185430), 52.80 MiB | 10.84 MiB/s, done.
  Resolving deltas: 100% (140505/140505), completed with 1784 local objects.
  remote: Counting objects: 579, done.
  remote: Compressing objects: 100% (579/579), done.
  remote: Total 579 (delta 0), reused 579 (delta 0), pack-reused 0
  Receiving objects: 100% (579/579), 266.85 KiB | 0 bytes/s, done.
  [... fetch output ...]

That looks like two packs being received for the --unshallow case.

-Peff
