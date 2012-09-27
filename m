From: Jeff King <peff@peff.net>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Thu, 27 Sep 2012 14:32:44 -0400
Message-ID: <20120927183244.GB2519@sigill.intra.peff.net>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <20120927173932.GE1547@sigill.intra.peff.net>
 <CAJo=hJtus46UGyTcnfTDArp=RkK-P24wO8pjhEY7qAmssyxgVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THItM-00073k-GC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab2I0Scr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:32:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab2I0Scq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:32:46 -0400
Received: (qmail 4445 invoked by uid 107); 27 Sep 2012 18:33:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 14:33:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 14:32:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJtus46UGyTcnfTDArp=RkK-P24wO8pjhEY7qAmssyxgVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206505>

On Thu, Sep 27, 2012 at 10:45:32AM -0700, Shawn O. Pearce wrote:

> On  2012-08-12 Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > Long term we might gain slight lookup speedup if we know object type
> > as search region is made smaller. But for that to happen, we need to
> > propagate object type hint down to find_pack_entry_one() and friends.
> > Possible thing to do, I think.
> 
> I'm not sure reclustering the index by object type is going to make a
> worthwhile difference. Of 2.2m objects in the Linux tree, 320k are
> commits. The difference between doing the binary search through all
> objects vs. just commits is only 2 iterations more of binary search if
> we assume the per-type ranges have their own fan-out tables.

To me the big win would be implicit indexing for items that are present
for every instance of a particular object type. So if we wanted to keep
the timestamp for every commit, you could have a "pack-*.timestamps"
that is literally just a packed list of uint32's, one per commit, where
the position of a commit's timestamp in the list is the same as its
position in the index of sha1s in the pack index.

That's simple to do if your index is just commits. But if it includes
all objects, then your list is sparse. So either you waste space by
making an empty slot for the non-commit objects, or you have an extra
level of indirection mapping the commit into the packed list, which is
going to double the storage in this case (though you could reuse that
extra mapping for the parent, generation number, etc, so it at least
gets amortized as you store more data). Or is there some clever solution
I'm missing?

For your extension, I don't think it matters. You're sparse even in the
commit-object space, so you have to store the mapping anyway. And your
data is big enough that the overhead isn't too painful.

-Peff
